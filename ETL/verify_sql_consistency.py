#!/usr/bin/env python3
# =============================================================================
# Script : verify_sql_consistency.py
# Description : Vérifie la cohérence entre les fichiers SQL et les DatasetClean
# et génère des scripts SQL corrigés pour correspondre aux modèles SQLAlchemy
# =============================================================================

import pandas as pd
import logging
from pathlib import Path
import os

# Configuration du logging
logging.basicConfig(
    level=logging.INFO,
    format='%(asctime)s - %(levelname)s - %(message)s'
)

class SQLAnalyzer:
    """Classe pour analyser et corriger les scripts SQL"""
    
    def __init__(self):
        self.sql_dir = Path('../SQL')
        self.dataset_dir = Path('../DatasetClean')
        self.models_structure = {
            'pays': {
                'columns': ['id_pays', 'pays', 'region_who'],
                'types': ['INTEGER PRIMARY KEY', 'VARCHAR(100) NOT NULL', 'VARCHAR(100)'],
                'csv_file': 'pays_clean.csv'
            },
            'unite': {
                'columns': ['id_unite', 'unite'],
                'types': ['INTEGER PRIMARY KEY', 'VARCHAR(50) NOT NULL'],
                'csv_file': 'unite_clean.csv'
            },
            'type_statistique': {
                'columns': ['id_type_statistique', 'nom_type_statistique'],
                'types': ['INTEGER PRIMARY KEY', 'VARCHAR(100) NOT NULL'],
                'csv_file': 'type_statistique_clean.csv'
            },
            'type_traitement': {
                'columns': ['id_type_traitement', 'nom_type_traitement'],
                'types': ['INTEGER PRIMARY KEY', 'VARCHAR(100) NOT NULL'],
                'csv_file': 'type_traitement_clean.csv'
            },
            'population_hiv': {
                'columns': ['id', 'id_pays', 'annee', 'valeur', 'id_unite'],
                'types': ['INTEGER PRIMARY KEY', 'INTEGER', 'INTEGER', 'DECIMAL(10,2)', 'INTEGER'],
                'csv_file': 'table_population_hiv.csv',
                'foreign_keys': [
                    ('id_pays', 'pays', 'id_pays'),
                    ('id_unite', 'unite', 'id_unite')
                ]
            },
            'mortalite': {
                'columns': ['id', 'id_pays', 'annee', 'valeur', 'id_unite'],
                'types': ['INTEGER PRIMARY KEY', 'INTEGER', 'INTEGER', 'DECIMAL(10,2)', 'INTEGER'],
                'csv_file': 'table_mortalite.csv',
                'foreign_keys': [
                    ('id_pays', 'pays', 'id_pays'),
                    ('id_unite', 'unite', 'id_unite')
                ]
            },
            'transmission_mere_enfant': {
                'columns': ['id_transmission', 'id_pays', 'besoin_arv_min', 'besoin_arv_median', 'besoin_arv_max',
                           'pourcentage_recu_min', 'pourcentage_recu_median', 'pourcentage_recu_max'],
                'types': ['INTEGER PRIMARY KEY', 'INTEGER', 'DECIMAL(10,2)', 'DECIMAL(10,2)', 'DECIMAL(10,2)',
                         'DECIMAL(5,2)', 'DECIMAL(5,2)', 'DECIMAL(5,2)'],
                'csv_file': 'table_transmission_mere_enfant.csv',
                'foreign_keys': [('id_pays', 'pays', 'id_pays')]
            },
            'traitement': {
                'columns': ['id', 'id_pays', 'valeur', 'id_unite', 'id_type_traitement'],
                'types': ['INTEGER PRIMARY KEY', 'INTEGER', 'DECIMAL(10,2)', 'INTEGER', 'INTEGER'],
                'csv_file': 'table_traitement.csv',
                'foreign_keys': [
                    ('id_pays', 'pays', 'id_pays'),
                    ('id_unite', 'unite', 'id_unite'),
                    ('id_type_traitement', 'type_traitement', 'id_type_traitement')
                ]
            },
            'statistique': {
                'columns': ['id', 'id_pays', 'annee', 'valeur', 'id_unite', 'id_type_statistique'],
                'types': ['INTEGER PRIMARY KEY', 'INTEGER', 'INTEGER', 'DECIMAL(10,2)', 'INTEGER', 'INTEGER'],
                'csv_file': 'table_statistique.csv',
                'foreign_keys': [
                    ('id_pays', 'pays', 'id_pays'),
                    ('id_unite', 'unite', 'id_unite'),
                    ('id_type_statistique', 'type_statistique', 'id_type_statistique')
                ]
            }
        }
    
    def analyze_csv_files(self):
        """Analyse les fichiers CSV pour vérifier leur structure"""
        logging.info("=== ANALYSE DES FICHIERS CSV ===")
        
        csv_issues = []
        
        for table_name, structure in self.models_structure.items():
            csv_file = self.dataset_dir / structure['csv_file']
            
            if not csv_file.exists():
                csv_issues.append(f"❌ {table_name}: Fichier CSV manquant ({csv_file})")
                continue
            
            try:
                df = pd.read_csv(csv_file)
                expected_columns = structure['columns']
                actual_columns = list(df.columns)
                
                logging.info(f"\n--- Table: {table_name} ---")
                logging.info(f"Colonnes attendues: {expected_columns}")
                logging.info(f"Colonnes trouvées: {actual_columns}")
                logging.info(f"Nombre de lignes: {len(df)}")
                
                # Vérification des colonnes
                missing_columns = set(expected_columns) - set(actual_columns)
                extra_columns = set(actual_columns) - set(expected_columns)
                
                if missing_columns:
                    csv_issues.append(f"❌ {table_name}: Colonnes manquantes: {missing_columns}")
                if extra_columns:
                    csv_issues.append(f"⚠️ {table_name}: Colonnes supplémentaires: {extra_columns}")
                
                if not missing_columns and not extra_columns:
                    logging.info(f"✅ {table_name}: Structure CSV conforme")
                
            except Exception as e:
                csv_issues.append(f"❌ {table_name}: Erreur lors de la lecture: {str(e)}")
        
        return csv_issues
    
    def analyze_existing_sql(self):
        """Analyse les fichiers SQL existants"""
        logging.info("\n=== ANALYSE DES FICHIERS SQL EXISTANTS ===")
        
        sql_files = list(self.sql_dir.glob('*.sql'))
        
        for sql_file in sql_files:
            logging.info(f"\nFichier SQL trouvé: {sql_file.name}")
            try:
                with open(sql_file, 'r', encoding='utf-8') as f:
                    content = f.read()
                    lines = len(content.splitlines())
                    logging.info(f"  - Taille: {lines} lignes")
                    
                    # Recherche de mots-clés SQL
                    if 'CREATE TABLE' in content.upper():
                        logging.info("  - Contient des CREATE TABLE")
                    if 'INSERT INTO' in content.upper():
                        logging.info("  - Contient des INSERT INTO")
                    if 'FOREIGN KEY' in content.upper():
                        logging.info("  - Contient des FOREIGN KEY")
                        
            except Exception as e:
                logging.error(f"  - Erreur lors de la lecture: {str(e)}")
    
    def generate_create_tables_sql(self):
        """Génère le script SQL pour créer les tables"""
        
        sql_content = [
            "-- =============================================================================",
            "-- Script : create_tables.sql",
            "-- Description : Création des tables conformes aux modèles SQLAlchemy",
            "-- Généré automatiquement le 28/06/2025",
            "-- =============================================================================",
            "",
            "-- Suppression des tables existantes (dans l'ordre des dépendances)",
            "DROP TABLE IF EXISTS statistique;",
            "DROP TABLE IF EXISTS traitement;",
            "DROP TABLE IF EXISTS transmission_mere_enfant;",
            "DROP TABLE IF EXISTS mortalite;",
            "DROP TABLE IF EXISTS population_hiv;",
            "DROP TABLE IF EXISTS pays;",
            "DROP TABLE IF EXISTS type_statistique;",
            "DROP TABLE IF EXISTS type_traitement;",
            "DROP TABLE IF EXISTS unite;",
            "",
            "-- =============================================================================",
            "-- TABLES DE REFERENCE",
            "-- =============================================================================",
            ""
        ]
        
        # Tables de référence (sans FK)
        reference_tables = ['unite', 'type_statistique', 'type_traitement']
        
        for table_name in reference_tables:
            structure = self.models_structure[table_name]
            sql_content.extend(self._generate_table_sql(table_name, structure))
            sql_content.append("")
        
        sql_content.extend([
            "-- =============================================================================",
            "-- TABLE PRINCIPALE",
            "-- =============================================================================",
            ""
        ])
        
        # Table pays (référencée par les autres)
        structure = self.models_structure['pays']
        sql_content.extend(self._generate_table_sql('pays', structure))
        sql_content.append("")
        
        sql_content.extend([
            "-- =============================================================================",
            "-- TABLES DE DONNEES",
            "-- =============================================================================",
            ""
        ])
        
        # Tables de données (avec FK)
        data_tables = ['population_hiv', 'mortalite', 'transmission_mere_enfant', 'traitement', 'statistique']
        
        for table_name in data_tables:
            structure = self.models_structure[table_name]
            sql_content.extend(self._generate_table_sql(table_name, structure))
            sql_content.append("")
        
        return "\n".join(sql_content)
    
    def _generate_table_sql(self, table_name, structure):
        """Génère le SQL pour une table spécifique"""
        
        lines = [f"-- Table: {table_name}"]
        lines.append(f"CREATE TABLE {table_name} (")
        
        # Colonnes
        column_definitions = []
        for i, (column, col_type) in enumerate(zip(structure['columns'], structure['types'])):
            column_definitions.append(f"    {column} {col_type}")
        
        # Foreign Keys
        if 'foreign_keys' in structure:
            for fk_column, ref_table, ref_column in structure['foreign_keys']:
                column_definitions.append(f"    FOREIGN KEY ({fk_column}) REFERENCES {ref_table}({ref_column})")
        
        lines.append(",\n".join(column_definitions))
        lines.append(");")
        
        return lines
    
    def generate_import_data_sql(self):
        """Génère le script SQL pour importer les données"""
        
        sql_content = [
            "-- =============================================================================",
            "-- Script : import_data.sql",
            "-- Description : Import des données depuis les fichiers CSV",
            "-- Généré automatiquement le 28/06/2025",
            "-- =============================================================================",
            "",
            "-- Désactivation des contraintes de clés étrangères temporairement",
            "PRAGMA foreign_keys = OFF;",
            "",
            "-- Nettoyage des tables",
            "DELETE FROM statistique;",
            "DELETE FROM traitement;",
            "DELETE FROM transmission_mere_enfant;",
            "DELETE FROM mortalite;",
            "DELETE FROM population_hiv;",
            "DELETE FROM pays;",
            "DELETE FROM type_statistique;",
            "DELETE FROM type_traitement;",
            "DELETE FROM unite;",
            "",
            "-- =============================================================================",
            "-- IMPORT DES TABLES DE REFERENCE",
            "-- =============================================================================",
            ""
        ]
        
        # Import des tables de référence
        reference_tables = ['unite', 'type_statistique', 'type_traitement', 'pays']
        
        for table_name in reference_tables:
            structure = self.models_structure[table_name]
            csv_file = structure['csv_file']
            
            sql_content.extend([
                f"-- Import {table_name}",
                f".mode csv",
                f".headers on",
                f".import '../DatasetClean/{csv_file}' {table_name}",
                f"",
                f"-- Vérification {table_name}",
                f"SELECT 'Table {table_name}:' as info, COUNT(*) as nb_lignes FROM {table_name};",
                ""
            ])
        
        sql_content.extend([
            "-- =============================================================================",
            "-- IMPORT DES TABLES DE DONNEES",
            "-- =============================================================================",
            ""
        ])
        
        # Import des tables de données
        data_tables = ['population_hiv', 'mortalite', 'transmission_mere_enfant', 'traitement', 'statistique']
        
        for table_name in data_tables:
            structure = self.models_structure[table_name]
            csv_file = structure['csv_file']
            
            sql_content.extend([
                f"-- Import {table_name}",
                f".mode csv",
                f".headers on",
                f".import '../DatasetClean/{csv_file}' {table_name}",
                f"",
                f"-- Vérification {table_name}",
                f"SELECT 'Table {table_name}:' as info, COUNT(*) as nb_lignes FROM {table_name};",
                ""
            ])
        
        sql_content.extend([
            "-- Réactivation des contraintes de clés étrangères",
            "PRAGMA foreign_keys = ON;",
            "",
            "-- =============================================================================",
            "-- VERIFICATION FINALE",
            "-- =============================================================================",
            "",
            "-- Résumé des tables",
            "SELECT 'RESUME DES IMPORTS:' as section;",
            "SELECT name as table_name, ",
            "       (SELECT COUNT(*) FROM unite) as unite_count,",
            "       (SELECT COUNT(*) FROM type_statistique) as type_stat_count,",
            "       (SELECT COUNT(*) FROM type_traitement) as type_trait_count,",
            "       (SELECT COUNT(*) FROM pays) as pays_count,",
            "       (SELECT COUNT(*) FROM population_hiv) as pop_hiv_count,",
            "       (SELECT COUNT(*) FROM mortalite) as mortalite_count,",
            "       (SELECT COUNT(*) FROM transmission_mere_enfant) as transmission_count,",
            "       (SELECT COUNT(*) FROM traitement) as traitement_count,",
            "       (SELECT COUNT(*) FROM statistique) as statistique_count",
            "FROM sqlite_master WHERE type='table' AND name='unite';",
            "",
            "-- Test des jointures",
            "SELECT 'TEST JOINTURES:' as section;",
            "SELECT p.pays, COUNT(ph.id) as nb_population_hiv",
            "FROM pays p",
            "LEFT JOIN population_hiv ph ON p.id_pays = ph.id_pays",
            "GROUP BY p.id_pays, p.pays",
            "LIMIT 5;"
        ])
        
        return "\n".join(sql_content)
    
    def generate_corrected_sql_files(self):
        """Génère tous les fichiers SQL corrigés"""
        logging.info("\n=== GENERATION DES FICHIERS SQL CORRIGES ===")
        
        # Création du dossier SQL s'il n'existe pas
        self.sql_dir.mkdir(exist_ok=True)
        
        # Génération du script de création des tables
        create_tables_sql = self.generate_create_tables_sql()
        create_tables_file = self.sql_dir / 'create_tables_corrected.sql'
        
        with open(create_tables_file, 'w', encoding='utf-8') as f:
            f.write(create_tables_sql)
        
        logging.info(f"✅ Fichier généré: {create_tables_file}")
        
        # Génération du script d'import des données
        import_data_sql = self.generate_import_data_sql()
        import_data_file = self.sql_dir / 'import_data_corrected.sql'
        
        with open(import_data_file, 'w', encoding='utf-8') as f:
            f.write(import_data_sql)
        
        logging.info(f"✅ Fichier généré: {import_data_file}")
        
        # Génération d'un script complet
        complete_sql = [
            create_tables_sql,
            "",
            "-- =============================================================================",
            "-- IMPORT DES DONNEES",
            "-- =============================================================================",
            "",
            import_data_sql
        ]
        
        complete_file = self.sql_dir / 'setup_database_complete.sql'
        with open(complete_file, 'w', encoding='utf-8') as f:
            f.write("\n".join(complete_sql))
        
        logging.info(f"✅ Fichier complet généré: {complete_file}")
        
        return {
            'create_tables': create_tables_file,
            'import_data': import_data_file,
            'complete': complete_file
        }

def main():
    """Fonction principale"""
    
    logging.info("DEBUT DE L'ANALYSE DE COHERENCE SQL/CSV")
    logging.info("=" * 60)
    
    analyzer = SQLAnalyzer()
    
    # Analyse des fichiers CSV
    csv_issues = analyzer.analyze_csv_files()
    
    # Analyse des fichiers SQL existants
    analyzer.analyze_existing_sql()
    
    # Résumé des problèmes CSV
    if csv_issues:
        logging.info("\n=== PROBLEMES DETECTES DANS LES CSV ===")
        for issue in csv_issues:
            logging.info(issue)
    else:
        logging.info("\n✅ TOUS LES FICHIERS CSV SONT CONFORMES")
    
    # Génération des fichiers SQL corrigés
    try:
        generated_files = analyzer.generate_corrected_sql_files()
        
        logging.info("\n=== FICHIERS SQL GENERES ===")
        for file_type, file_path in generated_files.items():
            logging.info(f"✅ {file_type}: {file_path}")
        
        logging.info("\n=== INSTRUCTIONS D'UTILISATION ===")
        logging.info("1. Pour créer une nouvelle base de données:")
        logging.info(f"   sqlite3 ma_base.db < {generated_files['complete']}")
        logging.info("")
        logging.info("2. Pour une base existante:")
        logging.info(f"   sqlite3 ma_base.db < {generated_files['create_tables']}")
        logging.info(f"   sqlite3 ma_base.db < {generated_files['import_data']}")
        
        logging.info("\n✅ ANALYSE TERMINEE AVEC SUCCES")
        return True
        
    except Exception as e:
        logging.error(f"❌ Erreur lors de la génération: {str(e)}")
        return False

if __name__ == "__main__":
    success = main()
    exit(0 if success else 1)
