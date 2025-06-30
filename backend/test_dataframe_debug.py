#!/usr/bin/env python3
"""
Test script pour debugger l'endpoint /dataframe/
"""
import requests
import json

def test_dataframe_endpoint():
    """Test l'endpoint dataframe avec différents payloads"""
    
    # Test 1: Payload minimal (comme dans le frontend)
    payload_minimal = {
        "table": "statistique",
        "target_column": "value",
        "pays": "Brazil",
        "max_records": 100
    }
    
    print("🔍 TEST 1 - Payload minimal (comme frontend):")
    print(json.dumps(payload_minimal, indent=2))
    
    try:
        response = requests.post('http://localhost:8080/api/fr/dataframe/', 
                               json=payload_minimal, 
                               timeout=10,
                               headers={'Content-Type': 'application/json'})
        print(f"✅ Status: {response.status_code}")
        if response.status_code == 200:
            data = response.json()
            print(f"📊 Réponse: {len(data.get('data', []))} enregistrements")
            if data.get('data'):
                print(f"🔗 Colonnes: {list(data['data'][0].keys())}")
        else:
            print(f"❌ Erreur: {response.text}")
            # Afficher les détails de l'erreur
            try:
                error_detail = response.json()
                print(f"📋 Détails: {json.dumps(error_detail, indent=2)}")
            except:
                pass
    except Exception as e:
        print(f"💥 Exception: {e}")
    
    print("\n" + "="*50 + "\n")
    
    # Test 2: Payload avec tous les champs optionnels
    payload_complet = {
        "table": "statistique",
        "target_column": "value",
        "who_region": "Americas",
        "pays": "Brazil",
        "indicator_types": ["People Living with HIV"],
        "value_types": ["Estimate"],
        "year_min": 2019,
        "year_max": 2023,
        "max_records": 100,
        "include_confidence": True
    }
    
    print("🔍 TEST 2 - Payload complet:")
    print(json.dumps(payload_complet, indent=2))
    
    try:
        response = requests.post('http://localhost:8080/api/fr/dataframe/', 
                               json=payload_complet, 
                               timeout=10,
                               headers={'Content-Type': 'application/json'})
        print(f"✅ Status: {response.status_code}")
        if response.status_code == 200:
            data = response.json()
            print(f"📊 Réponse: {len(data.get('data', []))} enregistrements")
            if data.get('data'):
                print(f"🔗 Colonnes: {list(data['data'][0].keys())}")
        else:
            print(f"❌ Erreur: {response.text}")
            try:
                error_detail = response.json()
                print(f"📋 Détails: {json.dumps(error_detail, indent=2)}")
            except:
                pass
    except Exception as e:
        print(f"💥 Exception: {e}")
    
    print("\n" + "="*50 + "\n")
    
    # Test 3: Format exact du frontend avec null values
    payload_frontend = {
        "who_region": None,  # null dans le frontend
        "pays": "Brazil",
        "indicator_types": ["People Living with HIV"],  # Array(1) dans le frontend
        "value_types": ["Estimate"],  # Array(1) dans le frontend  
        "year_min": 2000,
        "year_max": None,  # null ou undefined dans le frontend
        "target_column": "value",
        "table": "statistique",
        "max_records": 1000,
        "include_confidence": True
    }
    
    print("🔍 TEST 3 - Format exact du frontend:")
    print(json.dumps(payload_frontend, indent=2))
    
    try:
        response = requests.post('http://localhost:8080/api/fr/dataframe/', 
                               json=payload_frontend, 
                               timeout=10,
                               headers={'Content-Type': 'application/json'})
        print(f"✅ Status: {response.status_code}")
        if response.status_code == 200:
            data = response.json()
            print(f"📊 Réponse: {len(data.get('data', []))} enregistrements")
            if data.get('data'):
                print(f"🔗 Colonnes: {list(data['data'][0].keys())}")
        else:
            print(f"❌ Erreur: {response.text}")
            try:
                error_detail = response.json()
                print(f"📋 Détails: {json.dumps(error_detail, indent=2)}")
            except:
                pass
    except Exception as e:
        print(f"💥 Exception: {e}")

if __name__ == "__main__":
    test_dataframe_endpoint()
