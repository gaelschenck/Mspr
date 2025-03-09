import pandas as pd

# ---------------------- 🟢 EXTRACTION (Extract) ----------------------

# Définition des chemins des fichiers sources contenant les données des pays et régions OMS
files = [
    "../SourceData/art_coverage_by_country_clean.csv",
    "../SourceData/art_pediatric_coverage_by_country_clean.csv",
    "../SourceData/no_of_cases_adults_15_to_49_by_country_clean.csv",
    "../SourceData/no_of_deaths_by_country_clean.csv",
    "../SourceData/no_of_people_living_with_hiv_by_country_clean.csv",
    "../SourceData/prevention_of_mother_to_child_transmission_by_country_clean.csv"
]

# Fonction pour extraire les pays et les régions d’un fichier CSV avec gestion d'erreur
def extract_countries_regions(file_path):
    try:
        df = pd.read_csv(file_path)  # Charger le fichier CSV
        df.columns = df.columns.str.strip()  # Suppression des espaces autour des noms de colonnes

        # Identification des colonnes "Country" (pays) et "WHO Region" (région OMS) si présentes
        country_col = next((col for col in df.columns if "Country" in col), None)
        region_col = next((col for col in df.columns if "WHO Region" in col), None)

        # Vérification de la présence des colonnes
        if country_col and region_col:
            df.rename(columns={country_col: "pays", region_col: "region_who"}, inplace=True)  # Renommage pour uniformisation
            return df[["pays", "region_who"]].drop_duplicates()  # Sélection des colonnes utiles et suppression des doublons
        elif country_col:
            df.rename(columns={country_col: "pays"}, inplace=True)  # Si seule la colonne "Country" est présente
            return df[["pays"]].drop_duplicates()  # Sélection des pays uniques
        else:
            print(f" Aucune colonne 'Country' trouvée dans `{file_path}` !")
            return pd.DataFrame(columns=["pays", "region_who"])  # Retourner un DataFrame vide si aucun pays trouvé

    except FileNotFoundError:
        print(f" Erreur critique : Le fichier `{file_path}` est introuvable !")
        exit()  # Arrête immédiatement le script

    except Exception as e:
        print(f" Erreur lors de la lecture de `{file_path}` : {e}")
        exit()  # Arrête immédiatement le script

try:
    # Extraction et fusion des pays et régions provenant de tous les fichiers sources
    pays_df = pd.concat([extract_countries_regions(file) for file in files], ignore_index=True)
    print(f" Extraction des {len(files)} fichiers réussie.")

except Exception as e:
    print(f" Erreur lors de l'extraction : {e}")
    exit()  # Arrêter le script si l'extraction échoue

# ---------------------- 🟡 TRANSFORMATION (Transform) ----------------------

try:
    #  Nettoyage des noms de pays et régions
    pays_df["pays"] = pays_df["pays"].str.strip().str.lower().str.replace(r"\s+", " ", regex=True)  # Nettoyage des noms de pays
    pays_df["region_who"] = pays_df["region_who"].str.strip().str.lower()  # Nettoyage des noms de région OMS

    #  Suppression des doublons basés sur les noms de pays
    pays_df.drop_duplicates(subset=["pays"], inplace=True)

    # Vérification si le DataFrame est vide après transformation
    if pays_df.empty:
        raise ValueError(" Aucune donnée valide après transformation ! Vérifie les fichiers sources.")

    # Ajout d'un identifiant unique pour chaque pays
    pays_df.insert(0, "id_pays", range(1, len(pays_df) + 1))

    print(" Transformation des données réussie.")

except Exception as e:
    print(f" Erreur lors de la transformation : {e}")
    exit()  # Arrêter le script si la transformation échoue

# ---------------------- 🔵 CHARGEMENT (Load) ----------------------

try:
    # Chemin du fichier de sortie
    output_file = "../DatasetClean/pays_clean.csv"

    # Sauvegarde du DataFrame nettoyé sous forme de fichier CSV
    pays_df.to_csv(output_file, index=False)

    print(f" Table `pays_clean.csv` enregistrée avec {len(pays_df)} pays et leur région OMS.")

except Exception as e:
    print(f" Erreur lors de l'enregistrement du fichier : {e}")
    exit()  # Arrêter le script si l'enregistrement échoue