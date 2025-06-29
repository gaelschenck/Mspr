#!/usr/bin/env python3
"""
Tests des schémas Pydantic
"""
import pytest
from pydantic import ValidationError
import sys
import os

# Ajouter le répertoire backend au path
sys.path.insert(0, os.path.dirname(os.path.dirname(os.path.abspath(__file__))))

from schemas import (
    PredictionRequest, TrainingRequest, PredictionResponse,
    CountryBase, CountryCreate, Country,
    HealthIndicatorBase, HealthIndicatorCreate, HealthIndicator,
    UtilisateurCreate, UtilisateurOut
)

class TestSchemas:
    """Tests des schémas de validation"""
    
    def test_prediction_request_valid(self):
        """Test de validation d'une requête de prédiction valide"""
        request = PredictionRequest(
            region="Europe",
            indicator_type="HIV Population"
        )
        
        assert request.region == "Europe"
        assert request.indicator_type == "HIV Population"
        assert request.country is None
        assert request.value_type is None
    
    def test_prediction_request_with_optional_fields(self):
        """Test avec tous les champs optionnels"""
        request = PredictionRequest(
            region="Europe",
            country="France",
            indicator_type="HIV Population",
            value_type="estimated"
        )
        
        assert request.region == "Europe"
        assert request.country == "France"
        assert request.indicator_type == "HIV Population"
        assert request.value_type == "estimated"
    
    def test_prediction_request_missing_required_fields(self):
        """Test d'erreur avec champs obligatoires manquants"""
        with pytest.raises(ValidationError) as exc_info:
            PredictionRequest()  # indicator_type manquant
        
        errors = exc_info.value.errors()
        assert len(errors) >= 1  # Seul indicator_type est obligatoire
        
        # Vérifier que indicator_type manquant est détecté
        missing_fields = [error['loc'][0] for error in errors]
        assert 'indicator_type' in missing_fields
    
    def test_training_request_valid(self):
        """Test de validation d'une requête d'entraînement valide"""
        dataframe = {
            "data": [
                {
                    "country_id": 1,
                    "year": 2020,
                    "value": 100000,
                    "indicator_type_id": 1
                },
                {
                    "country_id": 1,
                    "year": 2021,
                    "value": 105000,
                    "indicator_type_id": 1
                }
            ]
        }
        
        request = TrainingRequest(
            dataframe=dataframe,
            target_column="value"
        )
        
        assert request.dataframe == dataframe
        assert request.target_column == "value"
    
    def test_training_request_empty_dataframe(self):
        """Test avec dataframe vide - doit passer car dict vide est valide"""
        # Le schéma TrainingRequest accepte n'importe quel dict, même vide
        request = TrainingRequest(
            dataframe={},  # Dict vide est valide selon le schéma
            target_column="value"
        )
        
        assert request.dataframe == {}
        assert request.target_column == "value"
    
    def test_training_request_missing_target_column(self):
        """Test d'erreur avec target_column manquant"""
        dataframe = {"data": [{"country_id": 1, "year": 2020, "value": 100000}]}
        
        with pytest.raises(ValidationError) as exc_info:
            TrainingRequest(dataframe=dataframe)
        
        errors = exc_info.value.errors()
        missing_fields = [error['loc'][0] for error in errors]
        assert 'target_column' in missing_fields
    
    def test_health_indicator_validation(self):
        """Test de validation d'un indicateur de santé"""
        health_indicator = HealthIndicatorCreate(
            country_id=1,
            indicator_type_id=1,
            year=2023,
            value_type="estimated",
            value=180000,
            confidence_min=170000,
            confidence_max=190000,
            data_quality="good"
        )
        
        assert health_indicator.country_id == 1
        assert health_indicator.indicator_type_id == 1
        assert health_indicator.year == 2023
        assert health_indicator.value == 180000
    
    def test_utilisateur_create_validation(self):
        """Test de validation d'une création d'utilisateur"""
        user_request = UtilisateurCreate(
            username="testuser",
            password="testpassword",
            role="user"
        )
        
        assert user_request.username == "testuser"
        assert user_request.password == "testpassword"
        assert user_request.role == "user"
    
    def test_utilisateur_create_missing_fields(self):
        """Test d'erreur avec champs d'utilisateur manquants"""
        with pytest.raises(ValidationError) as exc_info:
            UtilisateurCreate(username="testuser")  # password et role manquants
        
        errors = exc_info.value.errors()
        missing_fields = [error['loc'][0] for error in errors]
        assert 'password' in missing_fields
    
    def test_schema_field_types(self):
        """Test des types de champs"""
        # Tester que les types incorrects sont rejetés
        with pytest.raises(ValidationError):
            PredictionRequest(
                region=123,  # Devrait être string
                indicator_type="HIV Population"
            )
        
        with pytest.raises(ValidationError):
            HealthIndicatorCreate(
                country_id="not_an_int",  # Devrait être int
                indicator_type_id=1,
                year=2023,
                value_type="estimated"
            )

if __name__ == "__main__":
    pytest.main([__file__, "-v"])
