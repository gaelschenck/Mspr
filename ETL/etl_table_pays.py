import pandas as pd

# ---------------------- 🟢 EXTRACTION (Extract) ----------------------

files = [
    "../SourceData/art_coverage_by_country_clean.csv",
    "../SourceData/art_pediatric_coverage_by_country_clean.csv",
    "../SourceData/no_of_cases_adults_15_to_49_by_country_clean.csv",
    "../SourceData/no_of_deaths_by_country_clean.csv",
    "../SourceData/no_of_people_living_with_hiv_by_country_clean.csv",
    "../SourceData/prevention_of_mother_to_child_transmission_by_country_clean.csv"
]

def extract_countries_regions(file_path):
    try:
        df = pd.read_csv(file_path)
        df.columns = df.columns.str.strip()

        country_col = next((col for col in df.columns if "Country" in col), None)
        region_col = next((col for col in df.columns if "WHO Region" in col), None)

        if country_col and region_col:
            df.rename(columns={country_col: "pays", region_col: "region_who"}, inplace=True)
            return df[["pays", "region_who"]].drop_duplicates()
        elif country_col:
            df.rename(columns={country_col: "pays"}, inplace=True)
            return df[["pays"]].drop_duplicates()
        else:
            print(f" Aucune colonne 'Country' trouvée dans `{file_path}` !")
            return pd.DataFrame(columns=["pays", "region_who"])

    except FileNotFoundError:
        print(f" Erreur critique : Le fichier `{file_path}` est introuvable !")
        exit()

    except Exception as e:
        print(f" Erreur lors de la lecture de `{file_path}` : {e}")
        exit()

try:
    pays_df = pd.concat([extract_countries_regions(file) for file in files], ignore_index=True)
    print(f" Extraction des {len(files)} fichiers réussie.")

except Exception as e:
    print(f" Erreur lors de l'extraction : {e}")
    exit()

# ---------------------- 🟡 TRANSFORMATION (Transform) ----------------------

try:
    pays_df["pays"] = pays_df["pays"].str.strip().str.lower().str.replace(r"\s+", " ", regex=True)
    pays_df["region_who"] = pays_df["region_who"].str.strip().str.lower()

    pays_df.drop_duplicates(subset=["pays"], inplace=True)

    if pays_df.empty:
        raise ValueError(" Aucune donnée valide après transformation ! Vérifie les fichiers sources.")

    pays_df.insert(0, "id_pays", range(1, len(pays_df) + 1))

    print(" Transformation des données réussie.")

except Exception as e:
    print(f" Erreur lors de la transformation : {e}")
    exit()

# ---------------------- 🔵 CHARGEMENT (Load) ----------------------

try:
    output_file = "../DatasetClean/pays_clean.csv"
    pays_df.to_csv(output_file, index=False)
    print(f" Table `pays_clean.csv` enregistrée avec {len(pays_df)} pays et leur région OMS.")

except Exception as e:
    print(f" Erreur lors de l'enregistrement du fichier : {e}")
    exit()

"""
Résumé du script paysETL.py :
1. Extraction :
   - Lecture de 6 fichiers source contenant des données par pays
   - Extraction des colonnes Country et WHO Region de chaque fichier
   - Fusion des données de tous les fichiers en un seul DataFrame
   - Suppression des doublons de pays

2. Transformation :
   - Nettoyage et standardisation des noms de pays (minuscules, espaces)
   - Nettoyage et standardisation des noms de régions OMS
   - Suppression des doublons de pays
   - Ajout d'un identifiant unique (id_pays) pour chaque pays

3. Chargement :
   - Sauvegarde du résultat dans pays_clean.csv
   - Affichage du nombre de pays et de leurs régions OMS

Résultat : Table de référence des pays avec 170 entrées, incluant l'identifiant unique, 
          le nom du pays et sa région OMS correspondante.
"""