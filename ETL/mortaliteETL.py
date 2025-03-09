import pandas as pd

# ---------------------- 🟢 EXTRACTION (Extract) ----------------------

pays_file = "../DatasetClean/pays_clean.csv"
mortalite_file = "../SourceData/no_of_deaths_by_country_clean.csv"
output_file = "../DatasetClean/mortalite_clean.csv"

try:
    pays_df = pd.read_csv(pays_file)
    mortalite_df = pd.read_csv(mortalite_file)

    mortalite_df.columns = mortalite_df.columns.str.strip()
    pays_df.rename(columns={"pays": "Country"}, inplace=True)
    pays_df["Country"] = pays_df["Country"].str.strip().str.lower()

    print("✅ Extraction réussie.")
    print(f"📊 Colonnes disponibles : {mortalite_df.columns.tolist()}")

except Exception as e:
    print(f"❌ Erreur lors de l'extraction : {e}")
    exit()

# ---------------------- 🟡 TRANSFORMATION (Transform) ----------------------

try:
    mortalite_df["Country"] = mortalite_df["Country"].str.strip().str.lower()

    mortalite_df = mortalite_df.merge(pays_df[["Country", "id_pays"]], on="Country", how="inner")

    mortalite_df = mortalite_df.rename(columns={
        "Count_median": "mortalite_median",
        "Count_min": "mortalite_min",
        "Count_max": "mortalite_max",
        "Year": "annee"
    })

    mortalite_df = mortalite_df[["id_pays", "annee", "mortalite_median", "mortalite_min", "mortalite_max"]]

    cols_to_numeric = ["mortalite_median", "mortalite_min", "mortalite_max"]
    for col in cols_to_numeric:
        mortalite_df[col] = pd.to_numeric(mortalite_df[col], errors="coerce")

    mortalite_df.dropna(inplace=True)

    for col in cols_to_numeric:
        mortalite_df[col] = mortalite_df[col].astype(int)
    
    mortalite_df["annee"] = mortalite_df["annee"].astype(int)

    mortalite_df.sort_values(by=["id_pays", "annee"], inplace=True)

    print("✅ Transformation des données réussie.")
    print(f"📊 Nombre de pays avec données de mortalité : {len(mortalite_df)}")
    print(f"📅 Période couverte : de {mortalite_df['annee'].min()} à {mortalite_df['annee'].max()}")

except Exception as e:
    print(f"❌ Erreur lors de la transformation : {e}")
    exit()

# ---------------------- 🔵 CHARGEMENT (Load) ----------------------

try:
    mortalite_df.to_csv(output_file, index=False)
    print(f"✅ Table enregistrée sous : {output_file}")

except Exception as e:
    print(f"❌ Erreur lors de l'enregistrement : {e}")
    exit()

if mortalite_df.empty:
    print("⚠️ Attention, le fichier généré est vide. Vérifie les données !")
else:
    print("📊 Aperçu des données finales :")
    print(mortalite_df.head(10))