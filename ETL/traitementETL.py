import pandas as pd

# ---------------------- 🟢 EXTRACTION (Extract) ----------------------

# 📂 Définition des chemins des fichiers sources
pays_file = "../DatasetClean/pays_clean.csv"
adulte_file = "../SourceData/art_coverage_by_country_clean.csv"
enfant_file = "../SourceData/art_pediatric_coverage_by_country_clean.csv"

# 📂 Fichier de sortie
output_file = "../DatasetClean/traitement_couverture_clean.csv"

try:
    # 📌 Chargement de la table des pays
    pays_df = pd.read_csv(pays_file)
    pays_df.rename(columns={"pays": "Country"}, inplace=True)  # Uniformisation du nom de colonne
    pays_df["Country"] = pays_df["Country"].str.strip().str.lower()  # Nettoyage des noms de pays

    # 📌 Chargement des fichiers adultes et enfants
    adulte_df = pd.read_csv(adulte_file)
    enfant_df = pd.read_csv(enfant_file)

    # 📌 Nettoyage des noms de colonnes
    adulte_df.columns = adulte_df.columns.str.strip()
    enfant_df.columns = enfant_df.columns.str.strip()

    print("✅ Extraction réussie.")

except FileNotFoundError as e:
    print(f"❌ Erreur : Fichier introuvable - {e}")
    exit()
except Exception as e:
    print(f"❌ Erreur lors de l'extraction : {e}")
    exit()

# ---------------------- 🟡 TRANSFORMATION (Transform) ----------------------

try:
    # 📌 Normalisation des noms de pays
    adulte_df["Country"] = adulte_df["Country"].str.strip().str.lower()
    enfant_df["Country"] = enfant_df["Country"].str.strip().str.lower()

    # 📌 Fusionner avec la table `pays` pour récupérer `id_pays`
    adulte_df = adulte_df.merge(pays_df[["Country", "id_pays"]], on="Country", how="inner").drop(columns=["Country"])
    enfant_df = enfant_df.merge(pays_df[["Country", "id_pays"]], on="Country", how="inner").drop(columns=["Country"])

    # 📌 Sélectionner et renommer les colonnes
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

    # 📌 Ajouter l'identifiant du type de traitement
    adulte_df["id_type_traitement"] = 1  # Adulte
    enfant_df["id_type_traitement"] = 2  # Enfant

    # 📌 Fusionner les deux tables
    traitement_df = pd.concat([adulte_df, enfant_df], ignore_index=True)

    # 📌 Convertir en nombre et supprimer les lignes incomplètes
    cols_to_numeric = ["population_hiv_median", "population_hiv_min", "population_hiv_max",
                       "couverture_median", "couverture_min", "couverture_max"]

    for col in cols_to_numeric:
        traitement_df[col] = pd.to_numeric(traitement_df[col], errors="coerce")  # Convertir en float

    # 📌 Supprimer les lignes avec au moins une valeur NaN dans les colonnes essentielles
    traitement_df.dropna(subset=cols_to_numeric, how="any", inplace=True)

    # 📌 Supprimer les pays sans `id_pays`
    traitement_df.dropna(subset=["id_pays"], inplace=True)

    # 📌 Transformer `id_pays` en int
    traitement_df["id_pays"] = traitement_df["id_pays"].astype(int)

    # 📌 Convertir tous les nombres en `int` pour supprimer les `.0`
    for col in cols_to_numeric:
        traitement_df[col] = traitement_df[col].astype(int)

    # 📌 Réorganiser les colonnes
    traitement_df = traitement_df[["id_pays", "population_hiv_median", "population_hiv_min", "population_hiv_max",
                                   "couverture_median", "couverture_min", "couverture_max", "id_type_traitement"]]

    print(f"✅ Transformation réussie. Nombre total de lignes après nettoyage : {len(traitement_df)}")

except Exception as e:
    print(f"❌ Erreur lors de la transformation : {e}")
    exit()

# ---------------------- 🔵 CHARGEMENT (Load) ----------------------

try:
    # 📌 Sauvegarde du fichier nettoyé en CSV avec séparateur `,` sans index et sans `float .0`
    traitement_df.to_csv(output_file, index=False)

    print(f"✅ Table `traitement_couverture_clean` enregistrée sous : {output_file}")

except Exception as e:
    print(f"❌ Erreur lors de l'enregistrement du fichier : {e}")
    exit()

# 📊 Aperçu de la table finale
if traitement_df.empty:
    print("⚠️ Attention, le fichier généré est vide. Vérifie les noms des pays et les valeurs !")
else:
    print("📊 Aperçu de la table `traitement_couverture_clean` :")
    print(traitement_df.head(10))