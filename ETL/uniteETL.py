import pandas as pd

# ---------------------- 🟢 EXTRACTION (Extract) ----------------------

data = {
    "id_unite": [1, 2],
    "libelle": ["Pourcentage", "Effectif"]
}

# ---------------------- 🟡 TRANSFORMATION (Transform) ----------------------

unite_df = pd.DataFrame(data)

# ---------------------- 🔵 CHARGEMENT (Load) ----------------------

output_file = "../DatasetClean/unite_clean.csv"
unite_df.to_csv(output_file, index=False)
print(f" Table `unité` enregistrée sous : {output_file}")