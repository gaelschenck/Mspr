#!/usr/bin/env python3
"""
Test avec les vraies valeurs du Brésil
"""
import requests
import json

def test_with_correct_values():
    """Test avec les valeurs qui existent vraiment"""
    
    print("🧪 TEST AVEC LES VRAIES VALEURS DU BRÉSIL\n")
    
    # Payload qui correspond exactement à ce qui est disponible
    payload_correct = {
        "table": "statistique",
        "target_column": "value",
        "pays": "Brazil",
        "indicator_types": ["People Living with HIV"],  # ✅ Existe
        "value_types": ["estimated_living_with_hiv"],    # ✅ Existe (pas "Estimate")
        "year_min": 2000,
        "year_max": 2023,
        "max_records": 1000,
        "include_confidence": True
    }
    
    print("🔍 Payload avec les vraies valeurs:")
    print(json.dumps(payload_correct, indent=2))
    
    try:
        response = requests.post('http://localhost:8080/api/fr/dataframe/', 
                               json=payload_correct, 
                               timeout=10,
                               headers={'Content-Type': 'application/json'})
        
        print(f"\n✅ Status: {response.status_code}")
        
        if response.status_code == 200:
            data = response.json()
            records = data.get('data', [])
            print(f"🎯 SUCCÈS ! {len(records)} enregistrements trouvés")
            
            if records:
                print(f"📋 Premier enregistrement:")
                first_record = records[0]
                for key, value in first_record.items():
                    print(f"  {key}: {value}")
                    
                print(f"\n📊 Statistiques:")
                print(f"  Shape: {data.get('shape', 'N/A')}")
                print(f"  Statistics: {data.get('statistics', 'N/A')}")
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
    test_with_correct_values()
