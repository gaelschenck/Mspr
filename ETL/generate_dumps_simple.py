#!/usr/bin/env python3
"""
Script simplifié pour générer les dumps PostgreSQL
"""

import sqlite3
import os
from pathlib import Path

def get_postgresql_schema():
    """Retourne le schéma PostgreSQL pour toutes les tables"""
    return """-- Schema PostgreSQL généré automatiquement

-- Suppression des tables existantes
DROP TABLE IF EXISTS statistique CASCADE;
DROP TABLE IF EXISTS traitement CASCADE;
DROP TABLE IF EXISTS transmission_mere_enfant CASCADE;
DROP TABLE IF EXISTS mortalite CASCADE;
DROP TABLE IF EXISTS population_hiv CASCADE;
DROP TABLE IF EXISTS pays CASCADE;
DROP TABLE IF EXISTS unite CASCADE;
DROP TABLE IF EXISTS type_statistique CASCADE;
DROP TABLE IF EXISTS type_traitement CASCADE;
DROP TABLE IF EXISTS utilisateur CASCADE;

-- Table pays
CREATE TABLE pays (
    id_pays SERIAL PRIMARY KEY,
    pays VARCHAR(100) NOT NULL,
    region_who VARCHAR(100)
);

-- Table unite
CREATE TABLE unite (
    id_unite SERIAL PRIMARY KEY,
    unite VARCHAR(50) NOT NULL
);

-- Table type_statistique
CREATE TABLE type_statistique (
    id_type_statistique SERIAL PRIMARY KEY,
    nom_type_statistique VARCHAR(100) NOT NULL
);

-- Table type_traitement
CREATE TABLE type_traitement (
    id_type_traitement SERIAL PRIMARY KEY,
    nom_type_traitement VARCHAR(100) NOT NULL
);

-- Table population_hiv
CREATE TABLE population_hiv (
    id SERIAL PRIMARY KEY,
    id_pays INTEGER NOT NULL,
    annee INTEGER NOT NULL,
    valeur DECIMAL(10,2) NOT NULL,
    id_unite INTEGER,
    FOREIGN KEY (id_pays) REFERENCES pays(id_pays),
    FOREIGN KEY (id_unite) REFERENCES unite(id_unite)
);

-- Table mortalite
CREATE TABLE mortalite (
    id SERIAL PRIMARY KEY,
    id_pays INTEGER NOT NULL,
    annee INTEGER NOT NULL,
    valeur DECIMAL(10,2) NOT NULL,
    id_unite INTEGER,
    FOREIGN KEY (id_pays) REFERENCES pays(id_pays),
    FOREIGN KEY (id_unite) REFERENCES unite(id_unite)
);

-- Table transmission_mere_enfant
CREATE TABLE transmission_mere_enfant (
    id_transmission SERIAL PRIMARY KEY,
    id_pays INTEGER NOT NULL,
    besoin_arv_min DECIMAL(10,2) NOT NULL,
    besoin_arv_median DECIMAL(10,2) NOT NULL,
    besoin_arv_max DECIMAL(10,2) NOT NULL,
    pourcentage_recu_min DECIMAL(5,2) NOT NULL,
    pourcentage_recu_median DECIMAL(5,2) NOT NULL,
    pourcentage_recu_max DECIMAL(5,2) NOT NULL,
    FOREIGN KEY (id_pays) REFERENCES pays(id_pays)
);

-- Table traitement
CREATE TABLE traitement (
    id SERIAL PRIMARY KEY,
    id_pays INTEGER NOT NULL,
    valeur DECIMAL(10,2) NOT NULL,
    id_unite INTEGER,
    id_type_traitement INTEGER NOT NULL,
    FOREIGN KEY (id_pays) REFERENCES pays(id_pays),
    FOREIGN KEY (id_unite) REFERENCES unite(id_unite),
    FOREIGN KEY (id_type_traitement) REFERENCES type_traitement(id_type_traitement)
);

-- Table statistique
CREATE TABLE statistique (
    id SERIAL PRIMARY KEY,
    id_pays INTEGER NOT NULL,
    annee INTEGER NOT NULL,
    valeur DECIMAL(10,2) NOT NULL,
    id_unite INTEGER,
    id_type_statistique INTEGER NOT NULL,
    FOREIGN KEY (id_pays) REFERENCES pays(id_pays),
    FOREIGN KEY (id_unite) REFERENCES unite(id_unite),
    FOREIGN KEY (id_type_statistique) REFERENCES type_statistique(id_type_statistique)
);

-- Table utilisateur
CREATE TABLE utilisateur (
    id SERIAL PRIMARY KEY,
    username VARCHAR UNIQUE NOT NULL,
    hashed_password VARCHAR NOT NULL,
    role VARCHAR NOT NULL,
    rgpd_accept INTEGER NOT NULL DEFAULT 0
);

"""

def export_table_data(cursor, table_name):
    """Exporte les données d'une table au format INSERT PostgreSQL"""
    try:
        cursor.execute(f"SELECT * FROM {table_name}")
        rows = cursor.fetchall()
        
        if not rows:
            return f"\n-- Aucune donnée dans {table_name}\n"
        
        # Obtenir les noms de colonnes
        cursor.execute(f"PRAGMA table_info({table_name})")
        columns = [column[1] for column in cursor.fetchall()]
        
        inserts = [f"\n-- Données pour {table_name}"]
        
        for row in rows:
            formatted_values = []
            for value in row:
                if value is None:
                    formatted_values.append("NULL")
                elif isinstance(value, str):
                    escaped_value = value.replace("'", "''")
                    formatted_values.append(f"'{escaped_value}'")
                else:
                    formatted_values.append(str(value))
            
            values_str = ", ".join(formatted_values)
            columns_str = ", ".join(columns)
            inserts.append(f"INSERT INTO {table_name} ({columns_str}) VALUES ({values_str});")
        
        return "\n".join(inserts) + "\n"
    except Exception as e:
        return f"\n-- Erreur lors de l'export de {table_name}: {e}\n"

def generate_dump(sqlite_path, output_path, region):
    """Génère un dump PostgreSQL"""
    print(f"Génération du dump {region}...")
    
    try:
        conn = sqlite3.connect(sqlite_path)
        cursor = conn.cursor()
        
        # Commencer le dump
        content = f"""-- Dump PostgreSQL pour la région {region}
-- Généré à partir de {os.path.basename(sqlite_path)}

{get_postgresql_schema()}
"""
        
        # Exporter les données dans l'ordre des dépendances
        tables = [
            "pays", "unite", "type_statistique", "type_traitement",
            "population_hiv", "mortalite", "transmission_mere_enfant",
            "traitement", "statistique", "utilisateur"
        ]
        
        for table in tables:
            content += export_table_data(cursor, table)
        
        # Finaliser
        content += """
-- Réinitialisation des séquences
SELECT setval('pays_id_pays_seq', (SELECT COALESCE(MAX(id_pays), 1) FROM pays));
SELECT setval('unite_id_unite_seq', (SELECT COALESCE(MAX(id_unite), 1) FROM unite));
SELECT setval('type_statistique_id_type_statistique_seq', (SELECT COALESCE(MAX(id_type_statistique), 1) FROM type_statistique));
SELECT setval('type_traitement_id_type_traitement_seq', (SELECT COALESCE(MAX(id_type_traitement), 1) FROM type_traitement));
SELECT setval('population_hiv_id_seq', (SELECT COALESCE(MAX(id), 1) FROM population_hiv));
SELECT setval('mortalite_id_seq', (SELECT COALESCE(MAX(id), 1) FROM mortalite));
SELECT setval('transmission_mere_enfant_id_transmission_seq', (SELECT COALESCE(MAX(id_transmission), 1) FROM transmission_mere_enfant));
SELECT setval('traitement_id_seq', (SELECT COALESCE(MAX(id), 1) FROM traitement));
SELECT setval('statistique_id_seq', (SELECT COALESCE(MAX(id), 1) FROM statistique));
SELECT setval('utilisateur_id_seq', (SELECT COALESCE(MAX(id), 1) FROM utilisateur));
"""
        
        # Écrire le fichier
        os.makedirs(os.path.dirname(output_path), exist_ok=True)
        with open(output_path, 'w', encoding='utf-8') as f:
            f.write(content)
        
        conn.close()
        print(f"✅ {output_path} généré avec succès")
        return True
        
    except Exception as e:
        print(f"❌ Erreur: {e}")
        return False

def main():
    """Fonction principale"""
    base_dir = Path(__file__).parent.parent
    
    configs = [
        ("backend/db-fr.db", "essaidocker/initdb/dump.sql", "FR"),
        ("backend/db-us.db", "essaidocker/init_us/dumpus.sql", "US"),
        ("backend/db-ch.db", "essaidocker/init_ch/dumpch.sql", "CH")
    ]
    
    success = 0
    for sqlite_rel, output_rel, region in configs:
        sqlite_path = base_dir / sqlite_rel
        output_path = base_dir / output_rel
        
        if generate_dump(str(sqlite_path), str(output_path), region):
            success += 1
    
    print(f"\n🎉 {success}/{len(configs)} dumps générés avec succès!")

if __name__ == "__main__":
    main()
