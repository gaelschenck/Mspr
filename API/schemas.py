from pydantic import BaseModel
from typing import Optional


#schemas des pays
class PaysBase(BaseModel):
    nom: str
    region: Optional[str] = None

class PaysCreate(PaysBase):
    pass

class Pays(PaysBase):
    id_pays: int

    class Config:
        orm_mode = True

#schémas des unités
class UniteBase(BaseModel):
    libelle: str

class UniteCreate(UniteBase):
    pass

class Unite(UniteBase):
    id_unite: int

    class Config:
        orm_mode = True

#schémas des types de statistiques 
class TypeStatistiqueBase(BaseModel):
    libelle: str

class TypeStatistiqueCreate(TypeStatistiqueBase):
    pass

class TypeStatistique(TypeStatistiqueBase):
    id_type_statistique: int

    class Config:
        orm_mode = True

#schémas des types de traitement
class TypeTraitementBase(BaseModel):
    libelle: str

class TypeTraitementCreate(TypeTraitementBase):
    pass

class TypeTraitement(TypeTraitementBase):
    id_type_traitement: int

    class Config:
        orm_mode = True

#schémas des traitement
class TraitementBase(BaseModel):
    id_pays: int
    annee: int
    id_type_traitement: int
    couverture: float

class TraitementCreate(TraitementBase):
    pass

class Traitement(TraitementBase):
    id_traitement: int

    class Config:
        orm_mode = True

#schémas des statistitiques
class StatistiqueBase(BaseModel):
    id_pays: int
    annee: int
    id_type_statistique: int
    valeur: float
    id_unite: int

class StatistiqueCreate(StatistiqueBase):
    pass

class Statistique(StatistiqueBase):
    id_statistique: int

    class Config:
        orm_mode = True

#schémas de la population HIV
class PopulationHIVBase(BaseModel):
    id_pays: int
    annee: int
    population_hiv: int

class PopulationHIVCreate(PopulationHIVBase):
    pass

class PopulationHIV(PopulationHIVBase):
    id_population_hiv: int

    class Config:
        orm_mode = True

#schémas de la mortalité
class MortaliteBase(BaseModel):
    id_pays: int
    annee: int
    nombre_deces: int

class MortaliteCreate(MortaliteBase):
    pass

class Mortalite(MortaliteBase):
    id_mortalite: int

    class Config:
        orm_mode = True

#schémas de la transmission mère enfant
class TransmissionMereEnfantBase(BaseModel):
    id_pays: int
    annee: int
    taux_transmission: float

class TransmissionMereEnfantCreate(TransmissionMereEnfantBase):
    pass

class TransmissionMereEnfant(TransmissionMereEnfantBase):
    id_transmission: int

    class Config:
        orm_mode = True
