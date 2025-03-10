"""
Script ETL pour la table traitement
Cette table contient les données sur la couverture des traitements antirétroviraux par pays.

Structure de la table :
- id_traitement (identifiant unique)
- id_pays (clé étrangère vers pays)
- id_type_traitement (clé étrangère vers type_traitement)
- couverture (pourcentage de couverture du traitement)
"""

import pandas as pd
import numpy as np

# ---------------------- 🟢 EXTRACTION (Extract) ----------------------

# Lecture des données sources
pays_df = pd.read_csv('../DatasetClean/pays_clean.csv')
art_coverage_df = pd.read_csv('../SourceData/art_coverage_by_country_clean.csv')
art_pediatric_df = pd.read_csv('../SourceData/art_pediatric_coverage_by_country_clean.csv')

# Nettoyage des noms de colonnes
art_coverage_df.columns = art_coverage_df.columns.str.strip()
art_pediatric_df.columns = art_pediatric_df.columns.str.strip()

# Standardisation des noms de pays
art_coverage_df['Country'] = art_coverage_df['Country'].str.strip().str.lower()
art_pediatric_df['Country'] = art_pediatric_df['Country'].str.strip().str.lower()

# Fusion avec la table des pays
art_coverage_df = pd.merge(art_coverage_df, pays_df, left_on='Country', right_on='pays', how='inner')
art_pediatric_df = pd.merge(art_pediatric_df, pays_df, left_on='Country', right_on='pays', how='inner')

# Création de la table traitement
traitement_data = []
id_traitement = 1

# Traitement des données pour les adultes (type_traitement = 1)
for _, row in art_coverage_df.iterrows():
    coverage = pd.to_numeric(row['Estimated ART coverage among people living with HIV (%)_median'], errors='coerce')
    if pd.notna(coverage) and pd.notna(row['id_pays']):
        traitement_data.append({
            'id_traitement': id_traitement,
            'id_pays': row['id_pays'],
            'id_type_traitement': 1,
            'couverture': coverage
        })
        id_traitement += 1

# Traitement des données pour les enfants (type_traitement = 2)
for _, row in art_pediatric_df.iterrows():
    coverage = pd.to_numeric(row['Estimated ART coverage among children (%)_median'], errors='coerce')
    if pd.notna(coverage) and pd.notna(row['id_pays']):
        traitement_data.append({
            'id_traitement': id_traitement,
            'id_pays': row['id_pays'],
            'id_type_traitement': 2,
            'couverture': coverage
        })
        id_traitement += 1

# Création du DataFrame final
traitement_df = pd.DataFrame(traitement_data)

# Sauvegarde du résultat
output_file = '../DatasetClean/table_traitement.csv'
traitement_df.to_csv(output_file, index=False)
print(f"✅ Table traitement créée avec succès : {len(traitement_df)} entrées")
