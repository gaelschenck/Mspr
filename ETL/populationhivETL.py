import pandas as pd

# ---------------------- 🟢 EXTRACTION (Extract) ----------------------

# 📂 Chemins des fichiers sources
pays_file = "../DatasetClean/pays_clean.csv"
hiv_file = "../SourceData/no_of_people_living_with_hiv_by_country_clean.csv"
output_file = "../DatasetClean/population_hiv_clean.csv"

try:
    # 📌 Chargement des données
    pays_df = pd.read_csv(pays_file)
    hiv_df = pd.read_csv(hiv_file)

    # 📌 Nettoyage des noms de colonnes
    hiv_df.columns = hiv_df.columns.str.strip()
    pays_df.rename(columns={"pays": "Country"}, inplace=True)
    pays_df["Country"] = pays_df["Country"].str.strip().str.lower()

    print("✅ Extraction réussie.")
    print(f"📊 Colonnes disponibles : {hiv_df.columns.tolist()}")

except Exception as e:
    print(f"❌ Erreur lors de l'extraction : {e}")
    exit()

# ---------------------- 🟡 TRANSFORMATION (Transform) ----------------------

try:
    # 📌 Normalisation des noms de pays
    hiv_df["Country"] = hiv_df["Country"].str.strip().str.lower()

    # 📌 Fusionner avec la table des pays pour récupérer id_pays
    population_hiv_df = hiv_df.merge(pays_df[["Country", "id_pays"]], on="Country", how="inner")

    # 📌 Sélectionner et renommer les colonnes
    population_hiv_df = population_hiv_df.rename(columns={
        "Count_median": "population_hiv_median",
        "Count_min": "population_hiv_min",
        "Count_max": "population_hiv_max",
        "Year": "annee"
    })

    # 📌 Sélectionner uniquement les colonnes nécessaires
    population_hiv_df = population_hiv_df[["id_pays", "annee", "population_hiv_median", "population_hiv_min", "population_hiv_max"]]

    # 📌 Convertir en nombres
    cols_to_numeric = ["population_hiv_median", "population_hiv_min", "population_hiv_max"]
    for col in cols_to_numeric:
        population_hiv_df[col] = pd.to_numeric(population_hiv_df[col], errors="coerce")

    # 📌 Supprimer les lignes avec des valeurs manquantes
    population_hiv_df.dropna(inplace=True)

    # 📌 Convertir en entiers
    for col in cols_to_numeric:
        population_hiv_df[col] = population_hiv_df[col].astype(int)
    
    # 📌 Convertir l'année en entier
    population_hiv_df["annee"] = population_hiv_df["annee"].astype(int)

    # 📌 Trier par id_pays et année
    population_hiv_df.sort_values(by=["id_pays", "annee"], inplace=True)

    print("✅ Transformation des données réussie.")
    print(f"📊 Nombre de pays avec données de population HIV : {len(population_hiv_df)}")
    print(f"📅 Période couverte : de {population_hiv_df['annee'].min()} à {population_hiv_df['annee'].max()}")

except Exception as e:
    print(f"❌ Erreur lors de la transformation : {e}")
    exit()

# ---------------------- 🔵 CHARGEMENT (Load) ----------------------

try:
    population_hiv_df.to_csv(output_file, index=False)
    print(f"✅ Table enregistrée sous : {output_file}")

except Exception as e:
    print(f"❌ Erreur lors de l'enregistrement : {e}")
    exit()

# 📂 Aperçu
if population_hiv_df.empty:
    print("⚠️ Attention, le fichier généré est vide. Vérifie les données !")
else:
    print("📊 Aperçu des données finales :")
    print(population_hiv_df.head(10)) 