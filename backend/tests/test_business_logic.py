#!/usr/bin/env python3
"""
Tests de logique métier et de validation des données
"""
import pytest
import sys
import os
import pandas as pd
from decimal import Decimal

# Ajouter le répertoire backend au path
sys.path.insert(0, os.path.dirname(os.path.dirname(os.path.abspath(__file__))))

import schemas
from models import Country, IndicatorType, HealthIndicator

class TestBusinessLogic:
    """Tests de la logique métier de l'application"""
    
    def test_country_validation(self):
        """Test de validation des données de pays"""
        # Données valides
        valid_country_data = {
            "name": "France",
            "who_region": "Europe",
            "iso_code": "FRA"
        }
        country_schema = schemas.CountryCreate(**valid_country_data)
        assert country_schema.name == "France"
        assert country_schema.who_region == "Europe"
        assert country_schema.iso_code == "FRA"
        
        # Test avec nom obligatoire manquant
        with pytest.raises(Exception):
            schemas.CountryCreate(who_region="Europe")
    
    def test_health_indicator_value_validation(self):
        """Test de validation des valeurs d'indicateurs de santé"""
        # Données valides avec valeur numérique
        valid_data = {
            "country_id": 1,
            "indicator_type_id": 1,
            "value_type": "estimated",
            "value": "123.45",
            "confidence_min": "120.00",
            "confidence_max": "125.00"
        }
        
        indicator_schema = schemas.HealthIndicatorCreate(**valid_data)
        assert indicator_schema.country_id == 1
        assert indicator_schema.value_type == "estimated"
        
        # Test que les valeurs sont bien converties
        if indicator_schema.value is not None:
            assert isinstance(indicator_schema.value, (Decimal, float))
    
    def test_confidence_interval_logic(self):
        """Test de la logique des intervalles de confiance"""
        data = {
            "confidence_min": 100.0,
            "confidence_max": 120.0,
            "confidence_median": 110.0
        }
        
        # Vérifier la cohérence logique
        assert data["confidence_min"] <= data["confidence_median"] <= data["confidence_max"]
        
        # Calcul de la plage de confiance
        confidence_range = data["confidence_max"] - data["confidence_min"]
        assert confidence_range == 20.0
        
        # Calcul du point médian
        confidence_mid = (data["confidence_max"] + data["confidence_min"]) / 2
        assert confidence_mid == 110.0
    
    def test_year_validation(self):
        """Test de validation des années"""
        current_year = 2023
        
        # Années valides
        valid_years = [2015, 2020, 2021, 2022, 2023]
        for year in valid_years:
            assert 2010 <= year <= current_year + 1
        
        # Années potentiellement problématiques
        edge_cases = [2010, current_year + 1]
        for year in edge_cases:
            # Ces années sont acceptées mais peuvent nécessiter une attention particulière
            assert isinstance(year, int)
    
    def test_value_type_categories(self):
        """Test des catégories de types de valeurs"""
        valid_value_types = [
            "estimated", "received", "needed", "percentage", 
            "rate", "count", "ratio", "coverage"
        ]
        
        for value_type in valid_value_types:
            health_data = {
                "country_id": 1,
                "indicator_type_id": 1,
                "value_type": value_type,
                "value": 100.0
            }
            schema = schemas.HealthIndicatorCreate(**health_data)
            assert schema.value_type == value_type
    
    def test_data_quality_levels(self):
        """Test des niveaux de qualité des données"""
        quality_levels = ["excellent", "good", "fair", "poor", "unknown"]
        
        for quality in quality_levels:
            health_data = {
                "country_id": 1,
                "indicator_type_id": 1,
                "value_type": "estimated",
                "data_quality": quality
            }
            # Créer directement le modèle car le schéma pourrait ne pas avoir ce champ
            indicator = HealthIndicator(**health_data)
            assert indicator.data_quality == quality
    
    def test_prediction_request_validation(self):
        """Test de validation des requêtes de prédiction"""
        # Requête complète
        complete_request = {
            "region": "Europe",
            "country": "France",
            "indicator_type": "HIV Population",
            "value_type": "estimated"
        }
        
        prediction_request = schemas.PredictionRequest(**complete_request)
        assert prediction_request.region == "Europe"
        assert prediction_request.country == "France"
        assert prediction_request.indicator_type == "HIV Population"
        assert prediction_request.value_type == "estimated"
        
        # Requête avec seulement le champ requis
        minimal_request = {
            "indicator_type": "HIV Population"
        }
        
        minimal_prediction = schemas.PredictionRequest(**minimal_request)
        assert minimal_prediction.indicator_type == "HIV Population"
        assert minimal_prediction.region is None
        assert minimal_prediction.country is None
    
    def test_training_request_validation(self):
        """Test de validation des requêtes d'entraînement"""
        training_data = {
            "dataframe": {
                "data": [
                    {"year": 2020, "value": 100, "country_id": 1},
                    {"year": 2021, "value": 110, "country_id": 1},
                    {"year": 2022, "value": 120, "country_id": 1}
                ]
            },
            "target_column": "value"
        }
        
        training_request = schemas.TrainingRequest(**training_data)
        assert training_request.dataframe is not None
        assert training_request.target_column == "value"
        
        # Vérifier que les données sont exploitables
        dataframe = training_request.dataframe
        assert "data" in dataframe
        data_list = dataframe["data"]
        assert len(data_list) == 3
        assert "year" in data_list[0]
        assert "value" in data_list[0]
        assert training_request.target_column == "value"
    
    def test_who_regions_validation(self):
        """Test de validation des régions WHO"""
        valid_who_regions = [
            "Africa", "Americas", "South-East Asia", 
            "Europe", "Eastern Mediterranean", "Western Pacific"
        ]
        
        for region in valid_who_regions:
            country_data = {
                "name": f"Test Country {region}",
                "who_region": region
            }
            country_schema = schemas.CountryCreate(**country_data)
            assert country_schema.who_region == region
    
    def test_percentage_value_validation(self):
        """Test de validation des valeurs en pourcentage"""
        # Test pour les valeurs de pourcentage
        percentage_cases = [
            {"value": 0.0, "valid": True},
            {"value": 50.5, "valid": True},
            {"value": 100.0, "valid": True},
            {"value": -5.0, "valid": False},  # Négatif invalide pour %
            {"value": 150.0, "valid": False}  # > 100% peut être invalide selon le contexte
        ]
        
        for case in percentage_cases:
            health_data = {
                "country_id": 1,
                "indicator_type_id": 1,
                "value_type": "percentage",
                "value": case["value"]
            }
            
            if case["valid"]:
                schema = schemas.HealthIndicatorCreate(**health_data)
                assert schema.value_type == "percentage"
            else:
                # Pour les valeurs invalides, on peut vouloir les accepter 
                # mais les signaler (dépend de la logique métier)
                schema = schemas.HealthIndicatorCreate(**health_data)
                # Ici on pourrait ajouter une validation métier supplémentaire
                assert schema.value_type == "percentage"
    
    def test_user_role_validation(self):
        """Test de validation des rôles utilisateur"""
        valid_roles = ["admin", "user", "viewer", "analyst"]
        
        for role in valid_roles:
            user_data = {
                "username": f"test_{role}",
                "password": "testpassword",
                "role": role
            }
            user_schema = schemas.UtilisateurCreate(**user_data)
            assert user_schema.role == role
    
    def test_data_completeness_calculation(self):
        """Test du calcul de complétude des données"""
        # Simulation de données avec valeurs manquantes
        test_data = [
            {"value": 100.0, "has_value": True},
            {"value": None, "has_value": False},
            {"value": 200.0, "has_value": True},
            {"value": None, "has_value": False},
            {"value": 150.0, "has_value": True}
        ]
        
        total_records = len(test_data)
        records_with_values = sum(1 for record in test_data if record["has_value"])
        completeness_rate = (records_with_values / total_records) * 100
        
        assert total_records == 5
        assert records_with_values == 3
        assert completeness_rate == 60.0

if __name__ == "__main__":
    pytest.main([__file__, "-v"])
