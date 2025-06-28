#!/usr/bin/env python
# -*- coding: utf-8 -*-

import pandas as pd
import sys
import os
import matplotlib
matplotlib.use('Agg')  # Utiliser un backend sans interface graphique

# Désactiver l'affichage des graphiques pendant les tests
os.environ['MPLBACKEND'] = 'Agg'
os.environ['DISPLAY'] = ''

# Ajouter le répertoire courant au PYTHONPATH
sys.path.insert(0, os.path.dirname(os.path.dirname(os.path.abspath(__file__))))

from prediction import prepare_data_generic, preprocess_features, create_voting_regressor, train_voting_regressor

def test_prediction():
    print('=== Test de la prédiction ===')
    
    # Créer des données de test
    df_test = pd.DataFrame({
        'id_pays': [1, 2, 3, 4, 5, 6, 7, 8],
        'annee': [2020, 2021, 2020, 2021, 2022, 2020, 2021, 2022],
        'valeur': [100.5, 120.3, 95.7, 110.2, 130.1, 85.4, 105.6, 125.8],
        'pays': ['France', 'Germany', 'Spain', 'Italy', 'Portugal', 'Belgium', 'Netherlands', 'Austria'],
        'region_who': ['Europe', 'Europe', 'Europe', 'Europe', 'Europe', 'Europe', 'Europe', 'Europe']
    })

    print('DataFrame de test:')
    print(df_test)
    print()

    try:
        # Test de prepare_data_generic
        print('1. Test de prepare_data_generic...')
        X, y = prepare_data_generic(df_test, target_column='valeur')
        print(f'X shape: {X.shape}')
        print(f'y shape: {y.shape}')
        print(f'Features: {X.columns.tolist()}')
        print()
        
        # Test de preprocess_features
        print('2. Test de preprocess_features...')
        X_processed = preprocess_features(X)
        print(f'X après préprocessing: {X_processed.shape}')
        print(f'Features finales: {X_processed.columns.tolist()}')
        print()
        
        # Test de création du modèle
        print('3. Test de création du modèle...')
        model = create_voting_regressor()
        print('Modèle créé avec succès')
        print(f'Type du modèle: {type(model)}')
        print()
        
        # Test d'entraînement complet
        print('4. Test d\'entraînement complet...')
        if len(X_processed) >= 5:  # Au moins 5 échantillons pour l'entraînement
            trained_model, rmse, r2, future_pred, future_year = train_voting_regressor(model, X_processed, y)
            print('Entraînement réussi !')
            print(f'RMSE: {rmse}')
            print(f'R2: {r2}')
            print(f'Prédiction future: {future_pred} pour {future_year}')
        else:
            print('Pas assez de données pour l\'entraînement (besoin de 5+ échantillons)')
        
        print('\n=== Test réussi ! ===')
        
    except Exception as e:
        print(f'Erreur: {e}')
        import traceback
        traceback.print_exc()

if __name__ == "__main__":
    test_prediction()
