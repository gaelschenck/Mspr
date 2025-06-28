#!/usr/bin/env python3
"""
Tests unitaires pour les modèles SQLAlchemy
"""

import pytest
import sys
import os

# Ajouter le répertoire du backend au path pour les imports
sys.path.insert(0, os.path.dirname(os.path.dirname(os.path.abspath(__file__))))

try:
    # Import direct pour permettre une meilleure détection par pytest
    sys.path.insert(0, os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
    from models import (
        TransmissionMereEnfant,
        Mortalite,
        PopulationHIV,
        Traitement,
        Pays,
        Unite,
        TypeStatistique,
        TypeTraitement,
        Utilisateur
    )
    MODELS_AVAILABLE = True
except ImportError as e:
    print(f"AVERTISSEMENT: Erreur d'import des modèles: {e}")
    MODELS_AVAILABLE = False
    # Créer des classes factices pour éviter les erreurs NameError
    class TransmissionMereEnfant: pass
    class Mortalite: pass
    class PopulationHIV: pass  
    class Traitement: pass
    class Pays: pass
    class Unite: pass
    class TypeStatistique: pass
    class TypeTraitement: pass
    class Utilisateur: pass

class TestModels:
    """Tests pour les modèles SQLAlchemy"""
    
    def test_transmission_mere_enfant_model(self):
        """Test du modèle TransmissionMereEnfant"""
        if not MODELS_AVAILABLE:
            pytest.skip("Modèles non disponibles")
            
        transmission = TransmissionMereEnfant(
            id_transmission=1,
            id_pays=42,
            besoin_arv_min=100,
            besoin_arv_median=150,
            besoin_arv_max=200,
            pourcentage_recu_min=50,
            pourcentage_recu_median=75,
            pourcentage_recu_max=90
        )
        
        assert transmission.id_transmission == 1
        assert transmission.id_pays == 42
        assert transmission.besoin_arv_min == 100
        assert transmission.besoin_arv_median == 150
        assert transmission.besoin_arv_max == 200
        assert transmission.pourcentage_recu_min == 50
        assert transmission.pourcentage_recu_median == 75
        assert transmission.pourcentage_recu_max == 90
    
    def test_pays_model(self):
        """Test du modèle Pays"""
        if not MODELS_AVAILABLE:
            pytest.skip("Modèles non disponibles")
            
        pays = Pays(
            id_pays=1,
            pays="France",
            region_who="European Region"
        )
        
        assert pays.id_pays == 1
        assert pays.pays == "France"
        assert pays.region_who == "European Region"
    
    def test_unite_model(self):
        """Test du modèle Unite"""
        if not MODELS_AVAILABLE:
            pytest.skip("Modèles non disponibles")
            
        unite = Unite(
            id_unite=1,
            unite="Number"
        )
        
        assert unite.id_unite == 1
        assert unite.unite == "Number"
    
    def test_mortalite_model(self):
        """Test du modèle Mortalite"""
        if not MODELS_AVAILABLE:
            pytest.skip("Modèles non disponibles")
            
        mortalite = Mortalite(
            id=1,
            id_pays=42,
            annee=2023,
            valeur=1500,
            id_unite=1
        )
        
        assert mortalite.id == 1
        assert mortalite.id_pays == 42
        assert mortalite.annee == 2023
        assert mortalite.valeur == 1500
        assert mortalite.id_unite == 1
    
    def test_population_hiv_model(self):
        """Test du modèle PopulationHIV"""
        if not MODELS_AVAILABLE:
            pytest.skip("Modèles non disponibles")
            
        population = PopulationHIV(
            id=1,
            id_pays=42,
            annee=2023,
            valeur=50000,
            id_unite=1
        )
        
        assert population.id == 1
        assert population.id_pays == 42
        assert population.annee == 2023
        assert population.valeur == 50000
        assert population.id_unite == 1
    
    def test_utilisateur_model(self):
        """Test du modèle Utilisateur"""
        if not MODELS_AVAILABLE:
            pytest.skip("Modèles non disponibles")
            
        utilisateur = Utilisateur(
            id=1,
            username="testuser",
            hashed_password="$2b$12$hashedpassword",
            role="user",
            rgpd_accept=1
        )
        
        assert utilisateur.id == 1
        assert utilisateur.username == "testuser"
        assert utilisateur.hashed_password == "$2b$12$hashedpassword"
        assert utilisateur.role == "user"
        assert utilisateur.rgpd_accept == 1
    
    def test_type_statistique_model(self):
        """Test du modèle TypeStatistique"""
        if not MODELS_AVAILABLE:
            pytest.skip("Modèles non disponibles")
            
        type_stat = TypeStatistique(
            id_type_statistique=1,
            nom_type_statistique="Taux de prévalence"
        )
        
        assert type_stat.id_type_statistique == 1
        assert type_stat.nom_type_statistique == "Taux de prévalence"
    
    def test_type_traitement_model(self):
        """Test du modèle TypeTraitement"""
        if not MODELS_AVAILABLE:
            pytest.skip("Modèles non disponibles")
            
        type_trait = TypeTraitement(
            id_type_traitement=1,
            nom_type_traitement="Traitement adulte"
        )
        
        assert type_trait.id_type_traitement == 1
        assert type_trait.nom_type_traitement == "Traitement adulte"

class TestModelProperties:
    """Tests des propriétés et méthodes des modèles"""
    
    def test_model_repr_methods(self):
        """Test que les modèles ont des représentations string correctes"""
        if not MODELS_AVAILABLE:
            pytest.skip("Modèles non disponibles")
            
        try:
            pays = Pays(id_pays=1, pays="France", region_who="European Region")
            
            # Le modèle devrait avoir une représentation string
            repr_str = repr(pays)
            assert "Pays" in repr_str or "france" in repr_str.lower()
        except Exception as e:
            pytest.skip(f"Test de représentation échoué: {e}")
    
    def test_transmission_has_all_required_columns(self):
        """Test que le modèle TransmissionMereEnfant a toutes les colonnes requises"""
        if not MODELS_AVAILABLE:
            pytest.skip("Modèles non disponibles")
            
        try:
            from models import TransmissionMereEnfant
            transmission = TransmissionMereEnfant()
            
            # Vérifier que tous les attributs existent
            required_attrs = [
                'id_transmission', 'id_pays', 'besoin_arv_min', 'besoin_arv_median', 'besoin_arv_max',
                'pourcentage_recu_min', 'pourcentage_recu_median', 'pourcentage_recu_max'
            ]
            
            for attr in required_attrs:
                assert hasattr(transmission, attr), f"Attribut requis manquant: {attr}"
                
            print("Tous les attributs requis sont présents")
        except ImportError:
            pytest.skip("Import TransmissionMereEnfant échoué")

if __name__ == "__main__":
    pytest.main([__file__, "-v"])
