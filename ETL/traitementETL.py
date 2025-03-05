import pandas as pd
import re

#  Chemins des fichiers sources
pays_file = "./Csv2Table/pays_clean.csv"
art_adult_file = "./DataSet/art_coverage_by_country_clean.csv"
art_child_file = "./DataSet/art_pediatric_coverage_by_country_clean.csv"

#  Fichier de sortie
output_file = "./Csv2Table/traitement_clean.csv"

#  Charger la table des pays
pays_df = pd.read_csv(pays_file)

#  Vérification des colonnes disponibles
print(f" Colonnes disponibles dans `pays_clean.csv` : {pays_df.columns.tolist()}")

#  Vérification que `id_pays` et `pays` existent
if "id_pays" not in pays_df.columns or "pays" not in pays_df.columns:
    raise KeyError(" `id_pays` ou `pays` manquant dans `pays_clean.csv` !")

#  Nettoyage des noms de pays
def clean_country_name(name):
    if pd.isna(name):
        return None
    return re.sub(r'\s+', ' ', name.strip().lower())  # Supprime les espaces en trop et met en minuscule

pays_df["pays"] = pays_df["pays"].apply(clean_country_name)

#  Fonction pour extraire médiane, min et max
def extract_values(value):
    match = re.search(r"(\d+)\[(\d+)[–-](\d+)\]", str(value))  # Supporte les tirets longs et courts
    if match:
        return int(match.group(1)), int(match.group(2)), int(match.group(3))
    return None, None, None

#  Fonction pour charger et transformer les fichiers de traitement
def process_treatment(file_path, type_traitement):
    df = pd.read_csv(file_path)
    
    # Nettoyer les colonnes
    df.columns = df.columns.str.strip()
    print(f" Colonnes disponibles dans `{file_path}` : {df.columns.tolist()}")

    # Vérifier et récupérer la bonne colonne
    correct_col = None
    for col in df.columns:
        if "Estimated ART coverage" in col:
            correct_col = col
            break
    
    if not correct_col:
        raise KeyError(f" Colonne 'Estimated ART coverage' introuvable dans {file_path}")
    
    # Renommer les colonnes
    df.rename(columns={"Country": "pays", correct_col: "couverture"}, inplace=True)
    
    # Appliquer le même nettoyage sur les noms de pays
    df["pays"] = df["pays"].apply(clean_country_name)

    # Vérifier que `pays` existe bien après renommage
    if "pays" not in df.columns:
        raise KeyError(f" Colonne 'pays' absente après renommage dans {file_path}")

    # Associer chaque pays à son `id_pays`
    df = df.merge(pays_df, on="pays", how="inner")  # Utilisation directe de `id_pays`

    # Vérifier après merge
    print(f" Exemples de `id_pays` dans `{file_path}` après merge : \n{df[['id_pays']].drop_duplicates().head(5)}")

    # Extraire médiane, min et max
    df[["median", "min", "max"]] = df["couverture"].apply(lambda x: pd.Series(extract_values(x)))
    
    # Supprimer l'ancienne colonne
    df.drop(columns=["couverture", "pays"], inplace=True)
    
    # Ajouter l'id_type_traitement (1 = Adulte, 2 = Enfant)
    df["id_type_traitement"] = 1 if type_traitement == "adulte" else 2
    
    return df

#  Traiter les fichiers adulte et enfant
traitement_adulte_df = process_treatment(art_adult_file, "adulte")
traitement_enfant_df = process_treatment(art_child_file, "enfant")

#  Fusionner les deux datasets
traitement_df = pd.concat([traitement_adulte_df, traitement_enfant_df], ignore_index=True)

#  Sauvegarder le fichier final
traitement_df.to_csv(output_file, index=False)
print(f" Table `traitement_clean` enregistrée sous : {output_file}")

#  Aperçu des données finales
print(" Aperçu de la table `traitement_clean` :")
print(traitement_df.head(10))