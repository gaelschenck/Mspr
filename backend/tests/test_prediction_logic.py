#!/usr/bin/env python3
"""
Script de test pour diagnostiquer le problème de prédiction avec des données simulées
"""

import pandas as pd
import numpy as np
import sys
import os
sys.path.append(os.path.dirname(os.path.abspath(__file__)))

from prediction import prepare_data_generic, preprocess_features, train_voting_regressor, create_voting_regressor

def test_prediction_logic():
    """
    Teste la logique de prédiction avec différents scénarios de données
    """
    print("=== TEST DE LA LOGIQUE DE PRÉDICTION ===")
    print()
    
    # Test 1: Données insuffisantes (cas probable pour Europe + population_hiv)
    print("1. TEST AVEC DONNÉES INSUFFISANTES (scénario Europe):")
    try:
        # Simuler le cas où il n'y a que quelques lignes de données
        df_small = pd.DataFrame({
            'id_pays': [1, 2],
            'pays': ['France', 'Allemagne'],
            'region_who': ['Europe', 'Europe'],
            'annee': [2020, 2021],
            'valeur': [1000.5, 1100.2],
            'id_unite': [1, 1]
        })
        
        print(f"DataFrame test: {df_small.shape}")
        print(df_small)
        print()
        
        X, y = prepare_data_generic(df_small, target_column='annee')
        print(f"Après prepare_data_generic: X={X.shape}, y={len(y) if y is not None else 0}")
        
        X_processed = preprocess_features(X)
        print(f"Après preprocess_features: X={X_processed.shape}")
        
        if len(X_processed) < 5:
            print(" ERREUR ATTENDUE: Pas assez de données pour l'entraînement")
            print("C'est probablement le problème avec vos données Europe + population_hiv")
        else:
            print(" Données suffisantes")
            
    except Exception as e:
        print(f" ERREUR: {e}")
    print()
    
    # Test 2: Données suffisantes
    print("2. TEST AVEC DONNÉES SUFFISANTES:")
    try:
        # Créer des données avec plus de lignes
        np.random.seed(42)
        df_good = pd.DataFrame({
            'id_pays': range(1, 11),
            'pays': [f'Pays{i}' for i in range(1, 11)],
            'region_who': ['Europe'] * 10,
            'annee': [2020 + (i % 5) for i in range(10)],
            'valeur': np.random.uniform(1000, 5000, 10),
            'id_unite': [1] * 10
        })
        
        print(f"DataFrame test: {df_good.shape}")
        print(df_good.head())
        print()
        
        X, y = prepare_data_generic(df_good, target_column='annee')
        print(f"Après prepare_data_generic: X={X.shape}, y={len(y) if y is not None else 0}")
        
        X_processed = preprocess_features(X)
        print(f"Après preprocess_features: X={X_processed.shape}")
        
        if len(X_processed) >= 5 and X_processed.shape[1] > 0:
            print(" Tentative d'entraînement...")
            model = create_voting_regressor()
            trained_model, rmse, r2, future_pred, future_year = train_voting_regressor(model, X_processed, y)
            print(f" Entraînement réussi! RMSE: {rmse:.2f}, R²: {r2:.2f}")
        else:
            print(" Pas assez de données ou caractéristiques")
            
    except Exception as e:
        print(f" ERREUR: {e}")
        import traceback
        traceback.print_exc()
    print()
    
    # Test 3: Problème avec colonne cible
    print("3. TEST AVEC COLONNE CIBLE PROBLÉMATIQUE:")
    try:
        df_bad_target = pd.DataFrame({
            'id_pays': range(1, 6),
            'pays': [f'Pays{i}' for i in range(1, 6)],
            'region_who': ['Europe'] * 5,
            'annee': [2020, 2020, 2020, 2020, 2020],  # Toutes les mêmes valeurs
            'valeur': np.random.uniform(1000, 5000, 5),
            'id_unite': [1] * 5
        })
        
        print(f"DataFrame test (annees identiques): {df_bad_target['annee'].unique()}")
        
        X, y = prepare_data_generic(df_bad_target, target_column='annee')
        print(f"Valeurs cibles uniques: {y.nunique() if y is not None else 0}")
        
        if y is not None and y.nunique() == 1:
            print(" ERREUR ATTENDUE: Toutes les valeurs cibles sont identiques")
            print("Le modèle ne peut pas apprendre avec une seule valeur cible")
        
    except Exception as e:
        print(f" ERREUR: {e}")
    print()
    
    print("=== RECOMMANDATIONS ===")
    print("Pour résoudre l'erreur 422 avec Europe + population_hiv + annee:")
    print("1. Vérifiez qu'il y a au moins 5 pays européens dans votre base")
    print("2. Vérifiez que ces pays ont des données dans population_hiv")
    print("3. Vérifiez que les valeurs d'annee sont variées (pas toutes identiques)")
    print("4. Essayez avec 'valeur' comme colonne cible au lieu de 'annee'")
    print("5. Ou essayez avec une autre région (Africa, Americas, etc.)")

if __name__ == "__main__":
    test_prediction_logic()
