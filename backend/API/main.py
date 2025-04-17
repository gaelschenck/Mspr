from fastapi import FastAPI, Depends, HTTPException
import joblib
from sqlalchemy.ext.asyncio import AsyncSession
from sqlalchemy import select, update, delete
from typing import List
import models, schemas
from database import engine, get_db
import sys
import os
from fastapi.middleware.cors import CORSMiddleware
from contextlib import asynccontextmanager
from prediction import create_voting_regressor, prepare_data_generic, preprocess_features, train_voting_regressor
import pandas as pd
sys.path.append(os.path.dirname(os.path.abspath(__file__)))

# Déclare `app`
@asynccontextmanager
async def lifespan(app: FastAPI):
    await init_db()
    yield

app = FastAPI(title="MSPR API", version="1.0.0", lifespan=lifespan)

# ========================
# Configuration des CORS
# ========================  
app.add_middleware(
    CORSMiddleware,
    allow_origins=["http://localhost:5173"],  # Permet toutes les origines. Tu peux spécifier ici une liste d'origines autorisées.
    allow_credentials=True,
    allow_methods=["*"],  # Permet toutes les méthodes HTTP (GET, POST, etc.).
    allow_headers=["Authorization", "Content-Type","*"],  # Permet tous les types d'en-têtes.
)
@app.options("/{path:path}")
async def options_handler():
    return {"message": "Préflight OPTIONS accepté"}


# Initialisation de la base de données
async def init_db():
    async with engine.begin() as conn:
        await conn.run_sync(models.Base.metadata.create_all)





# ========================
# Endpoints PAYS
# ========================
@app.get("/payslist/")
async def get_pays(db: AsyncSession = Depends(get_db)):
    """
    Endpoint pour récupérer les informations des pays depuis la table `pays`.
    """
    result = await db.execute(select(models.Pays))  # Adapte `Pays` à ton modèle SQLAlchemy
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
        raise HTTPException(status_code=404, detail="Pays non trouvé")

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
        raise HTTPException(status_code=404, detail="Pays non trouvé")

    await db.execute(delete(models.Pays).where(models.Pays.id_pays == pays_id))
    await db.commit()
    return {"message": "Pays supprimé avec succès"}


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
    return {"message": "Bienvenue sur l'API MSPR!"}


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
    print(region,pays,table,target_column)

    if table not in ["mortalite", "population_hiv", "statistique", "traitement", "transmission_mere_enfant", "type_statistique", "type_traitement", "unite"]:
        raise HTTPException(status_code=400, detail="Table invalide")
    # Vérification des paramètres
    if not region and not pays:
        raise HTTPException(status_code=400, detail="Region ou pays doivent être renseignés")

    query_pays = select(models.Pays)
    if region:
        query_pays = query_pays.filter(models.Pays.region == region)
    if pays:
        query_pays = query_pays.filter(models.Pays.nom_pays == pays)

    result_pays = await db.execute(query_pays)
    data_pays = result_pays.scalars().all()

    # Charger les données de la table sélectionnée
    query_table = select(getattr(models, table.capitalize()))
    result_table = await db.execute(query_table)
    data_table = result_table.scalars().all()

    # Conversion des données en DataFrames
    df_pays = pd.DataFrame([item.__dict__ for item in data_pays])
    df_table = pd.DataFrame([item.__dict__ for item in data_table])

    # Nettoyage des colonnes inutiles
    df_pays = df_pays.drop("_sa_instance_state", axis=1, errors="ignore")
    df_table = df_table.drop("_sa_instance_state", axis=1, errors="ignore")
    print(f"✅ df_pays : { df_pays }")
    print(f"✅ df_table { df_table }")  
    # Fusion des deux DataFrames pour créer un DataFrame croisé
    try:
        dataframe_croise = pd.merge(df_pays, df_table, on="id_pays", how="inner") 
        print(f"✅ Données chargées. Dataframe croisé : { dataframe_croise }") # `id_pays` est la clé de fusion
        return {"dataframe": dataframe_croise.to_dict()}  # Retourne le DataFrame croisé sous forme de dictionnaire
    except KeyError:
        raise HTTPException(status_code=400, detail="Les clés de fusion ne correspondent pas entre les tables")



@app.get("/tables/")
async def get_available_tables():
    """
    Endpoint pour fournir les noms des tables disponibles et leurs relations.
    """
    tables = {"mortalite", "population_hiv", "statistque","traitement","transmission_mere_enfant"}
   
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
        raise HTTPException(status_code=404, detail=f"Table '{table_name}' introuvable")

    # Récupère les colonnes du modèle
    columns = [column.key for column in model.__table__.columns]
    return {"columns": columns}

@app.post("/train_model/")
async def train_model_endpoint(payload: dict):
    """
    Endpoint pour entraîner le modèle avec les données fournies.
    """
    dataframe_dict = payload.get("dataframe")
    target_column = payload.get("target_column")  # Récupérer dynamiquement la colonne cible
    print(f"✅ Données chargées. Dataframe : { dataframe_dict }")
    print(f"✅ Données chargées. Colonne cible : { target_column }")
    if not dataframe_dict:
        raise HTTPException(status_code=400, detail="Le DataFrame est manquant")

    # Convertir le dictionnaire en DataFrame
    df = pd.DataFrame.from_dict(dataframe_dict)
    print(f"Avant séparation, taille du DataFrame : {df.shape}")

    #test
    X = df.drop(columns=[target_column, "region", "nom_pays", "sous_region","id_unite"])  # Définir X avant usage
    
    y = df[target_column]

# Nettoyer le DataFrame avec la fonction importée depuis prediction.py
    X = preprocess_features(X)

   # Préparer les données de manière générique
    X, y = prepare_data_generic(df, target_column=target_column)

    # Vérification : une colonne cible est-elle fournie ?
    if y is None:
        raise HTTPException(status_code=400, detail="La colonne cible est requise pour l'entraînement")

    # Créer le modèle
    model = create_voting_regressor()

    # Entraîner le modèle
    trained_model = train_voting_regressor(model, X, y)
    
    # Sauvegarder le modèle
    joblib.dump(trained_model, "voting_regressor.pkl")


    return {"message": "Modèle entraîné avec succès"}


# ========================
# RUN SERVER
# ========================

if __name__ == "__main__":
    import uvicorn

    uvicorn.run(app, host="127.0.0.1", port=8000, reload=True)
