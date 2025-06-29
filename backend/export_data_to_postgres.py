#!/usr/bin/env python3
"""
Script pour exporter les données de SQLite vers PostgreSQL par région
"""
import sqlite3
import os

def export_data_to_sql(region='fr'):
    """Ajoute les données au fichier schema existant pour une région donnée"""
    
    # Détecter le répertoire de base (où se trouve ce script)
    script_dir = os.path.dirname(os.path.abspath(__file__))
    
    # Utiliser la base normalisée qui a la bonne structure
    sqlite_db = os.path.join(script_dir, 'normalized_health_data.db')
    if not os.path.exists(sqlite_db):
        print(f"❌ Erreur: {sqlite_db} n'existe pas!")
        return
    
    conn = sqlite3.connect(sqlite_db)
    cursor = conn.cursor()
    
    # Vérifier que les tables existent
    cursor.execute("SELECT name FROM sqlite_master WHERE type='table'")
    tables = [row[0] for row in cursor.fetchall()]
    print(f"📋 Tables trouvées: {tables}")
    
    if 'indicator_types' not in tables:
        print(f"❌ Erreur: Table 'indicator_types' non trouvée dans {sqlite_db}")
        conn.close()
        return
    
    # Fichier schema existant où ajouter les données
    if region == 'fr':
        schema_file = os.path.join(script_dir, '../essaidocker/initdb/schema_fr.sql')
    elif region == 'us':
        schema_file = os.path.join(script_dir, '../essaidocker/init_us/schema_us.sql')
    elif region == 'ch':
        schema_file = os.path.join(script_dir, '../essaidocker/init_ch/schema_ch.sql')
    else:
        print(f"❌ Région {region} non supportée!")
        return
    
    # Normaliser le chemin
    schema_file = os.path.abspath(schema_file)
    
    # Vérifier que le fichier schema existe
    if not os.path.exists(schema_file):
        print(f"❌ Erreur: {schema_file} n'existe pas!")
        return
    
    # Ajouter les données au fichier schema existant (en mode append)
    with open(schema_file, 'a', encoding='utf-8') as f:
        f.write(f"\n\n-- === DONNÉES IMPORTÉES DEPUIS {os.path.basename(sqlite_db).upper()} ===\n")
        f.write(f"-- Généré automatiquement le {__import__('datetime').datetime.now().strftime('%Y-%m-%d %H:%M:%S')}\n\n")
        
        # Export des types d'indicateurs
        f.write("-- Insertion des types d'indicateurs\n")
        cursor.execute("SELECT id, name, description, unit FROM indicator_types ORDER BY id")
        for row in cursor.fetchall():
            id_val, name, desc, unit = row
            # Échapper les apostrophes
            name = name.replace("'", "''") if name else ''
            desc = desc.replace("'", "''") if desc else None
            unit = unit.replace("'", "''") if unit else None
            
            desc_sql = f"'{desc}'" if desc else 'NULL'
            unit_sql = f"'{unit}'" if unit else 'NULL'
            
            f.write(f"INSERT INTO indicator_types (id, name, description, unit) VALUES ({id_val}, '{name}', {desc_sql}, {unit_sql});\n")
        
        # Export des pays
        f.write("\n-- Insertion des pays\n")
        cursor.execute("SELECT id, name, who_region, iso_code FROM countries ORDER BY id")
        for row in cursor.fetchall():
            id_val, name, region, iso = row
            # Échapper les apostrophes
            name = name.replace("'", "''") if name else ''
            region = region.replace("'", "''") if region else None
            iso = iso.replace("'", "''") if iso else None
            
            region_sql = f"'{region}'" if region else 'NULL'
            iso_sql = f"'{iso}'" if iso else 'NULL'
            
            f.write(f"INSERT INTO countries (id, name, who_region, iso_code) VALUES ({id_val}, '{name}', {region_sql}, {iso_sql});\n")
        
        # Export des indicateurs de santé (TOUTES les données, sans distinction de région)
        f.write(f"\n-- Insertion de TOUS les indicateurs de santé (données identiques pour toutes les régions)\n")
        
        cursor.execute("""
            SELECT hi.id, hi.country_id, hi.indicator_type_id, hi.year, hi.value_type, hi.value, hi.value_text, 
                   hi.confidence_min, hi.confidence_max, hi.confidence_median, hi.data_quality, hi.source_file
            FROM health_indicators hi
            WHERE hi.value IS NOT NULL
            ORDER BY hi.id
        """)
        
        for row in cursor.fetchall():
            id_val, country_id, indicator_type_id, year, value_type, value, value_text, conf_min, conf_max, conf_median, quality, source = row
            
            # Échapper les apostrophes pour les chaînes
            value_type = value_type.replace("'", "''") if value_type else ''
            value_text = value_text.replace("'", "''") if value_text else None
            quality = quality.replace("'", "''") if quality else 'good'
            source = source.replace("'", "''") if source else None
            
            value_text_sql = f"'{value_text}'" if value_text else 'NULL'
            conf_min_sql = str(conf_min) if conf_min is not None else 'NULL'
            conf_max_sql = str(conf_max) if conf_max is not None else 'NULL'
            conf_median_sql = str(conf_median) if conf_median is not None else 'NULL'
            source_sql = f"'{source}'" if source else 'NULL'
            value_sql = str(value) if value is not None else 'NULL'
            
            f.write(f"""INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES ({id_val}, {country_id}, {indicator_type_id}, {year}, '{value_type}', {value_sql}, {value_text_sql}, {conf_min_sql}, {conf_max_sql}, {conf_median_sql}, '{quality}', {source_sql});
""")
        
        # Réinitialiser les séquences
        f.write("""
-- Réinitialisation des séquences
SELECT setval('countries_id_seq', (SELECT MAX(id) FROM countries));
SELECT setval('indicator_types_id_seq', (SELECT MAX(id) FROM indicator_types));
SELECT setval('health_indicators_id_seq', (SELECT MAX(id) FROM health_indicators));
""")
    
    conn.close()
    print(f"✅ Données {region.upper()} ajoutées à {schema_file}")
    
    # Statistiques
    conn = sqlite3.connect(sqlite_db)
    cursor = conn.cursor()
    
    cursor.execute("SELECT COUNT(*) FROM countries")
    countries_count = cursor.fetchone()[0]
    
    cursor.execute("SELECT COUNT(*) FROM indicator_types")
    types_count = cursor.fetchone()[0]
    
    cursor.execute("SELECT COUNT(*) FROM health_indicators WHERE value IS NOT NULL")
    indicators_count = cursor.fetchone()[0]
    
    print(f"📊 Statistiques {region.upper()}:")
    print(f"   - Pays: {countries_count}")
    print(f"   - Types d'indicateurs: {types_count}")
    print(f"   - Indicateurs de santé (avec valeurs): {indicators_count}")
    
    conn.close()

def export_all_regions():
    """Exporte les données pour toutes les régions"""
    regions = ['fr', 'us', 'ch']
    
    for region in regions:
        print(f"\n🔄 Export des données pour {region.upper()}...")
        export_data_to_sql(region)

if __name__ == "__main__":
    export_all_regions()
