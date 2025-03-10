from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker, declarative_base
from dotenv import load_dotenv
import os

# Charger les variables d'environnement
load_dotenv()

# Configuration PostgreSQL
POSTGRES_USER = os.getenv("POSTGRES_USER", "florentbaccard")
POSTGRES_PASSWORD = os.getenv("POSTGRES_PASSWORD", "postgres")
POSTGRES_HOST = os.getenv("POSTGRES_HOST", "localhost")
POSTGRES_PORT = os.getenv("POSTGRES_PORT", "5432")
POSTGRES_DB = os.getenv("POSTGRES_DB", "bdd_mspr")

# Construction de l'URL de connexion PostgreSQL
DATABASE_URL = f"postgresql+psycopg://{POSTGRES_USER}:{POSTGRES_PASSWORD}@{POSTGRES_HOST}:{POSTGRES_PORT}/{POSTGRES_DB}"

# Création du moteur SQLAlchemy avec echo=True pour voir les requêtes SQL
engine = create_engine(DATABASE_URL, echo=True)

# Session SQLAlchemy
SessionLocal = sessionmaker(autocommit=False, autoflush=False, bind=engine)

# Base déclarative pour les modèles
Base = declarative_base()

# Dépendance pour obtenir la session de base de données
def get_db():
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close() 