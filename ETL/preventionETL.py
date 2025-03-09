import pandas as pd

# ---------------------- 🟢 EXTRACTION (Extract) ----------------------

pays_file = "../DatasetClean/pays_clean.csv"
prevention_file = "../SourceData/prevention_of_mother_to_child_transmission_by_country_clean.csv"
output_file = "../DatasetClean/prevention_mere_enfant_clean.csv"

try:
    pays_df = pd.read_csv(pays_file)
    pays_df.rename(columns={"pays": "Country"}, inplace=True)
    pays_df["Country"] = pays_df["Country"].str.strip().str.lower()

    df = pd.read_csv(prevention_file)
    df.columns = df.columns.str.strip()

    print("✅ Extraction réussie.")
    print(f"📊 Colonnes disponibles : {df.columns.tolist()}")

except Exception as e:
    print(f"❌ Erreur lors de l'extraction : {e}")
    exit()

# ---------------------- 🟡 TRANSFORMATION (Transform) ----------------------

try:
    df["Country"] = df["Country"].str.strip().str.lower()

    df = df.merge(pays_df[["Country", "id_pays"]], on="Country", how="inner")

    df = df[["id_pays", "Received Antiretrovirals", "Needing antiretrovirals_max"]]

    df.rename(columns={
        "Received Antiretrovirals": "recus_antiretroviraux",
        "Needing antiretrovirals_max": "besoin_antiretroviraux_max"
    }, inplace=True)

    df["recus_antiretroviraux"] = pd.to_numeric(df["recus_antiretroviraux"], errors="coerce").fillna(0).astype(int)
    df["besoin_antiretroviraux_max"] = pd.to_numeric(df["besoin_antiretroviraux_max"], errors="coerce").fillna(0).astype(int)

    df["taux_prevention"] = ((df["recus_antiretroviraux"] / df["besoin_antiretroviraux_max"]) * 100)
    df["taux_prevention"] = df["taux_prevention"].replace([float('inf'), -float('inf')], 0).fillna(0).astype(int)

    df = df[~((df["recus_antiretroviraux"] == 0) & (df["besoin_antiretroviraux_max"] == 0))]
    df = df[df["taux_prevention"] != 0]

    df.sort_values(by="id_pays", ascending=True, inplace=True)

    print("✅ Transformation des données réussie.")

except Exception as e:
    print(f"❌ Erreur lors de la transformation : {e}")
    exit()

# ---------------------- 🔵 CHARGEMENT (Load) ----------------------

try:
    df.to_csv(output_file, index=False)
    print(f"✅ Table enregistrée sous : {output_file}")

except Exception as e:
    print(f"❌ Erreur lors de l'enregistrement : {e}")
    exit()

if df.empty:
    print("⚠️ Attention, le fichier généré est vide. Vérifie les données !")
else:
    print("📊 Aperçu des données finales :")
    print(df.head(10))
