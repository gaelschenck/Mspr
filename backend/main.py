from fastapi import FastAPI, Depends, HTTPException, Request
import joblib
from sqlalchemy.ext.asyncio import AsyncSession, create_async_engine
from sqlalchemy import select, update, delete
from fastapi.middleware.cors import CORSMiddleware
from typing import List
import models, schemas
from database import get_db, initialize_engine
import sys
import os
import numpy as np
import math

from prediction import create_voting_regressor, prepare_data_generic, preprocess_features, train_voting_regressor
import pandas as pd
sys.path.append(os.path.dirname(os.path.abspath(__file__)))


from fastapi.security import OAuth2PasswordBearer, OAuth2PasswordRequestForm
from passlib.context import CryptContext
from jose import JWTError, jwt
from datetime import datetime, timedelta
from sqlalchemy.future import select

# Déclare `app`
app = FastAPI(title="MSPR API", version="1.0.0")

# ========================
# Event handlers pour l'initialisation
# ========================

@app.on_event("startup")
async def startup_event():
    """
    Initialise la connexion à la base de données au démarrage de l'application
    """
    try:
        print("Démarrage de l'application...")
        await initialize_engine()
        print("Application démarrée avec succès - Base de données connectée")
        # Créer les tables après l'initialisation de l'engine
        await init_db()
        print("Initialisation terminée avec succès")
    except Exception as e:
        print(f"Erreur lors de l'initialisation de la base de données: {e}")
        # On laisse l'application démarrer même si la DB n'est pas accessible immédiatement
        # Les retry se feront automatiquement lors des requêtes
        import traceback
        traceback.print_exc()

@app.on_event("shutdown")
async def shutdown_event():
    """
    Nettoie les connexions à la base de données à l'arrêt
    """
    import database
    if database.engine:
        await database.engine.dispose()
        print("Connexions à la base de données fermées")

# ========================
# Configuration de la securité/authentification
# ========================

SECRET_KEY = "supersecret"  # À remplacer par une vraie clé secrète en prod
ALGORITHM = "HS256"
ACCESS_TOKEN_EXPIRE_MINUTES = 60

pwd_context = CryptContext(schemes=["bcrypt"], deprecated="auto")
oauth2_scheme = OAuth2PasswordBearer(tokenUrl="token")



def verify_password(plain_password, hashed_password):
    return pwd_context.verify(plain_password, hashed_password)

def get_password_hash(password):
    return pwd_context.hash(password)

async def get_user_by_username(db, username):
    result = await db.execute(select(models.Utilisateur).where(models.Utilisateur.username == username))
    return result.scalar_one_or_none()

async def authenticate_user(db, username: str, password: str):
    user = await get_user_by_username(db, username)
    if not user or not verify_password(password, user.hashed_password):
        return None
    return user

def create_access_token(data: dict, expires_delta: timedelta = None):
    to_encode = data.copy()
    expire = datetime.utcnow() + (expires_delta or timedelta(minutes=ACCESS_TOKEN_EXPIRE_MINUTES))
    to_encode.update({"exp": expire})
    return jwt.encode(to_encode, SECRET_KEY, algorithm=ALGORITHM)

async def get_current_user(token: str = Depends(oauth2_scheme), db: AsyncSession = Depends(get_db)):
    credentials_exception = HTTPException(
        status_code=401,
        detail="Could not validate credentials",
        headers={"WWW-Authenticate": "Bearer"},
    )
    try:
        payload = jwt.decode(token, SECRET_KEY, algorithms=[ALGORITHM])
        username: str = payload.get("sub")
        if username is None:
            raise credentials_exception
    except JWTError:
        raise credentials_exception
    user = await get_user_by_username(db, username)
    if user is None:
        raise credentials_exception
    return user

def require_role(role: str):
    async def role_checker(current_user=Depends(get_current_user)):
        if current_user.role != role:
            raise HTTPException(status_code=403, detail="Not enough permissions")
        return current_user
    return role_checker

#Endpoints authentification


@app.post("/register/", response_model=schemas.UtilisateurOut)
async def register(user: schemas.UtilisateurCreate, db: AsyncSession = Depends(get_db)):
    hashed_password = get_password_hash(user.password)
    db_user = models.Utilisateur(username=user.username, hashed_password=hashed_password, role=user.role)
    db.add(db_user)
    await db.commit()
    await db.refresh(db_user)
    return db_user

@app.post("/token")
async def login(
    request: Request,
    form_data: OAuth2PasswordRequestForm = Depends()
):
    # Récupère le cluster depuis le header ou localStorage (frontend)
    cluster = request.headers.get("X-Cluster")
    if not cluster:
        raise HTTPException(status_code=400, detail="Cluster non spécifié")

    # Sélectionne la bonne base selon le cluster
    # Utilise directement POSTGRES_DB car chaque pod a sa propre base configurée
    db_url = f"postgresql+asyncpg://{os.getenv('POSTGRES_USER')}:{os.getenv('POSTGRES_PASSWORD')}@{os.getenv('POSTGRES_HOST')}:{os.getenv('POSTGRES_PORT')}/{os.getenv('POSTGRES_DB')}"
    
    if not all([os.getenv('POSTGRES_USER'), os.getenv('POSTGRES_PASSWORD'), os.getenv('POSTGRES_HOST'), os.getenv('POSTGRES_PORT'), os.getenv('POSTGRES_DB')]):
        raise HTTPException(status_code=500, detail="Configuration de base de données incomplète")

    # Crée une session temporaire sur la bonne base
    local_engine = create_async_engine(db_url, echo=False, future=True, pool_size=1, max_overflow=0)
    try:
        async with AsyncSession(local_engine) as db:
            user = await authenticate_user(db, form_data.username, form_data.password)
            if not user:
                raise HTTPException(status_code=401, detail="Incorrect username or password")
            access_token = create_access_token(data={"sub": user.username, "role": user.role, "cluster": cluster})
            return {"access_token": access_token, "token_type": "bearer"}
    finally:
        await local_engine.dispose()
    
def safe(val):
    # Convertit les types numpy en natif, gère les nan
    if isinstance(val, (np.integer,)):
        return int(val)
    if isinstance(val, (np.floating,)):
        if math.isnan(val) or math.isinf(val):
            return None
        return float(val)
    return val

from fastapi import Body

@app.put("/me/rgpd")
async def accept_rgpd(
    rgpd: dict = Body(...),
    db: AsyncSession = Depends(get_db),
    current_user: models.Utilisateur = Depends(get_current_user)
):
    current_user.rgpd_accept = rgpd.get("rgpd_accept", 1)
    db.add(current_user)
    await db.commit()
    return {"ok": True}

@app.get("/admin-only/")
async def admin_only(current_user=Depends(require_role("admin"))):
    return {"message": f"Bienvenue, admin {current_user.username}!"}

@app.get("/user-only/")
async def user_only(current_user=Depends(require_role("user"))):
    return {"message": f"Bienvenue, utilisateur {current_user.username}!"}

@app.get("/route-protegee/")
async def route_protegee(current_user=Depends(require_role("admin"))):
    return {"message": "Ceci est une route protégée pour les admins"}

async def init_db():
    """
    Initialise les tables de la base de données
    """
    try:
        # Importer database au lieu d'engine directement
        import database
        
        # S'assurer que l'engine est initialisé
        if database.engine is None:
            print("ERREUR: Engine non initialisé! Tentative d'initialisation...")
            await database.initialize_engine()
            
        if database.engine is None:
            print("ERREUR: Impossible d'initialiser l'engine!")
            return
            
        print(f"engine in main.py: {database.engine}")
        async with database.engine.begin() as conn:
            await conn.run_sync(models.Base.metadata.create_all)
            print("Tables créées avec succès")
    except Exception as e:
        print(f"Erreur lors de la création des tables: {e}")
        import traceback
        traceback.print_exc()
        # Ne pas faire échouer le démarrage, les tables pourraient déjà exister
# ========================
# Configuration de la langue
# ========================

LANG = os.getenv("LANG", "fr")  # "fr" par défaut

# Dictionnaire de traductions
TRANSLATIONS = {
    "root_message": {
        "fr": "Bienvenue sur l'API MSPR!",
        "en": "Welcome to the MSPR API!",
        "de": "Willkommen bei der MSPR API!",
        "it": "Benvenuto nell'API MSPR!"
    },
    "preflight_ok": {
        "fr": "Préflight OPTIONS accepté",
        "en": "Preflight OPTIONS accepted",
        "de": "Preflight OPTIONS akzeptiert",
        "it": "Preflight OPTIONS accettato"
    },
    "country_not_found": {
        "fr": "Pays non trouvé",
        "en": "Country not found",
        "de": "Land nicht gefunden",
        "it": "Paese non trovato"
    },
    "country_deleted": {
        "fr": "Pays supprimé avec succès",
        "en": "Country successfully deleted",
        "de": "Land erfolgreich gelöscht",
        "it": "Paese eliminato con successo"
    },
    "invalid_table": {
        "fr": "Table invalide",
        "en": "Invalid table",
        "de": "Ungültige Tabelle",
        "it": "Tabella non valida"
    },
    "region_or_country_required": {
        "fr": "Region ou pays doivent être renseignés",
        "en": "Region or country must be provided",
        "de": "Region oder Land müssen angegeben werden",
        "it": "Regione o paese devono essere forniti"
    },
    "unknown_table": {
        "fr": "Table inconnue",
        "en": "Unknown table",
        "de": "Unbekannte Tabelle",
        "it": "Tabella sconosciuta"
    },
    "merge_key_error": {
        "fr": "Les clés de fusion ne correspondent pas entre les tables",
        "en": "Merge keys do not match between tables",
        "de": "Die Schlüsselfelder stimmen zwischen den Tabellen nicht überein",
        "it": "Le chiavi di unione non corrispondono tra le tabelle"
    },
    "table_not_found": {
        "fr": "Table '{table}' introuvable",
        "en": "Table '{table}' not found",
        "de": "Tabelle '{table}' nicht gefunden",
        "it": "Tabella '{table}' non trovata"
    },
    "missing_dataframe": {
        "fr": "Le DataFrame est manquant",
        "en": "DataFrame is missing",
        "de": "DataFrame fehlt",
        "it": "Manca il DataFrame"
    },
    "target_required": {
        "fr": "La colonne cible est requise pour l'entraînement",
        "en": "Target column is required for training",
        "de": "Zielspalte für das Training erforderlich",
        "it": "La colonna target è richiesta per l'addestramento"
    },
    "avant_separation": {
        "fr": "Avant séparation, taille du DataFrame : {shape}",
        "en": "Before split, DataFrame shape: {shape}",
        "de": "Vor der Trennung, DataFrame-Größe: {shape}",
        "it": "Prima della separazione, dimensione del DataFrame: {shape}"
    },
    "model_trained": {
        "fr": "Modèle entraîné avec succès",
        "en": "Model trained successfully",
        "de": "Modell erfolgreich trainiert",
        "it": "Modello addestrato con successo"
    }
}

def tr(key, **kwargs):
    """Fonction utilitaire pour traduire les messages."""
    msg = TRANSLATIONS.get(key, {}).get(LANG, TRANSLATIONS.get(key, {}).get("fr", key))
    return msg.format(**kwargs) if kwargs else msg

# ========================
# Configuration des CORS
# ========================
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],  # Permet toutes les origines. Tu peux spécifier ici une liste d'origines autorisées.
    allow_credentials=True,
    allow_methods=["*"],  # Permet toutes les méthodes HTTP (GET, POST, etc.).
    allow_headers=["Authorization", "Content-Type","*"],  # Permet tous les types d'en-têtes.
)
@app.options("/{path:path}")
async def options_handler():
    return {"message": tr("preflight_ok")}


# ========================
# Endpoints PAYS
# ========================
@app.get("/payslist/")
async def get_pays(db: AsyncSession = Depends(get_db)):
    """
    Endpoint pour récupérer les informations des pays depuis la table `pays`.
    """
    result = await db.execute(select(models.Pays))
    pays_list = result.scalars().all()
    return [{"id": pays.id_pays, "nom": pays.nom_pays, "region": pays.region} for pays in pays_list]


@app.get("/pays/", response_model=List[schemas.Pays])
async def get_pays(db: AsyncSession = Depends(get_db)):
    result = await db.execute(select(models.Pays))
    return result.scalars().all()


@app.post("/pays/", response_model=schemas.Pays)
async def create_pays(pays: schemas.PaysCreate, db: AsyncSession = Depends(get_db)):
    new_pays = models.Pays(**pays.dict())
    db.add(new_pays)
    await db.commit()
    await db.refresh(new_pays)
    return new_pays


@app.put("/pays/{pays_id}/", response_model=schemas.Pays)
async def update_pays(
    pays_id: int, pays: schemas.PaysCreate, db: AsyncSession = Depends(get_db)
):
    result = await db.execute(select(models.Pays).where(models.Pays.id_pays == pays_id))
    db_pays = result.scalar_one_or_none()

    if not db_pays:
        raise HTTPException(status_code=404, detail=tr("country_not_found"))

    await db.execute(
        update(models.Pays).where(models.Pays.id_pays == pays_id).values(**pays.dict())
    )
    await db.commit()
    return {**pays.dict(), "id_pays": pays_id}


@app.delete("/pays/{pays_id}/")
async def delete_pays(pays_id: int, db: AsyncSession = Depends(get_db)):
    result = await db.execute(select(models.Pays).where(models.Pays.id_pays == pays_id))
    db_pays = result.scalar_one_or_none()

    if not db_pays:
        raise HTTPException(status_code=404, detail=tr("country_not_found"))

    await db.execute(delete(models.Pays).where(models.Pays.id_pays == pays_id))
    await db.commit()
    return {"message": tr("country_deleted")}


# ========================
# Endpoints POPULATION HIV
# ========================


@app.get("/population_hiv/", response_model=List[schemas.PopulationHIV])
async def get_population_hiv(db: AsyncSession = Depends(get_db)):
    result = await db.execute(select(models.PopulationHIV))
    return result.scalars().all()


@app.post("/population_hiv/", response_model=schemas.PopulationHIV)
async def create_population_hiv(
    data: schemas.PopulationHIVCreate, db: AsyncSession = Depends(get_db)
):
    new_data = models.PopulationHIV(**data.dict())
    db.add(new_data)
    await db.commit()
    await db.refresh(new_data)
    return new_data


# ========================
# Endpoints MORTALITE
# ========================


@app.get("/mortalite/", response_model=List[schemas.Mortalite])
async def get_mortalite(db: AsyncSession = Depends(get_db)):
    result = await db.execute(select(models.Mortalite))
    return result.scalars().all()


@app.post("/mortalite/", response_model=schemas.Mortalite)
async def create_mortalite(
    data: schemas.MortaliteCreate, db: AsyncSession = Depends(get_db)
):
    new_data = models.Mortalite(**data.dict())
    db.add(new_data)
    await db.commit()
    await db.refresh(new_data)
    return new_data


# ========================
# Endpoints TRANSMISSION MÈRE-ENFANT
# ========================


@app.get("/transmission/", response_model=List[schemas.TransmissionMereEnfant])
async def get_transmission(db: AsyncSession = Depends(get_db)):
    result = await db.execute(select(models.TransmissionMereEnfant))
    return result.scalars().all()


@app.post("/transmission/", response_model=schemas.TransmissionMereEnfant)
async def create_transmission(
    data: schemas.TransmissionMereEnfantCreate, db: AsyncSession = Depends(get_db)
):
    new_data = models.TransmissionMereEnfant(**data.dict())
    db.add(new_data)
    await db.commit()
    await db.refresh(new_data)
    return new_data


# ========================
# Endpoints STATISTIQUES
# ========================


@app.get("/statistiques/", response_model=List[schemas.Statistique])
async def get_statistiques(db: AsyncSession = Depends(get_db)):
    result = await db.execute(select(models.Statistique))
    return result.scalars().all()


@app.post("/statistiques/", response_model=schemas.Statistique)
async def create_statistique(
    data: schemas.StatistiqueCreate, db: AsyncSession = Depends(get_db)
):
    new_data = models.Statistique(**data.dict())
    db.add(new_data)
    await db.commit()
    await db.refresh(new_data)
    return new_data


# ========================
# ROOT ENDPOINT
# ========================


@app.get("/")
async def read_root():
    return {"message": tr("root_message"), "langue": LANG}

@app.get("/health")
async def health_check():
    """
    Endpoint de vérification de santé de l'application et de la base de données
    """
    import database
    from database import health_check_db
    
    status = {
        "status": "healthy",
        "timestamp": datetime.utcnow().isoformat(),
        "database": "disconnected",
        "engine_initialized": database.engine is not None
    }
    
    # Vérification de la base de données
    if database.engine:
        try:
            db_healthy = await health_check_db(database.engine)
            status["database"] = "connected" if db_healthy else "error"
        except Exception as e:
            status["database"] = f"error: {str(e)}"
            status["status"] = "degraded"
    else:
        status["status"] = "degraded"
    
    return status


# ========================
# ENDPOINT prédiction
# ========================

@app.post("/dataframe/")
async def create_dataframe(payload: dict, db: AsyncSession = Depends(get_db)):
    """
    Endpoint pour générer un DataFrame croisé basé sur les choix de l'utilisateur.
    """
    region = payload.get("region")
    pays = payload.get("pays")
    table = payload.get("table")
    target_column = payload.get("target_column")

    if table not in ["mortalite", "population_hiv", "statistique", "traitement", "transmission_mere_enfant", "type_statistique", "type_traitement", "unite"]:
        raise HTTPException(status_code=400, detail=tr("invalid_table"))
    if not region and not pays:
        raise HTTPException(status_code=400, detail=tr("region_or_country_required"))


    query_pays = select(models.Pays)
    if region:
        query_pays = query_pays.filter(models.Pays.region == region)
    if pays:
        query_pays = query_pays.filter(models.Pays.nom_pays == pays)

    result_pays = await db.execute(query_pays)
    data_pays = result_pays.scalars().all()

# Mapping précis entre nom de table (frontend) et classe modèle Python
    MODEL_MAPPING = {
        "mortalite": models.Mortalite,
        "population_hiv": models.PopulationHIV,
        "statistique": models.Statistique,
        "traitement": models.Traitement,
        "transmission_mere_enfant": models.TransmissionMereEnfant,
        "type_statistique": models.TypeStatistique,
        "type_traitement": models.TypeTraitement,
        "unite": models.Unite,
        "pays": models.Pays,
    }
    model = MODEL_MAPPING.get(table)
    if not model:
        raise HTTPException(status_code=400, detail=tr("unknown_table"))
    query_table = select(model)
    result_table = await db.execute(query_table)
    data_table = result_table.scalars().all()

    # Conversion des données en DataFrames
    df_pays = pd.DataFrame([item.__dict__ for item in data_pays])
    df_table = pd.DataFrame([item.__dict__ for item in data_table])

    # Nettoyage des colonnes inutiles
    df_pays = df_pays.drop("_sa_instance_state", axis=1, errors="ignore")
    df_table = df_table.drop("_sa_instance_state", axis=1, errors="ignore")
    print(f"df_pays : { df_pays }")
    print(f"df_table { df_table }")  
    # Fusion des deux DataFrames pour créer un DataFrame croisé
    try:
        dataframe_croise = pd.merge(df_pays, df_table, on="id_pays", how="inner")
        return {"dataframe": dataframe_croise.to_dict()}
    except KeyError:
        raise HTTPException(status_code=400, detail=tr("merge_key_error"))



@app.get("/tables/")
async def get_available_tables():
    """
    Endpoint pour fournir les noms des tables disponibles et leurs relations.
    """
    tables = {
        "pays": ["region"],
        "mortalite": [],
        "population_hiv": [],
        "statistique": [],
        "traitement": [],
        "transmission_mere_enfant": [],
    }
    return {"tables": tables}

@app.get("/columns/{table_name}")
async def get_columns(table_name: str):
    """
    Endpoint pour récupérer la liste des colonnes disponibles dans une table donnée.
    """
    TABLE_MAPPING = {
        "mortalite": models.Mortalite,
        "population_hiv": models.PopulationHIV,
        "statistique": models.Statistique,
        "traitement": models.Traitement,
        "transmission_mere_enfant": models.TransmissionMereEnfant
        # Ajoute ici d'autres tables et leurs modèles
    }

    # Vérifie si la table existe
    model = TABLE_MAPPING.get(table_name)
    if not model:
        raise HTTPException(status_code=404, detail=tr("table_not_found", table=table_name))

    # Récupère les colonnes du modèle
    columns = [column.key for column in model.__table__.columns]
    return {"columns": columns}

@app.post("/train_model/")
async def train_model_endpoint(payload: dict):
    try:
        """
        Endpoint pour entraîner le modèle avec les données fournies.
        """
        dataframe_dict = payload.get("dataframe")
        target_column = payload.get("target_column")
        if not dataframe_dict:
            raise HTTPException(status_code=400, detail=tr("missing_dataframe"))

        # Convertir le dictionnaire en DataFrame
        df = pd.DataFrame.from_dict(dataframe_dict)
        print(tr("avant_separation", shape=df.shape))
        print("DataFrame reçu :", df.head())
        print("Colonnes :", df.columns)
        print("Target column :", target_column)

        # Préparer X et y
        X = df.drop(columns=[target_column, "region", "nom_pays", "sous_region", "id_unite"], errors="ignore")
        y = df[target_column]

        X = preprocess_features(X)
        X, y = prepare_data_generic(df, target_column=target_column)

        if y is None:
            raise HTTPException(status_code=400, detail=tr("target_required"))

        model = create_voting_regressor()
        trained_model, rmse, r2, future_pred_value, future_year = train_voting_regressor(model, X, y)
        joblib.dump(trained_model, "voting_regressor.pkl")

        predictions = trained_model.predict(X)
        labels = list(df["annee"]) if "annee" in df.columns else list(range(len(predictions)))

        return {
        "prediction": [safe(x) for x in predictions],
        "labels": [safe(x) for x in labels],
        "message": tr("model_trained"),
        "rmse": safe(rmse),
        "r2": safe(r2),
        "future_prediction": safe(future_pred_value),
        "future_year": safe(future_year)
    }
    except Exception as e:
            import traceback
            print("Erreur dans /train_model/:", e)
            traceback.print_exc()
            raise HTTPException(status_code=500, detail=str(e))

# ========================
# RUN SERVER
# ========================

if __name__ == "__main__":
    import uvicorn

    uvicorn.run(app, host="0.0.0.0", port=8084, reload=True)


#========================= 
# END POINTS US - GESTION SCALABILITE
#=========================

from fastapi import Query
from sqlalchemy.orm import selectinload

@app.get("/us/mortalite/")
async def get_us_mortalite(
    offset: int = Query(0, ge=0),
    limit: int = Query(25, ge=1, le=1000),
    year: int = Query(None),
    db: AsyncSession = Depends(get_db)
):
    query = select(models.Mortalite).options(selectinload(models.Mortalite.pays))
    if year:
        query = query.where(models.Mortalite.annee == year)
    query = query.offset(offset).limit(limit)
    result = await db.execute(query)
    data = result.scalars().all()
    return [
        {
            "id": m.id,
            "id_pays": m.id_pays,
            "nom_pays": m.pays.nom_pays if m.pays else None,  # <-- Ajout ici
            "annee": m.annee,
            "valeur": m.valeur,
            "id_unite": m.id_unite
        }
        for m in data
    ]

from sqlalchemy import func

@app.get("/us/mortalite/count/")
async def get_us_mortalite_count(db: AsyncSession = Depends(get_db)):
    result = await db.execute(select(func.count(models.Mortalite.id)))
    count = result.scalar()
    return {"count": count}

@app.get("/population_hiv/paginated/")
async def get_population_hiv_paginated(
    offset: int = Query(0, ge=0),
    limit: int = Query(25, ge=1, le=1000),
    db: AsyncSession = Depends(get_db)
):
    query = select(models.PopulationHIV).options(selectinload(models.PopulationHIV.pays))
    query = query.offset(offset).limit(limit)
    result = await db.execute(query)
    data = result.scalars().all()
    return [
        {
            "id": m.id,
            "id_pays": m.id_pays,
            "nom_pays": m.pays.nom_pays if m.pays else None,
            "annee": m.annee,
            "valeur": m.valeur
        }
        for m in data
    ]

@app.get("/traitement/paginated/")
async def get_traitement_paginated(
    offset: int = Query(0, ge=0),
    limit: int = Query(25, ge=1, le=1000),
    db: AsyncSession = Depends(get_db)
):
    query = select(models.Traitement).options(selectinload(models.Traitement.pays))
    query = query.offset(offset).limit(limit)
    result = await db.execute(query)
    data = result.scalars().all()
    output = []
    for t in data:
        if not t.pays:
            print(f"[WARN] Traitement id={t.id} id_pays={t.id_pays} sans pays associé")
        output.append({
            "id": t.id,
            "id_pays": t.id_pays,
            "nom_pays": t.pays.nom_pays if t.pays and t.pays.nom_pays else None,
            "valeur": t.valeur
        })
    return output

@app.get("/transmission_mere_enfant/paginated/")
async def get_transmission_mere_enfant_paginated(
    offset: int = Query(0, ge=0),
    limit: int = Query(25, ge=1, le=1000),
    db: AsyncSession = Depends(get_db)
):
    query = select(models.TransmissionMereEnfant).options(selectinload(models.TransmissionMereEnfant.pays))
    query = query.offset(offset).limit(limit)
    result = await db.execute(query)
    data = result.scalars().all()
    return [
        {
            "id": t.id,
            "id_pays": t.id_pays,
            "nom_pays": t.pays.nom_pays if t.pays else None,
            "besoin_arv_min": float(t.besoin_arv_min),
            "besoin_arv_median": float(t.besoin_arv_median),
            "besoin_arv_max": float(t.besoin_arv_max),
            "pourcentage_recu_min": float(t.pourcentage_recu_min),
            "pourcentage_recu_median": float(t.pourcentage_recu_median),
            "pourcentage_recu_max": float(t.pourcentage_recu_max)
        }
        for t in data
    ]

@app.get("/mortalite/paginated/")
async def get_mortalite_paginated(
    offset: int = Query(0, ge=0),
    limit: int = Query(25, ge=1, le=1000),
    db: AsyncSession = Depends(get_db)
):
    query = select(models.Mortalite).options(selectinload(models.Mortalite.pays))
    query = query.offset(offset).limit(limit)
    result = await db.execute(query)
    data = result.scalars().all()
    return [
        {
            "id": m.id,
            "id_pays": m.id_pays,
            "nom_pays": m.pays.nom_pays if m.pays else None,
            "annee": m.annee,
            "valeur": m.valeur,
            "id_unite": m.id_unite
        }
        for m in data
    ]

