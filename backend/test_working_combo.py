#!/usr/bin/env python3
"""
Test avec une combinaison qui a assez de données
"""
import requests
import json

def test_working_combination():
    """Test avec People Living with HIV | count qui a 4 points de données"""
    
    print("🎯 TEST AVEC UNE COMBINAISON QUI A ASSEZ DE DONNÉES\n")
    
    # Combinaison qui fonctionne : People Living with HIV | count (4 points)
    payload = {
        "table": "statistique",
        "target_column": "value",
        "pays": "Brazil",
        "indicator_types": ["People Living with HIV"],
        "value_types": ["count"],  # PAS "Estimate" !
        "max_records": 1000,
        "include_confidence": True
    }
    
    print("🔍 Payload avec la combinaison qui fonctionne:")
    print(json.dumps(payload, indent=2))
    
    try:
        # Étape 1: Créer le DataFrame
        print(f"\n📊 Étape 1: Création du DataFrame...")
        response = requests.post('http://localhost:8080/api/fr/dataframe/', 
                               json=payload, 
                               timeout=10,
                               headers={'Content-Type': 'application/json'})
        
        print(f"Status: {response.status_code}")
        
        if response.status_code == 200:
            data = response.json()
            records = data.get('data', [])
            print(f"✅ {len(records)} enregistrements trouvés")
            
            if len(records) >= 2:
                # Étape 2: Entraîner le modèle
                print(f"\n🤖 Étape 2: Entraînement du modèle...")
                train_payload = {
                    "dataframe": records,
                    "target_column": "value"
                }
                
                train_response = requests.post('http://localhost:8080/api/fr/train_model/', 
                                             json=train_payload, 
                                             timeout=30,
                                             headers={'Content-Type': 'application/json'})
                
                print(f"Status: {train_response.status_code}")
                
                if train_response.status_code == 200:
                    train_data = train_response.json()
                    print(f"\n🎉 MODÈLE ENTRAÎNÉ AVEC SUCCÈS !")
                    print(f"   📈 RMSE: {train_data.get('rmse', 'N/A'):.2f}")
                    print(f"   🎯 R²: {train_data.get('r2', 'N/A'):.3f}")
                    
                    if 'future_prediction' in train_data:
                        print(f"   🔮 Prédiction future: {train_data['future_prediction']:.0f} ({train_data.get('future_year', 'N/A')})")
                    
                    print(f"\n✅ LA PRÉDICTION FONCTIONNE ! ✅")
                    print(f"🚀 Le problème était dans le frontend : mauvaises valeurs 'value_types'")
                    
                else:
                    print(f"❌ Erreur entraînement: {train_response.text}")
            else:
                print(f"⚠️ Pas assez de données ({len(records)} < 2)")
        else:
            print(f"❌ Erreur DataFrame: {response.text}")
            
    except Exception as e:
        print(f"💥 Exception: {e}")

if __name__ == "__main__":
    test_working_combination()
