#!/usr/bin/env python3
# =============================================================================
# Script : test_run_etl.py
# Description : Test complet du processus ETL avec mesure des performances
# =============================================================================

import subprocess
import time
import logging
import sys
from pathlib import Path
import pandas as pd

# Configuration du logging
logging.basicConfig(
    level=logging.INFO,
    format='%(asctime)s - %(levelname)s - %(message)s',
    handlers=[
        logging.FileHandler('test_etl_performance.log'),
        logging.StreamHandler(sys.stdout)
    ]
)

def check_output_files():
    """Vérifie que tous les fichiers de sortie sont créés"""
    expected_files = [
        '../DatasetClean/unite_clean.csv',
        '../DatasetClean/type_statistique_clean.csv',
        '../DatasetClean/type_traitement_clean.csv',
        '../DatasetClean/pays_clean.csv',
        '../DatasetClean/table_population_hiv.csv',
        '../DatasetClean/table_mortalite.csv',
        '../DatasetClean/table_transmission_mere_enfant.csv',
        '../DatasetClean/table_traitement.csv',
        '../DatasetClean/table_statistique.csv'
    ]
    
    missing_files = []
    existing_files = []
    
    for file_path in expected_files:
        if Path(file_path).exists():
            existing_files.append(file_path)
            # Vérifier que le fichier n'est pas vide
            try:
                df = pd.read_csv(file_path)
                if df.empty:
                    logging.warning(f"[WARNING] Fichier vide: {file_path}")
                else:
                    logging.info(f"[SUCCESS] Fichier créé: {file_path} ({len(df)} lignes)")
            except Exception as e:
                logging.error(f"[ERROR] Erreur lors de la lecture de {file_path}: {e}")
        else:
            missing_files.append(file_path)
    
    if missing_files:
        logging.error(f"[ERROR] Fichiers manquants: {missing_files}")
        return False
    
    logging.info(f"[SUCCESS] Tous les fichiers de sortie sont présents ({len(existing_files)} fichiers)")
    return True

def run_single_etl(script_name):
    """Exécute un script ETL individuel et mesure ses performances"""
    try:
        start_time = time.time()
        logging.info(f"[PROCESSING] Exécution de {script_name}...")
        
        result = subprocess.run(
            [sys.executable, script_name],
            capture_output=True,
            text=True,
            cwd=Path.cwd()
        )
        
        execution_time = time.time() - start_time
        
        if result.returncode == 0:
            logging.info(f"[SUCCESS] {script_name} terminé en {execution_time:.2f}s")
            return True, execution_time
        else:
            logging.error(f"[ERROR] Échec de {script_name}")
            logging.error(f"STDERR: {result.stderr}")
            return False, execution_time
            
    except Exception as e:
        logging.error(f"[ERROR] Erreur lors de l'exécution de {script_name}: {e}")
        return False, 0

def run_batch_etl():
    """Exécute le script batch ETL complet"""
    try:
        start_time = time.time()
        logging.info("[PROCESSING] Exécution du script batch ETL...")
        
        result = subprocess.run(
            ['run_etl.bat'],
            capture_output=True,
            text=True,
            cwd=Path.cwd(),
            shell=True
        )
        
        execution_time = time.time() - start_time
        
        if result.returncode == 0:
            logging.info(f"[SUCCESS] Script batch terminé en {execution_time:.2f}s")
            return True, execution_time
        else:
            logging.error("[ERROR] Échec du script batch")
            logging.error(f"STDOUT: {result.stdout}")
            logging.error(f"STDERR: {result.stderr}")
            return False, execution_time
            
    except Exception as e:
        logging.error(f"[ERROR] Erreur lors de l'exécution du batch: {e}")
        return False, 0

def generate_performance_report(individual_times, batch_time):
    """Génère un rapport de performance"""
    logging.info("\n" + "=" * 50)
    logging.info("RAPPORT DE PERFORMANCE ETL")
    logging.info("=" * 50)
    
    total_individual = sum(individual_times.values())
    
    logging.info(f"Temps d'exécution individuel:")
    for script, exec_time in individual_times.items():
        logging.info(f"  - {script}: {exec_time:.2f}s")
    
    logging.info(f"\nTemps total individuel: {total_individual:.2f}s")
    logging.info(f"Temps batch: {batch_time:.2f}s")
    
    if batch_time > 0:
        efficiency = (total_individual / batch_time) * 100
        logging.info(f"Efficacité du batch: {efficiency:.1f}%")
    
    # Estimation des performances
    if total_individual < 30:
        logging.info("[PERFORMANCE] Excellent - ETL rapide")
    elif total_individual < 60:
        logging.info("[PERFORMANCE] Bon - ETL acceptable")
    else:
        logging.info("[PERFORMANCE] Lent - Optimisation recommandée")

def cleanup_output_files():
    """Nettoie les fichiers de sortie pour un test propre"""
    output_files = [
        '../DatasetClean/table_population_hiv.csv',
        '../DatasetClean/table_mortalite.csv',
        '../DatasetClean/table_transmission_mere_enfant.csv',
        '../DatasetClean/table_traitement.csv',
        '../DatasetClean/table_statistique.csv'
    ]
    
    cleaned_count = 0
    for file_path in output_files:
        try:
            if Path(file_path).exists():
                Path(file_path).unlink()
                cleaned_count += 1
        except Exception as e:
            logging.warning(f"[WARNING] Impossible de supprimer {file_path}: {e}")
    
    if cleaned_count > 0:
        logging.info(f"[INFO] {cleaned_count} fichiers de sortie nettoyés")

def main():
    """Fonction principale de test"""
    logging.info("DEBUT DU TEST COMPLET DES SCRIPTS ETL")
    logging.info("=" * 50)
    
    # Nettoyage préalable
    cleanup_output_files()
    
    # Liste des scripts ETL dans l'ordre d'exécution
    etl_scripts = [
        "etl_table_unite.py",
        "etl_table_type_statistique.py",
        "etl_table_type_traitement.py",
        "etl_table_pays.py",
        "etl_table_population_hiv.py",
        "etl_table_mortalite.py",
        "etl_table_transmission_mere_enfant.py",
        "etl_table_traitement.py",
        "etl_table_statistique.py"
    ]
    
    # Test 1: Exécution individuelle de chaque script
    logging.info("\n--- TEST 1: EXECUTION INDIVIDUELLE ---")
    individual_times = {}
    all_individual_success = True
    
    for script in etl_scripts:
        success, exec_time = run_single_etl(script)
        individual_times[script] = exec_time
        if not success:
            all_individual_success = False
    
    # Vérification des fichiers de sortie après exécution individuelle
    if all_individual_success:
        logging.info("\n[SUCCESS] Tous les scripts individuels ont réussi")
        individual_files_ok = check_output_files()
    else:
        logging.error("\n[ERROR] Certains scripts individuels ont échoué")
        individual_files_ok = False
    
    # Nettoyage pour le test batch
    cleanup_output_files()
    
    # Test 2: Exécution via script batch
    logging.info("\n--- TEST 2: EXECUTION BATCH ---")
    batch_success, batch_time = run_batch_etl()
    
    # Vérification des fichiers de sortie après batch
    if batch_success:
        batch_files_ok = check_output_files()
    else:
        batch_files_ok = False
    
    # Génération du rapport final
    logging.info("\n--- RAPPORT FINAL ---")
    generate_performance_report(individual_times, batch_time)
    
    # Résumé des tests
    logging.info("\n" + "=" * 50)
    logging.info("RESUME DES TESTS")
    logging.info("=" * 50)
    
    test_results = [
        ("Scripts individuels", all_individual_success),
        ("Fichiers après exécution individuelle", individual_files_ok),
        ("Script batch", batch_success),
        ("Fichiers après exécution batch", batch_files_ok)
    ]
    
    all_tests_passed = True
    for test_name, result in test_results:
        status = "[SUCCESS]" if result else "[ERROR]"
        logging.info(f"{status} {test_name}")
        if not result:
            all_tests_passed = False
    
    logging.info("\n" + "=" * 50)
    if all_tests_passed:
        logging.info("[SUCCESS] TOUS LES TESTS SONT PASSES")
        logging.info("Les scripts ETL sont fonctionnels et efficaces!")
    else:
        logging.error("[ERROR] CERTAINS TESTS ONT ECHOUE")
        logging.error("Veuillez vérifier les erreurs ci-dessus.")
    
    return all_tests_passed

if __name__ == "__main__":
    success = main()
    sys.exit(0 if success else 1)
