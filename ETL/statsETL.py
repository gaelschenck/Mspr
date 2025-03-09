import pandas as pd

#  Définition des chemins des fichiers sources
pays_file = "./Csv2Table/pays_clean2.csv"
files = {
    "cases_adults": "./DataSet/no_of_cases_adults_15_to_49_by_country_clean.csv",
    "deaths": "./DataSet/no_of_deaths_by_country_clean.csv",
    "hiv_population": "./DataSet/no_of_people_living_with_hiv_by_country_clean.csv",
    "mother_to_child": "./DataSet/prevention_of_mother_to_child_transmission_by_country_clean.csv"
}

#  Fichier de sortie
output_file = "./Csv2Table/statistique_clean.csv"

#  Charger la table des pays
pays_df = pd.read_csv(pays_file)
print(f" Colonnes disponibles dans `pays_clean2.csv` : {pays_df.columns.tolist()}")

#  Assurer la cohérence des colonnes
pays_df.rename(columns={"pays": "Country"}, inplace=True)

#  Mapping des fichiers avec `id_type_statistique`
statistique_mapping = {
    "cases_adults": 1,
    "deaths": 2,
    "hiv_population": 3,
    "mother_to_child": 4
}

#  Fonction pour charger et nettoyer les fichiers de statistiques
def process_statistique(file_path, id_type_statistique):
    df = pd.read_csv(file_path)
    df.columns = df.columns.str.strip()
    print(f" Colonnes disponibles dans `{file_path}` : {df.columns.tolist()}")
    print(f" Shape of {file_path}: {df.shape}")

    if "Country" not in df.columns:
        raise KeyError(f" La colonne `Country` est absente de `{file_path}`")

    # Normaliser les noms des pays
    df["Country"] = df["Country"].str.lower().str.strip()
    pays_df["Country"] = pays_df["Country"].str.lower().str.strip()

    print(f" Exemples de pays dans `{file_path}` : {df['Country'].dropna().unique()[:10]}")
    print(f" Exemples de pays dans `pays_clean2.csv` : {pays_df['Country'].dropna().unique()[:10]}")

    df = df.merge(pays_df[["Country", "id_pays"]], on="Country", how="inner")
    print(f" Shape after merge: {df.shape}")

    df["id_type_statistique"] = id_type_statistique

    if "Year" in df.columns:
        df.rename(columns={"Year": "annee"}, inplace=True)
    else:
        df["annee"] = 2020

    df.drop(columns=["Country"], inplace=True)

    return df


#  Traiter chaque fichier et les fusionner
statistique_dfs = []
for key, path in files.items():
    df = process_statistique(path, statistique_mapping[key])
    statistique_dfs.append(df)

#  Fusionner les datasets
statistique_df = pd.concat(statistique_dfs, ignore_index=True)

# Remplir les valeurs NaN avec une valeur par défaut
statistique_df.fillna(0, inplace=True)
#  Sauvegarder le fichier final
statistique_df.to_csv(output_file, index=False)
print(f" Table `statistique_clean` enregistrée sous : {output_file}")

#  Aperçu des données finales
print(" Aperçu de la table `statistique_clean` :")
print(statistique_df.head(10))