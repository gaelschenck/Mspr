#!/usr/bin/env python3
"""
Script de validation finale pour vérifier que tous les modèles et schémas 
sont cohérents avec la nouvelle structure après les corrections ETL
"""

import pytest
import sys
import os

# Ajouter le répertoire du backend au path pour les imports
sys.path.insert(0, os.path.dirname(os.path.dirname(os.path.abspath(__file__))))

def test_models_import():
    """Test que tous les modèles peuvent être importés"""
    try:
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
        print("Tous les modèles importés avec succès")
        return True
    except ImportError as e:
        print(f"Erreur d'import des modèles: {e}")
        return False

def test_schemas_import():
    """Test que tous les schémas peuvent être importés"""
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
        print("Tous les schémas importés avec succès")
        return True
    except ImportError as e:
        print(f"Erreur d'import des schémas: {e}")
        return False

def test_model_structure_consistency():
    """Test que la structure des modèles est cohérente"""
    try:
        from models import TransmissionMereEnfant, Pays, Unite
        
        # Test TransmissionMereEnfant - clé primaire doit être id_transmission
        transmission = TransmissionMereEnfant()
        assert hasattr(transmission, 'id_transmission'), "TransmissionMereEnfant devrait avoir id_transmission"
        
        # Test Pays - devrait avoir pays au lieu de nom_pays
        pays = Pays()
        assert hasattr(pays, 'pays'), "Pays devrait avoir 'pays'"
        assert hasattr(pays, 'region_who'), "Pays devrait avoir 'region_who'"
        
        # Test Unite - devrait avoir unite au lieu de nom_unite
        unite = Unite()
        assert hasattr(unite, 'unite'), "Unite devrait avoir 'unite'"
        
        print("Structure des modèles cohérente")
        return True
    except Exception as e:
        print(f"Erreur de structure des modèles: {e}")
        return False

def test_schema_structure_consistency():
    """Test que la structure des schémas est cohérente avec les modèles"""
    try:
        from schemas import TransmissionMereEnfant as TransmissionSchema
        from schemas import Pays as PaysSchema
        from schemas import Unite as UniteSchema
        
        # Test création d'instances de schémas avec la nouvelle structure
        transmission_data = {
            "id_transmission": 1,
            "id_pays": 1,
            "besoin_arv_min": 100.0,
            "besoin_arv_median": 150.0,
            "besoin_arv_max": 200.0,
            "pourcentage_recu_min": 50.0,
            "pourcentage_recu_median": 75.0,
            "pourcentage_recu_max": 90.0
        }
        
        pays_data = {
            "id_pays": 1,
            "pays": "France",
            "region_who": "European Region"
        }
        
        unite_data = {
            "id_unite": 1,
            "unite": "Number"
        }
        
        # Créer les instances
        transmission = TransmissionSchema(**transmission_data)
        pays = PaysSchema(**pays_data)
        unite = UniteSchema(**unite_data)
        
        # Vérifier les valeurs
        assert transmission.id_transmission == 1
        assert pays.pays == "France"
        assert unite.unite == "Number"
        
        print("Structure des schémas cohérente avec les modèles")
        return True
    except Exception as e:
        print(f"Erreur de structure des schémas: {e}")
        return False

def test_database_consistency():
    """Test rapide de cohérence avec la base de données"""
    try:
        import sqlite3
        db_path = os.path.join(os.path.dirname(os.path.dirname(__file__)), "db-fr.db")
        
        if not os.path.exists(db_path):
            print(f"Base de données non trouvée: {db_path}")
            return False
        
        conn = sqlite3.connect(db_path)
        cursor = conn.cursor()
        
        # Vérifier que les tables ont la bonne structure
        cursor.execute("PRAGMA table_info(pays)")
        pays_columns = [col[1] for col in cursor.fetchall()]
        assert 'pays' in pays_columns, "Table pays devrait avoir colonne 'pays'"
        assert 'region_who' in pays_columns, "Table pays devrait avoir colonne 'region_who'"
        
        cursor.execute("PRAGMA table_info(unite)")
        unite_columns = [col[1] for col in cursor.fetchall()]
        assert 'unite' in unite_columns, "Table unite devrait avoir colonne 'unite'"
        
        cursor.execute("PRAGMA table_info(transmission_mere_enfant)")
        transmission_columns = [col[1] for col in cursor.fetchall()]
        assert 'id_transmission' in transmission_columns, "Table transmission_mere_enfant devrait avoir colonne 'id_transmission'"
        
        conn.close()
        print("Structure de la base de données cohérente")
        return True
    except Exception as e:
        print(f"Erreur de vérification base de données: {e}")
        return False

def run_all_validations():
    """Lance toutes les validations"""
    print("=== VALIDATION FINALE DES CORRECTIONS ===")
    
    results = []
    results.append(("Import modèles", test_models_import()))
    results.append(("Import schémas", test_schemas_import()))
    results.append(("Structure modèles", test_model_structure_consistency()))
    results.append(("Structure schémas", test_schema_structure_consistency()))
    results.append(("Cohérence BDD", test_database_consistency()))
    
    print("\n=== RÉSULTATS ===")
    for test_name, result in results:
        status = "OK" if result else "ERREUR"
        print(f"{test_name}: {status}")
    
    all_passed = all(result for _, result in results)
    print(f"\nRésultat global: {'TOUS LES TESTS PASSENT' if all_passed else 'CERTAINS TESTS ÉCHOUENT'}")
    
    return all_passed

if __name__ == "__main__":
    run_all_validations()
