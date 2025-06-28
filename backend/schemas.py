from pydantic import BaseModel, Field
from datetime import datetime
from typing import Optional, List


### SCHEMAS POUR PAYS
class PaysBase(BaseModel):
    pays: str = Field(..., min_length=2, max_length=100)
    region_who: Optional[str] = Field(None, max_length=100)


class PaysCreate(PaysBase):
    pass


class Pays(PaysBase):
    id_pays: int

    class Config:
        from_attributes = True


### SCHEMAS POUR UNITE
class UniteBase(BaseModel):
    unite: str = Field(..., min_length=1, max_length=50)


class UniteCreate(UniteBase):
    pass


class Unite(UniteBase):
    id_unite: int

    class Config:
        from_attributes = True


### SCHEMAS POUR POPULATION HIV
class PopulationHIVBase(BaseModel):
    id_pays: int
    annee: int = Field(..., ge=1900, le=2100)
    valeur: float = Field(..., gt=0)
    id_unite: Optional[int] = None


class PopulationHIVCreate(PopulationHIVBase):
    pass


class PopulationHIV(PopulationHIVBase):
    id: int

    class Config:
        from_attributes = True


### SCHEMAS POUR MORTALITE
class MortaliteBase(BaseModel):
    id_pays: int
    annee: int = Field(..., ge=1900, le=2100)
    valeur: float = Field(..., gt=0)
    id_unite: Optional[int] = None


class MortaliteCreate(MortaliteBase):
    pass


class Mortalite(MortaliteBase):
    id: int

    class Config:
        from_attributes = True


### SCHEMAS POUR TRANSMISSION MERE-ENFANT
class TransmissionMereEnfantBase(BaseModel):
    id_pays: int
    besoin_arv_min: float = Field(..., ge=0)
    besoin_arv_median: float = Field(..., ge=0)
    besoin_arv_max: float = Field(..., ge=0)
    pourcentage_recu_min: float = Field(..., ge=0, le=100)
    pourcentage_recu_median: float = Field(..., ge=0, le=100)
    pourcentage_recu_max: float = Field(..., ge=0, le=100)


class TransmissionMereEnfantCreate(TransmissionMereEnfantBase):
    pass


class TransmissionMereEnfant(TransmissionMereEnfantBase):
    id_transmission: int

    class Config:
        from_attributes = True


### SCHEMAS POUR TRAITEMENT
class TraitementBase(BaseModel):
    id_pays: int
    valeur: float = Field(..., ge=0, le=100)
    id_unite: Optional[int] = None
    id_type_traitement: int


class TraitementCreate(TraitementBase):
    pass


class Traitement(TraitementBase):
    id: int

    class Config:
        from_attributes = True


### SCHEMAS POUR STATISTIQUE
class StatistiqueBase(BaseModel):
    id_pays: int
    annee: int = Field(..., ge=1900, le=2100)
    valeur: float = Field(..., gt=0)
    id_unite: Optional[int] = None
    id_type_statistique: int


class StatistiqueCreate(StatistiqueBase):
    pass


class Statistique(StatistiqueBase):
    id: int

    class Config:
        from_attributes = True


### SCHEMAS POUR TYPES DE STATISTIQUE ET TRAITEMENT
class TypeStatistiqueBase(BaseModel):
    nom_type_statistique: str = Field(..., min_length=3, max_length=100)


class TypeStatistiqueCreate(TypeStatistiqueBase):
    pass


class TypeStatistique(TypeStatistiqueBase):
    id_type_statistique: int

    class Config:
        from_attributes = True


class TypeTraitementBase(BaseModel):
    nom_type_traitement: str = Field(..., min_length=3, max_length=100)


class TypeTraitementCreate(TypeTraitementBase):
    pass


class TypeTraitement(TypeTraitementBase):
    id_type_traitement: int

    class Config:
        from_attributes = True


###Authentification

class UtilisateurBase(BaseModel):
    username: str

class UtilisateurCreate(UtilisateurBase):
    password: str
    role: str

class UtilisateurOut(UtilisateurBase):
    id: int
    role: str

    class Config:
        orm_mode = True