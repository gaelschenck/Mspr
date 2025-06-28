import pandas as pd

# Lire le fichier CSV
df = pd.read_csv('pays_clean.csv')

# Vérifier les colonnes actuelles
print("Colonnes actuelles:", list(df.columns))

# Supprimer la colonne sous_region si elle existe
if len(df.columns) > 3:  # Si il y a plus de 3 colonnes
    df = df.iloc[:, :3]  # Garder seulement les 3 premières
    df.columns = ['id_pays', 'pays', 'region_who']

# Sauvegarder
df.to_csv('pays_clean.csv', index=False)
print('Fichier pays_clean.csv mis à jour')
print('Nouvelles colonnes:', list(df.columns))
print('Nombre de lignes:', len(df))
