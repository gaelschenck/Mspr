import pandas as pd

# ---------------------- 🟢 EXTRACTION (Extract) ----------------------

# 📂 Chemins des fichiers sources
pays_file = "../DatasetClean/pays_clean.csv"
prevalence_file = "../SourceData/no_of_cases_adults_15_to_49_by_country_clean.csv"
mortalite_file = "../SourceData/no_of_deaths_by_country_clean.csv"
output_file = "../DatasetClean/statistique_clean.csv"

try:
    # 📌 Chargement des données
    pays_df = pd.read_csv(pays_file)
    prevalence_df = pd.read_csv(prevalence_file)
    mortalite_df = pd.read_csv(mortalite_file)

    # 📌 Nettoyage des noms de colonnes
    prevalence_df.columns = prevalence_df.columns.str.strip()
    mortalite_df.columns = mortalite_df.columns.str.strip()
    pays_df.rename(columns={"pays": "Country"}, inplace=True)
    pays_df["Country"] = pays_df["Country"].str.strip().str.lower()

    print("✅ Extraction réussie.")
    print(f"📊 Colonnes disponibles dans prévalence : {prevalence_df.columns.tolist()}")
    print(f"📊 Colonnes disponibles dans mortalité : {mortalite_df.columns.tolist()}")

except Exception as e:
    print(f"❌ Erreur lors de l'extraction : {e}")
    exit()

# ---------------------- 🟡 TRANSFORMATION (Transform) ----------------------

try:
    # 📌 Normalisation des noms de pays
    prevalence_df["Country"] = prevalence_df["Country"].str.strip().str.lower()
    mortalite_df["Country"] = mortalite_df["Country"].str.strip().str.lower()

    # 📌 Fusionner avec la table des pays pour récupérer id_pays
    prevalence_df = prevalence_df.merge(pays_df[["Country", "id_pays"]], on="Country", how="inner")
    mortalite_df = mortalite_df.merge(pays_df[["Country", "id_pays"]], on="Country", how="inner")

    # 📌 Sélectionner et renommer les colonnes pour la prévalence
    prevalence_df = prevalence_df.rename(columns={
        "Count_median": "taux_hiv",
        "Year": "annee"
    })
    prevalence_df = prevalence_df[["id_pays", "annee", "taux_hiv"]]

    # 📌 Sélectionner et renommer les colonnes pour la mortalité
    mortalite_df = mortalite_df.rename(columns={
        "Count_median": "taux_mortalite",
        "Year": "annee"
    })
    mortalite_df = mortalite_df[["id_pays", "annee", "taux_mortalite"]]

    # 📌 Fusionner les deux tables
    statistique_df = prevalence_df.merge(mortalite_df, on=["id_pays", "annee"], how="outer")

    # 📌 Convertir en nombres
    statistique_df["taux_hiv"] = pd.to_numeric(statistique_df["taux_hiv"], errors="coerce")
    statistique_df["taux_mortalite"] = pd.to_numeric(statistique_df["taux_mortalite"], errors="coerce")

    # 📌 Supprimer les lignes avec des valeurs manquantes
    statistique_df.dropna(inplace=True)

    # 📌 Convertir en entiers
    statistique_df["taux_hiv"] = statistique_df["taux_hiv"].astype(int)
    statistique_df["taux_mortalite"] = statistique_df["taux_mortalite"].astype(int)
    statistique_df["annee"] = statistique_df["annee"].astype(int)

    # 📌 Trier par id_pays et année
    statistique_df.sort_values(by=["id_pays", "annee"], inplace=True)

    print("✅ Transformation des données réussie.")
    print(f"📊 Nombre de pays avec statistiques : {len(statistique_df)}")
    print(f"📅 Période couverte : de {statistique_df['annee'].min()} à {statistique_df['annee'].max()}")

except Exception as e:
    print(f"❌ Erreur lors de la transformation : {e}")
    exit()

# ---------------------- 🔵 CHARGEMENT (Load) ----------------------

try:
    statistique_df.to_csv(output_file, index=False)
    print(f"✅ Table enregistrée sous : {output_file}")

except Exception as e:
    print(f"❌ Erreur lors de l'enregistrement : {e}")
    exit()

# 📂 Aperçu
if statistique_df.empty:
    print("⚠️ Attention, le fichier généré est vide. Vérifie les données !")
else:
    print("📊 Aperçu des données finales :")
    print(statistique_df.head(10)) 