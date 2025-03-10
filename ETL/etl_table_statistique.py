"""
Script ETL pour la table statistique
Cette table contient les statistiques générales sur le VIH par pays et par année.

Structure de la table :
- id_statistique (PK) : Identifiant unique de la statistique
- id_pays (FK) : Identifiant du pays
- annee : Année de la statistique
- id_type_statistique (FK) : Type de statistique
- valeur : Valeur de la statistique
- id_unite (FK) : Unité de mesure
"""

import pandas as pd
import numpy as np

# ---------------------- 🟢 EXTRACTION (Extract) ----------------------

# Lecture des données sources
pays_df = pd.read_csv('../DatasetClean/pays_clean.csv')
population_df = pd.read_csv('../SourceData/no_of_people_living_with_hiv_by_country_clean.csv')
mortalite_df = pd.read_csv('../SourceData/no_of_deaths_by_country_clean.csv')
prevention_df = pd.read_csv('../SourceData/prevention_of_mother_to_child_transmission_by_country_clean.csv')

# Nettoyage des noms de colonnes
population_df.columns = population_df.columns.str.strip()
mortalite_df.columns = mortalite_df.columns.str.strip()
prevention_df.columns = prevention_df.columns.str.strip()

# Standardisation des noms de pays
population_df['Country'] = population_df['Country'].str.strip().str.lower()
mortalite_df['Country'] = mortalite_df['Country'].str.strip().str.lower()
prevention_df['Country'] = prevention_df['Country'].str.strip().str.lower()

# Fusion avec la table des pays
population_df = pd.merge(population_df, pays_df, left_on='Country', right_on='pays', how='inner')
mortalite_df = pd.merge(mortalite_df, pays_df, left_on='Country', right_on='pays', how='inner')
prevention_df = pd.merge(prevention_df, pays_df, left_on='Country', right_on='pays', how='inner')

# Conversion des colonnes en format numérique
numeric_columns_pop = ['Count_min', 'Count_median', 'Count_max']
numeric_columns_mort = ['Count_min', 'Count_median', 'Count_max']
numeric_columns_prev = ['Percentage Recieved_min', 'Percentage Recieved_median', 'Percentage Recieved_max']

for col in numeric_columns_pop:
    population_df[col] = pd.to_numeric(population_df[col], errors='coerce')
for col in numeric_columns_mort:
    mortalite_df[col] = pd.to_numeric(mortalite_df[col], errors='coerce')
for col in numeric_columns_prev:
    prevention_df[col] = pd.to_numeric(prevention_df[col], errors='coerce')

# Création de la table statistique
statistiques = []
id_statistique = 1

# 1. Taux de prévalence (pourcentage de la population infectée)
for _, row in population_df.iterrows():
    if pd.notna(row['Count_median']) and pd.notna(row['id_pays']):
        # Calcul du taux de prévalence (en pourcentage)
        prevalence = round((row['Count_median'] / 1000000) * 100, 2)  # Approximation grossière
        statistiques.append({
            'id_statistique': id_statistique,
            'id_pays': int(row['id_pays']),
            'annee': int(row['Year']),
            'id_type_statistique': 1,  # 1 = taux de prévalence
            'valeur': float(prevalence),
            'id_unite': 2  # 2 = pourcentage
        })
        id_statistique += 1

# 2. Taux de mortalité (pourcentage des décès liés au VIH)
for _, row in mortalite_df.iterrows():
    if pd.notna(row['Count_median']) and pd.notna(row['id_pays']):
        # Calcul du taux de mortalité (en pourcentage)
        mortalite = round((row['Count_median'] / 1000000) * 100, 2)  # Approximation grossière
        statistiques.append({
            'id_statistique': id_statistique,
            'id_pays': int(row['id_pays']),
            'annee': int(row['Year']),
            'id_type_statistique': 2,  # 2 = taux de mortalité
            'valeur': float(mortalite),
            'id_unite': 2  # 2 = pourcentage
        })
        id_statistique += 1

# 3. Taux de transmission mère-enfant
for _, row in prevention_df.iterrows():
    if pd.notna(row['Percentage Recieved_median']) and pd.notna(row['id_pays']):
        statistiques.append({
            'id_statistique': id_statistique,
            'id_pays': int(row['id_pays']),
            'annee': 2018,  # Année de référence
            'id_type_statistique': 3,  # 3 = taux de transmission mère-enfant
            'valeur': round(float(row['Percentage Recieved_median']), 2),
            'id_unite': 2  # 2 = pourcentage
        })
        id_statistique += 1

# Création du DataFrame final
statistique_df = pd.DataFrame(statistiques)

# Sauvegarde du résultat
output_file = '../DatasetClean/table_statistique.csv'
statistique_df.to_csv(output_file, index=False)
print(f"✅ Table statistique créée avec succès ! ({len(statistique_df)} lignes)")

# Vérification
if statistique_df.empty:
    print("⚠️ Attention : La table statistique est vide !")
else:
    print(f"✅ La table statistique contient {len(statistique_df)} entrées.")
    print("\nTypes de statistiques inclus :")
    print("1. Taux de prévalence du VIH")
    print("2. Taux de mortalité liée au VIH")
    print("3. Taux de transmission mère-enfant") 