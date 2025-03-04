from sqlalchemy import Column, Integer,Numeric, ForeignKey
from sqlalchemy.orm import relationship
from ..db.db_property.property import Base

class CouvertureTraitement(Base):
    __tablename__ = 'couverture_traitement'

    id = Column(Integer, primary_key=True, autoincrement=True, unique=True)
    id_pays = Column(Integer, ForeignKey('pays.id'), nullable=False)
    annee = Column(Integer, nullable=False)
    couverture_enfant = Column(Numeric(10, 2), nullable=False)
    couverture_adulte = Column(Numeric(10, 2), nullable=False)
    id_unité = Column(Integer, ForeignKey('unité.id'), nullable=False)

    pays = relationship("Pays", back_populates="couverture_traitement")
    unité = relationship("Unité", back_populates="couverture_traitement")
