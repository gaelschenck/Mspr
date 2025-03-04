from sqlalchemy import Column, Integer, String, Enum
from sqlalchemy.orm import relationship
from ..db.db_property.property import Base
from Enum.Unit_enum import Unit_enum

class Unité(Base):
    __tablename__ = 'unité'

    id = Column(Integer, primary_key=True, autoincrement=True)
    unité = Column(Enum(Unit_enum), nullable=False)
    description = Column(String, nullable=True)

    statistiques = relationship("Statistique", back_populates="unité")
    couverture_traitement = relationship("CouvertureTraitement", back_populates="unité")