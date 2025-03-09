import pandas as pd

# ---------------------- 🟢 EXTRACTION (Extract) ----------------------

data = {
    "id_type_stat": [1, 2, 3],
    "libelle": ["Taux HIV", "Taux mortalité", "Nombre de cas"]
}

# ---------------------- 🟡 TRANSFORMATION (Transform) ----------------------

type_stat_df = pd.DataFrame(data)

# ---------------------- 🔵 CHARGEMENT (Load) ----------------------

output_file = "../DatasetClean/type_statistique_clean.csv"
type_stat_df.to_csv(output_file, index=False)
print(f" Table `type_statistique` enregistrée sous : {output_file}")