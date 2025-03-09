import pandas as pd

df = pd.read_csv("./DataSet/prevention_of_mother_to_child_transmission_by_country_clean.csv")
pays_df = pd.read_csv("./Csv2Table/pays_clean2.csv").rename(columns={"id": "id_pays"})

df.rename(columns={"Country": "pays"}, inplace=True)
df = df.merge(pays_df, on="pays", how="inner").drop(columns=["pays"])
df.to_csv("./Csv2Table/prevention_mere_enfant_clean.csv", index=False)
print(" Table `prevention_mere_enfant` enregistrée")