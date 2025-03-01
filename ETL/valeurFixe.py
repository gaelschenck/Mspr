import pandas as pd

# ---------------------- 🟢 EXTRACTION (Extract) ---------------------- 
# (Ici, on crée les données directement dans le script, pas d'extraction externe)
 
# 📌 Création de la table type_statistique avec un dictionnaire de données
data = {
    "id_type_stat": [1, 2, 3],  # Identifiant unique pour chaque type de statistique
    "libelle": ["Taux HIV", "Taux mortalité", "Nombre de cas"]  # Libellé du type de statistique
}

# ---------------------- 🟡 TRANSFORMATION (Transform) ----------------------
# (Pas de transformation ici car les données sont déjà propres)

# 📌 Création d'un DataFrame à partir du dictionnaire
type_stat_df = pd.DataFrame(data)

# ---------------------- 🔵 CHARGEMENT (Load) ----------------------
# (Chargement des données dans un fichier CSV)

# 📌 Définition du chemin de sortie
output_file = "./Csv2Table/type_statistique_clean2.csv"

# 📌 Sauvegarde du DataFrame sous forme de CSV
type_stat_df.to_csv(output_file, index=False)  # Pas d'index Pandas dans le fichier final

# 📌 Affichage de confirmation
print(f"✅ Table `type_statistique` enregistrée sous : {output_file}")