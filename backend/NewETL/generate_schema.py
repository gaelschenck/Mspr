#!/usr/bin/env python3
"""
Script pour générer le fichier SQL du schéma de la base de données normalisée.
"""

import sqlite3
import logging
from pathlib import Path

# Configuration du logging
logging.basicConfig(
    level=logging.INFO,
    format='%(asctime)s - %(levelname)s - %(message)s'
)
logger = logging.getLogger(__name__)

def generate_schema_sql():
    """Génère le fichier SQL contenant le schéma complet de la base de données."""
    
    db_path = Path("normalized_health_data.db")
    schema_path = Path("normalized_health_data_schema.sql")
    
    if not db_path.exists():
        logger.error(f"Base de données non trouvée: {db_path}")
        return False
    
    try:
        # Connexion à la base de données
        conn = sqlite3.connect(db_path)
        cursor = conn.cursor()
        
        # Récupération de toutes les tables
        cursor.execute("SELECT name FROM sqlite_master WHERE type='table' ORDER BY name;")
        tables = cursor.fetchall()
        
        schema_content = []
        schema_content.append("-- =======================================================")
        schema_content.append("-- SCHÉMA DE LA BASE DE DONNÉES NORMALISÉE SANTÉ/VIH")
        schema_content.append("-- =======================================================")
        schema_content.append("-- Généré automatiquement par generate_schema.py")
        schema_content.append("-- Base de données: normalized_health_data.db")
        schema_content.append("-- Date de génération: " + str(Path(__file__).stat().st_mtime))
        schema_content.append("")
        
        for table_name in tables:
            table_name = table_name[0]
            
            # Récupération du schéma de création de la table
            cursor.execute(f"SELECT sql FROM sqlite_master WHERE type='table' AND name='{table_name}';")
            create_table_sql = cursor.fetchone()
            
            if create_table_sql:
                schema_content.append(f"-- Table: {table_name}")
                schema_content.append(create_table_sql[0] + ";")
                schema_content.append("")
            
            # Récupération des index pour cette table
            cursor.execute(f"SELECT sql FROM sqlite_master WHERE type='index' AND tbl_name='{table_name}' AND sql IS NOT NULL;")
            indexes = cursor.fetchall()
            
            for index_sql in indexes:
                if index_sql[0]:
                    schema_content.append(index_sql[0] + ";")
            
            if indexes:
                schema_content.append("")
        
        # Ajout des statistiques de la base
        schema_content.append("-- =======================================================")
        schema_content.append("-- STATISTIQUES DE LA BASE DE DONNÉES")
        schema_content.append("-- =======================================================")
        
        for table_name in tables:
            table_name = table_name[0]
            cursor.execute(f"SELECT COUNT(*) FROM {table_name};")
            count = cursor.fetchone()[0]
            schema_content.append(f"-- Table {table_name}: {count:,} enregistrements")
        
        schema_content.append("")
        schema_content.append("-- =======================================================")
        schema_content.append("-- EXEMPLES DE REQUÊTES")
        schema_content.append("-- =======================================================")
        
        example_queries = [
            "-- Récupérer tous les pays avec leur région WHO:",
            "SELECT country_name, who_region FROM countries ORDER BY who_region, country_name;",
            "",
            "-- Récupérer les indicateurs de mortalité pour la France en 2020:",
            "SELECT hi.year, it.name, hi.value, hi.unit",
            "FROM health_indicators hi",
            "JOIN countries c ON hi.country_id = c.id",
            "JOIN indicator_types it ON hi.indicator_type_id = it.id",
            "WHERE c.country_name = 'France' AND hi.year = 2020",
            "  AND it.category = 'mortality'",
            "ORDER BY it.name;",
            "",
            "-- Récupérer les données de traitement pour tous les pays en 2021:",
            "SELECT c.country_name, it.name, hi.value, hi.unit",
            "FROM health_indicators hi",
            "JOIN countries c ON hi.country_id = c.id", 
            "JOIN indicator_types it ON hi.indicator_type_id = it.id",
            "WHERE hi.year = 2021 AND it.category = 'treatment'",
            "ORDER BY c.country_name, it.name;",
            "",
            "-- Obtenir les statistiques par région WHO:",
            "SELECT c.who_region, COUNT(DISTINCT c.id) as nb_pays,",
            "       COUNT(hi.id) as nb_indicateurs,",
            "       AVG(hi.value) as valeur_moyenne",
            "FROM countries c",
            "LEFT JOIN health_indicators hi ON c.id = hi.country_id",
            "GROUP BY c.who_region",
            "ORDER BY nb_pays DESC;"
        ]
        
        schema_content.extend(example_queries)
        
        # Écriture du fichier
        with open(schema_path, 'w', encoding='utf-8') as f:
            f.write('\n'.join(schema_content))
        
        conn.close()
        
        logger.info(f"Schéma SQL généré avec succès: {schema_path}")
        logger.info(f"Nombre de tables: {len(tables)}")
        
        return True
        
    except Exception as e:
        logger.error(f"Erreur lors de la génération du schéma: {e}")
        return False

if __name__ == "__main__":
    success = generate_schema_sql()
    if success:
        print(" Schéma SQL généré avec succès!")
    else:
        print(" Erreur lors de la génération du schéma")
