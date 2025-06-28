#!/usr/bin/env python3
"""
Script de lancement des tests backend avec gestion des dépendances
"""

import sys
import subprocess
import os

def install_missing_dependencies():
    """Installe les dépendances manquantes"""
    try:
        import aiohttp
        print("aiohttp déjà installé")
    except ImportError:
        print("Installation d'aiohttp...")
        subprocess.check_call([sys.executable, "-m", "pip", "install", "aiohttp"])
        print("aiohttp installé")

def run_tests():
    """Lance les tests avec pytest"""
    print("\nLancement des tests backend...")
    print("=" * 50)
    
    # Tests de base (toujours disponibles)
    print("\n1. Tests de base...")
    result1 = subprocess.run([sys.executable, "-m", "pytest", "test_basic.py", "-v"], 
                           capture_output=False)
    
    # Tests de validation des données
    print("\n2. Tests de validation des données...")
    result2 = subprocess.run([sys.executable, "-m", "pytest", "test_data_validation.py", "-v"], 
                           capture_output=False)
    
    # Tests des modèles (si disponibles)
    print("\n3. Tests des modèles...")
    result3 = subprocess.run([sys.executable, "-m", "pytest", "test_models.py", "-v"], 
                           capture_output=False)
    
    # Tests des schémas (si disponibles)
    print("\n4. Tests des schémas...")
    result4 = subprocess.run([sys.executable, "-m", "pytest", "test_schemas.py", "-v"], 
                           capture_output=False)
    
    # Tests des endpoints (si serveur disponible)
    print("\n5. Tests des endpoints (optionnels)...")
    result5 = subprocess.run([sys.executable, "-m", "pytest", "test_api_endpoints.py", "-v"], 
                           capture_output=False)
    
    print("\n" + "=" * 50)
    print("Résumé des tests:")
    
    results = [
        ("Tests de base", result1.returncode),
        ("Validation données", result2.returncode),
        ("Modèles", result3.returncode),
        ("Schémas", result4.returncode),
        ("Endpoints", result5.returncode)
    ]
    
    for test_name, returncode in results:
        status = "PASS" if returncode == 0 else "FAIL" if returncode != 0 else "SKIP"
        print(f"  {test_name}: {status}")
    
    # Retourner 0 si au moins les tests critiques passent
    critical_tests_passed = result1.returncode == 0 and result2.returncode == 0
    return 0 if critical_tests_passed else 1

def main():
    """Fonction principale"""
    print("Préparation des tests backend MSPR")
    print("=" * 50)
    
    # Vérifier que nous sommes dans le bon répertoire
    if not os.path.exists("main.py"):
        print("ERREUR: main.py non trouvé. Exécutez ce script depuis le dossier backend/")
        return 1
    
    # Installer les dépendances si nécessaire
    install_missing_dependencies()
    
    # Lancer les tests
    return run_tests()

if __name__ == "__main__":
    sys.exit(main())
