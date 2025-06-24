import asyncio
from sqlalchemy.ext.asyncio import create_async_engine, AsyncSession
from sqlalchemy.orm import sessionmaker
import models
from passlib.context import CryptContext
from dotenv import load_dotenv
import os
from pathlib import Path

load_dotenv(dotenv_path=Path(__file__).parent / ".env")

print("User:", os.getenv("POSTGRES_USER"), "Password:", os.getenv("POSTGRES_PASSWORD"), "Host:", os.getenv("POSTGRES_HOST"), "Port:", os.getenv("POSTGRES_PORT"), "DB_FR:", os.getenv("POSTGRES_DB_FR"))

user = os.getenv("POSTGRES_USER")
password = os.getenv("POSTGRES_PASSWORD")
host = os.getenv("POSTGRES_HOST")
port = os.getenv("POSTGRES_PORT")
db_fr = os.getenv("POSTGRES_DB_FR")
db_us = os.getenv("POSTGRES_DB_US")
db_ch = os.getenv("POSTGRES_DB_CH")

# Mets ici les URLs de connexion à chaque base (adapter selon ta config)
DATABASES = {
    
    "fr": f"postgresql+asyncpg://{user}:{password}@{host}:{port}/{db_fr}",
    "us": f"postgresql+asyncpg://{user}:{password}@{host}:{port}/{db_us}",
    "ch": f"postgresql+asyncpg://{user}:{password}@{host}:{port}/{db_ch}",
}

USERS = {
    "fr": [
        {"username": "adminfr", "password": "adminfr", "role": "admin"},
        {"username": "userfr", "password": "userfr", "role": "user"},
    ],
    "us": [
        {"username": "adminus", "password": "adminus", "role": "admin"},
        {"username": "userus", "password": "userus", "role": "user"},
    ],
    "ch": [
        {"username": "adminch", "password": "adminch", "role": "admin"},
        {"username": "userch", "password": "userch", "role": "user"},
    ],
}

pwd_context = CryptContext(schemes=["bcrypt"], deprecated="auto")

async def create_users_for_db(db_url, users):
    engine = create_async_engine(db_url, echo=False, future=True)
    async with engine.begin() as conn:
        await conn.run_sync(models.Base.metadata.create_all)
    async with AsyncSession(engine) as session:
        for u in users:
            result = await session.execute(
                models.Utilisateur.__table__.select().where(models.Utilisateur.username == u["username"])
            )
            if result.first() is None:
                user = models.Utilisateur(
                    username=u["username"],
                    hashed_password=pwd_context.hash(u["password"]),
                    role=u["role"]
                )
                session.add(user)
        await session.commit()
    await engine.dispose()

async def main():
    for key in DATABASES:
        print(f"Initialisation des utilisateurs pour la base {key.upper()}...")
        await create_users_for_db(DATABASES[key], USERS[key])
        print(f"OK pour {key.upper()}")

if __name__ == "__main__":
    asyncio.run(main())