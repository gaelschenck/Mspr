#!/usr/bin/env python
# -*- coding: utf-8 -*-

import requests
import json
import pytest

def test_prediction_api():
    """Test de l'API de prédiction avec un serveur local"""
    
    BASE_URL = "http://localhost:8084"  # Ajustez le port selon votre config
    
    # Vérifier si le serveur est disponible
    try:
        response = requests.get(f"{BASE_URL}/", timeout=2)
    except (requests.exceptions.ConnectionError, requests.exceptions.Timeout):
        pytest.skip("Serveur API non disponible - test ignoré")
        return
    
    print("=== Test de l'API de prédiction ===")
    
    try:
        # 1. Test de santé
        print("1. Test de santé...")
        health_response = requests.get(f"{BASE_URL}/health")
        print(f"Santé: {health_response.status_code} - {health_response.json()}")
        
        # 2. Test de récupération des tables
        print("\n2. Test des tables disponibles...")
        tables_response = requests.get(f"{BASE_URL}/tables/")
        tables_data = tables_response.json()
        print(f"Tables: {tables_data}")
        
        # 3. Test de création de DataFrame
        print("\n3. Test de création de DataFrame...")
        dataframe_payload = {
            "region": "Europe",
            "pays": None,
            "table": "mortalite",
            "target_column": "valeur"
        }
        
        dataframe_response = requests.post(
            f"{BASE_URL}/dataframe/",
            headers={"Content-Type": "application/json"},
            data=json.dumps(dataframe_payload)
        )
        
        if dataframe_response.status_code == 200:
            dataframe_data = dataframe_response.json()
            print(f"DataFrame créé avec {len(dataframe_data['dataframe'])} lignes")
            
            # 4. Test d'entraînement du modèle
            print("\n4. Test d'entraînement du modèle...")
            train_payload = {
                "dataframe": dataframe_data["dataframe"],
                "target_column": "valeur"
            }
            
            train_response = requests.post(
                f"{BASE_URL}/train_model/",
                headers={"Content-Type": "application/json"},
                data=json.dumps(train_payload)
            )
            
            if train_response.status_code == 200:
                train_data = train_response.json()
                print(f"Modèle entraîné avec succès!")
                print(f"RMSE: {train_data.get('rmse')}")
                print(f"R²: {train_data.get('r2')}")
                print(f"Prédictions: {len(train_data.get('prediction', []))} valeurs")
                print(f"Prédiction future: {train_data.get('future_prediction')} pour {train_data.get('future_year')}")
                
                print("\n=== Test API réussi ! ===")
                return True
            else:
                print(f"Erreur lors de l'entraînement: {train_response.status_code} - {train_response.text}")
        else:
            print(f"Erreur lors de la création du DataFrame: {dataframe_response.status_code} - {dataframe_response.text}")
            
    except requests.exceptions.ConnectionError:
        print("Erreur: Impossible de se connecter au serveur. Assurez-vous que le backend est en cours d'exécution.")
    except Exception as e:
        print(f"Erreur: {e}")
    
    return False

if __name__ == "__main__":
    test_prediction_api()
