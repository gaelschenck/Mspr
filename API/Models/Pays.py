from sqlalchemy import Column, Integer, String
from sqlalchemy.orm import relationship
from ..db.db_property.property import Base

class Pays(Base):
    __tablename__ = 'pays'

    id = Column(Integer, primary_key=True, autoincrement=True)
    pays = Column(String(255), unique=True, nullable=False)
    region = Column(String(255), unique=True, nullable=False)

    couverture_traitement = relationship("CouvertureTraitement", back_populates="pays")
    statistiques = relationship("Statistique", back_populates="pays")