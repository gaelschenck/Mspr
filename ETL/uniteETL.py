import pandas as pd

# ---------------------- 🟢 EXTRACTION (Extract) ---------------------- 
# (Ici, on crée les données directement dans le script, donc pas d'extraction externe)

#  Création de la table unité avec un dictionnaire de données
data = {
    "id_unite": [1, 2],  # Identifiant unique pour chaque type d'unité
    "libelle": ["Pourcentage", "Effectif"]  # Type d'unité (ex : % ou un nombre absolu)
}

# ---------------------- 🟡 TRANSFORMATION (Transform) ----------------------
# (Pas de transformation ici car les données sont déjà propres et définies statiquement)

#  Création d'un DataFrame à partir du dictionnaire
unite_df = pd.DataFrame(data)

# ---------------------- 🔵 CHARGEMENT (Load) ----------------------
# (Chargement des données dans un fichier CSV)

#  Définition du chemin de sortie
output_file = "../DatasetClean/unite_clean.csv"

#  Sauvegarde du DataFrame sous forme de CSV
unite_df.to_csv(output_file, index=False)  # On ne garde pas l'index Pandas dans le fichier final

#  Affichage de confirmation
print(f" Table `unité` enregistrée sous : {output_file}")