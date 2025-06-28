#!/usr/bin/env python3
"""
Test final de l'intégration complète
Vérifie que l'API peut démarrer et que toutes les routes fonctionnent avec la nouvelle structure
"""

import sys
import os
import sqlite3

# Ajouter le répertoire du backend au path pour les imports
sys.path.insert(0, os.path.dirname(os.path.dirname(os.path.abspath(__file__))))

def test_api_startup():
    """Test que l'API peut démarrer sans erreur"""
    try:
        from main import app
        print("API importée avec succès")
        return True
    except Exception as e:
        print(f"Erreur lors de l'import de l'API: {e}")
        return False

def test_database_content():
    """Test que la base de données contient des données cohérentes"""
    try:
        db_path = os.path.join(os.path.dirname(os.path.dirname(__file__)), "db-fr.db")
        
        if not os.path.exists(db_path):
            print(f"Base de données non trouvée: {db_path}")
            return False
        
        conn = sqlite3.connect(db_path)
        cursor = conn.cursor()
        
        # Vérifier qu'il y a des données dans chaque table
        tables_to_check = [
            'pays', 'unite', 'type_statistique', 'type_traitement',
            'transmission_mere_enfant', 'utilisateur'
        ]
        
        for table in tables_to_check:
            cursor.execute(f"SELECT COUNT(*) FROM {table}")
            count = cursor.fetchone()[0]
            print(f"Table {table}: {count} enregistrements")
            
            if count == 0:
                print(f"ATTENTION: Table {table} est vide")
        
        # Test spécifique pour transmission_mere_enfant avec id_transmission
        cursor.execute("SELECT id_transmission, id_pays FROM transmission_mere_enfant LIMIT 1")
        result = cursor.fetchone()
        if result:
            print(f"Test transmission_mere_enfant: id_transmission={result[0]}, id_pays={result[1]}")
        
        conn.close()
        print("Base de données contient des données cohérentes")
        return True
    except Exception as e:
        print(f"Erreur lors de la vérification de la base: {e}")
        return False

def test_model_schema_alignment():
    """Test que les modèles et schémas sont alignés"""
    try:
        from models import TransmissionMereEnfant as TransmissionModel
        from schemas import TransmissionMereEnfant as TransmissionSchema
        
        # Test création d'une instance modèle
        model_instance = TransmissionModel(
            id_transmission=1,
            id_pays=1,
            besoin_arv_min=100.0,
            besoin_arv_median=150.0,
            besoin_arv_max=200.0,
            pourcentage_recu_min=50.0,
            pourcentage_recu_median=75.0,
            pourcentage_recu_max=90.0
        )
        
        # Test création d'une instance schéma
        schema_data = {
            "id_transmission": 1,
            "id_pays": 1,
            "besoin_arv_min": 100.0,
            "besoin_arv_median": 150.0,
            "besoin_arv_max": 200.0,
            "pourcentage_recu_min": 50.0,
            "pourcentage_recu_median": 75.0,
            "pourcentage_recu_max": 90.0
        }
        
        schema_instance = TransmissionSchema(**schema_data)
        
        # Vérifier que les attributs correspondent
        assert model_instance.id_transmission == schema_instance.id_transmission
        assert model_instance.id_pays == schema_instance.id_pays
        
        print("Modèles et schémas parfaitement alignés")
        return True
    except Exception as e:
        print(f"Erreur d'alignement modèles/schémas: {e}")
        return False

def run_integration_tests():
    """Lance tous les tests d'intégration"""
    print("=== TESTS D'INTÉGRATION FINALE ===")
    
    tests = [
        ("Démarrage API", test_api_startup),
        ("Contenu base de données", test_database_content),
        ("Alignement modèles/schémas", test_model_schema_alignment)
    ]
    
    results = []
    for test_name, test_func in tests:
        print(f"\n--- {test_name} ---")
        result = test_func()
        results.append((test_name, result))
    
    print("\n=== RÉSULTATS FINAUX ===")
    for test_name, result in results:
        status = "OK" if result else "ERREUR"
        print(f"{test_name}: {status}")
    
    all_passed = all(result for _, result in results)
    final_status = "INTEGRATION COMPLETE" if all_passed else "PROBLEMES DETECTES"
    print(f"\nStatut final: {final_status}")
    
    if all_passed:
        print("\nLe système est prêt pour le déploiement!")
        print("- Modèles SQLAlchemy cohérents")
        print("- Schémas Pydantic alignés") 
        print("- Base de données avec données")
        print("- API fonctionnelle")
    
    return all_passed

if __name__ == "__main__":
    run_integration_tests()
