from typing import List
from fastapi import Depends, FastAPI, HTTPException
from fastapi.responses import RedirectResponse
from sqlalchemy.ext.asyncio import AsyncSession
from sqlalchemy.orm import Session
from sqlalchemy.future import select
from schemas import Pays, PaysCreate, Unite, UniteCreate,TypeStatistique, TypeTraitement, Traitement, Statistique, PopulationHIV, Mortalite, TransmissionMereEnfant, TypeStatistiqueCreate, TypeTraitementCreate, TraitementCreate, StatistiqueCreate, PopulationHIVCreate, MortaliteCreate, TransmissionMereEnfantCreate
from database import SessionLocal, engine, get_db
from models import Base, Pays as PaysModel, Unite as UniteModel, TypeStatistique as TypeStatistiqueModel, TypeTraitement as TypeTraitementModel, Traitement as TraitementModel, Statistique as StatistiqueModel, PopulationHIV as PopulationHIVModel, Mortalite as MortaliteModel, TransmissionMereEnfant as TransmissionMereEnfantModel

app = FastAPI()

Base.metadata.create_all(bind=engine)

@app.get("/", include_in_schema=False)
async def root():
    return RedirectResponse(url="/docs")
#
#partie pays
#
#(commande pour accéder : uvicorn main:app --reload)
#

# Create (Ajouter un nouveau pays)
@app.post("/pays/", response_model=Pays)
def create_pays(pays: PaysCreate, db: Session = Depends(get_db)):
    try:
        db_pays = PaysModel(**pays.dict())
        db.add(db_pays)
        db.commit()
        db.refresh(db_pays)
        return db_pays
    except Exception as e:
        db.rollback()  # Annuler la transaction en cas d'erreur
        raise HTTPException(status_code=500, detail=str(e))  # Lever une exception avec les détails de l'erreur

@app.get("/pays/", response_model=List[Pays])
def read_pays(skip: int = 0, limit: int = 10, db: Session = Depends(get_db)):
    return db.query(PaysModel).offset(skip).limit(limit).all()

@app.get("/pays/{id_pays}", response_model=Pays)
def read_pays_by_id(id_pays: int, db: Session = Depends(get_db)):
    db_pays = db.query(PaysModel).filter(PaysModel.id_pays == id_pays).first()
    if db_pays is None:
        raise HTTPException(status_code=404, detail="Pays not found")
    return db_pays

@app.put("/pays/{id_pays}", response_model=Pays)
def update_pays(id_pays: int, pays: PaysCreate, db: Session = Depends(get_db)):
    db_pays = db.query(PaysModel).filter(PaysModel.id_pays == id_pays).first()
    if db_pays is None:
        raise HTTPException(status_code=404, detail="Pays not found")
    db_pays.nom = pays.nom
    db_pays.region = pays.region
    db.commit()
    db.refresh(db_pays)
    return db_pays

@app.delete("/pays/{id_pays}", response_model=Pays)
def delete_pays(id_pays: int, db: Session = Depends(get_db)):
    db_pays = db.query(PaysModel).filter(PaysModel.id_pays == id_pays).first()
    if db_pays is None:
        raise HTTPException(status_code=404, detail="Pays not found")
    db.delete(db_pays)
    db.commit()
    return {"detail": "Pays deleted"}

#
#partie unité
#
#
#
@app.post("/unite/", response_model=Unite)
def create_unite(unite: UniteCreate, db: Session = Depends(get_db)):
    db_unite = UniteModel(**unite.dict())
    db.add(db_unite)
    db.commit()
    db.refresh(db_unite)
    return db_unite

@app.get("/unite/", response_model=List[Unite])
def read_unite(skip: int = 0, limit: int = 10, db: Session = Depends(get_db)):
    return db.query(UniteModel).offset(skip).limit(limit).all()

@app.get("/unite/{id_unite}", response_model=Unite)
def read_unite_by_id(id_unite: int, db: Session = Depends(get_db)):
    db_unite = db.query(UniteModel).filter(UniteModel.id_unite == id_unite).first()
    if db_unite is None:
        raise HTTPException(status_code=404, detail="Unite not found")
    return db_unite

@app.put("/unite/{id_unite}", response_model=Unite)
def update_unite(id_unite: int, unite: UniteCreate, db: Session = Depends(get_db)):
    db_unite = db.query(UniteModel).filter(UniteModel.id_unite == id_unite).first()
    if db_unite is None:
        raise HTTPException(status_code=404, detail="Unite not found")
    db_unite.libelle = unite.libelle
    db.commit()
    db.refresh(db_unite)
    return db_unite

@app.delete("/unite/{id_unite}", response_model=Unite)
def delete_unite(id_unite: int, db: Session = Depends(get_db)):
    db_unite = db.query(UniteModel).filter(UniteModel.id_unite == id_unite).first()
    if db_unite is None:
        raise HTTPException(status_code=404, detail="Unite not found")
    db.delete(db_unite)
    db.commit()
    return {"detail": "Pays deleted"}

#
#partie type_statistique
#
#
#

@app.post("/type_statistique/", response_model=TypeStatistique)
def create_type_statistique(type_statistique: TypeStatistiqueCreate, db: Session = Depends(get_db)):
    db_type_statistique = TypeStatistiqueModel(**type_statistique.dict())
    db.add(db_type_statistique)
    db.commit()
    db.refresh(db_type_statistique)
    return db_type_statistique

@app.get("/type_statistique/", response_model=List[TypeStatistique])
def read_type_statistiques(skip: int = 0, limit: int = 10, db: Session = Depends(get_db)):
    return db.query(TypeStatistiqueModel).offset(skip).limit(limit).all()

@app.get("/type_statistique/{id_type_statistique}", response_model=TypeStatistique)
def read_type_statistique_by_id(id_type_statistique: int, db: Session = Depends(get_db)):
    db_type_statistique = db.query(TypeStatistiqueModel).filter(TypeStatistiqueModel.id_type_statistique == id_type_statistique).first()
    if db_type_statistique is None:
        raise HTTPException(status_code=404, detail="TypeStatistique not found")
    return db_type_statistique

@app.put("/type_statistique/{id_type_statistique}", response_model=TypeStatistique)
def update_type_statistique(id_type_statistique: int, type_statistique: TypeStatistiqueCreate, db: Session = Depends(get_db)):
    db_type_statistique = db.query(TypeStatistiqueModel).filter(TypeStatistiqueModel.id_type_statistique == id_type_statistique).first()
    if db_type_statistique is None:
        raise HTTPException(status_code=404, detail="TypeStatistique not found")
    db_type_statistique.libelle = type_statistique.libelle
    db.commit()
    db.refresh(db_type_statistique)
    return db_type_statistique

@app.delete("/type_statistique/{id_type_statistique}", response_model=TypeStatistique)
def delete_type_statistique(id_type_statistique: int, db: Session = Depends(get_db)):
    db_type_statistique = db.query(TypeStatistiqueModel).filter(TypeStatistiqueModel.id_type_statistique == id_type_statistique).first()
    if db_type_statistique is None:
        raise HTTPException(status_code=404, detail="TypeStatistique not found")
    db.delete(db_type_statistique)
    db.commit()
    return 

#
#partie type traitement
#
#
#
@app.post("/type_traitement/", response_model=TypeTraitement)
def create_type_traitement(type_traitement: TypeTraitementCreate, db: Session = Depends(get_db)):
    db_type_traitement = TypeTraitementModel(**type_traitement.dict())
    db.add(db_type_traitement)
    db.commit()
    db.refresh(db_type_traitement)
    return db_type_traitement

@app.get("/type_traitement/", response_model=List[TypeTraitement])
def read_type_traitements(skip: int = 0, limit: int = 10, db: Session = Depends(get_db)):
    return db.query(TypeTraitementModel).offset(skip).limit(limit).all()

@app.get("/type_traitement/{id_type_traitement}", response_model=TypeTraitement)
def read_type_traitement_by_id(id_type_traitement: int, db: Session = Depends(get_db)):
    db_type_traitement = db.query(TypeTraitementModel).filter(TypeTraitementModel.id_type_traitement == id_type_traitement).first()
    if db_type_traitement is None:
        raise HTTPException(status_code=404, detail="TypeTraitement not found")
    return db_type_traitement

@app.put("/type_traitement/{id_type_traitement}", response_model=TypeTraitement)
def update_type_traitement(id_type_traitement: int, type_traitement: TypeTraitementCreate, db: Session = Depends(get_db)):
    db_type_traitement = db.query(TypeTraitementModel).filter(TypeTraitementModel.id_type_traitement == id_type_traitement).first()
    if db_type_traitement is None:
        raise HTTPException(status_code=404, detail="TypeTraitement not found")
    db_type_traitement.libelle = type_traitement.libelle
    db.commit()
    db.refresh(db_type_traitement)
    return db_type_traitement

@app.delete("/type_traitement/{id_type_traitement}", response_model=TypeTraitement)
def delete_type_traitement(id_type_traitement: int, db: Session = Depends(get_db)):
    db_type_traitement = db.query(TypeTraitementModel).filter(TypeTraitementModel.id_type_traitement == id_type_traitement).first()
    if db_type_traitement is None:
        raise HTTPException(status_code=404, detail="TypeTraitement not found")
    db.delete(db_type_traitement)
    db.commit()
    return {"detail": "TypeTraitement deleted"}

#
#partie traitement
#
#
#
@app.post("/traitement/", response_model=Traitement)
def create_traitement(traitement: TraitementCreate, db: Session = Depends(get_db)):
    db_traitement = TraitementModel(**traitement.dict())
    db.add(db_traitement)
    db.commit()
    db.refresh(db_traitement)
    return db_traitement

@app.get("/traitement/", response_model=List[Traitement])
def read_traitements(skip: int = 0, limit: int = 10, db: Session = Depends(get_db)):
    return db.query(TraitementModel).offset(skip).limit(limit).all()

@app.get("/traitement/{id_traitement}", response_model=Traitement)
def read_traitement_by_id(id_traitement: int, db: Session = Depends(get_db)):
    db_traitement = db.query(TraitementModel).filter(TraitementModel.id_traitement == id_traitement).first()
    if db_traitement is None:
        raise HTTPException(status_code=404, detail="Traitement not found")
    return db_traitement

@app.put("/traitement/{id_traitement}", response_model=Traitement)
def update_traitement(id_traitement: int, traitement: TraitementCreate, db: Session = Depends(get_db)):
    db_traitement = db.query(TraitementModel).filter(TraitementModel.id_traitement == id_traitement).first()
    if db_traitement is None:
        raise HTTPException(status_code=404, detail="Traitement not found")
    db_traitement.id_pays = traitement.id_pays
    db_traitement.annee = traitement.annee
    db_traitement.id_type_traitement = traitement.id_type_traitement
    db_traitement.couverture = traitement.couverture
    db.commit()
    db.refresh(db_traitement)
    return db_traitement

@app.delete("/traitement/{id_traitement}", response_model=Traitement)
def delete_traitement(id_traitement: int, db: Session = Depends(get_db)):
    db_traitement = db.query(TraitementModel).filter(TraitementModel.id_traitement == id_traitement).first()
    if db_traitement is None:
        raise HTTPException(status_code=404, detail="Traitement not found")
    db.delete(db_traitement)
    db.commit()
    return {"detail": "Traitement deleted"}

#
#partie statistique
#
#
#
@app.post("/statistique/", response_model=Statistique)
def create_statistique(statistique: StatistiqueCreate, db: Session = Depends(get_db)):
    db_statistique = StatistiqueModel(**statistique.dict())
    db.add(db_statistique)
    db.commit()
    db.refresh(db_statistique)
    return db_statistique

@app.get("/statistique/", response_model=List[Statistique])
def read_statistiques(skip: int = 0, limit: int = 10, db: Session = Depends(get_db)):
    return db.query(StatistiqueModel).offset(skip).limit(limit).all()

@app.get("/statistique/{id_statistique}", response_model=Statistique)
def read_statistique_by_id(id_statistique: int, db: Session = Depends(get_db)):
    db_statistique = db.query(StatistiqueModel).filter(StatistiqueModel.id_statistique == id_statistique).first()
    if db_statistique is None:
        raise HTTPException(status_code=404, detail="Statistique not found")
    return db_statistique

@app.put("/statistique/{id_statistique}", response_model=Statistique)
def update_statistique(id_statistique: int, statistique: StatistiqueCreate, db: Session = Depends(get_db)):
    db_statistique = db.query(StatistiqueModel).filter(StatistiqueModel.id_statistique == id_statistique).first()
    if db_statistique is None:
        raise HTTPException(status_code=404, detail="Statistique not found")
    db_statistique.id_pays = statistique.id_pays
    db_statistique.annee = statistique.annee
    db_statistique.id_type_statistique = statistique.id_type_statistique
    db_statistique.valeur = statistique.valeur
    db_statistique.id_unite = statistique.id_unite
    db.commit()
    db.refresh(db_statistique)
    return db_statistique

@app.delete("/statistique/{id_statistique}", response_model=Statistique)
def delete_statistique(id_statistique: int, db: Session = Depends(get_db)):
    db_statistique = db.query(StatistiqueModel).filter(StatistiqueModel.id_statistique == id_statistique).first()
    if db_statistique is None:
        raise HTTPException(status_code=404, detail="Statistique not found")
    db.delete(db_statistique)
    db.commit()
    return {"detail": "Statistique deleted"}

#
#partie population HIV
#
#
#
@app.post("/population_hiv/", response_model=PopulationHIV)
def create_population_hiv(population_hiv: PopulationHIVCreate, db: Session = Depends(get_db)):
    db_population_hiv = PopulationHIVModel(**population_hiv.dict())
    db.add(db_population_hiv)
    db.commit()
    db.refresh(db_population_hiv)
    return db_population_hiv

@app.get("/population_hiv/", response_model=List[PopulationHIV])
def read_population_hivs(skip: int = 0, limit: int = 10, db: Session = Depends(get_db)):
    return db.query(PopulationHIVModel).offset(skip).limit(limit).all()

@app.get("/population_hiv/{id_population_hiv}", response_model=PopulationHIV)
def read_population_hiv_by_id(id_population_hiv: int, db: Session = Depends(get_db)):
    db_population_hiv = db.query(PopulationHIVModel).filter(PopulationHIVModel.id_population_hiv == id_population_hiv).first()
    if db_population_hiv is None:
        raise HTTPException(status_code=404, detail="Population HIV not found")
    return db_population_hiv

@app.put("/population_hiv/{id_population_hiv}", response_model=PopulationHIV)
def update_population_hiv(id_population_hiv: int, population_hiv: PopulationHIVCreate, db: Session = Depends(get_db)):
    db_population_hiv = db.query(PopulationHIVModel).filter(PopulationHIVModel.id_population_hiv == id_population_hiv).first()
    if db_population_hiv is None:
        raise HTTPException(status_code=404, detail="Population HIV not found")
    db_population_hiv.id_pays = population_hiv.id_pays
    db_population_hiv.annee = population_hiv.annee
    db_population_hiv.population_hiv = population_hiv.population_hiv
    db.commit()
    db.refresh(db_population_hiv)
    return db_population_hiv

@app.delete("/population_hiv/{id_population_hiv}", response_model=PopulationHIV)
def delete_population_hiv(id_population_hiv: int, db: Session = Depends(get_db)):
    db_population_hiv = db.query(PopulationHIVModel).filter(PopulationHIVModel.id_population_hiv == id_population_hiv).first()
    if db_population_hiv is None:
        raise HTTPException(status_code=404, detail="Population HIV not found")
    db.delete(db_population_hiv)
    db.commit()
    return {"detail": "Population HIV deleted"}

#
#partie mortalité
#
#
#
@app.post("/mortalite/", response_model=Mortalite)
def create_mortalite(mortalite: MortaliteCreate, db: Session = Depends(get_db)):
    db_mortalite = MortaliteModel(**mortalite.dict())
    db.add(db_mortalite)
    db.commit()
    db.refresh(db_mortalite)
    return db_mortalite

@app.get("/mortalite/", response_model=List[Mortalite])
def read_mortalites(skip: int = 0, limit: int = 10, db: Session = Depends(get_db)):
    return db.query(MortaliteModel).offset(skip).limit(limit).all()

@app.get("/mortalite/{id_mortalite}", response_model=Mortalite)
def read_mortalite_by_id(id_mortalite: int, db: Session = Depends(get_db)):
    db_mortalite = db.query(MortaliteModel).filter(MortaliteModel.id_mortalite == id_mortalite).first()
    if db_mortalite is None:
        raise HTTPException(status_code=404, detail="Mortalite not found")
    return db_mortalite

@app.put("/mortalite/{id_mortalite}", response_model=Mortalite)
def update_mortalite(id_mortalite: int, mortalite: MortaliteCreate, db: Session = Depends(get_db)):
    db_mortalite = db.query(MortaliteModel).filter(MortaliteModel.id_mortalite == id_mortalite).first()
    if db_mortalite is None:
        raise HTTPException(status_code=404, detail="Mortalite not found")
    db_mortalite.id_pays = mortalite.id_pays
    db_mortalite.annee = mortalite.annee
    db_mortalite.nombre_deces = mortalite.nombre_deces
    db.commit()
    db.refresh(db_mortalite)
    return db_mortalite

@app.delete("/mortalite/{id_mortalite}", response_model=Mortalite)
def delete_mortalite(id_mortalite: int, db: Session = Depends(get_db)):
    db_mortalite = db.query(MortaliteModel).filter(MortaliteModel.id_mortalite == id_mortalite).first()
    if db_mortalite is None:
        raise HTTPException(status_code=404, detail="Mortalite not found")
    db.delete(db_mortalite)
    db.commit()
    return

#
#partie transmission mère enfant
#
#
#
@app.post("/transmission_mere_enfant/", response_model=TransmissionMereEnfant)
def create_transmission_mere_enfant(transmission_mere_enfant: TransmissionMereEnfantCreate, db: Session = Depends(get_db)):
    db_transmission_mere_enfant = TransmissionMereEnfantModel(**transmission_mere_enfant.dict())
    db.add(db_transmission_mere_enfant)
    db.commit()
    db.refresh(db_transmission_mere_enfant)
    return db_transmission_mere_enfant

@app.get("/transmission_mere_enfant/", response_model=List[TransmissionMereEnfant])
def read_transmission_mere_enfants(skip: int = 0, limit: int = 10, db: Session = Depends(get_db)):
    return db.query(TransmissionMereEnfantModel).offset(skip).limit(limit).all()

@app.get("/transmission_mere_enfant/{id_transmission}", response_model=TransmissionMereEnfant)
def read_transmission_mere_enfant_by_id(id_transmission: int, db: Session = Depends(get_db)):
    db_transmission_mere_enfant = db.query(TransmissionMereEnfantModel).filter(TransmissionMereEnfantModel.id_transmission == id_transmission).first()
    if db_transmission_mere_enfant is None:
        raise HTTPException(status_code=404, detail="Transmission Mère Enfant not found")
    return db_transmission_mere_enfant

@app.put("/transmission_mere_enfant/{id_transmission}", response_model=TransmissionMereEnfant)
def update_transmission_mere_enfant(id_transmission: int, transmission_mere_enfant: TransmissionMereEnfantCreate, db: Session = Depends(get_db)):
    db_transmission_mere_enfant = db.query(TransmissionMereEnfantModel).filter(TransmissionMereEnfantModel.id_transmission == id_transmission).first()
    if db_transmission_mere_enfant is None:
        raise HTTPException(status_code=404, detail="Transmission Mère Enfant not found")
    db_transmission_mere_enfant.id_pays = transmission_mere_enfant.id_pays
    db_transmission_mere_enfant.annee = transmission_mere_enfant.annee
    db_transmission_mere_enfant.taux_transmission = transmission_mere_enfant.taux_transmission
    db.commit()
    db.refresh(db_transmission_mere_enfant)
    return db_transmission_mere_enfant

@app.delete("/transmission_mere_enfant/{id_transmission}", response_model=TransmissionMereEnfant)
def delete_transmission_mere_enfant(id_transmission: int, db: Session = Depends(get_db)):
    db_transmission_mere_enfant = db.query(TransmissionMereEnfantModel).filter(TransmissionMereEnfantModel.id_transmission == id_transmission).first()
    if db_transmission_mere_enfant is None:
        raise HTTPException(status_code=404, detail="Transmission Mère Enfant not found")
    db.delete(db_transmission_mere_enfant)
    db.commit()
    return {"detail": "Transmission Mère Enfant deleted"}