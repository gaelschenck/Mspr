import pandas as pd
import re

# ---------------------- 🟢 EXTRACTION (Extract) ---------------------- 

# 📂 Définition des chemins des fichiers sources
pays_file = "./Csv2Table/pays_clean.csv"  # Fichier contenant la table des pays avec `id_pays`
deaths_file = "./DataSet/no_of_deaths_by_country_clean.csv"  # Fichier contenant les données de mortalité

# 📂 Fichier de sortie
output_file = "./Csv2Table/mortalite_clean2.csv"  # Destination des données transformées

# 📌 Chargement de la table des pays
pays_df = pd.read_csv(pays_file)  # Lecture du fichier pays
pays_df.rename(columns={"pays": "Country"}, inplace=True)  # Renommage pour correspondre aux autres fichiers

# 📌 Nettoyage des noms de pays (supprimer espaces et mettre en minuscule)
pays_df["Country"] = pays_df["Country"].str.strip().str.lower()  # Uniformisation des noms de pays

# 📌 Chargement du fichier de mortalité
df = pd.read_csv(deaths_file)  # Lecture du fichier de mortalité
df.columns = df.columns.str.strip()  # Suppression des espaces dans les noms de colonnes

# ---------------------- 🟡 TRANSFORMATION (Transform) ---------------------- 

# 📌 Vérification des colonnes disponibles dans le fichier source
print(f"📊 Colonnes disponibles dans `{deaths_file}` : {df.columns.tolist()}")

# 📌 Normalisation des noms de pays
df["Country"] = df["Country"].str.strip().str.lower()  # Nettoyage et mise en minuscule

# 📌 Vérification de la correspondance entre les pays des deux fichiers
common_pays = set(df["Country"]).intersection(set(pays_df["Country"]))  # Vérification des pays en commun
if not common_pays:  # Si aucun pays ne correspond, affichage d'un message d'erreur
    print("❌ Aucun pays ne correspond entre les fichiers. Vérifie les noms de pays !")
    print("🔍 Exemples de pays dans `deaths_file` :", df["Country"].unique()[:10])  # Exemples de noms de pays dans le fichier des décès
    print("🔍 Exemples de pays dans `pays_file` :", pays_df["Country"].unique()[:10])  # Exemples de noms de pays dans le fichier des pays
    exit()  # Arrêt du script si aucun pays ne correspond

# 📌 Fusionner avec la table `pays` pour récupérer `id_pays`
df = df.merge(pays_df[["Country", "id_pays"]], on="Country", how="inner")  # Jointure sur `Country`

# 📌 Extraction de la valeur médiane de `nombre_deces`
def extract_median(value):
    """
    Extrait uniquement la valeur médiane des données de mortalité.
    Exemples :
    - "1000[900–1100]" -> 1000  (on extrait la médiane)
    - "500" -> 500  (valeur simple)
    - NaN ou valeurs invalides -> None
    """
    match = re.match(r"(\d+)\[(\d+)–(\d+)\]", str(value))  # Vérifie si la valeur contient une médiane
    if match:
        return int(match.group(1))  # Extraction de la médiane
    elif str(value).isdigit():  # Vérifie si la valeur est un nombre entier simple
        return int(value)  # Conversion directe
    else:
        return None  # Retourne `None` si la valeur est NaN ou invalide

df["nombre_deces"] = df["Count"].apply(extract_median)  # Application de la fonction à la colonne `Count`

# 📌 Suppression des lignes avec des valeurs NaN (décès non renseignés)
df.dropna(subset=["nombre_deces"], inplace=True)

# 📌 Conversion en entier
df["nombre_deces"] = df["nombre_deces"].astype(int)  # Conversion en type `int`

# 📌 Sélectionner les colonnes finales et renommer
df = df[["id_pays", "Year", "nombre_deces"]].rename(columns={"Year": "annee"})  # Sélection et renommage des colonnes

# ---------------------- 🔵 CHARGEMENT (Load) ---------------------- 

# 📌 Sauvegarde du fichier nettoyé
df.to_csv(output_file, index=False)  # Exportation en CSV sans index
print(f"✅ Table `mortalite_clean` enregistrée sous : {output_file}")

# 📂 Aperçu des données finales
if df.empty:  # Vérification si le fichier est vide après transformation
    print("⚠️ Attention, le fichier généré est vide. Vérifie les noms des pays et les valeurs !")
else:
    print("📊 Aperçu de la table `mortalite_clean` :")
    print(df.head(10))  # Affichage des 10 premières lignes