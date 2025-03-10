"""
Script ETL pour la table unité
Cette table contient les unités de mesure utilisées dans les statistiques
Structure :
- id_unite (PK) : Identifiant unique de l'unité
- libelle : Nom de l'unité (ex: pourcentage, nombre absolu, taux)
"""
import pandas as pd

# ---------------------- 🟢 EXTRACTION (Extract) ----------------------

data = {
    "id_unite": [1, 2, 3, 4],
    "libelle": ["nombre", "pourcentage", "taux", "ratio"]
}

# ---------------------- 🟡 TRANSFORMATION (Transform) ----------------------

unite_df = pd.DataFrame(data)
unite_df = unite_df.sort_values('id_unite')

# ---------------------- 🔵 CHARGEMENT (Load) ----------------------

output_file = "../DatasetClean/unite_clean.csv"
unite_df.to_csv(output_file, index=False)

# Vérification
if unite_df.empty:
    print("❌ La table unité est vide")
else:
    print(f"✅ Table unité créée avec succès : {len(unite_df)} entrées")

"""
Résumé du script uniteETL.py :
1. Extraction :
   - Création d'un dictionnaire contenant les unités de mesure avec leurs IDs et libellés
   - Les unités incluent : nombre, pourcentage, taux, ratio

2. Transformation :
   - Conversion du dictionnaire en DataFrame pandas
   - Tri des unités par ID
   - Création d'une table de référence pour les unités de mesure

3. Chargement :
   - Sauvegarde du DataFrame dans le fichier unite_clean.csv
   - Affichage d'un message de confirmation

Résultat : Table de référence unite avec 4 entrées, définissant les différentes unités 
          de mesure utilisées dans le système (nombre, pourcentage, taux, ratio).
"""