import pandas as pd

# ---------------------- 🟢 EXTRACTION (Extract) ----------------------

pays_file = "../DatasetClean/pays_clean.csv"
hiv_file = "../SourceData/no_of_people_living_with_hiv_by_country_clean.csv"
output_file = "../DatasetClean/population_hiv_clean.csv"

try:
    pays_df = pd.read_csv(pays_file)
    hiv_df = pd.read_csv(hiv_file)

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
    hiv_df["Country"] = hiv_df["Country"].str.strip().str.lower()

    population_hiv_df = hiv_df.merge(pays_df[["Country", "id_pays"]], on="Country", how="inner")

    population_hiv_df = population_hiv_df.rename(columns={
        "Count_median": "population_hiv_median",
        "Count_min": "population_hiv_min",
        "Count_max": "population_hiv_max",
        "Year": "annee"
    })

    population_hiv_df = population_hiv_df[["id_pays", "annee", "population_hiv_median", "population_hiv_min", "population_hiv_max"]]

    cols_to_numeric = ["population_hiv_median", "population_hiv_min", "population_hiv_max"]
    for col in cols_to_numeric:
        population_hiv_df[col] = pd.to_numeric(population_hiv_df[col], errors="coerce")

    population_hiv_df.dropna(inplace=True)

    for col in cols_to_numeric:
        population_hiv_df[col] = population_hiv_df[col].astype(int)
    
    population_hiv_df["annee"] = population_hiv_df["annee"].astype(int)

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

if population_hiv_df.empty:
    print("⚠️ Attention, le fichier généré est vide. Vérifie les données !")
else:
    print("📊 Aperçu des données finales :")
    print(population_hiv_df.head(10)) 