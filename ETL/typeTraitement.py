import pandas as pd

# ---------------------- 🟢 EXTRACTION (Extract) ----------------------

data = {
    "id_type_traitement": [1, 2],
    "libelle": ["Adulte", "Enfant"]
}

# ---------------------- 🟡 TRANSFORMATION (Transform) ----------------------

type_trait_df = pd.DataFrame(data)

# ---------------------- 🔵 CHARGEMENT (Load) ----------------------

output_file = "../DatasetClean/type_traitement_clean.csv"
type_trait_df.to_csv(output_file, index=False)
print(f" Table `type_traitement` enregistrée sous : {output_file}")