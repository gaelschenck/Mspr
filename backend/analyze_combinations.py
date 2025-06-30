#!/usr/bin/env python3
"""
Analyser en détail les combinaisons disponibles
"""
import requests
import json
from collections import defaultdict

def analyze_brazil_combinations():
    """Analyser toutes les combinaisons disponibles pour le Brésil"""
    
    print("🔬 ANALYSE DÉTAILLÉE DES COMBINAISONS - BRÉSIL\n")
    
    # Récupérer toutes les données du Brésil
    payload = {
        "table": "statistique",
        "target_column": "value", 
        "pays": "Brazil",
        "max_records": 1000
    }
    
    try:
        response = requests.post('http://localhost:8080/api/fr/dataframe/', 
                               json=payload, 
                               timeout=10,
                               headers={'Content-Type': 'application/json'})
        
        if response.status_code == 200:
            data = response.json()
            records = data.get('data', [])
            print(f"✅ {len(records)} enregistrements trouvés\n")
            
            # Analyser les combinaisons indicator_type + value_type
            combinations = defaultdict(list)
            
            for record in records:
                indicator = record.get('indicator_type_name')
                value_type = record.get('value_type')
                year = record.get('year')
                value = record.get('value')
                
                key = f"{indicator} | {value_type}"
                combinations[key].append({
                    'year': year,
                    'value': value
                })
            
            print("🎯 COMBINAISONS INDICATOR_TYPE + VALUE_TYPE DISPONIBLES:\n")
            for combo, data_points in combinations.items():
                years = [str(dp['year']) for dp in data_points]
                print(f"📊 {combo}")
                print(f"   Années: {', '.join(sorted(years))}")
                print(f"   Valeurs: {[dp['value'] for dp in data_points[:3]]}{'...' if len(data_points) > 3 else ''}")
                print()
                
            # Test spécifique avec une combinaison qui existe
            if combinations:
                first_combo = list(combinations.keys())[0]
                indicator_name, value_type_name = first_combo.split(' | ')
                
                print(f"🧪 TEST AVEC UNE COMBINAISON QUI EXISTE:")
                print(f"   Indicator: {indicator_name}")
                print(f"   Value Type: {value_type_name}")
                
                test_payload = {
                    "table": "statistique",
                    "target_column": "value",
                    "pays": "Brazil",
                    "indicator_types": [indicator_name],
                    "value_types": [value_type_name],
                    "max_records": 1000,
                    "include_confidence": True
                }
                
                test_response = requests.post('http://localhost:8080/api/fr/dataframe/', 
                                           json=test_payload, 
                                           timeout=10,
                                           headers={'Content-Type': 'application/json'})
                
                print(f"\n🚀 Status: {test_response.status_code}")
                if test_response.status_code == 200:
                    test_data = test_response.json()
                    print(f"✅ SUCCÈS ! {len(test_data.get('data', []))} enregistrements")
                    
                    # Maintenant tester l'entraînement du modèle
                    if test_data.get('data'):
                        print(f"\n🤖 TEST ENTRAÎNEMENT MODÈLE...")
                        train_payload = {
                            "dataframe": test_data['data'],
                            "target_column": "value"
                        }
                        
                        train_response = requests.post('http://localhost:8080/api/fr/train_model/', 
                                                     json=train_payload, 
                                                     timeout=30,
                                                     headers={'Content-Type': 'application/json'})
                        
                        print(f"🎯 Training Status: {train_response.status_code}")
                        if train_response.status_code == 200:
                            train_data = train_response.json()
                            print(f"🎉 MODÈLE ENTRAÎNÉ AVEC SUCCÈS !")
                            print(f"   RMSE: {train_data.get('rmse', 'N/A')}")
                            print(f"   R²: {train_data.get('r2', 'N/A')}")
                            if 'future_prediction' in train_data:
                                print(f"   Prédiction future: {train_data['future_prediction']} ({train_data.get('future_year', 'N/A')})")
                        else:
                            print(f"❌ Erreur entraînement: {train_response.text}")
                else:
                    print(f"❌ Erreur test: {test_response.text}")
        else:
            print(f"❌ Erreur: {response.status_code} - {response.text}")
            
    except Exception as e:
        print(f"💥 Exception: {e}")

if __name__ == "__main__":
    analyze_brazil_combinations()
