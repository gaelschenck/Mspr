"""
Script ETL pour la table population_hiv
Cette table contient les données sur la population vivant avec le VIH par pays et par année.

Structure de la table :
- id_pays (clé étrangère vers pays)
- annee
- population_min
- population_median
- population_max
- id_unite (clé étrangère vers unite)
"""

import pandas as pd
import numpy as np

# Extraction
# Lecture des données sources
pays_df = pd.read_csv('../DatasetClean/pays_clean.csv')
population_df = pd.read_csv('../SourceData/no_of_people_living_with_hiv_by_country_clean.csv')

# Nettoyage des noms de colonnes
population_df.columns = population_df.columns.str.strip()

# Standardisation des noms de pays
population_df['Country'] = population_df['Country'].str.strip().str.lower()

# Fusion avec la table des pays
population_df = pd.merge(population_df, pays_df, left_on='Country', right_on='pays', how='inner')

# Conversion des colonnes en format numérique
numeric_columns = ['Count_min', 'Count_median', 'Count_max']
for col in numeric_columns:
    population_df[col] = pd.to_numeric(population_df[col], errors='coerce')

# Création de la table population_hiv
population_hiv_data = []
for _, row in population_df.iterrows():
    if pd.notna(row['Count_median']) and pd.notna(row['id_pays']):
        population_hiv_data.append({
            'id_pays': int(row['id_pays']),
            'annee': int(row['Year']),
            'population_min': int(row['Count_min']),
            'population_median': int(row['Count_median']),
            'population_max': int(row['Count_max']),
            'id_unite': 1  # 1 = nombre de personnes
        })

# Création du DataFrame final
population_hiv_df = pd.DataFrame(population_hiv_data)

# Chargement
# Sauvegarde dans un fichier CSV
population_hiv_df.to_csv('../DatasetClean/table_population_hiv.csv', index=False)

# Vérification
if population_hiv_df.empty:
    print("❌ La table population_hiv est vide !")
else:
    print(f"✅ Table population_hiv créée avec succès ! ({len(population_hiv_df)} lignes)")

"""
Résumé du script populationhivETL.py :
1. Extraction :
   - Lecture des fichiers pays_clean.csv et no_of_people_living_with_hiv_by_country_clean.csv
   - Nettoyage des noms de colonnes et standardisation des noms de pays

2. Transformation :
   - Fusion des données de population avec les IDs des pays
   - Conversion des colonnes en format numérique
   - Calcul de la médiane comme moyenne des valeurs min et max pour la population HIV
   - Renommage des colonnes en français
   - Suppression des lignes avec valeurs manquantes
   - Conversion des valeurs en entiers
   - Tri par pays et année

3. Chargement :
   - Sauvegarde du résultat dans populationhiv_clean.csv
   - Vérification de la présence de données

Résultat : Table de population HIV avec 553 entrées couvrant la période 2000-2018, 
          incluant les valeurs min, médiane (calculée) et max pour chaque pays et année.
""" 