from fastapi import FastAPI, Depends, HTTPException, Request, Query
import joblib
from sqlalchemy.ext.asyncio import AsyncSession, create_async_engine
from sqlalchemy import select, update, delete
from sqlalchemy.orm import selectinload
from fastapi.middleware.cors import CORSMiddleware
from typing import List
import models, schemas
from database import get_db, initialize_engine
import sys
import os
import numpy as np
import math
import subprocess
import json
from datetime import datetime
from pathlib import Path

from prediction import create_voting_regressor, prepare_data_generic, preprocess_features, train_voting_regressor
import pandas as pd
sys.path.append(os.path.dirname(os.path.abspath(__file__)))


from fastapi.security import OAuth2PasswordBearer, OAuth2PasswordRequestForm
from passlib.context import CryptContext
from jose import JWTError, jwt
from datetime import datetime, timedelta
from sqlalchemy.future import select
from contextlib import asynccontextmanager
from pathlib import Path

@asynccontextmanager
async def lifespan(app: FastAPI):
    """
    Gère le cycle de vie de l'application FastAPI
    """
    # Startup
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
    
    yield
    
    # Shutdown
    import database
    if database.engine:
        await database.engine.dispose()
        print("Connexions à la base de données fermées")

# Déclare `app`
app = FastAPI(title="MSPR API", version="1.0.0", lifespan=lifespan)

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
    if not user:
        raise HTTPException(status_code=404, detail="Utilisateur non trouvé")
    if not verify_password(password, user.hashed_password):
        raise HTTPException(status_code=401, detail="Mot de passe incorrect")
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
            access_token = create_access_token(data={"sub": user.username, "role": user.role, "cluster": cluster})
            return {"access_token": access_token, "token_type": "bearer"}
    finally:
        await local_engine.dispose()

@app.get("/users/", response_model=List[schemas.UtilisateurOut])
async def list_users(request: Request):
    """Liste tous les utilisateurs de la base sélectionnée (pour debug)"""
    cluster = request.headers.get("X-Cluster")
    if not cluster:
        raise HTTPException(status_code=400, detail="Cluster non spécifié")

    db_url = f"postgresql+asyncpg://{os.getenv('POSTGRES_USER')}:{os.getenv('POSTGRES_PASSWORD')}@{os.getenv('POSTGRES_HOST')}:{os.getenv('POSTGRES_PORT')}/{os.getenv('POSTGRES_DB')}"

    local_engine = create_async_engine(db_url, echo=False, future=True, pool_size=1, max_overflow=0)
    try:
        async with AsyncSession(local_engine) as db:
            result = await db.execute(select(models.Utilisateur))
            users = result.scalars().all()
            return users
    finally:
        await local_engine.dispose()
    
def safe(val):
    # Convertit les types numpy en natif, gère les nan
    if val is None:
        return None
    if isinstance(val, (np.integer,)):
        return int(val)
    if isinstance(val, (np.floating,)):
        if math.isnan(val) or math.isinf(val):
            return None
        return float(val)
    if isinstance(val, (list, tuple)):
        return [safe(x) for x in val]
    if isinstance(val, dict):
        return {k: safe(v) for k, v in val.items()}
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
    Initialise les tables de la base de données si nécessaire
    """
    try:
        import database
        if database.engine:
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
# Endpoints COUNTRIES (remplace PAYS)
# ========================
@app.get("/countries/")
async def get_countries(db: AsyncSession = Depends(get_db)):
    """
    Endpoint pour récupérer les informations des pays depuis la table `countries`.
    """
    result = await db.execute(select(models.Country))
    countries_list = result.scalars().all()
    return [{"id": country.id, "name": country.name, "who_region": country.who_region} for country in countries_list]


@app.get("/countries/list/", response_model=List[schemas.Country])
async def get_countries_list(db: AsyncSession = Depends(get_db)):
    result = await db.execute(select(models.Country))
    return result.scalars().all()


@app.post("/countries/", response_model=schemas.Country)
async def create_country(country: schemas.CountryCreate, db: AsyncSession = Depends(get_db)):
    new_country = models.Country(**country.dict())
    db.add(new_country)
    await db.commit()
    await db.refresh(new_country)
    return new_country


@app.put("/countries/{country_id}/", response_model=schemas.Country)
async def update_country(
    country_id: int, country: schemas.CountryCreate, db: AsyncSession = Depends(get_db)
):
    result = await db.execute(select(models.Country).where(models.Country.id == country_id))
    db_country = result.scalar_one_or_none()

    if not db_country:
        raise HTTPException(status_code=404, detail=tr("country_not_found"))

    await db.execute(
        update(models.Country).where(models.Country.id == country_id).values(**country.dict())
    )
    await db.commit()
    return {**country.dict(), "id": country_id}


@app.delete("/countries/{country_id}/")
async def delete_country(country_id: int, db: AsyncSession = Depends(get_db)):
    result = await db.execute(select(models.Country).where(models.Country.id == country_id))
    db_country = result.scalar_one_or_none()

    if not db_country:
        raise HTTPException(status_code=404, detail=tr("country_not_found"))

    await db.execute(delete(models.Country).where(models.Country.id == country_id))
    await db.commit()
    return {"message": tr("country_deleted")}


# ========================
# Endpoints INDICATOR TYPES
# ========================

@app.get("/indicator-types/", response_model=List[schemas.IndicatorType])
async def get_indicator_types(db: AsyncSession = Depends(get_db)):
    result = await db.execute(select(models.IndicatorType))
    return result.scalars().all()


@app.post("/indicator-types/", response_model=schemas.IndicatorType)
async def create_indicator_type(
    indicator_type: schemas.IndicatorTypeCreate, db: AsyncSession = Depends(get_db)
):
    new_indicator_type = models.IndicatorType(**indicator_type.dict())
    db.add(new_indicator_type)
    await db.commit()
    await db.refresh(new_indicator_type)
    return new_indicator_type


# ========================
# Endpoints HEALTH INDICATORS
# ========================

@app.get("/health-indicators/", response_model=List[schemas.HealthIndicator])
async def get_health_indicators(db: AsyncSession = Depends(get_db)):
    result = await db.execute(select(models.HealthIndicator))
    return result.scalars().all()


@app.post("/health-indicators/", response_model=schemas.HealthIndicator)
async def create_health_indicator(
    health_indicator: schemas.HealthIndicatorCreate, db: AsyncSession = Depends(get_db)
):
    new_health_indicator = models.HealthIndicator(**health_indicator.dict())
    db.add(new_health_indicator)
    await db.commit()
    await db.refresh(new_health_indicator)
    return new_health_indicator


@app.get("/health-indicators/detailed/")
async def get_health_indicators_detailed(
    offset: int = Query(0, ge=0),
    limit: int = Query(25, ge=1, le=1000),
    country_name: str = Query(None),
    indicator_type_name: str = Query(None),
    who_region: str = Query(None),
    year: int = Query(None),
    db: AsyncSession = Depends(get_db)
):
    """
    Endpoint avec pagination et filtres pour récupérer les indicateurs de santé avec détails
    """
    query = select(models.HealthIndicator).options(
        selectinload(models.HealthIndicator.country),
        selectinload(models.HealthIndicator.indicator_type)
    )
    
    # Filtres
    if country_name:
        query = query.join(models.Country).filter(models.Country.name.ilike(f"%{country_name}%"))
    if indicator_type_name:
        query = query.join(models.IndicatorType).filter(models.IndicatorType.name.ilike(f"%{indicator_type_name}%"))
    if who_region:
        query = query.join(models.Country).filter(models.Country.who_region == who_region)
    if year:
        query = query.filter(models.HealthIndicator.year == year)
    
    query = query.offset(offset).limit(limit)
    result = await db.execute(query)
    data = result.scalars().all()
    
    return [
        {
            "id": indicator.id,
            "country_name": indicator.country.name if indicator.country else None,
            "who_region": indicator.country.who_region if indicator.country else None,
            "indicator_type": indicator.indicator_type.name if indicator.indicator_type else None,
            "year": indicator.year,
            "value_type": indicator.value_type,
            "value": float(indicator.value) if indicator.value else None,
            "value_text": indicator.value_text,
            "confidence_min": float(indicator.confidence_min) if indicator.confidence_min else None,
            "confidence_max": float(indicator.confidence_max) if indicator.confidence_max else None,
            "confidence_median": float(indicator.confidence_median) if indicator.confidence_median else None,
            "data_quality": indicator.data_quality,
            "source_file": indicator.source_file
        }
        for indicator in data
    ]


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
async def create_dataframe(payload: schemas.DataframeRequest, db: AsyncSession = Depends(get_db)):
    """
    Endpoint ultra-flexible pour générer des DataFrames avec filtres multiples.
    Version intégrée - pas de dépendance externe.
    """
    
    print(f"Requête DataFrame flexible reçue:")
    print(f"   - Géographie: région={payload.who_region}, pays={payload.pays}, countries={payload.countries}")
    print(f"   - Temporel: années={payload.years}, période={payload.year_min}-{payload.year_max}")
    print(f"   - Indicateurs: table={payload.table}, types={payload.indicator_types}")
    print(f"   - Valeurs: min={payload.value_min}, max={payload.value_max}, qualité={payload.data_quality}")
    print(f"   - Config: target={payload.target_column}, max_records={payload.max_records}")

    # Construction dynamique de la requête de base
    query = select(models.HealthIndicator).options(
        selectinload(models.HealthIndicator.country),
        selectinload(models.HealthIndicator.indicator_type)
    )
    
    # Jointures nécessaires (optimisées)
    joins_applied = set()
    
    # === FILTRES GÉOGRAPHIQUES ===
    geographic_filters = []
    
    if payload.who_region:
        if 'country' not in joins_applied:
            query = query.join(models.Country)
            joins_applied.add('country')
        geographic_filters.append(models.Country.who_region.ilike(f"%{payload.who_region}%"))
    
    if payload.pays:
        if 'country' not in joins_applied:
            query = query.join(models.Country)
            joins_applied.add('country')
        geographic_filters.append(models.Country.name.ilike(f"%{payload.pays}%"))
    
    if payload.countries:
        if 'country' not in joins_applied:
            query = query.join(models.Country)
            joins_applied.add('country')
        from sqlalchemy import or_
        country_filters = [models.Country.name.ilike(f"%{country}%") for country in payload.countries]
        geographic_filters.append(or_(*country_filters))
    
    # Appliquer les filtres géographiques
    if geographic_filters:
        from sqlalchemy import or_
        query = query.filter(or_(*geographic_filters))
    
    # === FILTRES TEMPORELS ===
    if payload.year_min:
        query = query.filter(models.HealthIndicator.year >= payload.year_min)
    
    if payload.year_max:
        query = query.filter(models.HealthIndicator.year <= payload.year_max)
    
    if payload.years:
        query = query.filter(models.HealthIndicator.year.in_(payload.years))
    
    # === FILTRES SUR LES INDICATEURS ===
    if payload.table != "statistique":  # Mode spécifique
        table_mapping = {
            "population_hiv": "People Living with HIV",
            "traitement": "ART Coverage", 
            "transmission_mere_enfant": "Prevention of Mother-to-Child Transmission",
            "mortalite": "HIV-related Deaths",
            "art_coverage": "ART Coverage",
            "hiv_deaths": "HIV-related Deaths"
        }
        
        indicator_type = table_mapping.get(payload.table, payload.table)
        
        if 'indicator_type' not in joins_applied:
            query = query.join(models.IndicatorType)
            joins_applied.add('indicator_type')
        
        query = query.filter(models.IndicatorType.name.ilike(f"%{indicator_type}%"))
    
    if payload.indicator_types:
        if 'indicator_type' not in joins_applied:
            query = query.join(models.IndicatorType)
            joins_applied.add('indicator_type')
        
        from sqlalchemy import or_
        indicator_filters = [models.IndicatorType.name.ilike(f"%{ind_type}%") for ind_type in payload.indicator_types]
        query = query.filter(or_(*indicator_filters))
    
    if payload.value_types:
        query = query.filter(models.HealthIndicator.value_type.in_(payload.value_types))
    
    # === FILTRES SUR LES VALEURS ===
    if payload.value_min is not None:
        query = query.filter(models.HealthIndicator.value >= payload.value_min)
    
    if payload.value_max is not None:
        query = query.filter(models.HealthIndicator.value <= payload.value_max)
    
    if payload.data_quality:
        query = query.filter(models.HealthIndicator.data_quality.in_(payload.data_quality))
    
    # === OPTIMISATIONS ===
    # Limiter le nombre d'enregistrements pour les performances
    query = query.limit(payload.max_records)
    
    # Ordonner par année décroissante pour avoir les données les plus récentes
    query = query.order_by(models.HealthIndicator.year.desc())
    
    print(f"Exécution de la requête optimisée...")
    
    # Exécuter la requête
    result = await db.execute(query)
    health_indicators = result.scalars().all()

    if not health_indicators:
        raise HTTPException(
            status_code=404, 
            detail=f"Aucune donnée trouvée avec les critères spécifiés. Essayez d'élargir les filtres."
        )

    # === CONSTRUCTION DU DATAFRAME OPTIMISÉE ===
    print(f"Construction du DataFrame avec {len(health_indicators)} enregistrements...")
    
    data = []
    for indicator in health_indicators:
        row = {
            "id": indicator.id,
            "country_id": indicator.country_id,
            "country_name": indicator.country.name if indicator.country else None,
            "who_region": indicator.country.who_region if indicator.country else None,
            "iso_code": indicator.country.iso_code if indicator.country else None,
            "indicator_type_id": indicator.indicator_type_id,
            "indicator_type_name": indicator.indicator_type.name if indicator.indicator_type else None,
            "year": indicator.year,
            "value_type": indicator.value_type,
            "value": float(indicator.value) if indicator.value else None,
            "value_text": indicator.value_text,
            "data_quality": indicator.data_quality,
            "source_file": indicator.source_file
        }
        
        # Inclure les intervalles de confiance si demandé
        if payload.include_confidence:
            # Conversion sûre pour éviter les NaN
            conf_min = indicator.confidence_min
            conf_max = indicator.confidence_max
            conf_med = indicator.confidence_median
            
            row.update({
                "confidence_min": float(conf_min) if conf_min is not None and not pd.isna(conf_min) else None,
                "confidence_max": float(conf_max) if conf_max is not None and not pd.isna(conf_max) else None,
                "confidence_median": float(conf_med) if conf_med is not None and not pd.isna(conf_med) else None,
            })
        
        data.append(row)

    df = pd.DataFrame(data)
    
    # Filtrer les lignes avec des valeurs nulles pour la colonne target
    if payload.target_column in df.columns:
        df_clean = df.dropna(subset=[payload.target_column])
        print(f"Après nettoyage: {len(df_clean)} lignes avec {payload.target_column} non-null")
    else:
        df_clean = df.dropna(subset=['value'])  # Fallback sur 'value'
        print(f"Après nettoyage: {len(df_clean)} lignes avec valeurs numériques")

    if df_clean.empty:
        raise HTTPException(
            status_code=422,
            detail=f"Aucune donnée numérique trouvée pour la colonne '{payload.target_column}'. Vérifiez vos critères de filtrage."
        )

    # === STATISTIQUES ET MÉTADONNÉES ===
    # Calculs sûrs pour éviter les NaN
    target_col = payload.target_column if payload.target_column in df_clean.columns else 'value'
    target_values = df_clean[target_col].dropna()
    
    stats = {
        "total_records": len(df_clean),
        "countries_count": df_clean['country_name'].nunique(),
        "regions_count": df_clean['who_region'].nunique(),
        "indicators_count": df_clean['indicator_type_name'].nunique(),
        "year_range": f"{int(df_clean['year'].min())}-{int(df_clean['year'].max())}" if not df_clean['year'].empty else "N/A",
        "value_range": f"{target_values.min():.2f}-{target_values.max():.2f}" if not target_values.empty else "N/A"
    }
    
    print(f"DataFrame créé: {stats}")

    # Convertir en dictionnaire pour l'envoi
    # IMPORTANT: Remplacer TOUS les NaN par None pour compatibilité JSON
    df_clean = df_clean.replace([np.nan, np.inf, -np.inf], None)
    
    df_dict = df_clean.to_dict(orient='records')

    return {
        "success": True,
        "data": df_dict,
        "shape": df_clean.shape,
        "columns": df_clean.columns.tolist(),
        "target_column": payload.target_column,
        "statistics": stats,
        "metadata": {
            "filters_applied": {
                "geographic": bool(payload.who_region or payload.pays or payload.countries),
                "temporal": bool(payload.year_min or payload.year_max or payload.years),
                "value_based": bool(payload.value_min is not None or payload.value_max is not None),
                "quality_based": bool(payload.data_quality)
            },
            "optimization": {
                "max_records_requested": payload.max_records,
                "actual_records": len(df_clean),
                "include_confidence": payload.include_confidence
            }
        }
    }


@app.get("/tables/")
async def get_available_tables():
    """
    Endpoint pour fournir les informations sur le nouveau schéma normalisé.
    """
    return {
        "tables": {
            "health_indicators": "Table principale contenant tous les indicateurs de santé",
            "countries": "Table des pays avec régions WHO",
            "indicator_types": "Types d'indicateurs disponibles"
        },
        "filters": {
            "country": "Filtrer par nom de pays",
            "region": "Filtrer par région WHO",
            "indicator_type": "Filtrer par type d'indicateur", 
            "value_type": "Filtrer par type de valeur",
            "year": "Filtrer par année"
        }
    }

@app.get("/indicator-types/list/")
async def get_indicator_types_list(db: AsyncSession = Depends(get_db)):
    """
    Endpoint pour récupérer la liste des types d'indicateurs disponibles.
    """
    result = await db.execute(select(models.IndicatorType.name).distinct())
    indicator_types = [row[0] for row in result.fetchall()]
    return {"indicator_types": indicator_types}

@app.get("/countries/regions/")
async def get_who_regions(db: AsyncSession = Depends(get_db)):
    """
    Endpoint pour récupérer la liste des régions WHO disponibles.
    """
    result = await db.execute(select(models.Country.who_region).distinct().filter(models.Country.who_region.isnot(None)))
    regions = [row[0] for row in result.fetchall()]
    return {"who_regions": regions}

@app.get("/health-indicators/value-types/")
async def get_value_types(db: AsyncSession = Depends(get_db)):
    """
    Endpoint pour récupérer la liste des types de valeurs disponibles.
    """
    result = await db.execute(select(models.HealthIndicator.value_type).distinct())
    value_types = [row[0] for row in result.fetchall()]
    return {"value_types": value_types}

@app.get("/health-indicators/years/")
async def get_available_years(db: AsyncSession = Depends(get_db)):
    """
    Endpoint pour récupérer la liste des années disponibles.
    """
    result = await db.execute(select(models.HealthIndicator.year).distinct().order_by(models.HealthIndicator.year))
    years = [row[0] for row in result.fetchall()]
    return {"years": years}

@app.post("/train_model/", response_model=schemas.PredictionResponse)
async def train_model_endpoint(payload: schemas.TrainingRequest):
    try:
        """
        Endpoint pour entraîner le modèle avec les données fournies.
        """
        dataframe_dict = payload.dataframe
        target_column = payload.target_column
        
        if not dataframe_dict:
            raise HTTPException(status_code=400, detail=tr("missing_dataframe"))
        
        if not target_column:
            raise HTTPException(status_code=400, detail=tr("target_required"))

        # Convertir les données en DataFrame (gérer dict ou list)
        if isinstance(dataframe_dict, list):
            # Format liste de dictionnaires (nouveau format ultra-flexible)
            df = pd.DataFrame(dataframe_dict)
        elif isinstance(dataframe_dict, dict):
            # Format dictionnaire traditionnel
            df = pd.DataFrame.from_dict(dataframe_dict)
        else:
            raise HTTPException(
                status_code=400, 
                detail=f"Format de dataframe non supporté. Attendu: dict ou list, reçu: {type(dataframe_dict)}"
            )
            
        print(tr("avant_separation", shape=df.shape))
        print("DataFrame reçu :", df.head())
        print("Colonnes :", df.columns.tolist())
        print("Target column :", target_column)

        # Vérifier que la colonne cible existe
        if target_column not in df.columns:
            raise HTTPException(
                status_code=400, 
                detail=f"Colonne cible '{target_column}' non trouvée dans les données. Colonnes disponibles: {df.columns.tolist()}"
            )

        # Préparer les données avec la fonction de prediction.py
        X, y = prepare_data_generic(df, target_column=target_column)
        
        if y is None or len(y) == 0:
            raise HTTPException(status_code=400, detail=tr("target_required"))
        
        if len(X) == 0:
            raise HTTPException(status_code=400, detail="Aucune caractéristique disponible pour l'entraînement")

        # Préprocesser les caractéristiques
        X = preprocess_features(X)
        
        # Créer et entraîner le modèle
        model = create_voting_regressor()
        trained_model, rmse, r2, future_pred_value, future_year = train_voting_regressor(model, X, y)
        
        # Sauvegarder le modèle
        joblib.dump(trained_model, "voting_regressor.pkl")

        # Faire des prédictions sur toutes les données pour visualisation
        predictions = trained_model.predict(X)
        labels = list(df["year"]) if "year" in df.columns else (list(df["annee"]) if "annee" in df.columns else list(range(len(predictions))))

        return {
            "prediction": [safe(x) for x in predictions],
            "labels": [safe(x) for x in labels],
            "message": tr("model_trained"),
            "rmse": safe(rmse),
            "r2": safe(r2),
            "future_prediction": safe(future_pred_value),
            "future_year": safe(future_year)
        }
    except ValueError as ve:
        # Erreurs de validation spécifiques (pas assez de données, etc.)
        print(f"Erreur de validation dans /train_model/: {ve}")
        raise HTTPException(status_code=422, detail=str(ve))
    except Exception as e:
        import traceback
        print("Erreur dans /train_model/:", e)
        traceback.print_exc()
        raise HTTPException(status_code=500, detail=str(e))

# ========================
# ENDPOINT TEST PRÉDICTION
# ========================

@app.get("/test_prediction/")
async def test_prediction_endpoint(db: AsyncSession = Depends(get_db)):
    """
    Endpoint de test pour vérifier que la prédiction fonctionne avec des données réelles.
    Utilise le nouveau schéma normalisé.
    """
    try:
        # Récupérer des données d'indicateurs de santé pour test
        query = select(models.HealthIndicator).options(
            selectinload(models.HealthIndicator.country),
            selectinload(models.HealthIndicator.indicator_type)
        ).filter(models.HealthIndicator.value.isnot(None)).limit(50)
        
        result = await db.execute(query)
        health_indicators = result.scalars().all();
        
        if not health_indicators:
            return {"error": "Aucune donnée d'indicateur de santé disponible pour le test"}
        
        # Convertir en DataFrame
        data = []
        for indicator in health_indicators:
            data.append({
                "id": indicator.id,
                "country_name": indicator.country.name if indicator.country else None,
                "who_region": indicator.country.who_region if indicator.country else None,
                "indicator_type_name": indicator.indicator_type.name if indicator.indicator_type else None,
                "year": indicator.year,
                "value_type": indicator.value_type,
                "value": float(indicator.value),
                "confidence_min": float(indicator.confidence_min) if indicator.confidence_min else None,
                "confidence_max": float(indicator.confidence_max) if indicator.confidence_max else None
            })
        
        df_test = pd.DataFrame(data)
        
        # Ajouter quelques features synthétiques pour le test
        df_test['feature1'] = df_test['value'] * 1.2
        df_test['feature2'] = df_test['year'] / 100
        
        print(f"DataFrame de test: {df_test.shape}")
        print(f"Colonnes: {df_test.columns.tolist()}")
        
        # Préparer les données
        X, y = prepare_data_generic(df_test, target_column='value')
        
        if y is None or len(y) < 5:
            return {"error": "Pas assez de données pour l'entraînement"}
        
        # Préprocesser
        X = preprocess_features(X)
        
        # Entraîner le modèle
        model = create_voting_regressor()
        trained_model, rmse, r2, future_pred_value, future_year = train_voting_regressor(model, X, y)
        
        # Prédictions
        predictions = trained_model.predict(X)
        
        return {
            "status": "success",
            "data_shape": df_test.shape,
            "features_shape": X.shape,
            "target_size": len(y),
            "rmse": float(rmse),
            "r2": float(r2),
            "sample_predictions": [float(p) for p in predictions[:5]],
            "sample_actual": [float(v) for v in y.head(5)],
            "future_prediction": float(future_pred_value) if future_pred_value else None,
            "future_year": int(future_year) if future_year else None,
            "unique_countries": df_test['country_name'].nunique(),
            "unique_indicators": df_test['indicator_type_name'].nunique()
        }
        
    except Exception as e:
        import traceback
        print("Erreur dans test_prediction:", e)
        traceback.print_exc()
        return {"error": str(e), "traceback": traceback.format_exc()}

# ========================
# END POINTS - GESTION SCALABILITE (Nouveau schéma normalisé)
#========================

from sqlalchemy.orm import selectinload
from sqlalchemy import func

@app.get("/health-indicators/paginated/")
async def get_health_indicators_paginated(
    offset: int = Query(0, ge=0),
    limit: int = Query(25, ge=1, le=1000),
    country_name: str = Query(None),
    indicator_type_name: str = Query(None),
    who_region: str = Query(None),
    year: int = Query(None),
    value_type: str = Query(None),
    db: AsyncSession = Depends(get_db)
):
    """
    Endpoint paginé pour récupérer les indicateurs de santé avec filtres
    """
    print(f"Requête reçue - country_name: {country_name}, offset: {offset}, limit: {limit}")
    
    query = select(models.HealthIndicator).options(
        selectinload(models.HealthIndicator.country),
        selectinload(models.HealthIndicator.indicator_type)
    )
    
    # Filtres
    if country_name:
        query = query.join(models.Country).filter(models.Country.name.ilike(f"%{country_name}%"))
    if indicator_type_name:
        query = query.join(models.IndicatorType).filter(models.IndicatorType.name.ilike(f"%{indicator_type_name}%"))
    if who_region:
        query = query.join(models.Country).filter(models.Country.who_region == who_region)
    if year:
        query = query.filter(models.HealthIndicator.year == year)
    if value_type:
        query = query.filter(models.HealthIndicator.value_type == value_type)
    
    query = query.offset(offset).limit(limit)
    result = await db.execute(query)
    data = result.scalars().all()
    
    print(f"Nombre d'indicateurs trouvés: {len(data)}")
    if data:
        first_item = data[0]
        print(f"Premier élément - country_id: {first_item.country_id}, indicator_type_id: {first_item.indicator_type_id}")
        print(f"Relations - country: {first_item.country}, indicator_type: {first_item.indicator_type}")
        
        # Debug: vérifier si les IDs existent dans les tables
        if first_item.country_id:
            country_check = await db.execute(select(models.Country).filter(models.Country.id == first_item.country_id))
            country_exists = country_check.scalar_one_or_none()
            print(f"Country ID {first_item.country_id} existe: {country_exists is not None}")
        
        if first_item.indicator_type_id:
            indicator_check = await db.execute(select(models.IndicatorType).filter(models.IndicatorType.id == first_item.indicator_type_id))
            indicator_exists = indicator_check.scalar_one_or_none()
            print(f"IndicatorType ID {first_item.indicator_type_id} existe: {indicator_exists is not None}")
    
    return [
        {
            "id": indicator.id,
            "country_id": indicator.country_id,
            "country_name": indicator.country.name if indicator.country else None,
            "who_region": indicator.country.who_region if indicator.country else None,
            "indicator_type_id": indicator.indicator_type_id,
            "indicator_type_name": indicator.indicator_type.name if indicator.indicator_type else None,
            "year": indicator.year,
            "value_type": indicator.value_type,
            "value": float(indicator.value) if indicator.value else None,
            "value_text": indicator.value_text,
            "confidence_min": float(indicator.confidence_min) if indicator.confidence_min else None,
            "confidence_max": float(indicator.confidence_max) if indicator.confidence_max else None,
            "confidence_median": float(indicator.confidence_median) if indicator.confidence_median else None,
            "data_quality": indicator.data_quality,
            "source_file": indicator.source_file
        }
        for indicator in data
    ]

@app.get("/countries/paginated/")
async def get_countries_paginated(
    offset: int = Query(0, ge=0),
    limit: int = Query(25, ge=1, le=1000),
    who_region: str = Query(None),
    name_filter: str = Query(None),
    db: AsyncSession = Depends(get_db)
):
    """
    Endpoint paginé pour récupérer les pays avec filtres
    """
    query = select(models.Country)
    
    if who_region:
        query = query.filter(models.Country.who_region == who_region)
    if name_filter:
        query = query.filter(models.Country.name.ilike(f"%{name_filter}%"))
    
    query = query.offset(offset).limit(limit)
    result = await db.execute(query)
    data = result.scalars().all()
    
    return [
        {
            "id": country.id,
            "name": country.name,
            "who_region": country.who_region,
            "iso_code": country.iso_code,
            "created_at": country.created_at.isoformat() if country.created_at else None
        }
        for country in data
    ]

@app.get("/health-indicators/summary/")
async def get_health_indicators_summary(db: AsyncSession = Depends(get_db)):
    """
    Endpoint pour récupérer un résumé des indicateurs de santé
    """
    # Statistiques générales
    total_indicators = await db.execute(select(func.count(models.HealthIndicator.id)))
    total_indicators = total_indicators.scalar()
    
    indicators_with_values = await db.execute(
        select(func.count(models.HealthIndicator.id)).filter(models.HealthIndicator.value.isnot(None))
    )
    indicators_with_values = indicators_with_values.scalar()
    
    unique_countries = await db.execute(select(func.count(func.distinct(models.HealthIndicator.country_id))))
    unique_countries = unique_countries.scalar()
    
    unique_indicator_types = await db.execute(select(func.count(func.distinct(models.HealthIndicator.indicator_type_id))))
    unique_indicator_types = unique_indicator_types.scalar()
    
    # Répartition par région WHO
    region_stats = await db.execute(
        select(
            models.Country.who_region,
            func.count(func.distinct(models.Country.id)).label('country_count'),
            func.count(models.HealthIndicator.id).label('indicator_count')
        )
        .join(models.HealthIndicator, models.Country.id == models.HealthIndicator.country_id)
        .group_by(models.Country.who_region)
        .order_by(func.count(func.distinct(models.Country.id)).desc())
    )
    region_distribution = [
        {
            "who_region": region,
            "country_count": country_count,
            "indicator_count": indicator_count
        }
        for region, country_count, indicator_count in region_stats.fetchall()
    ]
    
    return {
        "total_indicators": total_indicators,
        "indicators_with_values": indicators_with_values,
        "data_completeness_rate": round((indicators_with_values / total_indicators) * 100, 2) if total_indicators > 0 else 0,
        "unique_countries": unique_countries,
        "unique_indicator_types": unique_indicator_types,
        "region_distribution": region_distribution
    }

# ========================
# ENDPOINTS DE COMPATIBILITÉ (pour le frontend existant)
# ========================

@app.get("/payslist/")
async def get_pays_legacy(db: AsyncSession = Depends(get_db)):
    """
    Endpoint de compatibilité pour l'ancien format payslist
    """
    result = await db.execute(select(models.Country))
    countries_list = result.scalars().all()
    return [{"id": country.id, "nom": country.name, "region": country.who_region} for country in countries_list]

@app.get("/pays/", response_model=List[schemas.Country])
async def get_pays_legacy_full(db: AsyncSession = Depends(get_db)):
    """
    Endpoint de compatibilité pour l'ancien format pays complet
    """
    return await get_countries_list(db)

# ========================
# ENDPOINTS - MAPPING ET COLUMNS
# ========================

@app.get("/tables/columns/")
async def get_table_columns(table: str = Query(...), db: AsyncSession = Depends(get_db)):
    """
    Endpoint pour récupérer les colonnes disponibles pour une table donnée.
    """
    # Mapping des "tables" frontend vers les types d'indicateurs
    table_mapping = {
        "health_indicators": None,  # Tous les indicateurs
        "population_hiv": "People living with HIV",
        "traitement": "ART Coverage",
        "transmission_mere_enfant": "Prevention of Mother-to-Child Transmission",
        "mortalite": "AIDS Deaths",
        "indicator_types": None  # Table spéciale pour les types d'indicateurs
    }
    
    if table == "indicator_types":
        # Retourner les colonnes des types d'indicateurs
        return {"columns": ["value", "year"]}
    
    # Colonnes numériques disponibles pour la prédiction
    available_columns = [
        "value",
        "confidence_min", 
        "confidence_max",
        "confidence_median",
        "year",
        "country_id",
        "indicator_type_id"
    ]
    
    return {"columns": available_columns}

@app.get("/tables/mapping/")
async def get_table_mapping():
    """
    Endpoint pour récupérer le mapping entre les noms de tables frontend et les types d'indicateurs.
    """
    return {
        "table_mapping": {
            "health_indicators": {
                "name": "Tous les indicateurs de santé",
                "indicator_type": None,
                "description": "Table principale contenant tous les indicateurs"
            },
            "population_hiv": {
                "name": "Population vivant avec le VIH", 
                "indicator_type": "People living with HIV",
                "description": "Données sur la population vivant avec le VIH"
            },
            "traitement": {
                "name": "Traitement antirétroviral",
                "indicator_type": "ART Coverage",
                "description": "Couverture du traitement antirétroviral"
            },
            "transmission_mere_enfant": {
                "name": "Transmission mère-enfant",
                "indicator_type": "Prevention of Mother-to-Child Transmission", 
                "description": "Prévention de la transmission mère-enfant"
            },
            "mortalite": {
                "name": "Mortalité liée au SIDA",
                "indicator_type": "AIDS Deaths",
                "description": "Données de mortalité liée au SIDA"
            },
            "indicator_types": {
                "name": "Types d'indicateurs",
                "indicator_type": None,
                "description": "Métadonnées sur les types d'indicateurs"
            }
        }
    }

# ========================
# ENDPOINTS ETL
# ========================

import subprocess
import json
from datetime import datetime

@app.get("/etl/source-files/")
async def get_source_files():
    """Retourne la liste des fichiers CSV sources et transformés avec gestion multi-encodage"""
    try:
        source_dir = Path("NewETL/SourceData")
        dataset_dir = Path("NewETL/DatasetClean")
        
        files = {
            "source_files": [],
            "processed_files": []
        }
        
        def try_read_csv_with_encoding(file_path, nrows=5, separator=','):
            """Essaie de lire un CSV avec plusieurs encodages"""
            encodings_to_try = ['utf-8', 'iso-8859-1', 'cp1252', 'utf-8-sig']
            
            for encoding in encodings_to_try:
                try:
                    df = pd.read_csv(file_path, nrows=nrows, sep=separator, encoding=encoding)
                    return df, encoding
                except UnicodeDecodeError:
                    continue
                except Exception:
                    # Si c'est une autre erreur, on continue avec l'encodage suivant
                    continue
            
            # Si aucun encodage ne fonctionne, lever une exception
            raise Exception(f"Impossible de décoder le fichier avec les encodages supportés")
        
        # Fichiers sources
        if source_dir.exists():
            for csv_file in source_dir.glob("*.csv"):
                try:
                    # Lire quelques lignes pour avoir un aperçu avec gestion d'encodage
                    df, encoding_used = try_read_csv_with_encoding(csv_file, nrows=5)
                    
                    # Convertir les données en format JSON-safe
                    preview_data = df.to_dict('records')
                    # Nettoyer les valeurs NaN qui peuvent poser problème en JSON
                    for row in preview_data:
                        for key, value in row.items():
                            if pd.isna(value):
                                row[key] = None
                    
                    files["source_files"].append({
                        "name": csv_file.name,
                        "path": str(csv_file),
                        "size": csv_file.stat().st_size,
                        "rows_sample": len(df),
                        "columns": list(df.columns),
                        "preview": preview_data,
                        "encoding": encoding_used,
                        "type": "source"
                    })
                except Exception as e:
                    files["source_files"].append({
                        "name": csv_file.name,
                        "path": str(csv_file),
                        "size": csv_file.stat().st_size if csv_file.exists() else 0,
                        "error": str(e),
                        "type": "source"
                    })
        
        # Fichiers traités (nouveaux fichiers CSV générés par NewETL)
        if dataset_dir.exists():
            for csv_file in dataset_dir.glob("*.csv"):
                try:
                    # Essayer d'abord avec ; puis avec , pour le séparateur
                    separator = ';'
                    try:
                        df, encoding_used = try_read_csv_with_encoding(csv_file, nrows=5, separator=separator)
                    except:
                        separator = ','
                        df, encoding_used = try_read_csv_with_encoding(csv_file, nrows=5, separator=separator)
                    
                    # Convertir les données en format JSON-safe
                    preview_data = df.to_dict('records')
                    # Nettoyer les valeurs NaN qui peuvent poser problème en JSON
                    for row in preview_data:
                        for key, value in row.items():
                            if pd.isna(value):
                                row[key] = None
                    
                    files["processed_files"].append({
                        "name": csv_file.name,
                        "path": str(csv_file),
                        "size": csv_file.stat().st_size,
                        "rows_sample": len(df),
                        "columns": list(df.columns),
                        "preview": preview_data,
                        "separator": separator,
                        "encoding": encoding_used,
                        "type": "processed"
                    })
                except Exception as e:
                    files["processed_files"].append({
                        "name": csv_file.name,
                        "path": str(csv_file),
                        "size": csv_file.stat().st_size if csv_file.exists() else 0,
                        "error": str(e),
                        "type": "processed"
                    })
        
        return files
    
    except Exception as global_error:
        # En cas d'erreur globale, retourner une réponse d'erreur structurée
        print(f"Erreur globale dans get_source_files: {global_error}")
        import traceback
        traceback.print_exc()
        
        # Retourner une structure minimale en cas d'erreur
        return {
            "source_files": [],
            "processed_files": [],
            "error": f"Erreur lors du chargement des fichiers: {str(global_error)}",
            "debug_info": {
                "source_dir_exists": Path("NewETL/SourceData").exists(),
                "dataset_dir_exists": Path("NewETL/DatasetClean").exists()
            }
        }

@app.get("/etl/file-preview/{file_type}/{file_name}")
async def get_file_preview(file_type: str, file_name: str, limit: int = 100):
    """Affiche un aperçu d'un fichier CSV avec détection automatique du séparateur et de l'encodage"""
    print(f"🔍 Preview demandé: {file_type}/{file_name}")
    
    try:
        if file_type == "source":
            file_path = Path("NewETL/SourceData") / file_name
        elif file_type == "processed":
            file_path = Path("NewETL/DatasetClean") / file_name
        else:
            raise HTTPException(status_code=400, detail="Type de fichier invalide")
        
        if not file_path.exists():
            print(f"❌ Fichier non trouvé: {file_path}")
            raise HTTPException(status_code=404, detail="Fichier non trouvé")
        
        print(f"📁 Fichier trouvé: {file_path}")
        
        # Essaie plusieurs encodages dans l'ordre de préférence
        encodings_to_try = ['utf-8', 'iso-8859-1', 'cp1252', 'utf-8-sig']
        df = None
        encoding_used = None
        separator = ','
        
        for encoding in encodings_to_try:
            try:
                # Pour les fichiers dans DatasetClean, essayer d'abord le point-virgule
                if file_type == "processed":
                    try:
                        test_df = pd.read_csv(file_path, nrows=2, sep=';', encoding=encoding)
                        if len(test_df.columns) > 1:  # Si on a plusieurs colonnes, le séparateur est correct
                            separator = ';'
                        else:
                            separator = ','
                    except:
                        separator = ','
                
                # Charger le fichier avec l'encodage et le séparateur détectés
                print(f"📖 Tentative lecture avec encodage {encoding}, séparateur '{separator}'")
                df = pd.read_csv(file_path, nrows=limit, sep=separator, encoding=encoding)
                encoding_used = encoding
                print(f"✅ Lecture réussie: {len(df)} lignes, {len(df.columns)} colonnes")
                break
                
            except UnicodeDecodeError:
                print(f"⚠️ Erreur d'encodage avec {encoding}")
                continue
            except Exception as e:
                print(f"⚠️ Autre erreur avec {encoding}: {str(e)[:50]}...")
                continue
        
        if df is None:
            error_msg = f"Impossible de décoder le fichier {file_name} avec les encodages supportés: {', '.join(encodings_to_try)}"
            print(f"❌ {error_msg}")
            raise HTTPException(status_code=500, detail=error_msg)
        
        print("🔄 Préparation de la réponse JSON...")
        
        # Nettoyer les données pour éviter les problèmes JSON
        df_clean = df.replace([np.nan, np.inf, -np.inf], None)
        data_records = df_clean.to_dict('records')
        
        result = {
            "file_name": file_name,
            "file_type": file_type,
            "total_rows": len(df_clean),
            "columns": list(df_clean.columns),
            "data": data_records,
            "separator_used": separator,
            "encoding_used": encoding_used,
            "info": {
                "memory_usage": int(df_clean.memory_usage(deep=True).sum()),
                "dtypes": {col: str(dtype) for col, dtype in df_clean.dtypes.items()}
            }
        }
        
        print(f"✅ Réponse préparée: {len(data_records)} enregistrements")
        return result
        
    except HTTPException:
        print("❌ HTTPException re-raised")
        raise
    except Exception as e:
        error_msg = f"Erreur lors de la lecture: {str(e)}"
        print(f"❌ Erreur inattendue: {error_msg}")
        print("📋 Détails de l'erreur:")
        import traceback
        traceback.print_exc()
        raise HTTPException(status_code=500, detail=error_msg)

@app.post("/etl/run/")
async def run_etl_process():
    """Lance le processus ETL"""
    try:
        # Importer et utiliser directement la classe ETL
        import sys
        import os
        
        # Ajouter le chemin vers NewETL au sys.path
        etl_dir = Path("NewETL")
        if str(etl_dir) not in sys.path:
            sys.path.insert(0, str(etl_dir))
        
        # Changer le répertoire de travail vers NewETL
        original_cwd = os.getcwd()
        os.chdir(etl_dir)
        
        try:
            # Importer la classe ETL
            from NewETL import HealthDataETL
            
            # Créer une instance de l'ETL
            etl = HealthDataETL(
                source_dir="./SourceData",
                db_path="./DatasetClean/normalized_health_data.db"
            )
            
            # Exécuter le pipeline ETL
            results = etl.run_etl_pipeline()
            
            # Lire les logs ETL récents
            log_file = Path("new_etl.log")
            logs = []
            if log_file.exists():
                try:
                    with open(log_file, 'r', encoding='utf-8', errors='replace') as f:
                        logs = f.readlines()[-50:]  # Dernières 50 lignes
                except Exception as log_error:
                    logs = [f"Erreur lecture logs: {str(log_error)}"]
            
            return {
                "success": True,
                "message": "Pipeline ETL exécuté avec succès",
                "results": results,
                "logs": [line.strip() for line in logs],
                "timestamp": datetime.now().isoformat()
            }
            
        finally:
            # Restaurer le répertoire de travail original
            os.chdir(original_cwd)
        
    except ImportError as e:
        return {
            "success": False,
            "error": f"Erreur d'import du module ETL: {str(e)}",
            "timestamp": datetime.now().isoformat()
        }
    except Exception as e:
        return {
            "success": False,
            "error": str(e),
            "timestamp": datetime.now().isoformat()
        }

@app.get("/etl/logs/")
async def get_etl_logs(lines: int = 100):
    """Retourne les logs de l'ETL avec gestion robuste de l'encodage"""
    log_file = Path("NewETL/new_etl.log")
    
    if not log_file.exists():
        return {"logs": [], "message": "Aucun log disponible"}
    
    try:
        # Essaie plusieurs encodages pour lire le fichier de log
        encodings_to_try = ['utf-8', 'iso-8859-1', 'cp1252', 'utf-8-sig']
        all_lines = []
        encoding_used = None
        
        for encoding in encodings_to_try:
            try:
                with open(log_file, 'r', encoding=encoding) as f:
                    all_lines = f.readlines()
                    encoding_used = encoding
                    break
            except UnicodeDecodeError:
                continue
        
        if not all_lines:
            # Si aucun encodage n'a marché, essaie avec errors='replace'
            with open(log_file, 'r', encoding='utf-8', errors='replace') as f:
                all_lines = f.readlines()
                encoding_used = 'utf-8 (avec remplacement des caractères)'
        
        recent_lines = all_lines[-lines:] if len(all_lines) > lines else all_lines
        
        return {
            "logs": [line.strip() for line in recent_lines],
            "total_lines": len(all_lines),
            "encoding_used": encoding_used,
            "timestamp": datetime.now().isoformat()
        }
    except Exception as e:
        return {"error": str(e)}

@app.get("/etl/status/")
async def get_etl_status():
    """Retourne le statut du système ETL"""
    status = {
        "database_exists": False,
        "source_files_count": 0,
        "processed_files_count": 0,
        "last_etl_run": None,
        "health_indicators_count": 0
    }
    
    # Vérifier la base de données
    db_path = Path("normalized_health_data.db")
    if db_path.exists():
        status["database_exists"] = True
        status["database_size"] = db_path.stat().st_size
        
        # Compter les enregistrements
        try:
            async for db in get_db():
                result = await db.execute(select(models.HealthIndicator).count())
                status["health_indicators_count"] = result.scalar()
                break
        except Exception:
            pass
    
    # Compter les fichiers sources
    source_dir = Path("NewETL/SourceData")
    if source_dir.exists():
        status["source_files_count"] = len(list(source_dir.glob("*.csv")))
    
    # Compter les fichiers traités
    dataset_dir = Path("NewETL/DatasetClean")
    if dataset_dir.exists():
        status["processed_files_count"] = len(list(dataset_dir.glob("*.csv")))
    
    # Dernière exécution ETL
    log_file = Path("NewETL/new_etl.log")
    if log_file.exists():
        status["last_etl_run"] = datetime.fromtimestamp(log_file.stat().st_mtime).isoformat()
    
    return status

@app.get("/etl/test-encodings/")
async def test_file_encodings():
    """Teste les encodages des fichiers CSV sources"""
    
    source_dir = Path("NewETL/SourceData")
    if not source_dir.exists():
        return {"error": "Répertoire source non trouvé"}
    
    results = []
    
    for file_path in source_dir.glob("*.csv"):
        try:
            # Tester si le fichier peut être lu avec pandas avec différents encodages
            test_success = False
            working_encoding = None
            error_details = []
            
            encodings_to_test = ['utf-8', 'iso-8859-1', 'cp1252', 'utf-8-sig', 'latin1']
            
            for encoding in encodings_to_test:
                try:
                    # Tester la lecture avec pandas
                    df_test = pd.read_csv(file_path, encoding=encoding, nrows=5)
                    working_encoding = encoding
                    test_success = True
                    break
                except Exception as e:
                    error_details.append(f"{encoding}: {str(e)[:50]}")
                    continue
            
            # Obtenir la taille du fichier
            file_size = file_path.stat().st_size
            
            results.append({
                "file": file_path.name,
                "working_encoding": working_encoding,
                "test_success": test_success,
                "file_size": file_size,
                "errors": error_details if not test_success else []
            })
            
        except Exception as e:
            results.append({
                "file": file_path.name,
                "error": str(e),
                "test_success": False
            })
    
    return {
        "results": results,
        "total_files": len(results),
        "successful_files": len([r for r in results if r.get('test_success', False)]),
        "timestamp": datetime.now().isoformat()
    }

