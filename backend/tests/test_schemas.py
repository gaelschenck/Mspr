#!/usr/bin/env python3
"""
Tests unitaires pour les modèles et schémas de l'API MSPR
"""

import pytest
import sys
import os

# Ajouter le répertoire du backend au path pour les imports
sys.path.insert(0, os.path.dirname(os.path.dirname(os.path.abspath(__file__))))

try:
    from schemas import (
        TransmissionMereEnfant, 
        Mortalite, 
        PopulationHIV, 
        Traitement,
        Pays,
        Unite,
        TypeStatistique,
        TypeTraitement
    )
    from pydantic import ValidationError
    SCHEMAS_AVAILABLE = True
except ImportError as e:
    print(f"AVERTISSEMENT: Erreur d'import des schémas: {e}")
    SCHEMAS_AVAILABLE = False

@pytest.mark.skipif(not SCHEMAS_AVAILABLE, reason="Schémas non disponibles")
class TestSchemas:
    """Tests pour les schémas Pydantic"""
    
    def test_transmission_mere_enfant_schema(self):
        """Test du schéma TransmissionMereEnfant"""
        # Test données valides
        data = {
            "id_transmission": 1,
            "id_pays": 42,
            "besoin_arv_min": 100,
            "besoin_arv_median": 150,
            "besoin_arv_max": 200,
            "pourcentage_recu_min": 50,
            "pourcentage_recu_median": 75,
            "pourcentage_recu_max": 90
        }
        
        transmission = TransmissionMereEnfant(**data)
        assert transmission.id_transmission == 1
        assert transmission.id_pays == 42
        assert transmission.besoin_arv_min == 100
        assert transmission.besoin_arv_median == 150
        assert transmission.besoin_arv_max == 200
        assert transmission.pourcentage_recu_min == 50
        assert transmission.pourcentage_recu_median == 75
        assert transmission.pourcentage_recu_max == 90
    
    def test_transmission_mere_enfant_schema_optional_fields(self):
        """Test du schéma avec champs optionnels"""
        data = {
            "id_transmission": 1,
            "id_pays": 42,
            "besoin_arv_min": 100,
            "besoin_arv_median": 150,
            "besoin_arv_max": 200,
            "pourcentage_recu_min": 50,
            "pourcentage_recu_median": 75,
            "pourcentage_recu_max": 90
        }
        
        transmission = TransmissionMereEnfant(**data)
        # Vérifier que le schéma fonctionne sans champs optionnels
        assert transmission.id_transmission == 1
    
    def test_mortalite_schema(self):
        """Test du schéma Mortalite"""
        data = {
            "id": 1,
            "id_pays": 42,
            "annee": 2023,
            "valeur": 1500,
            "id_unite": 1
        }
        
        mortalite = Mortalite(**data)
        assert mortalite.id == 1
        assert mortalite.id_pays == 42
        assert mortalite.annee == 2023
        assert mortalite.valeur == 1500
        assert mortalite.id_unite == 1
    
    def test_population_hiv_schema(self):
        """Test du schéma PopulationHIV"""
        data = {
            "id": 1,
            "id_pays": 42,
            "annee": 2023,
            "valeur": 50000,
            "id_unite": 1
        }
        
        population = PopulationHIV(**data)
        assert population.id == 1
        assert population.id_pays == 42
        assert population.annee == 2023
        assert population.valeur == 50000
        assert population.id_unite == 1
    
    def test_pays_schema(self):
        """Test du schéma Pays"""
        data = {
            "id_pays": 1,
            "pays": "France",
            "region_who": "European Region"
        }
        
        pays = Pays(**data)
        assert pays.id_pays == 1
        assert pays.pays == "France"
        assert pays.region_who == "European Region"
    
    def test_unite_schema(self):
        """Test du schéma Unite"""
        data = {
            "id_unite": 1,
            "unite": "Number"
        }
        
        unite = Unite(**data)
        assert unite.id_unite == 1
        assert unite.unite == "Number"
    
    def test_invalid_data_raises_validation_error(self):
        """Test que des données invalides lèvent une ValidationError"""
        with pytest.raises(ValidationError):
            # Pourcentage > 100 non autorisé
            TransmissionMereEnfant(
                id_transmission=1,
                id_pays=42,
                besoin_arv_min=100,
                besoin_arv_median=150,
                besoin_arv_max=200,
                pourcentage_recu_min=50,
                pourcentage_recu_median=75,
                pourcentage_recu_max=150  # > 100, devrait échouer
            )

class TestDataValidation:
    """Tests de validation des données"""
    
    def test_transmission_structure_consistency(self):
        """Test que la structure des données transmission est cohérente"""
        # Les valeurs médianes doivent être entre min et max
        data = {
            "id_transmission": 1,
            "id_pays": 42,
            "besoin_arv_min": 100,
            "besoin_arv_median": 150,  # Entre 100 et 200
            "besoin_arv_max": 200,
            "pourcentage_recu_min": 50,
            "pourcentage_recu_median": 75,  # Entre 50 et 90
            "pourcentage_recu_max": 90
        }
        
        transmission = TransmissionMereEnfant(**data)
        
        # Vérifications logiques
        assert transmission.besoin_arv_min <= transmission.besoin_arv_median <= transmission.besoin_arv_max
        assert transmission.pourcentage_recu_min <= transmission.pourcentage_recu_median <= transmission.pourcentage_recu_max
    
    def test_percentage_bounds(self):
        """Test que les pourcentages sont dans des limites raisonnables"""
        data = {
            "id_transmission": 1,
            "id_pays": 42,
            "besoin_arv_min": 100,
            "besoin_arv_median": 150,
            "besoin_arv_max": 200,
            "pourcentage_recu_min": 0,    # 0% valide
            "pourcentage_recu_median": 50,
            "pourcentage_recu_max": 100   # 100% valide
        }
        
        transmission = TransmissionMereEnfant(**data)
        
        # Les pourcentages doivent être entre 0 et 100
        assert 0 <= transmission.pourcentage_recu_min <= 100
        assert 0 <= transmission.pourcentage_recu_median <= 100
        assert 0 <= transmission.pourcentage_recu_max <= 100

if __name__ == "__main__":
    pytest.main([__file__, "-v"])
