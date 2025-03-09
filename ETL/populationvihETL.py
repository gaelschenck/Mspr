import pandas as pd
import re

#  Chemins des fichiers sources
pays_file = "./Csv2Table/pays_clean2.csv"
hiv_file = "./DataSet/no_of_people_living_with_hiv_by_country_clean.csv"

#  Fichier de sortie
output_file = "./Csv2Table/population_hiv_clean.csv"

#  Charger la table des pays
pays_df = pd.read_csv(pays_file)
pays_df.rename(columns={"pays": "Country"}, inplace=True)  # Uniformisation

#  Nettoyage des noms de pays (supprimer espaces et mettre en minuscule)
pays_df["Country"] = pays_df["Country"].str.strip().str.lower()

#  Charger et nettoyer le fichier source
df = pd.read_csv(hiv_file)
df.columns = df.columns.str.strip()  # Suppression des espaces autour des noms de colonnes

#  Vérification des colonnes disponibles
print(f" Colonnes disponibles dans `{hiv_file}` : {df.columns.tolist()}")

#  Normalisation des noms de pays
df["Country"] = df["Country"].str.strip().str.lower()

#  Vérifier si les pays correspondent bien entre `df` et `pays_df`
common_pays = set(df["Country"]).intersection(set(pays_df["Country"]))
if not common_pays:
    print(" Aucun pays ne correspond entre les fichiers. Vérifie les noms de pays !")
    print(" Exemples de pays dans `hiv_file` :", df["Country"].unique()[:10])
    print(" Exemples de pays dans `pays_file` :", pays_df["Country"].unique()[:10])
    exit()

#  Fusionner avec la table `pays` pour récupérer `id_pays`
df = df.merge(pays_df[["Country", "id_pays"]], on="Country", how="inner")

#  Extraire les valeurs médianes, min et max de population_hiv
def extract_values(value):
    match = re.match(r"(\d+)\[(\d+)–(\d+)\]", str(value))
    if match:
        return int(match.group(1)), int(round(float(match.group(2)))), int(round(float(match.group(3))))
    elif str(value).isdigit():
        return int(value), None, None  # Si la valeur est un nombre unique
    else:
        return None, None, None  # Si la valeur est NA, vide ou invalide

df[["population_hiv", "population_hiv_min", "population_hiv_max"]] = df["Count"].apply(lambda x: pd.Series(extract_values(x)))

#  Supprimer les lignes où `population_hiv` est `NaN` ou vide
df.dropna(subset=["population_hiv"], inplace=True)

#  Convertir `population_hiv`, `population_hiv_min` et `population_hiv_max` en entiers
df["population_hiv"] = df["population_hiv"].astype(int)
df["population_hiv_min"] = df["population_hiv_min"].fillna(0).astype(int)  # Remplacer NaN par 0
df["population_hiv_max"] = df["population_hiv_max"].fillna(0).astype(int)  # Remplacer NaN par 0

#  Sélectionner les colonnes nécessaires et renommer
df = df[["id_pays", "Year", "population_hiv", "population_hiv_min", "population_hiv_max"]].rename(columns={"Year": "annee"})

#  Sauvegarde du fichier nettoyé
df.to_csv(output_file, index=False)
print(f"✅ Table `population_hiv_clean` enregistrée sous : {output_file}")

#  Aperçu des données finales
if df.empty:
    print(" Attention, le fichier généré est vide. Vérifie les noms des pays et les valeurs !")
else:
    print(" Aperçu de la table `population_hiv_clean` :")
    print(df.head(10))