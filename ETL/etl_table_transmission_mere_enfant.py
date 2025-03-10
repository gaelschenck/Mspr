"""
Script ETL pour la table transmission_mere_enfant
Cette table contient les données sur la prévention de la transmission mère-enfant du VIH par pays.

Structure de la table :
- id_transmission (identifiant unique)
- id_pays (clé étrangère vers pays)
- besoin_arv_min (nombre minimum de personnes ayant besoin d'antirétroviraux)
- besoin_arv_median (nombre médian de personnes ayant besoin d'antirétroviraux)
- besoin_arv_max (nombre maximum de personnes ayant besoin d'antirétroviraux)
- pourcentage_recu_min (pourcentage minimum de personnes ayant reçu le traitement)
- pourcentage_recu_median (pourcentage médian de personnes ayant reçu le traitement)
- pourcentage_recu_max (pourcentage maximum de personnes ayant reçu le traitement)
"""

import pandas as pd
import numpy as np

# ---------------------- 🟢 EXTRACTION (Extract) ----------------------

# Lecture des données sources
pays_df = pd.read_csv('../DatasetClean/pays_clean.csv')
prevention_df = pd.read_csv('../SourceData/prevention_of_mother_to_child_transmission_by_country_clean.csv')

# Nettoyage des noms de colonnes
prevention_df.columns = prevention_df.columns.str.strip()

# Standardisation des noms de pays
prevention_df['Country'] = prevention_df['Country'].str.strip().str.lower()

# Fusion avec la table des pays
prevention_df = pd.merge(prevention_df, pays_df, left_on='Country', right_on='pays', how='inner')

# Debug : Afficher les premiers pays de chaque DataFrame
print("\nPremiers pays dans prevention_df :")
print(prevention_df['Country'].head())
print("\nPremiers pays dans pays_df :")
print(pays_df['pays'].head())

# Conversion des colonnes en format numérique
numeric_columns = [
    'Needing antiretrovirals_min', 'Needing antiretrovirals_median', 'Needing antiretrovirals_max',
    'Percentage Recieved_min', 'Percentage Recieved_median', 'Percentage Recieved_max'
]

for col in numeric_columns:
    prevention_df[col] = pd.to_numeric(prevention_df[col], errors='coerce')

# Création de la table transmission_mere_enfant
transmission_data = []

for _, row in prevention_df.iterrows():
    if pd.notna(row['Needing antiretrovirals_median']) and pd.notna(row['id_pays']):
        transmission_data.append({
            'id_transmission': len(transmission_data) + 1,
            'id_pays': row['id_pays'],
            'besoin_arv_min': row['Needing antiretrovirals_min'],
            'besoin_arv_median': row['Needing antiretrovirals_median'],
            'besoin_arv_max': row['Needing antiretrovirals_max'],
            'pourcentage_recu_min': row['Percentage Recieved_min'],
            'pourcentage_recu_median': row['Percentage Recieved_median'],
            'pourcentage_recu_max': row['Percentage Recieved_max']
        })

# Création du DataFrame final
transmission_df = pd.DataFrame(transmission_data)

# Debug : Afficher les premières lignes du DataFrame final
print("\nPremières lignes du DataFrame final :")
print(transmission_df.head())

# Sauvegarde du résultat
output_file = '../DatasetClean/table_transmission_mere_enfant.csv'
transmission_df.to_csv(output_file, index=False)
print(f"✅ Table transmission_mere_enfant créée avec succès ! ({len(transmission_df)} lignes)")

# Vérification
if transmission_df.empty:
    print("⚠️ Attention : La table transmission_mere_enfant est vide !")
else:
    print(f"✅ La table transmission_mere_enfant contient {len(transmission_df)} entrées.")