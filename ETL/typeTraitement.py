import pandas as pd

# ---------------------- 🟢 EXTRACTION (Extract) ---------------------- 
# (Ici, on crée les données directement dans le script, donc pas d'extraction externe)

#  Création de la table `type_traitement`
data = {
    "id_type_traitement": [1, 2],  # Identifiants uniques
    "libelle": ["Adulte", "Enfant"]  # Libellés des types de traitement
}

# ---------------------- 🟡 TRANSFORMATION (Transform) ----------------------
# (Pas de transformation ici car les données sont déjà propres)

#  Création du DataFrame à partir des données définies
type_trait_df = pd.DataFrame(data)

# ---------------------- 🔵 CHARGEMENT (Load) ---------------------- 
# (Chargement des données dans un fichier CSV)

#  Définition du chemin de sortie du fichier CSV
output_file = "./Csv2Table/type_traitement_clean2.csv"

#  Sauvegarde du DataFrame sous forme de CSV
type_trait_df.to_csv(output_file, index=False)  # Pas d'index Pandas dans le fichier final

#  Affichage de confirmation
print(f" Table `type_traitement` enregistrée sous : {output_file}")