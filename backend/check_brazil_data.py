#!/usr/bin/env python3
"""
Vérifier quelles données sont disponibles pour le Brésil
"""
import requests
import json

def check_brazil_data():
    """Vérifier les données disponibles pour le Brésil"""
    
    print("🇧🇷 VÉRIFICATION DES DONNÉES DISPONIBLES POUR LE BRÉSIL\n")
    
    # Test 1: Obtenir toutes les données du Brésil sans filtre
    payload_brazil_all = {
        "table": "statistique",
        "target_column": "value",
        "pays": "Brazil",
        "max_records": 100
    }
    
    print("🔍 TEST 1 - Toutes les données du Brésil:")
    try:
        response = requests.post('http://localhost:8080/api/fr/dataframe/', 
                               json=payload_brazil_all, 
                               timeout=10,
                               headers={'Content-Type': 'application/json'})
        
        if response.status_code == 200:
            data = response.json()
            records = data.get('data', [])
            print(f"✅ {len(records)} enregistrements trouvés")
            
            if records:
                # Analyser les types d'indicateurs disponibles
                indicator_types = set()
                value_types = set()
                years = set()
                
                for record in records:
                    indicator_types.add(record.get('indicator_type_name'))
                    value_types.add(record.get('value_type'))
                    years.add(record.get('year'))
                
                print(f"\n📊 TYPES D'INDICATEURS DISPONIBLES ({len(indicator_types)}):")
                for ind_type in sorted(indicator_types):
                    print(f"  - {ind_type}")
                
                print(f"\n📈 TYPES DE VALEURS DISPONIBLES ({len(value_types)}):")
                for val_type in sorted(value_types):
                    print(f"  - {val_type}")
                
                print(f"\n📅 ANNÉES DISPONIBLES ({len(years)}):")
                print(f"  {sorted(years)}")
                
                # Montrer quelques exemples
                print(f"\n📋 EXEMPLES D'ENREGISTREMENTS:")
                for i, record in enumerate(records[:3]):
                    print(f"  {i+1}. {record.get('indicator_type_name')} - {record.get('value_type')} - {record.get('year')}: {record.get('value')}")
        else:
            print(f"❌ Erreur: {response.status_code} - {response.text}")
            
    except Exception as e:
        print(f"💥 Exception: {e}")
    
    print("\n" + "="*60 + "\n")
    
    # Test 2: Avec un indicateur qui existe vraiment
    print("🔍 TEST 2 - Test avec un indicateur qui existe:")
    
    # D'abord, récupérer la liste des indicateurs disponibles via l'API
    try:
        indicators_response = requests.get('http://localhost:8080/api/fr/indicator-types/list/', timeout=10)
        if indicators_response.status_code == 200:
            indicators_data = indicators_response.json()
            available_indicators = indicators_data.get('indicator_types', [])
            print(f"🎯 Indicateurs disponibles via API: {available_indicators}")
            
            if available_indicators:
                # Tester avec le premier indicateur disponible
                first_indicator = available_indicators[0]
                
                payload_with_real_indicator = {
                    "table": "statistique",
                    "target_column": "value",
                    "pays": "Brazil",
                    "indicator_types": [first_indicator],
                    "max_records": 100
                }
                
                print(f"\n🧪 Test avec indicateur '{first_indicator}':")
                test_response = requests.post('http://localhost:8080/api/fr/dataframe/', 
                                           json=payload_with_real_indicator, 
                                           timeout=10,
                                           headers={'Content-Type': 'application/json'})
                
                print(f"Status: {test_response.status_code}")
                if test_response.status_code == 200:
                    test_data = test_response.json()
                    print(f"✅ {len(test_data.get('data', []))} enregistrements trouvés avec cet indicateur")
                else:
                    print(f"❌ Erreur: {test_response.text}")
        else:
            print(f"❌ Impossible de récupérer les indicateurs: {indicators_response.status_code}")
            
    except Exception as e:
        print(f"💥 Exception lors du test indicateur: {e}")

if __name__ == "__main__":
    check_brazil_data()
