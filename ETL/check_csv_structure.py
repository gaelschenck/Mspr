#!/usr/bin/env python3
"""
Script pour vérifier la structure des fichiers CSV générés par les ETL
"""

import os
import pandas as pd

def check_csv_structure():
    """Vérifie la structure de tous les fichiers CSV dans DatasetClean"""
    
    dataset_path = r"c:\Users\gaels\OneDrive\Documents\ECOLE-EPSI\Mspr\DatasetClean"
    
    if not os.path.exists(dataset_path):
        print(f"Le dossier {dataset_path} n'existe pas.")
        return
    
    csv_files = [f for f in os.listdir(dataset_path) if f.endswith('.csv')]
    
    for csv_file in sorted(csv_files):
        filepath = os.path.join(dataset_path, csv_file)
        print(f"\n{'='*60}")
        print(f"Fichier: {csv_file}")
        print(f"{'='*60}")
        
        try:
            # Lire seulement les 5 premières lignes
            df = pd.read_csv(filepath, nrows=5)
            print(f"Colonnes: {list(df.columns)}")
            print(f"Nombre de colonnes: {len(df.columns)}")
            print(f"Types de données:")
            for col in df.columns:
                print(f"  {col}: {df[col].dtype}")
            
            print(f"\nPremières lignes:")
            print(df.to_string(index=False))
            
            # Vérifier le nombre total de lignes
            total_lines = sum(1 for line in open(filepath, 'r', encoding='utf-8'))
            print(f"\nNombre total de lignes (avec en-tête): {total_lines}")
            
        except Exception as e:
            print(f"Erreur lors de la lecture de {csv_file}: {e}")

if __name__ == "__main__":
    check_csv_structure()
