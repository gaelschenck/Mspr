#!/usr/bin/env python3
"""
Script de validation rapide pour vérifier que tous les tests backend passent
"""

import subprocess
import sys
import os

def run_tests():
    """Exécute tous les tests backend et affiche un résumé"""
    
    print("🧪 Exécution des tests backend après correction des modèles...")
    print("=" * 60)
    
    # Tests à exécuter
    test_modules = [
        ("Tests des modèles", "tests/test_models.py"),
        ("Tests des schémas", "tests/test_schemas.py"),
        ("Tests basiques", "tests/test_basic.py"),
        ("Tests critiques CICD", "tests/test_cicd_critical.py")
    ]
    
    results = []
    
    for test_name, test_module in test_modules:
        print(f"\n📋 {test_name}...")
        try:
            result = subprocess.run([
                sys.executable, "-m", "pytest", test_module, "-v", "--tb=short"
            ], capture_output=True, text=True, timeout=30)
            
            if result.returncode == 0:
                print(f"✅ {test_name}: SUCCÈS")
                results.append((test_name, "SUCCÈS", ""))
            else:
                print(f"❌ {test_name}: ÉCHEC")
                print(f"   Erreur: {result.stderr}")
                results.append((test_name, "ÉCHEC", result.stderr))
                
        except subprocess.TimeoutExpired:
            print(f"⏰ {test_name}: TIMEOUT")
            results.append((test_name, "TIMEOUT", "Test trop long"))
        except Exception as e:
            print(f"💥 {test_name}: ERREUR - {e}")
            results.append((test_name, "ERREUR", str(e)))
    
    # Résumé final
    print("\n" + "=" * 60)
    print("📊 RÉSUMÉ DES TESTS:")
    print("=" * 60)
    
    success_count = 0
    for test_name, status, error in results:
        if status == "SUCCÈS":
            print(f"✅ {test_name}")
            success_count += 1
        else:
            print(f"❌ {test_name} - {status}")
            if error:
                print(f"   → {error[:100]}{'...' if len(error) > 100 else ''}")
    
    print(f"\n🎯 Résultat: {success_count}/{len(results)} tests réussis")
    
    if success_count == len(results):
        print("🎉 Tous les tests passent ! L'API est prête pour le déploiement.")
        return True
    else:
        print("⚠️  Certains tests échouent. Vérification nécessaire.")
        return False

if __name__ == "__main__":
    success = run_tests()
    sys.exit(0 if success else 1)
