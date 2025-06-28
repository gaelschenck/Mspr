#!/usr/bin/env python3
"""
Script de test CI/CD - Lance seulement les tests critiques
"""

import subprocess
import sys
import os

def run_critical_tests():
    """Lance seulement les tests critiques pour CI/CD"""
    print("Lancement des tests critiques pour CI/CD...")
    print("=" * 50)
    
    # Tests qui doivent toujours passer
    critical_test_files = [
        "tests/test_cicd_critical.py",
        "tests/test_basic.py", 
        "tests/test_data_validation.py"
    ]
    
    all_passed = True
    
    for test_file in critical_test_files:
        if os.path.exists(test_file):
            print(f"\nTest: {test_file}")
            result = subprocess.run([
                sys.executable, "-m", "pytest", test_file, "-v", "--tb=short"
            ], capture_output=False)
            
            if result.returncode != 0:
                print(f"ECHEC: {test_file}")
                all_passed = False
            else:
                print(f"SUCCES: {test_file}")
        else:
            print(f"IGNORE: {test_file} non trouvé")
    
    return all_passed

def main():
    """Fonction principale"""
    print("Tests Backend MSPR - Version CI/CD")
    print("=" * 50)
    
    if not os.path.exists("requirements.txt"):
        print("ERREUR: requirements.txt non trouvé")
        print("Exécutez ce script depuis le dossier backend/")
        return 1
    
    # Lancer seulement les tests critiques
    if run_critical_tests():
        print("\nSUCCES: Tous les tests critiques passent")
        print("Le build CI/CD peut continuer")
        return 0
    else:
        print("\nECHEC: Certains tests critiques ont échoué")
        print("Le build CI/CD doit échouer")
        return 1

if __name__ == "__main__":
    sys.exit(main())
