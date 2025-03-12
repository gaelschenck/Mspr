from fastapi import FastAPI, Depends, HTTPException
from sqlalchemy.ext.asyncio import AsyncSession
from sqlalchemy import select, update, delete
from typing import List
import models, schemas
from database import engine, get_db

# Déclare `app`
app = FastAPI(title="MSPR API", version="1.0.0")


# Initialisation de la base de données
async def init_db():
    async with engine.begin() as conn:
        await conn.run_sync(models.Base.metadata.create_all)


@app.on_event("startup")
async def startup():
    await init_db()


# ========================
# Endpoints PAYS
# ========================


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
# RUN SERVER
# ========================

if __name__ == "__main__":
    import uvicorn

    uvicorn.run(app, host="127.0.0.1", port=8000, reload=True)
