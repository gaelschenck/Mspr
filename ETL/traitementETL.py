import pandas as pd

# ---------------------- 🟢 EXTRACTION (Extract) ----------------------

pays_file = "../DatasetClean/pays_clean.csv"
adulte_file = "../SourceData/art_coverage_by_country_clean.csv"
enfant_file = "../SourceData/art_pediatric_coverage_by_country_clean.csv"
output_file = "../DatasetClean/traitement_couverture_clean.csv"

try:
    pays_df = pd.read_csv(pays_file)
    adulte_df = pd.read_csv(adulte_file)
    enfant_df = pd.read_csv(enfant_file)

    adulte_df.columns = adulte_df.columns.str.strip()
    enfant_df.columns = enfant_df.columns.str.strip()
    pays_df.rename(columns={"pays": "Country"}, inplace=True)
    pays_df["Country"] = pays_df["Country"].str.strip().str.lower()

    print("✅ Extraction réussie.")
    print(f"📊 Colonnes disponibles dans adulte : {adulte_df.columns.tolist()}")
    print(f"📊 Colonnes disponibles dans enfant : {enfant_df.columns.tolist()}")

except Exception as e:
    print(f"❌ Erreur lors de l'extraction : {e}")
    exit()

# ---------------------- 🟡 TRANSFORMATION (Transform) ----------------------

try:
    adulte_df["Country"] = adulte_df["Country"].str.strip().str.lower()
    enfant_df["Country"] = enfant_df["Country"].str.strip().str.lower()

    adulte_df = adulte_df.merge(pays_df[["Country", "id_pays"]], on="Country", how="inner")
    enfant_df = enfant_df.merge(pays_df[["Country", "id_pays"]], on="Country", how="inner")

    adulte_df = adulte_df.rename(columns={
        "Estimated number of people living with HIV_median": "population_hiv_median",
        "Estimated number of people living with HIV_min": "population_hiv_min",
        "Estimated number of people living with HIV_max": "population_hiv_max",
        "Estimated ART coverage among people living with HIV (%)_median": "couverture_median",
        "Estimated ART coverage among people living with HIV (%)_min": "couverture_min",
        "Estimated ART coverage among people living with HIV (%)_max": "couverture_max"
    })

    enfant_df = enfant_df.rename(columns={
        "Estimated number of children needing ART based on WHO methods_median": "population_hiv_median",
        "Estimated number of children needing ART based on WHO methods_min": "population_hiv_min",
        "Estimated number of children needing ART based on WHO methods_max": "population_hiv_max",
        "Estimated ART coverage among children (%)_median": "couverture_median",
        "Estimated ART coverage among children (%)_min": "couverture_min",
        "Estimated ART coverage among children (%)_max": "couverture_max"
    })

    adulte_df["id_type_traitement"] = 1
    enfant_df["id_type_traitement"] = 2

    traitement_df = pd.concat([adulte_df, enfant_df], ignore_index=True)

    cols_to_numeric = ["population_hiv_median", "population_hiv_min", "population_hiv_max",
                       "couverture_median", "couverture_min", "couverture_max"]

    for col in cols_to_numeric:
        traitement_df[col] = pd.to_numeric(traitement_df[col], errors="coerce")

    traitement_df.dropna(subset=cols_to_numeric, how="any", inplace=True)
    traitement_df.dropna(subset=["id_pays"], inplace=True)
    traitement_df["id_pays"] = traitement_df["id_pays"].astype(int)

    for col in cols_to_numeric:
        traitement_df[col] = traitement_df[col].astype(int)

    traitement_df = traitement_df[["id_pays", "population_hiv_median", "population_hiv_min", "population_hiv_max",
                                   "couverture_median", "couverture_min", "couverture_max", "id_type_traitement"]]

    print("✅ Transformation des données réussie.")
    print(f"📊 Nombre total de lignes après nettoyage : {len(traitement_df)}")

except Exception as e:
    print(f"❌ Erreur lors de la transformation : {e}")
    exit()

# ---------------------- 🔵 CHARGEMENT (Load) ----------------------

try:
    traitement_df.to_csv(output_file, index=False)
    print(f"✅ Table enregistrée sous : {output_file}")

except Exception as e:
    print(f"❌ Erreur lors de l'enregistrement : {e}")
    exit()

if traitement_df.empty:
    print("⚠️ Attention, le fichier généré est vide. Vérifie les données !")
else:
    print("📊 Aperçu des données finales :")
    print(traitement_df.head(10))