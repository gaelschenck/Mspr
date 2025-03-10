"""
Script ETL pour la table type_traitement
Cette table contient les différents types de traitement disponibles
Structure :
- id_type_traitement (PK) : Identifiant unique du type de traitement
- libelle : Nom du type de traitement (ex: adulte, enfant)
"""
import pandas as pd

# Extraction
type_traitement_df = pd.DataFrame({
    'id_type_traitement': [1, 2, 3],
    'libelle': ['adulte', 'enfant', 'mere_enfant']
})

# Transformation
type_traitement_df = type_traitement_df.sort_values('id_type_traitement')

# Chargement
type_traitement_df.to_csv('../DatasetClean/type_traitement_clean.csv', index=False)

# Vérification
if type_traitement_df.empty:
    print("❌ La table type_traitement est vide")
else:
    print(f"✅ Table type_traitement créée avec succès : {len(type_traitement_df)} entrées")

"""
Résumé du script typeTraitement.py :
1. Extraction :
   - Création d'un DataFrame contenant les types de traitement avec leurs IDs et libellés
   - Les types incluent : Adulte (1), Enfant (2), Mère_Enfant (3)

2. Transformation :
   - Tri du DataFrame par ID de type de traitement
   - Création d'une table de référence pour les types de traitement

3. Chargement :
   - Sauvegarde du DataFrame dans le fichier type_traitement_clean.csv
   - Affichage d'un message de confirmation

Résultat : Table de référence type_traitement avec 3 entrées, définissant les différents 
          types de traitement (adultes, enfants et mère_enfant) utilisés dans le système.
"""