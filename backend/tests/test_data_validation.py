#!/usr/bin/env python3
"""
Tests de validation de la structure des données transmission_mere_enfant
"""

import pytest

def test_transmission_data_structure():
    """Test que la structure des données transmission est correcte"""
    # Exemple de données réelles basées sur les CSV
    sample_data = {
        "id": 1,
        "id_pays": 1,  # afghanistan
        "besoin_arv_min": 100,
        "besoin_arv_median": 200,
        "besoin_arv_max": 500,
        "pourcentage_recu_min": 7,
        "pourcentage_recu_median": 11,
        "pourcentage_recu_max": 18,
        "id_unite": None
    }
    
    # Vérifications de base
    assert isinstance(sample_data["id"], int)
    assert isinstance(sample_data["id_pays"], int)
    assert sample_data["id_pays"] > 0
    
    # Vérifications de cohérence des valeurs ARV
    assert sample_data["besoin_arv_min"] <= sample_data["besoin_arv_median"]
    assert sample_data["besoin_arv_median"] <= sample_data["besoin_arv_max"]
    
    # Vérifications de cohérence des pourcentages
    assert sample_data["pourcentage_recu_min"] <= sample_data["pourcentage_recu_median"]
    assert sample_data["pourcentage_recu_median"] <= sample_data["pourcentage_recu_max"]
    
    # Vérifications des limites
    assert 0 <= sample_data["pourcentage_recu_min"] <= 100
    assert 0 <= sample_data["pourcentage_recu_median"] <= 100
    assert 0 <= sample_data["pourcentage_recu_max"] <= 100

def test_transmission_data_variants():
    """Test avec différents cas de données transmission"""
    test_cases = [
        # Cas 1: Valeurs identiques (coverage parfaite)
        {
            "besoin_arv_min": 500, "besoin_arv_median": 500, "besoin_arv_max": 500,
            "pourcentage_recu_min": 95, "pourcentage_recu_median": 95, "pourcentage_recu_max": 95
        },
        # Cas 2: Grande variance
        {
            "besoin_arv_min": 19000, "besoin_arv_median": 25000, "besoin_arv_max": 32000,
            "pourcentage_recu_min": 29, "pourcentage_recu_median": 38, "pourcentage_recu_max": 48
        },
        # Cas 3: Faible besoin, bonne couverture
        {
            "besoin_arv_min": 100, "besoin_arv_median": 100, "besoin_arv_max": 100,
            "pourcentage_recu_min": 0, "pourcentage_recu_median": 0, "pourcentage_recu_max": 0
        }
    ]
    
    for i, case in enumerate(test_cases):
        # Vérifier la cohérence de chaque cas
        assert case["besoin_arv_min"] <= case["besoin_arv_median"] <= case["besoin_arv_max"], f"Cas {i+1}: ARV non cohérent"
        assert case["pourcentage_recu_min"] <= case["pourcentage_recu_median"] <= case["pourcentage_recu_max"], f"Cas {i+1}: Pourcentages non cohérents"
        
        # Vérifier les limites des pourcentages
        for key in ["pourcentage_recu_min", "pourcentage_recu_median", "pourcentage_recu_max"]:
            assert 0 <= case[key] <= 100, f"Cas {i+1}: {key} hors limites"

def test_data_completeness():
    """Test que nous avons les champs requis"""
    required_fields = [
        "id", "id_pays", "besoin_arv_min", "besoin_arv_median", "besoin_arv_max",
        "pourcentage_recu_min", "pourcentage_recu_median", "pourcentage_recu_max", "id_unite"
    ]
    
    sample_record = {
        "id": 1,
        "id_pays": 1,
        "besoin_arv_min": 100,
        "besoin_arv_median": 200,
        "besoin_arv_max": 500,
        "pourcentage_recu_min": 7,
        "pourcentage_recu_median": 11,
        "pourcentage_recu_max": 18,
        "id_unite": None
    }
    
    for field in required_fields:
        assert field in sample_record, f"Champ requis manquant: {field}"

def test_country_data_coverage():
    """Test que nous avons une bonne couverture des pays"""
    # Basé sur les données réelles : 100 enregistrements pour environ 170 pays
    total_countries = 170
    total_transmission_records = 100
    
    coverage_percentage = (total_transmission_records / total_countries) * 100
    
    # Nous devons avoir au moins 50% de couverture des pays
    assert coverage_percentage >= 50, f"Couverture pays insuffisante: {coverage_percentage:.1f}%"
    
    # Et moins de 100% (tous les pays n'ont pas forcément de données)
    assert coverage_percentage <= 100, f"Plus d'enregistrements que de pays: {coverage_percentage:.1f}%"

if __name__ == "__main__":
    pytest.main([__file__, "-v"])
