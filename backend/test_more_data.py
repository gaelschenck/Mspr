#!/usr/bin/env python3
"""
Test avec plus de données (région ou plusieurs pays)
"""
import requests
import json

def test_with_more_data():
    """Test avec une région entière pour avoir plus de données"""
    
    print("🌍 TEST AVEC PLUS DE DONNÉES (RÉGION AMERICAS)\n")
    
    # Test avec toute la région Americas pour avoir plus de données
    payload_region = {
        "table": "statistique",
        "target_column": "value",
        "who_region": "Americas",  # Toute la région au lieu d'un seul pays
        "indicator_types": ["People Living with HIV"],
        "value_types": ["count"],
        "max_records": 1000,
        "include_confidence": True
    }
    
    print("🔍 Payload avec région Americas:")
    print(json.dumps(payload_region, indent=2))
    
    try:
        # Étape 1: Créer le DataFrame
        print(f"\n📊 Étape 1: Création du DataFrame...")
        response = requests.post('http://localhost:8080/api/fr/dataframe/', 
                               json=payload_region, 
                               timeout=10,
                               headers={'Content-Type': 'application/json'})
        
        print(f"Status: {response.status_code}")
        
        if response.status_code == 200:
            data = response.json()
            records = data.get('data', [])
            print(f"✅ {len(records)} enregistrements trouvés")
            
            # Afficher quelques exemples
            if records:
                print(f"\n📋 Exemples d'enregistrements:")
                for i, record in enumerate(records[:5]):
                    country = record.get('country_name')
                    year = record.get('year')
                    value = record.get('value')
                    print(f"  {i+1}. {country} - {year}: {value}")
            
            if len(records) >= 5:
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
                    
                    print(f"\n🚀 SUCCÈS COMPLET ! LA PRÉDICTION FONCTIONNE ! 🚀")
                    
                else:
                    print(f"❌ Erreur entraînement: {train_response.text}")
            else:
                print(f"⚠️ Pas assez de données ({len(records)} < 5)")
        else:
            print(f"❌ Erreur DataFrame: {response.text}")
    
    except Exception as e:
        print(f"💥 Exception: {e}")
    
    print("\n" + "="*60 + "\n")
    
    # Test 2: Avec tous les pays (sans filtre géographique)
    print("🌍 TEST 2: AVEC TOUS LES PAYS")
    
    payload_all = {
        "table": "statistique",
        "target_column": "value",
        # Pas de filtre géographique = tous les pays
        "indicator_types": ["People Living with HIV"],
        "value_types": ["count"],
        "max_records": 1000,
        "include_confidence": True
    }
    
    print("🔍 Payload sans filtre géographique:")
    print(json.dumps(payload_all, indent=2))
    
    try:
        response = requests.post('http://localhost:8080/api/fr/dataframe/', 
                               json=payload_all, 
                               timeout=10,
                               headers={'Content-Type': 'application/json'})
        
        print(f"\nStatus: {response.status_code}")
        
        if response.status_code == 200:
            data = response.json()
            records = data.get('data', [])
            print(f"✅ {len(records)} enregistrements trouvés")
            
            if len(records) >= 5:
                print(f"🎯 Assez de données pour l'entraînement !")
            else:
                print(f"⚠️ Pas assez de données ({len(records)} < 5)")
        else:
            print(f"❌ Erreur: {response.text}")
    
    except Exception as e:
        print(f"💥 Exception: {e}")

if __name__ == "__main__":
    test_with_more_data()
