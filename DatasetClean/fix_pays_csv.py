import pandas as pd

# Lire le fichier CSV actuel
df = pd.read_csv('pays_clean.csv')

print("Colonnes actuelles:", list(df.columns))
print("Premières lignes:")
print(df.head())

# Ajouter la colonne id_pays si elle manque
if 'id_pays' not in df.columns:
    print("\nAjout de la colonne id_pays...")
    df.insert(0, 'id_pays', range(1, len(df) + 1))
    
    # Réorganiser les colonnes selon le modèle SQLAlchemy
    df.columns = ['id_pays', 'pays', 'region_who']
    
    # Sauvegarder
    df.to_csv('pays_clean.csv', index=False)
    print("Fichier corrigé et sauvegardé!")
    
print("\nNouvelles colonnes:", list(df.columns))
print("Nombre de lignes:", len(df))
