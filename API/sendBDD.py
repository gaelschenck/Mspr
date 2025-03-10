import pandas as pd
from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker
from database import Base, engine, SessionLocal
from models import Pays, Unite, TypeStatistique, TypeTraitement,Traitement, Statistique, PopulationHIV, Mortalite

# Charger les variables d'environnement
from dotenv import load_dotenv
import os
load_dotenv()

# Lire le fichier CSV
df_pays = pd.read_csv('../ETL/Csv2Table/pays_clean2.csv')
df_unite = pd.read_csv('../ETL/Csv2Table/unite_clean2.csv')
df_typestatistique = pd.read_csv('../ETL/Csv2Table/type_statistique_clean2.csv')
df_typetraitement = pd.read_csv('../ETL/Csv2Table/type_traitement_clean2.csv')
df_traitement = pd.read_csv('../ETL/Csv2Table/traitement_clean.csv')
df_statistique = pd.read_csv('../ETL/Csv2Table/statistique_clean.csv')
df_populationHIV = pd.read_csv('../ETL/Csv2Table/population_hiv_clean.csv')
df_mortalite = pd.read_csv('../ETL/Csv2Table/mortalite_clean2.csv')
# df_transmission = pd.read_csv('../ETL/Csv2Table/unite_clean2.csv')

# Créer une session SQLAlchemy
Session = sessionmaker(bind=engine)
session = Session()

try:
    # Insérer les données dans la table pays
    for index, row in df_pays.iterrows():
        pays = Pays(id_pays=row['id_pays'], nom=row['nom'], region=row['region_who'])
        session.add(pays)
    session.commit()
    print("Données insérées avec succès dans la table 'pays'")

    # Insérer les données dans la table unite
    for index, row in df_unite.iterrows():
        unite = Unite(libelle=row['libelle'])
        session.add(unite)
    session.commit()
    print("Données insérées avec succès dans la table 'unite'")

    # Insérer les données dans la table type statistique
    for index, row in df_typestatistique.iterrows():
        unite = TypeStatistique(libelle=row['libelle'])
        session.add(unite)
    session.commit()
    print("Données insérées avec succès dans la table 'type_statistique'")


    # Insérer les données dans la table type traitement
    for index, row in df_typetraitement.iterrows():
        unite = TypeTraitement(libelle=row['libelle'])
        session.add(unite)
    session.commit()
    print("Données insérées avec succès dans la table 'type_traitement'")



except Exception as e:
    session.rollback()
    print(f"Erreur lors de l'insertion des données : {e}")
finally:
    session.close()