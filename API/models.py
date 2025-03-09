from sqlalchemy import Column, Integer, Sequence, String, DECIMAL, ForeignKey
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy.orm import relationship

Base = declarative_base()

class Pays(Base):
    __tablename__ = "pays"
    id_pays = Column(Integer, Sequence('pays_id_pays_seq'),primary_key=True, index=True)
    nom = Column(String(100))
    region = Column(String(100))

class Unite(Base):
    __tablename__ = "unite"
    id_unite = Column(Integer, Sequence('unite_id_unite_seq'), primary_key=True, index=True)
    libelle = Column(String(100))

class TypeStatistique(Base):
    __tablename__ = "type_statistique"
    id_type_statistique = Column(Integer, Sequence('type_statistique_id_type_statistique_seq'), primary_key=True, index=True)
    libelle = Column(String(100))

class TypeTraitement(Base):
    __tablename__ = "type_traitement"
    id_type_traitement = Column(Integer, Sequence('type_traitement_id_type_traitement_seq'), primary_key=True, index=True)
    libelle = Column(String(100))

class Traitement(Base):
    __tablename__ = "traitement"
    id_traitement = Column(Integer, Sequence('traitement_id_traitement_seq'), primary_key=True, index=True)
    id_pays = Column(Integer, ForeignKey("pays.id_pays"))
    annee = Column(Integer)
    id_type_traitement = Column(Integer, ForeignKey("type_traitement.id_type_traitement"))
    couverture = Column(DECIMAL(10, 2))

class Statistique(Base):
    __tablename__ = "statistique"
    id_statistique = Column(Integer, Sequence('statistique_id_statistique_seq'),primary_key=True, index=True)
    id_pays = Column(Integer, ForeignKey("pays.id_pays"))
    annee = Column(Integer)
    id_type_statistique = Column(Integer, ForeignKey("type_statistique.id_type_statistique"))
    valeur = Column(DECIMAL(10, 2))
    id_unite = Column(Integer, ForeignKey("unite.id_unite"))

class PopulationHIV(Base):
    __tablename__ = "population_hiv"
    id_population_hiv = Column(Integer, Sequence('population_hiv_id_population_hiv_seq'), primary_key=True, index=True)
    id_pays = Column(Integer, ForeignKey("pays.id_pays"))
    annee = Column(Integer)
    population_hiv = Column(Integer)

class Mortalite(Base):
    __tablename__ = "mortalite"
    id_mortalite = Column(Integer, Sequence('mortalite_id_mortalite_seq'), primary_key=True, index=True)
    id_pays = Column(Integer, ForeignKey("pays.id_pays"))
    annee = Column(Integer)
    nombre_deces = Column(Integer)

class TransmissionMereEnfant(Base):
    __tablename__ = "transmission_mere_enfant"
    id_transmission = Column(Integer, Sequence('transmission_mere_enfant_id_transmission_seq'), primary_key=True, index=True)
    id_pays = Column(Integer, ForeignKey("pays.id_pays"))
    annee = Column(Integer)
    taux_transmission = Column(DECIMAL(5, 2))
