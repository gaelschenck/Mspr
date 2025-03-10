"""
Script ETL pour la table mortalite
Cette table contient les données sur la mortalité liée au VIH par pays et par année.

Structure de la table :
- id_pays (clé étrangère vers pays)
- annee
- mortalite_min
- mortalite_median
- mortalite_max
- id_unite (clé étrangère vers unite)
"""

import pandas as pd
import numpy as np

# Extraction
# Lecture des données sources
pays_df = pd.read_csv('../DatasetClean/pays_clean.csv')
mortalite_df = pd.read_csv('../SourceData/no_of_deaths_by_country_clean.csv')

# Nettoyage des noms de colonnes
mortalite_df.columns = mortalite_df.columns.str.strip()

# Standardisation des noms de pays
mortalite_df['Country'] = mortalite_df['Country'].str.strip().str.lower()

# Fusion avec la table des pays
mortalite_df = pd.merge(mortalite_df, pays_df, left_on='Country', right_on='pays', how='inner')

# Conversion des colonnes en format numérique
numeric_columns = ['Count_min', 'Count_median', 'Count_max']
for col in numeric_columns:
    mortalite_df[col] = pd.to_numeric(mortalite_df[col], errors='coerce')

# Création de la table mortalite
mortalite_data = []
for _, row in mortalite_df.iterrows():
    if pd.notna(row['Count_median']) and pd.notna(row['id_pays']):
        mortalite_data.append({
            'id_pays': int(row['id_pays']),
            'annee': int(row['Year']),
            'mortalite_min': int(row['Count_min']),
            'mortalite_median': int(row['Count_median']),
            'mortalite_max': int(row['Count_max']),
            'id_unite': 1  # 1 = nombre de personnes
        })

# Création du DataFrame final
mortalite_df = pd.DataFrame(mortalite_data)

# Chargement
# Sauvegarde dans un fichier CSV
mortalite_df.to_csv('../DatasetClean/table_mortalite.csv', index=False)

# Vérification
if mortalite_df.empty:
    print("❌ La table mortalite est vide !")
else:
    print(f"✅ Table mortalite créée avec succès ! ({len(mortalite_df)} lignes)")

"""
Résumé du script mortaliteETL.py :
1. Extraction :
   - Lecture des fichiers pays_clean.csv et no_of_deaths_by_country_clean.csv
   - Nettoyage des noms de colonnes et standardisation des noms de pays

2. Transformation :
   - Fusion des données de mortalité avec les IDs des pays
   - Conversion des colonnes en format numérique (Count_min, Count_median, Count_max)
   - Création de la table mortalite avec les données de mortalité pour les années 2000, 2010 et 2018

3. Chargement :
   - Sauvegarde du résultat dans mortalite_clean.csv
   - Vérification de la présence de données

Résultat : Table de mortalité avec les données par pays et par année, incluant les valeurs 
          min, médiane (calculée) et max du nombre de décès.
"""