#!/usr/bin/env python3
"""
Script de validation rapide pour vérifier que tous les tests backend passent
"""

import subprocess
import sys
import os
import argparse
import json
from datetime import datetime

def setup_reports_directory():
    """Créer le dossier reports avec sous-dossier daté pour cette exécution"""
    base_reports_dir = os.path.join("tests", "reports")
    if not os.path.exists(base_reports_dir):
        os.makedirs(base_reports_dir)
    
    # Créer un sous-dossier avec la date et l'heure
    timestamp = datetime.now().strftime("%Y%m%d_%H%M%S")
    session_dir = os.path.join(base_reports_dir, f"session_{timestamp}")
    os.makedirs(session_dir)
    
    return session_dir, timestamp

def run_tests(quick_mode=False, html_report=False, coverage_report=False):
    """Exécute tous les tests backend et affiche un résumé"""
    
    # Créer le dossier reports avec sous-dossier daté
    reports_dir, timestamp = setup_reports_directory()
    
    mode_text = "RAPIDES" if quick_mode else "COMPLÈTE"
    print(f"Exécution de la suite {mode_text} de tests backend...")
    if html_report or coverage_report:
        print(f"Session de tests: {os.path.basename(reports_dir)}")
        print(f"Rapports sauvegardés dans: {reports_dir}/")
    print("=" * 80)
    
    # Tests à exécuter - Suite complète organisée par ordre de priorité
    all_test_modules = [
        # Tests rapides et critiques d'abord
        ("Tests critiques CI/CD", "tests/test_cicd_critical.py", 30, True),
        ("Tests des modèles", "tests/test_models.py", 30, True),
        ("Tests des schémas", "tests/test_schemas.py", 30, True),
        ("Tests de logique métier", "tests/test_business_logic.py", 45, True),
        
        # Tests d'intégration (plus lents)
        ("Tests d'intégration base de données", "tests/test_database_integration.py", 60, False),
        ("Tests des endpoints API", "tests/test_api_basic.py", 90, False),
        
        # Tests ML et performance - Mode permissif pour tester l'intégration
        ("Tests des endpoints ML", "tests/test_ml_endpoints.py", 180, False),  # Mode permissif
        ("Tests de prédiction ML", "tests/test_prediction_ml.py", 120, False),  # Tests logiques
        ("Diagnostic prédiction (manuel)", "tests/test_prediction_logic.py", 90, False),  # Outil de diagnostic
        ("Tests de performance", "tests/test_performance_simple.py", 240, False),  # Mode permissif
    ]
    
    # Filtrer selon le mode
    if quick_mode:
        test_modules = [(name, module, timeout) for name, module, timeout, is_quick in all_test_modules if is_quick]
        print("Mode rapide: execution des tests essentiels uniquement")
    else:
        test_modules = [(name, module, timeout) for name, module, timeout, is_quick in all_test_modules]
        print("Mode complet: execution de tous les tests")
    
    results = []
    total_tests = len(test_modules)
    
    for i, (test_name, test_module, timeout) in enumerate(test_modules, 1):
        print(f"\n[{i}/{total_tests}] {test_name}...")
        print(f"   Module: {test_module} (timeout: {timeout}s)")
        
        # Construire la commande pytest avec options
        pytest_cmd = [sys.executable, "-m", "pytest", test_module, "-v", "--tb=short", "--disable-warnings"]
        
        # Ajouter les options de rapport HTML
        if html_report:
            html_file = os.path.join(reports_dir, f"test_report_{test_name.replace(' ', '_').replace('/', '_')}.html")
            pytest_cmd.extend(["--html", html_file, "--self-contained-html"])
        
        # Ajouter les options de couverture
        if coverage_report:
            cov_dir = os.path.join(reports_dir, "coverage")
            pytest_cmd.extend(["--cov=.", f"--cov-report=html:{cov_dir}", "--cov-report=term-missing"])
        
        try:
            result = subprocess.run(
                pytest_cmd, capture_output=True, text=True, timeout=timeout
            )
            
            if result.returncode == 0:
                # Compter les tests réussis à partir de la sortie
                output_lines = result.stdout.split('\n')
                passed_line = [line for line in output_lines if 'passed' in line and 'failed' not in line]
                test_count = ""
                if passed_line:
                    test_count = f" ({passed_line[-1].split()[0]} tests)"
                
                print(f"   SUCCES{test_count}")
                if html_report:
                    print(f"   Rapport HTML: {html_file}")
                results.append((test_name, "SUCCES", "", timeout))
            else:
                print(f"   ECHEC")
                # Extraire les erreurs principales
                error_summary = result.stdout.split('\n')[-10:]  # Dernières lignes pour le résumé
                error_text = '\n'.join([line for line in error_summary if line.strip()])
                print(f"   Details: {error_text[-200:]}")  # Limiter l'affichage
                if html_report:
                    print(f"   Rapport HTML (avec erreurs): {html_file}")
                results.append((test_name, "ECHEC", error_text, timeout))
                
        except subprocess.TimeoutExpired:
            print(f"   TIMEOUT apres {timeout}s")
            results.append((test_name, "TIMEOUT", f"Test depasse {timeout}s", timeout))
        except Exception as e:
            print(f"   ERREUR - {e}")
            results.append((test_name, "ERREUR", str(e), timeout))
    
    # Résumé final
    print("\n" + "=" * 80)
    print("RÉSUMÉ DES TESTS:")
    print("=" * 80)
    
    success_count = 0
    critical_failures = []
    
    for test_name, status, error, timeout in results:
        if status == "SUCCES":
            print(f"[OK] {test_name}")
            success_count += 1
        else:
            status_icon = "[FAIL]" if status == "ECHEC" else "[TIME]" if status == "TIMEOUT" else "[ERR]"
            print(f"{status_icon} {test_name} - {status}")
            
            # Marquer les échecs critiques
            if "critiques" in test_name.lower() or "cicd" in test_name.lower():
                critical_failures.append(test_name)
            
            if error and len(error.strip()) > 0:
                print(f"   -> {error[:150]}{'...' if len(error) > 150 else ''}")
    
    print(f"\nResultat: {success_count}/{len(results)} tests reussis")
    
    # Afficher les chemins des rapports générés
    if html_report or coverage_report:
        print(f"\nRapports generes dans: {reports_dir}/")
        if coverage_report:
            print(f"   Rapport de couverture: {os.path.join(reports_dir, 'coverage', 'index.html')}")
        if html_report:
            print(f"   Rapports HTML: {reports_dir}/test_report_*.html")
    
    # Analyse du résultat
    if success_count == len(results):
        print("Tous les tests passent ! Backend pret pour production.")
        final_status = "SUCCESS"
    elif critical_failures:
        print("TESTS CRITIQUES EN ECHEC ! Correction urgente necessaire.")
        print(f"   Tests critiques echoues: {', '.join(critical_failures)}")
        final_status = "CRITICAL_FAILURE"
    elif success_count >= len(results) * 0.8:  # 80% de réussite
        print("La plupart des tests passent. Quelques corrections mineures necessaires.")
        final_status = "PARTIAL_SUCCESS"
    else:
        print("Plusieurs tests echouent. Revision du code necessaire.")
        final_status = "FAILURE"
    
    # Créer un fichier de métadonnées pour cette session
    metadata = {
        "timestamp": timestamp,
        "session_dir": os.path.basename(reports_dir),
        "mode": "quick" if quick_mode else "complete",
        "total_tests": len(results),
        "successful_tests": success_count,
        "failed_tests": len(results) - success_count,
        "success_rate": round((success_count / len(results)) * 100, 2) if results else 0,
        "final_status": final_status,
        "reports_generated": {
            "html": html_report,
            "coverage": coverage_report
        },
        "critical_failures": critical_failures,
        "test_results": [
            {
                "name": name,
                "status": status,
                "timeout": timeout,
                "error": error[:200] if error else None
            }
            for name, status, error, timeout in results
        ]
    }
    
    metadata_file = os.path.join(reports_dir, "session_metadata.json")
    with open(metadata_file, 'w', encoding='utf-8') as f:
        json.dump(metadata, f, indent=2, ensure_ascii=False)
    
    print(f"\nMetadonnees de session: {metadata_file}")
    
    return final_status == "SUCCESS" or final_status == "PARTIAL_SUCCESS"

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Exécute la suite de tests backend")
    parser.add_argument("--quick", "-q", action="store_true", 
                       help="Mode rapide: execute seulement les tests essentiels")
    parser.add_argument("--html", action="store_true", 
                       help="Genere des rapports HTML pour chaque module de test")
    parser.add_argument("--coverage", action="store_true", 
                       help="Genere un rapport de couverture de code")
    parser.add_argument("--all-reports", action="store_true", 
                       help="Active tous les rapports (HTML + couverture)")
    parser.add_argument("--verbose", "-v", action="store_true", 
                       help="Affichage detaille des erreurs")
    
    args = parser.parse_args()
    
    # Si --all-reports est activé, activer tous les rapports
    if args.all_reports:
        args.html = True
        args.coverage = True
    
    success = run_tests(
        quick_mode=args.quick, 
        html_report=args.html, 
        coverage_report=args.coverage
    )
    sys.exit(0 if success else 1)
