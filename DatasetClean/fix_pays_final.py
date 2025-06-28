import pandas as pd

# Lire le fichier actuel
df = pd.read_csv('pays_clean.csv')
print("Structure actuelle:")
print(df.head())
print("Colonnes:", list(df.columns))

# Créer un nouveau DataFrame corrigé
df_corrected = pd.DataFrame()
df_corrected['id_pays'] = range(1, len(df) + 1)
df_corrected['pays'] = df.iloc[:, 0].astype(str)  # Première colonne devient pays
df_corrected['region_who'] = df.iloc[:, 1].astype(str)  # Deuxième colonne devient region_who

# Nettoyer les valeurs NaN et 'nan'
df_corrected['region_who'] = df_corrected['region_who'].replace('nan', '')

# Sauvegarder
df_corrected.to_csv('pays_clean.csv', index=False)
print("\nFichier corrigé!")
print("Nouvelles données:")
print(df_corrected.head())
print("Colonnes finales:", list(df_corrected.columns))
