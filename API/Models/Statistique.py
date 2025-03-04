from sqlalchemy import Column, Integer, Enum, ForeignKey
from sqlalchemy.orm import relationship
from ..db.db_property.property import Base
from Enum.Statistique_enum import Statistique_enum

class Statistique(Base):
    __tablename__ = 'statistique'

    id = Column(Integer, primary_key=True, autoincrement=True, unique=True)
    id_pays = Column(Integer, ForeignKey('pays.id'), nullable=False)
    medianne = Column(Integer, nullable=False)
    min = Column(Integer, nullable=False)
    max = Column(Integer, nullable=False)
    type = Column(Enum(Statistique_enum), nullable=False)
    annee = Column(Integer, nullable=False)
    id_unité = Column(Integer, ForeignKey('unité.id'), nullable=False)

    pays = relationship("Pays", back_populates="statistiques")
    unité = relationship("Unité", back_populates="statistiques")