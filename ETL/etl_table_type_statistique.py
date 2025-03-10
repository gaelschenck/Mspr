"""
Script ETL pour la table type_statistique
Cette table contient les différents types de statistiques disponibles
Structure :
- id_type_statistique (PK) : Identifiant unique du type de statistique
- libelle : Nom du type de statistique (ex: taux_hiv, taux_mortalité)
"""
import pandas as pd

# Extraction
type_statistique_df = pd.DataFrame({
    'id_type_statistique': [1, 2, 3, 4, 5],
    'libelle': ['taux_hiv', 'taux_mortalite', 'taux_transmission', 'taux_couverture', 'population_hiv']
})

# Transformation
type_statistique_df = type_statistique_df.sort_values('id_type_statistique')

# Chargement
type_statistique_df.to_csv('../DatasetClean/type_statistique_clean.csv', index=False)

# Vérification
if type_statistique_df.empty:
    print("❌ La table type_statistique est vide")
else:
    print(f"✅ Table type_statistique créée avec succès : {len(type_statistique_df)} entrées") 