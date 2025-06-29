from sqlalchemy.ext.asyncio import AsyncSession, create_async_engine
from sqlalchemy.orm import sessionmaker, declarative_base
from sqlalchemy.pool import NullPool
import os
import asyncio
import logging
from dotenv import load_dotenv

# Configuration du logging
logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)

# Base déclarative pour les modèles (doit être définie tôt)
Base = declarative_base()

# Charge les variables d'environnement depuis .env
load_dotenv(dotenv_path=".env")
engine = None

async def create_engine_with_retry(database_url, max_retries=5, retry_delay=2):
    """
    Crée un engine avec retry automatique en cas d'échec de connexion
    """
    for attempt in range(max_retries):
        try:
            logger.info(f"Tentative de connexion {attempt + 1}/{max_retries} à la base de données...")
            
            # Configuration du pool de connexions plus robuste
            engine = create_async_engine(
                database_url,
                echo=False,  # Réduire les logs en production
                pool_size=10,  # Taille du pool de connexions
                max_overflow=20,  # Connexions supplémentaires en cas de pic
                pool_pre_ping=True,  # Vérifie les connexions avant utilisation
                pool_recycle=3600,  # Recycle les connexions après 1h
                poolclass=NullPool if os.getenv("DISABLE_POOL") else None,  # Permet de désactiver le pool si nécessaire
            )
            
            # Test de connexion
            async with engine.begin() as conn:
                await conn.exec_driver_sql("SELECT 1")
                
            logger.info("Connexion à la base de données établie avec succès !")
            return engine
            
        except Exception as e:
            logger.warning(f"Échec de la connexion (tentative {attempt + 1}/{max_retries}): {e}")
            if attempt < max_retries - 1:
                logger.info(f"Nouvelle tentative dans {retry_delay} secondes...")
                await asyncio.sleep(retry_delay)
                retry_delay *= 1.5  # Backoff exponentiel
            else:
                logger.error("Toutes les tentatives de connexion ont échoué !")
                raise

async def health_check_db(engine):
    """
    Vérifie la santé de la connexion à la base de données
    """
    try:
        async with engine.begin() as conn:
            await conn.exec_driver_sql("SELECT 1")
        return True
    except Exception as e:
        logger.error(f"Health check échoué: {e}")
        return False
# Récupération des variables d'environnement
POSTGRES_USER = os.getenv("POSTGRES_USER")
POSTGRES_PASSWORD = os.getenv("POSTGRES_PASSWORD")
POSTGRES_HOST = os.getenv("POSTGRES_HOST")
POSTGRES_PORT = os.getenv("POSTGRES_PORT")
POSTGRES_DB = os.getenv("POSTGRES_DB")

# Vérification des variables d'environnement
if POSTGRES_DB:
    logger.info(f"Configuration DB: User={POSTGRES_USER}, Host={POSTGRES_HOST}, Port={POSTGRES_PORT}, DB={POSTGRES_DB}")
    
    # Vérification stricte seulement si POSTGRES_DB est utilisé
    if not all([POSTGRES_USER, POSTGRES_PASSWORD, POSTGRES_HOST, POSTGRES_PORT, POSTGRES_DB]):
        raise ValueError(
            "Erreur : Certaines variables d'environnement ne sont pas chargées. Vérifie ton fichier .env !"
        )
    
    DATABASE_URL = f"postgresql+asyncpg://{POSTGRES_USER}:{POSTGRES_PASSWORD}@{POSTGRES_HOST}:{POSTGRES_PORT}/{POSTGRES_DB}"
    logger.info(f"URL de connexion: postgresql+asyncpg://{POSTGRES_USER}:***@{POSTGRES_HOST}:{POSTGRES_PORT}/{POSTGRES_DB}")
    
    # Initialisation de l'engine avec retry
    try:
        import asyncio
        # On ne peut pas utiliser await ici, donc on créera l'engine dans une fonction d'initialisation
        engine = None  # Sera initialisé plus tard
    except Exception as e:
        logger.error(f"Erreur lors de l'initialisation: {e}")
        engine = None
else:
    # Vérifier si on est en mode test avec TEST_MODE
    TEST_MODE = os.getenv("TEST_MODE", "false").lower() == "true"
    
    if TEST_MODE:
        # En mode test, utiliser SQLite en mémoire
        DATABASE_URL = "sqlite+aiosqlite:///:memory:"
        logger.info("Mode TEST activé - Utilisation de SQLite en mémoire")
        engine = None
    else:
        # Pas de base principale, on laisse le script d'init gérer ses propres connexions
        logger.info("Aucune base de données principale configurée")
        DATABASE_URL = None
        engine = None

# Fonction d'initialisation de l'engine
async def initialize_engine():
    """
    Initialise l'engine de base de données avec retry
    """
    global engine, SessionLocal
    
    if DATABASE_URL and engine is None:
        try:
            # Configuration spéciale pour SQLite en mode test
            if "sqlite" in DATABASE_URL:
                from sqlalchemy.pool import StaticPool
                engine = create_async_engine(
                    DATABASE_URL,
                    echo=False,
                    poolclass=StaticPool,
                    connect_args={"check_same_thread": False},
                )
                # Créer les tables pour SQLite
                async with engine.begin() as conn:
                    await conn.run_sync(Base.metadata.create_all)
                logger.info("Engine SQLite initialisé avec tables créées")
            else:
                engine = await create_engine_with_retry(DATABASE_URL)
                logger.info("Engine PostgreSQL initialisé avec succès")
            
            SessionLocal = sessionmaker(bind=engine, class_=AsyncSession, expire_on_commit=False)
        except Exception as e:
            logger.error(f"Échec de l'initialisation de l'engine: {e}")
            raise
    
    return engine

# Création de la session asynchrone (sera initialisée plus tard)
SessionLocal = None

# Dépendance pour récupérer la session de la base de données
async def get_db():
    """
    Dépendance FastAPI pour obtenir une session de base de données
    Inclut une vérification de santé et une reconnexion automatique si nécessaire
    """
    global engine, SessionLocal
    
    # Initialiser l'engine si pas encore fait
    if engine is None:
        await initialize_engine()
    
    if SessionLocal is None:
        raise RuntimeError("Aucune base de données principale configurée.")
    
    # Vérification de santé de la connexion
    try:
        # Test rapide de la connexion
        async with engine.begin() as conn:
            await conn.exec_driver_sql("SELECT 1")
    except Exception as e:
        logger.warning(f"Connexion DB défaillante, tentative de reconnexion: {e}")
        try:
            # Tentative de reconnexion
            await engine.dispose()
            engine = await create_engine_with_retry(DATABASE_URL)
            SessionLocal = sessionmaker(bind=engine, class_=AsyncSession, expire_on_commit=False)
            logger.info("Reconnexion réussie")
        except Exception as reconnect_error:
            logger.error(f"Échec de la reconnexion: {reconnect_error}")
            raise RuntimeError(f"Impossible de se connecter à la base de données: {reconnect_error}")
    
    # Fournir la session
    async with SessionLocal() as session:
        try:
            yield session
        except Exception as e:
            logger.error(f"Erreur dans la session DB: {e}")
            await session.rollback()
            raise
        finally:
            await session.close()