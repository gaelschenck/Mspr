#!/usr/bin/env python3
# =============================================================================
# Script : validate_etl.py
# Description : Valide que tous les scripts ETL sont fonctionnels
# =============================================================================

import os
import sys
import subprocess
import logging
from pathlib import Path
import pandas as pd

# Configuration du logging
logging.basicConfig(
    level=logging.INFO,
    format='%(asctime)s - %(levelname)s - %(message)s',
    handlers=[
        logging.FileHandler('validation_etl.log'),
        logging.StreamHandler(sys.stdout)
    ]
)

def check_file_exists(file_path):
    """Vérifie l'existence d'un fichier"""
    return Path(file_path).exists()

def validate_csv_structure(csv_path, expected_columns=None):
    """Valide la structure d'un fichier CSV"""
    try:
        if not check_file_exists(csv_path):
            return False, f"Fichier introuvable: {csv_path}"
        
        df = pd.read_csv(csv_path)
        
        if df.empty:
            return False, f"Fichier vide: {csv_path}"
        
        if expected_columns:
            missing_cols = set(expected_columns) - set(df.columns)
            if missing_cols:
                return False, f"Colonnes manquantes dans {csv_path}: {missing_cols}"
        
        return True, f"Structure valide: {csv_path} ({len(df)} lignes)"
        
    except Exception as e:
        return False, f"Erreur lors de la validation de {csv_path}: {str(e)}"

def validate_source_data():
    """Valide les fichiers sources"""
    logging.info("=== VALIDATION DES FICHIERS SOURCES ===")
    
    source_files = [
        "../SourceData/art_coverage_by_country_clean.csv",
        "../SourceData/art_pediatric_coverage_by_country_clean.csv", 
        "../SourceData/no_of_cases_adults_15_to_49_by_country_clean.csv",
        "../SourceData/no_of_deaths_by_country_clean.csv",
        "../SourceData/no_of_people_living_with_hiv_by_country_clean.csv",
        "../SourceData/prevention_of_mother_to_child_transmission_by_country_clean.csv"
    ]
    
    all_valid = True
    for file_path in source_files:
        is_valid, message = validate_csv_structure(file_path)
        if is_valid:
            logging.info(f"[SUCCESS] {message}")
        else:
            logging.error(f"[ERROR] {message}")
            all_valid = False
    
    return all_valid

def validate_etl_scripts():
    """Valide la syntaxe des scripts ETL"""
    logging.info("=== VALIDATION DES SCRIPTS ETL ===")
    
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
    
    all_valid = True
    for script in etl_scripts:
        try:
            # Vérification de la syntaxe Python
            result = subprocess.run(
                [sys.executable, "-m", "py_compile", script],
                capture_output=True,
                text=True
            )
            
            if result.returncode == 0:
                logging.info(f"[SUCCESS] Syntaxe valide: {script}")
            else:
                logging.error(f"[ERROR] Erreur de syntaxe dans {script}: {result.stderr}")
                all_valid = False
                
        except Exception as e:
            logging.error(f"[ERROR] Erreur lors de la validation de {script}: {str(e)}")
            all_valid = False
    
    return all_valid

def validate_dependencies():
    """Valide les dépendances Python"""
    logging.info("=== VALIDATION DES DEPENDANCES ===")
    
    required_packages = ['pandas', 'numpy']
    
    all_valid = True
    for package in required_packages:
        try:
            __import__(package)
            logging.info(f"[SUCCESS] Package disponible: {package}")
        except ImportError:
            logging.error(f"[ERROR] Package manquant: {package}")
            all_valid = False
    
    return all_valid

def validate_output_structure():
    """Valide la structure des fichiers de sortie attendus"""
    logging.info("=== VALIDATION DE LA STRUCTURE DE SORTIE ===")
    
    expected_outputs = {
        "../DatasetClean/unite_clean.csv": ["id_unite", "unite"],
        "../DatasetClean/type_statistique_clean.csv": ["id_type_statistique", "type_statistique"],
        "../DatasetClean/type_traitement_clean.csv": ["id_type_traitement", "type_traitement"],
        "../DatasetClean/pays_clean.csv": ["id_pays", "pays", "region_who"]
    }
    
    all_valid = True
    for file_path, expected_cols in expected_outputs.items():
        if check_file_exists(file_path):
            is_valid, message = validate_csv_structure(file_path, expected_cols)
            if is_valid:
                logging.info(f"[SUCCESS] {message}")
            else:
                logging.error(f"[ERROR] {message}")
                all_valid = False
        else:
            logging.info(f"[INFO] Fichier de sortie non encore généré: {file_path}")
    
    return all_valid

def main():
    """Fonction principale de validation"""
    logging.info("DEBUT DE LA VALIDATION DES SCRIPTS ETL")
    logging.info("=" * 50)
    
    validations = [
        ("Dépendances", validate_dependencies),
        ("Scripts ETL", validate_etl_scripts),  
        ("Fichiers sources", validate_source_data),
        ("Structure de sortie", validate_output_structure)
    ]
    
    all_tests_passed = True
    
    for test_name, test_func in validations:
        logging.info(f"\n--- Test: {test_name} ---")
        try:
            result = test_func()
            if result:
                logging.info(f"[SUCCESS] {test_name}: PASSE")
            else:
                logging.error(f"[ERROR] {test_name}: ECHEC")
                all_tests_passed = False
        except Exception as e:
            logging.error(f"[ERROR] Erreur durant {test_name}: {str(e)}")
            all_tests_passed = False
    
    logging.info("\n" + "=" * 50)
    if all_tests_passed:
        logging.info("[SUCCESS] TOUS LES TESTS SONT PASSES")
        logging.info("Les scripts ETL sont prêts à être exécutés.")
    else:
        logging.error("[ERROR] CERTAINS TESTS ONT ECHOUE")
        logging.error("Veuillez corriger les erreurs avant d'exécuter les ETL.")
    
    return all_tests_passed

if __name__ == "__main__":
    success = main()
    sys.exit(0 if success else 1)
