#!/usr/bin/env python3
"""
NewETL - Pipeline ETL moderne pour les données de santé VIH
Traite et normalise les fichiers CSV de données de santé dans une structure relationnelle.
"""

import pandas as pd
import sqlite3
import logging
import os
import re
from pathlib import Path
from typing import Dict, List, Optional, Tuple, Any
from datetime import datetime

# Configuration du logging
script_dir = Path(__file__).parent
log_dir = script_dir / "DatasetClean"
log_dir.mkdir(exist_ok=True)
log_file = log_dir / "new_etl.log"

logging.basicConfig(
    level=logging.INFO,
    format='%(asctime)s - %(levelname)s - %(message)s',
    handlers=[
        logging.FileHandler(str(log_file)),
        logging.StreamHandler()
    ]
)
logger = logging.getLogger(__name__)

class HealthDataETL:
    """Pipeline ETL pour les données de santé VIH"""
    
    def __init__(self, source_dir: str = None, db_path: str = None):
        """
        Initialise le pipeline ETL
        
        Args:
            source_dir: Répertoire contenant les fichiers CSV source
            db_path: Chemin vers la base de données SQLite
        """
        self.source_dir = source_dir or "./SourceData"
        self.db_path = db_path or "./DatasetClean/normalized_health_data.db"
        
        # Mapping des régions WHO pour normalisation
        self.who_regions = {
            'Africa': 'Africa',
            'Americas': 'Americas', 
            'South-East Asia': 'South-East Asia',
            'Europe': 'Europe',
            'Eastern Mediterranean': 'Eastern Mediterranean',
            'Western Pacific': 'Western Pacific'
        }
        
        # Configuration des fichiers CSV et leurs types de données
        self.csv_configs = {
            'prevention_of_mother_to_child_transmission_by_country_clean.csv': {
                'table_name': 'prevention_mother_to_child',
                'indicator_type': 'Prevention of Mother-to-Child Transmission',
                'value_columns': ['Received Antiretrovirals', 'Needing antiretrovirals', 'Percentage Recieved'],
                'confidence_columns': {
                    'Needing antiretrovirals': ['Needing antiretrovirals_median', 'Needing antiretrovirals_min', 'Needing antiretrovirals_max'],
                    'Percentage Recieved': ['Percentage Recieved_median', 'Percentage Recieved_min', 'Percentage Recieved_max']
                }
            },
            'art_coverage_by_country_clean.csv': {
                'table_name': 'art_coverage',
                'indicator_type': 'ART Coverage',
                'value_columns': [
                    'Reported number of people receiving ART',
                    'Estimated number of people living with HIV',
                    'Estimated ART coverage among people living with HIV (%)'
                ],
                'confidence_columns': {
                    'Estimated number of people living with HIV': [
                        'Estimated number of people living with HIV_median',
                        'Estimated number of people living with HIV_min',
                        'Estimated number of people living with HIV_max'
                    ],
                    'Estimated ART coverage among people living with HIV (%)': [
                        'Estimated ART coverage among people living with HIV (%)_median',
                        'Estimated ART coverage among people living with HIV (%)_min',
                        'Estimated ART coverage among people living with HIV (%)_max'
                    ]
                }
            },
            'no_of_people_living_with_hiv_by_country_clean.csv': {
                'table_name': 'hiv_population',
                'indicator_type': 'People Living with HIV',
                'value_columns': ['Count'],
                'confidence_columns': {
                    'Count': ['Count_median', 'Count_min', 'Count_max']
                },
                'additional_columns': ['Year']
            },
            'no_of_deaths_by_country_clean.csv': {
                'table_name': 'hiv_mortality',
                'indicator_type': 'HIV-related Deaths',
                'value_columns': ['Count'],
                'confidence_columns': {
                    'Count': ['Count_median', 'Count_min', 'Count_max']
                },
                'additional_columns': ['Year']
            },
            'no_of_cases_adults_15_to_49_by_country_clean.csv': {
                'table_name': 'hiv_cases_adults',
                'indicator_type': 'HIV Cases Adults 15-49',
                'value_columns': ['Count'],
                'confidence_columns': {
                    'Count': ['Count_median', 'Count_min', 'Count_max']
                },
                'additional_columns': ['Year']
            },
            'art_pediatric_coverage_by_country_clean.csv': {
                'table_name': 'art_pediatric_coverage',
                'indicator_type': 'ART Pediatric Coverage',
                'value_columns': [
                    'Reported number of children receiving ART',
                    'Estimated number of children needing ART based on WHO methods',
                    'Estimated ART coverage among children (%)'
                ],
                'confidence_columns': {
                    'Estimated number of children needing ART based on WHO methods': [
                        'Estimated number of children needing ART based on WHO methods_median',
                        'Estimated number of children needing ART based on WHO methods_min',
                        'Estimated number of children needing ART based on WHO methods_max'
                    ],
                    'Estimated ART coverage among children (%)': [
                        'Estimated ART coverage among children (%)_median',
                        'Estimated ART coverage among children (%)_min',
                        'Estimated ART coverage among children (%)_max'
                    ]
                }
            }
        }

    def init_database(self):
        """
        Initialise la base de données en créant le schéma normalisé
        Cette méthode est utilisée par les tests et les scripts d'initialisation
        """
        logger.info("Initialisation de la base de données...")
        try:
            self.create_normalized_schema()
            logger.info("Base de données initialisée avec succès")
        except Exception as e:
            logger.error(f"Erreur lors de l'initialisation de la base de données: {e}")
            raise

    def create_normalized_schema(self):
        """Crée le schéma normalisé de la base de données"""
        
        schema_sql = """
        -- Table des pays
        CREATE TABLE IF NOT EXISTS countries (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name VARCHAR(255) NOT NULL UNIQUE,
            who_region VARCHAR(100),
            iso_code VARCHAR(3),
            created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
            updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
        );

        -- Table des types d'indicateurs
        CREATE TABLE IF NOT EXISTS indicator_types (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name VARCHAR(255) NOT NULL UNIQUE,
            description TEXT,
            unit VARCHAR(100),
            created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
        );

        -- Table des indicateurs (données principales)
        CREATE TABLE IF NOT EXISTS health_indicators (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            country_id INTEGER NOT NULL,
            indicator_type_id INTEGER NOT NULL,
            year INTEGER DEFAULT 2023,
            value_type VARCHAR(100) NOT NULL, -- 'received', 'needed', 'percentage', etc.
            value DECIMAL(15,2),
            value_text VARCHAR(255), -- pour les valeurs comme "No data"
            confidence_min DECIMAL(15,2),
            confidence_max DECIMAL(15,2),
            confidence_median DECIMAL(15,2),
            data_quality VARCHAR(50) DEFAULT 'good',
            source_file VARCHAR(255),
            raw_value_text TEXT, -- stocke la valeur brute pour traçabilité
            created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
            updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
            FOREIGN KEY (country_id) REFERENCES countries(id),
            FOREIGN KEY (indicator_type_id) REFERENCES indicator_types(id),
            UNIQUE(country_id, indicator_type_id, value_type, year)
        );

        -- Table des métadonnées de traitement
        CREATE TABLE IF NOT EXISTS etl_metadata (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            file_name VARCHAR(255) NOT NULL,
            processing_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
            records_processed INTEGER,
            records_success INTEGER,
            records_failed INTEGER,
            processing_duration_seconds DECIMAL(10,2),
            notes TEXT
        );

        -- Index pour optimiser les requêtes
        CREATE INDEX IF NOT EXISTS idx_health_indicators_country ON health_indicators(country_id);
        CREATE INDEX IF NOT EXISTS idx_health_indicators_type ON health_indicators(indicator_type_id);
        CREATE INDEX IF NOT EXISTS idx_health_indicators_year ON health_indicators(year);
        CREATE INDEX IF NOT EXISTS idx_countries_region ON countries(who_region);
        """
        
        try:
            # S'assurer que le répertoire de la base de données existe
            db_dir = Path(self.db_path).parent
            db_dir.mkdir(exist_ok=True)
            
            with sqlite3.connect(self.db_path) as conn:
                conn.executescript(schema_sql)
                logger.info("Schéma de base de données normalisé créé avec succès")
        except Exception as e:
            logger.error(f"Erreur lors de la création du schéma: {e}")
            raise

    def clean_numeric_value(self, value: str) -> Tuple[Optional[float], Optional[float], Optional[float]]:
        """
        Nettoie et extrait les valeurs numériques des chaînes de caractères
        
        Args:
            value: Valeur à nettoyer (ex: "25000[19000–32000]", "No data")
            
        Returns:
            Tuple (valeur_principale, min, max)
        """
        if pd.isna(value) or value in ['No data', 'Nodata', '', ' ']:
            return None, None, None
            
        value_str = str(value).strip()
        
        # Supprime les espaces dans les nombres
        value_str = re.sub(r'(\d)\s+(\d)', r'\1\2', value_str)
        
        # Pattern pour extraire valeur principale et intervalle de confiance
        # Ex: "25000[19000–32000]" ou "38[29–48]"
        pattern = r'^(\d+(?:\.\d+)?)\s*\[(\d+(?:\.\d+)?)(?:–|-)(\d+(?:\.\d+)?)\]$'
        match = re.match(pattern, value_str)
        
        if match:
            main_val = float(match.group(1))
            min_val = float(match.group(2))
            max_val = float(match.group(3))
            return main_val, min_val, max_val
        
        # Si pas d'intervalle, essaie de parser juste le nombre
        number_pattern = r'^(\d+(?:\.\d+)?)$'
        number_match = re.match(number_pattern, value_str)
        
        if number_match:
            return float(number_match.group(1)), None, None
            
        return None, None, None

    def normalize_country_name(self, country: str) -> str:
        """Normalise les noms de pays"""
        if pd.isna(country):
            return None
            
        # Nettoie les espaces supplémentaires
        country = str(country).strip()
        
        # Mapping des noms de pays problématiques
        country_mapping = {
            'Bolivia (Plurinational State of)': 'Bolivia',
            'Iran (Islamic Republic of)': 'Iran',
            'Venezuela (Bolivarian Republic of)': 'Venezuela',
            'United Kingdom of Great Britain and Northern Ireland': 'United Kingdom',
            'United States of America': 'United States',
            'Democratic People\'s Republic of Korea': 'North Korea',
            'Democratic Republic of the Congo': 'DR Congo',
            'Lao People\'s Democratic Republic': 'Laos',
            'Republic of Korea': 'South Korea',
            'Republic of Moldova': 'Moldova',
            'Republic of North Macedonia': 'North Macedonia',
            'United Republic of Tanzania': 'Tanzania',
            'Russian Federation': 'Russia',
            'Syrian Arab Republic': 'Syria'
        }
        
        return country_mapping.get(country, country)

    def insert_or_get_country(self, conn: sqlite3.Connection, country_name: str, who_region: str) -> int:
        """Insère ou récupère l'ID d'un pays"""
        normalized_name = self.normalize_country_name(country_name)
        if not normalized_name:
            return None
            
        cursor = conn.cursor()
        
        # Vérifie si le pays existe
        cursor.execute("SELECT id FROM countries WHERE name = ?", (normalized_name,))
        result = cursor.fetchone()
        
        if result:
            return result[0]
        
        # Insère le nouveau pays
        cursor.execute(
            "INSERT INTO countries (name, who_region) VALUES (?, ?)",
            (normalized_name, who_region)
        )
        return cursor.lastrowid

    def insert_or_get_indicator_type(self, conn: sqlite3.Connection, indicator_name: str) -> int:
        """Insère ou récupère l'ID d'un type d'indicateur"""
        cursor = conn.cursor()
        
        # Vérifie si le type d'indicateur existe
        cursor.execute("SELECT id FROM indicator_types WHERE name = ?", (indicator_name,))
        result = cursor.fetchone()
        
        if result:
            return result[0]
        
        # Insère le nouveau type d'indicateur
        cursor.execute(
            "INSERT INTO indicator_types (name) VALUES (?)",
            (indicator_name,)
        )
        return cursor.lastrowid

    def process_csv_file(self, file_path: str, filename: str) -> Dict[str, int]:
        """
        Traite un fichier CSV générique basé sur sa configuration
        
        Args:
            file_path: Chemin vers le fichier CSV
            filename: Nom du fichier pour récupérer la configuration
            
        Returns:
            Dictionnaire avec les statistiques de traitement
        """
        start_time = datetime.now()
        stats = {'processed': 0, 'success': 0, 'failed': 0}
        
        try:
            # Essaie plusieurs encodages pour les fichiers CSV
            encodings_to_try = ['utf-8', 'iso-8859-1', 'cp1252', 'utf-8-sig']
            df = None
            encoding_used = None
            
            for encoding in encodings_to_try:
                try:
                    df = pd.read_csv(file_path, encoding=encoding)
                    encoding_used = encoding
                    logger.info(f"Fichier {filename} chargé avec encodage {encoding}: {len(df)} lignes")
                    break
                except UnicodeDecodeError:
                    continue
            
            if df is None:
                raise Exception(f"Impossible de décoder le fichier {filename} avec les encodages supportés")
            
            # Nettoie les noms de colonnes
            df.columns = df.columns.str.strip()
            
            # Récupère la configuration pour ce fichier
            if filename not in self.csv_configs:
                logger.error(f"Configuration non trouvée pour {filename}")
                return stats
                
            config = self.csv_configs[filename]
            
            with sqlite3.connect(self.db_path) as conn:
                indicator_type_id = self.insert_or_get_indicator_type(conn, config['indicator_type'])
                
                for idx, row in df.iterrows():
                    stats['processed'] += 1
                    
                    try:
                        # Récupère ou insère le pays
                        country_id = self.insert_or_get_country(
                            conn, 
                            row['Country'], 
                            row.get('WHO Region', '')
                        )
                        
                        if not country_id:
                            logger.warning(f"Pays ignoré (nom invalide): {row['Country']}")
                            stats['failed'] += 1
                            continue
                        
                        # Récupère l'année si disponible
                        year = 2023  # Valeur par défaut
                        if 'additional_columns' in config and 'Year' in config['additional_columns']:
                            if 'Year' in df.columns and pd.notna(row['Year']):
                                try:
                                    year = int(row['Year'])
                                except (ValueError, TypeError):
                                    year = 2023
                        
                        # Traite chaque colonne de valeur
                        for value_col in config['value_columns']:
                            if value_col not in df.columns:
                                logger.warning(f"Colonne {value_col} non trouvée dans {filename}")
                                continue
                                
                            value_type = self.normalize_value_type(value_col)
                            raw_value = row[value_col]
                            
                            # Nettoie la valeur
                            main_val, conf_min, conf_max = self.clean_numeric_value(raw_value)
                            
                            # Récupère les valeurs de confiance séparées si disponibles
                            conf_cols = config['confidence_columns'].get(value_col, [])
                            conf_median = None
                            
                            if conf_cols:
                                try:
                                    if len(conf_cols) > 0 and conf_cols[0] in df.columns and pd.notna(row[conf_cols[0]]):
                                        conf_median = float(row[conf_cols[0]])
                                    if len(conf_cols) > 1 and conf_cols[1] in df.columns and pd.notna(row[conf_cols[1]]):
                                        conf_min = float(row[conf_cols[1]])
                                    if len(conf_cols) > 2 and conf_cols[2] in df.columns and pd.notna(row[conf_cols[2]]):
                                        conf_max = float(row[conf_cols[2]])
                                except (ValueError, TypeError):
                                    pass
                            
                            # Insère ou met à jour l'indicateur
                            cursor = conn.cursor()
                            cursor.execute("""
                                INSERT OR REPLACE INTO health_indicators 
                                (country_id, indicator_type_id, year, value_type, value, value_text, 
                                 confidence_min, confidence_max, confidence_median, source_file, raw_value_text)
                                VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
                            """, (
                                country_id, indicator_type_id, year, value_type,
                                main_val, str(raw_value) if main_val is None else None,
                                conf_min, conf_max, conf_median,
                                os.path.basename(file_path), str(raw_value)
                            ))
                        
                        stats['success'] += 1
                        
                    except Exception as e:
                        logger.error(f"Erreur lors du traitement de la ligne {idx} dans {filename}: {e}")
                        stats['failed'] += 1
                        continue
                
                # Enregistre les métadonnées de traitement
                duration = (datetime.now() - start_time).total_seconds()
                cursor = conn.cursor()
                cursor.execute("""
                    INSERT INTO etl_metadata 
                    (file_name, records_processed, records_success, records_failed, processing_duration_seconds)
                    VALUES (?, ?, ?, ?, ?)
                """, (
                    os.path.basename(file_path), stats['processed'], 
                    stats['success'], stats['failed'], duration
                ))
                
                logger.info(f"Traitement de {filename} terminé: {stats['success']}/{stats['processed']} lignes traitées avec succès")
                
        except Exception as e:
            logger.error(f"Erreur lors du traitement du fichier {file_path}: {e}")
            raise
            
        return stats
    
    def normalize_value_type(self, column_name: str) -> str:
        """
        Normalise les noms de colonnes en types de valeurs pour la base de données
        
        Args:
            column_name: Nom de la colonne original
            
        Returns:
            Type de valeur normalisé
        """
        # Mapping des noms de colonnes vers des types normalisés
        mappings = {
            'Received Antiretrovirals': 'received_antiretrovirals',
            'Needing antiretrovirals': 'needing_antiretrovirals', 
            'Percentage Recieved': 'percentage_received',
            'Reported number of people receiving ART': 'reported_receiving_art',
            'Estimated number of people living with HIV': 'estimated_living_with_hiv',
            'Estimated ART coverage among people living with HIV (%)': 'estimated_art_coverage_percent',
            'Count': 'count',
            'Reported number of children receiving ART': 'reported_children_receiving_art',
            'Estimated number of children needing ART based on WHO methods': 'estimated_children_needing_art',
            'Estimated ART coverage among children (%)': 'estimated_children_art_coverage_percent'
        }
        
        normalized = mappings.get(column_name)
        if normalized:
            return normalized
        
        # Si pas de mapping direct, normalise automatiquement
        normalized = column_name.lower()
        normalized = re.sub(r'[^\w\s]', '', normalized)  # Supprime la ponctuation
        normalized = re.sub(r'\s+', '_', normalized)     # Remplace espaces par underscores
        normalized = normalized[:100]  # Limite la longueur
        
        return normalized

    def process_prevention_mtct_file(self, file_path: str) -> Dict[str, int]:
        """
        Traite le fichier de prévention de transmission mère-enfant
        DEPRECATED: Utilise process_csv_file à la place
        
        Returns:
            Dictionnaire avec les statistiques de traitement
        """
        logger.warning("process_prevention_mtct_file est obsolète, utilisation de process_csv_file")
        return self.process_csv_file(file_path, 'prevention_of_mother_to_child_transmission_by_country_clean.csv')

    def validate_data_quality(self) -> Dict[str, Any]:
        """Valide la qualité des données après traitement"""
        
        with sqlite3.connect(self.db_path) as conn:
            cursor = conn.cursor()
            
            # Statistiques générales
            cursor.execute("SELECT COUNT(*) FROM countries")
            total_countries = cursor.fetchone()[0]
            
            cursor.execute("SELECT COUNT(*) FROM health_indicators")
            total_indicators = cursor.fetchone()[0]
            
            cursor.execute("SELECT COUNT(*) FROM health_indicators WHERE value IS NOT NULL")
            indicators_with_values = cursor.fetchone()[0]
            
            # Répartition par région WHO
            cursor.execute("""
                SELECT c.who_region, COUNT(DISTINCT c.id) as country_count,
                       COUNT(hi.id) as indicator_count
                FROM countries c
                LEFT JOIN health_indicators hi ON c.id = hi.country_id
                GROUP BY c.who_region
                ORDER BY country_count DESC
            """)
            region_stats = cursor.fetchall()
            
            # Pays avec le plus de données
            cursor.execute("""
                SELECT c.name, c.who_region, COUNT(hi.id) as indicator_count
                FROM countries c
                LEFT JOIN health_indicators hi ON c.id = hi.country_id
                WHERE hi.value IS NOT NULL
                GROUP BY c.id, c.name, c.who_region
                ORDER BY indicator_count DESC
                LIMIT 10
            """)
            top_countries = cursor.fetchall()
            
            validation_report = {
                'total_countries': total_countries,
                'total_indicators': total_indicators,
                'indicators_with_values': indicators_with_values,
                'data_completeness_rate': round(indicators_with_values / total_indicators * 100, 2) if total_indicators > 0 else 0,
                'region_distribution': region_stats,
                'top_countries_by_data': top_countries
            }
            
            logger.info(f"Validation terminée - {total_countries} pays, {total_indicators} indicateurs")
            return validation_report

    def run_etl_pipeline(self, specific_file: str = None):
        """
        Exécute le pipeline ETL complet
        
        Args:
            specific_file: Fichier spécifique à traiter (optionnel)
        """
        logger.info("=== Démarrage du pipeline ETL ===")
        
        # Crée le schéma de base
        self.create_normalized_schema()
        
        # Détermine les fichiers à traiter
        if specific_file:
            files_to_process = [specific_file]
        else:
            files_to_process = list(self.csv_configs.keys())
        
        total_stats = {'processed': 0, 'success': 0, 'failed': 0}
        
        for filename in files_to_process:
            file_path = os.path.join(self.source_dir, filename)
            
            if not os.path.exists(file_path):
                logger.warning(f"Fichier non trouvé: {file_path}")
                continue
                
            logger.info(f"Traitement du fichier: {filename}")
            
            try:
                # Utilise la fonction générique pour tous les fichiers
                stats = self.process_csv_file(file_path, filename)
                
                # Cumule les statistiques
                for key in total_stats:
                    total_stats[key] += stats[key]
                    
            except Exception as e:
                logger.error(f"Échec du traitement de {filename}: {e}")
                continue
        
        # Validation finale
        validation_report = self.validate_data_quality()
        
        # Génération du schéma SQL
        try:
            logger.info("Génération du schéma SQL...")
            schema_file = self.generate_sql_schema_file()
            logger.info(f"Schéma SQL généré: {schema_file}")
        except Exception as e:
            logger.error(f"Erreur lors de la génération du schéma SQL: {e}")
            schema_file = None
        
        # Génération des fichiers SQL par pays
        try:
            logger.info("Génération des fichiers SQL par pays...")
            country_sql_files = self.generate_country_sql_files()
            logger.info(f"Fichiers SQL par pays générés: {country_sql_files}")
        except Exception as e:
            logger.error(f"Erreur lors de la génération des fichiers SQL par pays: {e}")
            country_sql_files = []
        
        # Export vers fichiers CSV
        try:
            logger.info("Génération des fichiers CSV...")
            csv_files = self.export_to_csv_files()
            logger.info(f"Fichiers CSV générés: {len(csv_files)} fichiers")
        except Exception as e:
            logger.error(f"Erreur lors de la génération des fichiers CSV: {e}")
            csv_files = []
        
        # Affichage des statistiques finales
        try:
            stats = self.get_database_stats()
            print("\n" + "="*60)
            print(" RÉSUMÉ DU PIPELINE ETL")
            print("="*60)
            print(f" Base de données: {self.db_path}")
            print(f" Fichiers traités: {len(files_to_process)}")
            print(f"  Pays uniques: {stats.get('countries_count', 0)}")
            print(f" Types d'indicateurs: {stats.get('indicator_types_count', 0)}")
            print(f" Indicateurs totaux: {stats.get('total_indicators', 0)}")
            print(f" Avec valeurs numériques: {stats.get('indicators_with_numeric_values', 0)}")
            print(f" Avec intervalles confiance: {stats.get('indicators_with_confidence', 0)}")
            print(f" Période des données: {stats.get('data_year_range', 'N/A')}")
            if schema_file:
                print(f" Schéma SQL: {schema_file}")
            if country_sql_files:
                print(f" Fichiers SQL par pays: {len(country_sql_files)} fichiers générés")
                for country_file in country_sql_files:
                    print(f"   • {Path(country_file).name}")
            if csv_files:
                print(f" Fichiers CSV: {len(csv_files)} fichiers générés")
                for csv_file in csv_files:
                    print(f"   • {Path(csv_file).name}")
            print("="*60)
        except Exception as e:
            logger.error(f"Erreur lors de l'affichage des statistiques: {e}")
        
        logger.info("=== Pipeline ETL terminé ===")
        logger.info(f"Total: {total_stats['success']}/{total_stats['processed']} lignes traitées")
        logger.info(f"Taux de réussite: {round(total_stats['success']/total_stats['processed']*100, 2)}%" if total_stats['processed'] > 0 else "Aucune ligne traitée")
        
        return {
            'processing_stats': total_stats,
            'validation_report': validation_report,
            'schema_file': schema_file,
            'country_sql_files': country_sql_files,
            'csv_files': csv_files
        }

    def generate_sql_schema_file(self, output_path: str = None) -> str:
        """
        Génère et sauvegarde le schéma SQL complet de la base de données
        
        Args:
            output_path: Chemin de sortie pour le fichier SQL (optionnel)
            
        Returns:
            Le chemin du fichier SQL généré
        """
        if output_path is None:
            # Par défaut, sauvegarde dans DatasetClean dans le même répertoire que le script
            script_dir = Path(__file__).parent
            output_dir = script_dir / "DatasetClean"
            output_dir.mkdir(exist_ok=True)
            output_path = output_dir / "normalized_health_data_schema.sql"
        
        try:
            with sqlite3.connect(self.db_path) as conn:
                cursor = conn.cursor()
                
                # Récupère le schéma complet
                cursor.execute("""
                    SELECT sql FROM sqlite_master 
                    WHERE type IN ('table', 'index', 'view', 'trigger') 
                    AND name NOT LIKE 'sqlite_%'
                    ORDER BY type DESC, name
                """)
                
                schema_items = cursor.fetchall()
                
                # Construit le contenu du fichier SQL
                sql_content = [
                    "-- Schéma de base de données généré automatiquement",
                    f"-- Date de génération: {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}",
                    f"-- Base de données source: {self.db_path}",
                    "",
                    "-- Désactive les contraintes de clés étrangères temporairement",
                    "PRAGMA foreign_keys = OFF;",
                    ""
                ]
                
                # Ajoute chaque élément du schéma
                for item in schema_items:
                    if item[0]:  # Vérifie que le SQL n'est pas NULL
                        sql_content.append(f"{item[0]};")
                        sql_content.append("")
                
                # Réactive les contraintes
                sql_content.extend([
                    "-- Réactive les contraintes de clés étrangères",
                    "PRAGMA foreign_keys = ON;",
                    ""
                ])
                
                # Écrit le fichier
                with open(output_path, 'w', encoding='utf-8') as f:
                    f.write('\n'.join(sql_content))
                
                logger.info(f"Schéma SQL sauvegardé dans: {output_path}")
                return str(output_path)
                
        except Exception as e:
            logger.error(f"Erreur lors de la génération du schéma SQL: {e}")
            raise

    def print_sql_schema(self):
        """Affiche le schéma SQL complet de la base de données"""
        try:
            with sqlite3.connect(self.db_path) as conn:
                cursor = conn.cursor()
                
                print("\n" + "="*60)
                print("SCHÉMA SQL DE LA BASE DE DONNÉES NORMALISÉE")
                print("="*60)
                
                # Récupère et affiche les tables
                cursor.execute("""
                    SELECT name, sql FROM sqlite_master 
                    WHERE type = 'table' AND name NOT LIKE 'sqlite_%'
                    ORDER BY name
                """)
                
                tables = cursor.fetchall()
                
                for table_name, table_sql in tables:
                    print(f"\n-- Table: {table_name}")
                    print(f"{table_sql};")
                
                # Récupère et affiche les index
                cursor.execute("""
                    SELECT name, sql FROM sqlite_master 
                    WHERE type = 'index' AND name NOT LIKE 'sqlite_%'
                    ORDER BY name
                """)
                
                indexes = cursor.fetchall()
                
                if indexes:
                    print(f"\n-- Index")
                    for index_name, index_sql in indexes:
                        if index_sql:  # Certains index sont auto-créés et n'ont pas de SQL
                            print(f"{index_sql};")
                
                print("\n" + "="*60)
                
        except Exception as e:
            logger.error(f"Erreur lors de l'affichage du schéma: {e}")
            raise

    def get_database_stats(self) -> Dict[str, Any]:
        """Récupère les statistiques détaillées de la base de données"""
        try:
            with sqlite3.connect(self.db_path) as conn:
                cursor = conn.cursor()
                
                stats = {}
                
                # Statistiques par table
                cursor.execute("""
                    SELECT name FROM sqlite_master 
                    WHERE type = 'table' AND name NOT LIKE 'sqlite_%'
                """)
                
                tables = [row[0] for row in cursor.fetchall()]
                
                for table in tables:
                    cursor.execute(f"SELECT COUNT(*) FROM {table}")
                    count = cursor.fetchone()[0]
                    stats[f"{table}_count"] = count
                
                # Statistiques spécifiques aux indicateurs de santé
                cursor.execute("""
                    SELECT 
                        COUNT(*) as total_indicators,
                        COUNT(CASE WHEN value IS NOT NULL THEN 1 END) as with_numeric_values,
                        COUNT(CASE WHEN confidence_min IS NOT NULL THEN 1 END) as with_confidence_intervals,
                        COUNT(DISTINCT country_id) as unique_countries,
                        COUNT(DISTINCT indicator_type_id) as unique_indicator_types,
                        MIN(year) as earliest_year,
                        MAX(year) as latest_year
                    FROM health_indicators
                """)
                
                indicator_stats = cursor.fetchone()
                stats.update({
                    'total_indicators': indicator_stats[0],
                    'indicators_with_numeric_values': indicator_stats[1], 
                    'indicators_with_confidence': indicator_stats[2],
                    'unique_countries_with_data': indicator_stats[3],
                    'unique_indicator_types': indicator_stats[4],
                    'data_year_range': f"{indicator_stats[5]}-{indicator_stats[6]}" if indicator_stats[5] else "N/A"
                })
                
                return stats
                
        except Exception as e:
            logger.error(f"Erreur lors de la récupération des statistiques: {e}")
            return {}

    def generate_country_sql_files(self) -> List[str]:
        """
        Génère trois fichiers SQL séparés (un par pays: FR, US, CH) 
        avec les tables utilisateur et leurs données
        
        Returns:
            Liste des chemins des fichiers SQL générés
        """
        # Configuration des pays et leurs utilisateurs
        countries_config = {
            'fr': {
                'filename': 'schema_fr.sql',
                'users': [
                    {
                        'id': 1,
                        'username': 'adminfr',
                        'hashed_password': '$2b$12$lN4GPs6jcnuhJHfYSIuTZOvksHo1WQjUZ2sn8XBh4M9WslOhZ18qW',
                        'role': 'admin',
                        'rgpd_accept': 0
                    },
                    {
                        'id': 2,
                        'username': 'userfr',
                        'hashed_password': '$2b$12$3bIXd2nTT8zvU80IMEKlg.QvMmFdcxc/.2aM3WT0wPauN2e9tl1wu',
                        'role': 'user',
                        'rgpd_accept': 0
                    }
                ]
            },
            'us': {
                'filename': 'schema_us.sql',
                'users': [
                    {
                        'id': 1,
                        'username': 'adminus',
                        'hashed_password': '$2b$12$11T77aHFYoAbk0bsH4jWxO6XYYUobYdayWRhbg0iKkRTZtvE86IXy',
                        'role': 'admin',
                        'rgpd_accept': 0
                    },
                    {
                        'id': 2,
                        'username': 'userus',
                        'hashed_password': '$2b$12$0D55L95jWU./LJTg5HnLj.dit2Aw4mODM7YuWnxHg1ZH/goBVWbQi',
                        'role': 'user',
                        'rgpd_accept': 0
                    }
                ]
            },
            'ch': {
                'filename': 'schema_ch.sql',
                'users': [
                    {
                        'id': 1,
                        'username': 'adminch',
                        'hashed_password': '$2b$12$c4vPjcMlJOqQZ34wOKnDke8TtqMDLu.eTzH8JR9NeZlzjpTCxTr3G',
                        'role': 'admin',
                        'rgpd_accept': 0
                    },
                    {
                        'id': 2,
                        'username': 'userch',
                        'hashed_password': '$2b$12$joU1oJbGL9MMduJGEVWp4.Jt/Gd3s6PjAyrcc6a1USN7EvGx5kM8q',
                        'role': 'user',
                        'rgpd_accept': 0
                    }
                ]
            }
        }
        
        generated_files = []
        # Utiliser DatasetClean dans le même répertoire que le script
        script_dir = Path(__file__).parent
        output_dir = script_dir / "DatasetClean"
        output_dir.mkdir(exist_ok=True)
        
        try:
            # Récupère le schéma de base depuis la base de données normalisée
            with sqlite3.connect(self.db_path) as conn:
                cursor = conn.cursor()
                
                # Récupère le schéma des tables principales
                cursor.execute("""
                    SELECT sql FROM sqlite_master 
                    WHERE type = 'table' AND name NOT LIKE 'sqlite_%'
                    ORDER BY name
                """)
                
                base_tables = cursor.fetchall()
                
                # Récupère les index
                cursor.execute("""
                    SELECT sql FROM sqlite_master 
                    WHERE type = 'index' AND name NOT LIKE 'sqlite_%'
                    ORDER BY name
                """)
                
                base_indexes = cursor.fetchall()
            
            # Génère un fichier pour chaque pays
            for country_code, config in countries_config.items():
                file_path = output_dir / config['filename']
                
                sql_content = [
                    f"-- Schéma SQL pour {country_code.upper()}",
                    f"-- Généré automatiquement le {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}",
                    f"-- Base de données source: {self.db_path}",
                    "",
                    "-- Configuration pour PostgreSQL",
                    "SET statement_timeout = 0;",
                    "SET lock_timeout = 0;",
                    "SET idle_in_transaction_session_timeout = 0;",
                    "SET client_encoding = 'UTF8';",
                    "SET standard_conforming_strings = on;",
                    "SET check_function_bodies = false;",
                    "SET xmloption = content;",
                    "SET client_min_messages = warning;",
                    "SET row_security = off;",
                    "",
                    "-- Suppression des tables existantes (avec CASCADE pour gérer les dépendances)",
                    "DROP TABLE IF EXISTS health_indicators CASCADE;",
                    "DROP TABLE IF EXISTS countries CASCADE;",
                    "DROP TABLE IF EXISTS indicator_types CASCADE;",
                    "DROP TABLE IF EXISTS etl_metadata CASCADE;",
                    "DROP TABLE IF EXISTS utilisateur CASCADE;",
                    ""
                ]
                
                # Ajoute les tables de la base normalisée (adaptées pour PostgreSQL)
                for table_sql in base_tables:
                    if table_sql[0]:
                        # Adapte la syntaxe SQLite vers PostgreSQL
                        postgres_sql = self._adapt_sqlite_to_postgres(table_sql[0])
                        sql_content.append(postgres_sql + ";")
                        sql_content.append("")
                
                # Ajoute la table utilisateur
                sql_content.extend([
                    "-- Table utilisateur spécifique au pays",
                    "CREATE TABLE utilisateur (",
                    "    id SERIAL PRIMARY KEY,",
                    "    username VARCHAR(50) NOT NULL UNIQUE,",
                    "    hashed_password VARCHAR(255) NOT NULL,",
                    "    role VARCHAR(20) NOT NULL DEFAULT 'user',",
                    "    rgpd_accept INTEGER NOT NULL DEFAULT 0,",
                    "    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,",
                    "    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP",
                    ");",
                    ""
                ])
                
                # Ajoute les index (adaptés pour PostgreSQL)
                for index_sql in base_indexes:
                    if index_sql[0]:
                        postgres_index = self._adapt_sqlite_to_postgres(index_sql[0])
                        sql_content.append(postgres_index + ";")
                
                # Index pour la table utilisateur
                sql_content.extend([
                    "",
                    "-- Index pour la table utilisateur",
                    "CREATE INDEX idx_utilisateur_username ON utilisateur(username);",
                    "CREATE INDEX idx_utilisateur_role ON utilisateur(role);",
                    ""
                ])
                
                # Ajoute les données utilisateur
                sql_content.extend([
                    f"-- Données utilisateur pour {country_code.upper()}",
                ])
                
                for user in config['users']:
                    sql_content.append(
                        f"INSERT INTO utilisateur (id, username, hashed_password, role, rgpd_accept) "
                        f"VALUES ({user['id']}, '{user['username']}', '{user['hashed_password']}', "
                        f"'{user['role']}', {user['rgpd_accept']});"
                    )
                
                sql_content.extend([
                    "",
                    "-- Réinitialise la séquence de l'ID utilisateur",
                    "SELECT setval('utilisateur_id_seq', (SELECT MAX(id) FROM utilisateur));",
                    "",
                    f"-- Fin du schéma pour {country_code.upper()}"
                ])
                
                # Écrit le fichier
                with open(file_path, 'w', encoding='utf-8') as f:
                    f.write('\n'.join(sql_content))
                
                generated_files.append(str(file_path))
                logger.info(f"Fichier SQL {country_code.upper()} généré: {file_path}")
            
            return generated_files
            
        except Exception as e:
            logger.error(f"Erreur lors de la génération des fichiers SQL par pays: {e}")
            raise
    
    def _adapt_sqlite_to_postgres(self, sqlite_sql: str) -> str:
        """
        Adapte la syntaxe SQL SQLite vers PostgreSQL
        
        Args:
            sqlite_sql: Requête SQL SQLite
            
        Returns:
            Requête SQL adaptée pour PostgreSQL
        """
        # Remplacements de base
        postgres_sql = sqlite_sql
        
        # Remplace les types de données
        postgres_sql = postgres_sql.replace("INTEGER PRIMARY KEY AUTOINCREMENT", "SERIAL PRIMARY KEY")
        postgres_sql = postgres_sql.replace("AUTOINCREMENT", "")
        postgres_sql = postgres_sql.replace("DECIMAL(15,2)", "NUMERIC(15,2)")
        postgres_sql = postgres_sql.replace("TIMESTAMP DEFAULT CURRENT_TIMESTAMP", "TIMESTAMP DEFAULT CURRENT_TIMESTAMP")
        
        # Remplace les contraintes IF NOT EXISTS (pas supporté dans CREATE TABLE PostgreSQL)
        postgres_sql = postgres_sql.replace("CREATE TABLE IF NOT EXISTS", "CREATE TABLE")
        postgres_sql = postgres_sql.replace("CREATE INDEX IF NOT EXISTS", "CREATE INDEX")
        
        return postgres_sql

    def export_to_csv_files(self, output_dir: str = None) -> List[str]:
        """
        Exporte les données de la base SQLite vers des fichiers CSV dans DatasetClean
        
        Args:
            output_dir: Répertoire de sortie (par défaut ./DatasetClean)
            
        Returns:
            Liste des fichiers CSV créés
        """
        if output_dir is None:
            # Utiliser DatasetClean dans le même répertoire que le script
            script_dir = Path(__file__).parent
            output_dir = script_dir / "DatasetClean"
        
        output_dir = Path(output_dir)
        output_dir.mkdir(exist_ok=True)
        
        created_files = []
        
        logger.info("=== Export vers fichiers CSV ===")
        
        try:
            with sqlite3.connect(self.db_path) as conn:
                
                # 1. Export des pays
                logger.info("Export des pays...")
                countries_df = pd.read_sql_query("""
                    SELECT id, name as nom, who_region as region, iso_code 
                    FROM countries 
                    ORDER BY name
                """, conn)
                countries_file = output_dir / "pays_clean.csv"
                countries_df.to_csv(countries_file, index=False, encoding='utf-8', sep=';')
                created_files.append(str(countries_file))
                logger.info(f" {countries_file.name} créé ({len(countries_df)} pays)")
                
                # 2. Export des types d'indicateurs
                logger.info("Export des types d'indicateurs...")
                indicator_types_df = pd.read_sql_query("""
                    SELECT id, name as nom, description 
                    FROM indicator_types 
                    ORDER BY name
                """, conn)
                indicator_types_file = output_dir / "type_statistique_clean.csv"
                indicator_types_df.to_csv(indicator_types_file, index=False, encoding='utf-8', sep=';')
                created_files.append(str(indicator_types_file))
                logger.info(f" {indicator_types_file.name} créé ({len(indicator_types_df)} types)")
                
                # 3. Export par type d'indicateur (fichiers séparés)
                indicator_mappings = {
                    'People living with HIV': 'table_population_hiv.csv',
                    'ART Coverage': 'table_traitement.csv', 
                    'Prevention of Mother-to-Child Transmission': 'table_transmission_mere_enfant.csv',
                    'HIV-related Deaths': 'table_mortalite.csv',
                    'AIDS Deaths': 'table_mortalite.csv',
                    'HIV Cases Adults 15-49': 'table_cas_adultes.csv',
                    'ART Pediatric Coverage': 'table_traitement_pediatrique.csv'
                }
                
                for indicator_type, filename in indicator_mappings.items():
                    logger.info(f"Export {indicator_type}...")
                    
                    # Requête adaptée selon le type d'indicateur
                    query = """
                        SELECT 
                            hi.id,
                            hi.country_id as id_pays,
                            c.name as pays,
                            hi.year as annee,
                            hi.value as valeur,
                            hi.value_type as type_valeur,
                            hi.confidence_min as confiance_min,
                            hi.confidence_max as confiance_max,
                            hi.confidence_median as confiance_median,
                            hi.data_quality as qualite_donnees,
                            hi.source_file as fichier_source
                        FROM health_indicators hi
                        JOIN countries c ON hi.country_id = c.id
                        JOIN indicator_types it ON hi.indicator_type_id = it.id
                        WHERE it.name LIKE ?
                        ORDER BY c.name, hi.year
                    """
                    
                    df = pd.read_sql_query(query, conn, params=[f"%{indicator_type}%"])
                    
                    if len(df) > 0:
                        output_file = output_dir / filename
                        df.to_csv(output_file, index=False, encoding='utf-8', sep=';')
                        created_files.append(str(output_file))
                        logger.info(f" {filename} créé ({len(df)} enregistrements)")
                    else:
                        logger.warning(f" Aucune donnée trouvée pour {indicator_type}")
                
                # 4. Export global des statistiques
                logger.info("Export des statistiques globales...")
                all_stats_df = pd.read_sql_query("""
                    SELECT 
                        hi.id,
                        hi.country_id as id_pays,
                        c.name as pays,
                        c.who_region as region,
                        hi.indicator_type_id as id_type_statistique,
                        it.name as type_statistique,
                        hi.year as annee,
                        hi.value as valeur,
                        hi.value_type as type_valeur,
                        hi.value_text as valeur_texte,
                        hi.confidence_min as confiance_min,
                        hi.confidence_max as confiance_max,
                        hi.confidence_median as confiance_median,
                        hi.data_quality as qualite_donnees,
                        hi.source_file as fichier_source,
                        hi.created_at as date_creation
                    FROM health_indicators hi
                    JOIN countries c ON hi.country_id = c.id
                    JOIN indicator_types it ON hi.indicator_type_id = it.id
                    ORDER BY c.name, it.name, hi.year
                """, conn)
                
                all_stats_file = output_dir / "table_statistique.csv"
                all_stats_df.to_csv(all_stats_file, index=False, encoding='utf-8', sep=';')
                created_files.append(str(all_stats_file))
                logger.info(f" {all_stats_file.name} créé ({len(all_stats_df)} enregistrements)")
                
                # 5. Export des unités (valeurs distinctes)
                logger.info("Export des types d'unités...")
                units_df = pd.read_sql_query("""
                    SELECT DISTINCT 
                        ROW_NUMBER() OVER (ORDER BY value_type) as id,
                        value_type as nom,
                        value_type as description
                    FROM health_indicators 
                    WHERE value_type IS NOT NULL
                    ORDER BY value_type
                """, conn)
                
                units_file = output_dir / "unite_clean.csv"
                units_df.to_csv(units_file, index=False, encoding='utf-8', sep=';')
                created_files.append(str(units_file))
                logger.info(f" {units_file.name} créé ({len(units_df)} unités)")
                
        except Exception as e:
            logger.error(f"Erreur lors de l'export CSV: {e}")
            raise
        
        logger.info(f"=== Export CSV terminé - {len(created_files)} fichiers créés ===")
        return created_files

def main():
    """Point d'entrée principal"""
    
    # Détermine les chemins relatifs au script
    script_dir = Path(__file__).parent
    source_dir = script_dir / "SourceData"  # Dans le même répertoire que le script
    db_path = script_dir / "DatasetClean/normalized_health_data.db"  # Dans DatasetClean
    
    # Initialise et exécute l'ETL
    etl = HealthDataETL(
        source_dir=str(source_dir),
        db_path=str(db_path)
    )
    
    # Exécute le pipeline pour tous les fichiers configurés
    results = etl.run_etl_pipeline()
    
    # Affiche un résumé
    print("\n=== RÉSUMÉ DU TRAITEMENT ETL ===")
    print(f"Lignes traitées: {results['processing_stats']['processed']}")
    print(f"Succès: {results['processing_stats']['success']}")
    print(f"Échecs: {results['processing_stats']['failed']}")
    print(f"Pays dans la base: {results['validation_report']['total_countries']}")
    print(f"Indicateurs créés: {results['validation_report']['total_indicators']}")
    print(f"Taux de complétude: {results['validation_report']['data_completeness_rate']}%")
    
    print("\nRépartition par région WHO:")
    for region, country_count, indicator_count in results['validation_report']['region_distribution']:
        print(f"  {region}: {country_count} pays, {indicator_count} indicateurs")
    
    # Affiche le schéma SQL généré
    if results.get('schema_file'):
        print(f"\n Schéma SQL disponible dans: {results['schema_file']}")
    
    # Affiche les fichiers CSV générés
    if results.get('csv_files'):
        print(f"\n Fichiers CSV générés dans DatasetClean:")
        for csv_file in results['csv_files']:
            file_name = Path(csv_file).name
            file_size = Path(csv_file).stat().st_size / 1024  # en KB
            print(f"  • {file_name} ({file_size:.1f} KB)")
        
        # Demande à l'utilisateur s'il veut voir le schéma
        try:
            choice = input("\nVoulez-vous afficher le schéma SQL complet ? (o/n): ").lower().strip()
            if choice in ['o', 'oui', 'y', 'yes']:
                etl.print_sql_schema()
        except (KeyboardInterrupt, EOFError):
            print("\nFin du programme.")
    
    print("\n ETL terminé avec succès!")

if __name__ == "__main__":
    main()
