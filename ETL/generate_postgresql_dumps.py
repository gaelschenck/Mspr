#!/usr/bin/env python3
"""
Script pour générer les dumps PostgreSQL complets à partir des bases SQLite
Génère dump.sql, dumpus.sql, dumpch.sql avec structure + données + utilisateurs
"""

import sqlite3
import os
import sys
from pathlib import Path

# Ajouter le répertoire parent au PYTHONPATH pour importer les modèles
current_dir = Path(__file__).parent
backend_dir = current_dir.parent / "backend"
sys.path.append(str(backend_dir))

def get_postgresql_schema():
    """Retourne le schéma PostgreSQL pour toutes les tables"""
    return """-- Schema PostgreSQL genere automatiquement a partir des modeles SQLAlchemy

-- Suppression des tables existantes (avec CASCADE pour gerer les dependances)
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

-- Index pour optimiser les performances
CREATE INDEX idx_pays_pays ON pays(pays);
CREATE INDEX idx_population_hiv_pays ON population_hiv(id_pays);
CREATE INDEX idx_population_hiv_annee ON population_hiv(annee);
CREATE INDEX idx_mortalite_pays ON mortalite(id_pays);
CREATE INDEX idx_mortalite_annee ON mortalite(annee);
CREATE INDEX idx_transmission_pays ON transmission_mere_enfant(id_pays);
CREATE INDEX idx_traitement_pays ON traitement(id_pays);
CREATE INDEX idx_statistique_pays ON statistique(id_pays);
CREATE INDEX idx_statistique_annee ON statistique(annee);
CREATE INDEX idx_utilisateur_username ON utilisateur(username);

"""

def export_table_data(cursor, table_name, columns):
    """Exporte les données d'une table au format INSERT PostgreSQL"""
    cursor.execute(f"SELECT * FROM {table_name}")
    rows = cursor.fetchall()
    
    if not rows:
        return f"\n-- Aucune donnee dans la table {table_name}\n"
    
    inserts = [f"\n-- Donnees pour la table {table_name}"]
    
    for row in rows:
        # Formater les valeurs pour PostgreSQL
        formatted_values = []
        for value in row:
            if value is None:
                formatted_values.append("NULL")
            elif isinstance(value, str):
                # Echapper les apostrophes pour PostgreSQL
                escaped_value = value.replace("'", "''")
                formatted_values.append(f"'{escaped_value}'")
            else:
                formatted_values.append(str(value))
        
        values_str = ", ".join(formatted_values)
        columns_str = ", ".join(columns)
        inserts.append(f"INSERT INTO {table_name} ({columns_str}) VALUES ({values_str});")
    
    return "\n".join(inserts) + "\n"

def generate_postgresql_dump(sqlite_db_path, output_file_path, region_suffix=""):
    """Génère un dump PostgreSQL complet à partir d'une base SQLite"""
    
    if not os.path.exists(sqlite_db_path):
        print(f"Erreur: Base SQLite non trouvee: {sqlite_db_path}")
        return False
    
    try:
        # Connexion à la base SQLite
        conn = sqlite3.connect(sqlite_db_path)
        cursor = conn.cursor()
        
        print(f"Connexion etablie a {sqlite_db_path}")
        
        # Commencer le dump avec le schéma
        dump_content = [
            f"-- Dump PostgreSQL pour la base {region_suffix}",
            f"-- Genere automatiquement a partir de {os.path.basename(sqlite_db_path)}",
            "",
            get_postgresql_schema()
        ]
        
        print("Schema ajoute, export des donnees...")
        
        # Tables de référence d'abord (sans clés étrangères)
        dump_content.append(export_table_data(cursor, "pays", ["id_pays", "pays", "region_who"]))
        dump_content.append(export_table_data(cursor, "unite", ["id_unite", "unite"]))
        dump_content.append(export_table_data(cursor, "type_statistique", ["id_type_statistique", "nom_type_statistique"]))
        dump_content.append(export_table_data(cursor, "type_traitement", ["id_type_traitement", "nom_type_traitement"]))
        
        print("Tables de reference exportees...")
        
        # Tables avec clés étrangères
        dump_content.append(export_table_data(cursor, "population_hiv", ["id", "id_pays", "annee", "valeur", "id_unite"]))
        dump_content.append(export_table_data(cursor, "mortalite", ["id", "id_pays", "annee", "valeur", "id_unite"]))
        dump_content.append(export_table_data(cursor, "transmission_mere_enfant", [
            "id_transmission", "id_pays", "besoin_arv_min", "besoin_arv_median", "besoin_arv_max",
            "pourcentage_recu_min", "pourcentage_recu_median", "pourcentage_recu_max"
        ]))
        dump_content.append(export_table_data(cursor, "traitement", ["id", "id_pays", "valeur", "id_unite", "id_type_traitement"]))
        dump_content.append(export_table_data(cursor, "statistique", ["id", "id_pays", "annee", "valeur", "id_unite", "id_type_statistique"]))
        
        print("Tables principales exportees...")
        
        # Table utilisateur
        dump_content.append(export_table_data(cursor, "utilisateur", ["id", "username", "hashed_password", "role", "rgpd_accept"]))
        
        print("Table utilisateur exportee...")
        
        # Réinitialiser les séquences PostgreSQL
        dump_content.append("""
-- Reinitialisation des sequences PostgreSQL
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

-- Fin du dump
""")
        
        print("Ecriture du fichier de sortie...")
        
        # Écrire le fichier
        with open(output_file_path, 'w', encoding='utf-8') as f:
            f.write("\n".join(dump_content))
        
        conn.close()
        print(f"Dump PostgreSQL genere: {output_file_path}")
        return True
        
    except Exception as e:
        print(f"Erreur lors de la generation du dump {output_file_path}: {e}")
        return False

def main():
    """Fonction principale"""
    print("Generation des dumps PostgreSQL...")
    
    # Chemins des bases de données
    base_dir = Path(__file__).parent.parent
    backend_dir = base_dir / "backend"
    essaidocker_dir = base_dir / "essaidocker"
    
    print(f"Base dir: {base_dir}")
    print(f"Backend dir: {backend_dir}")
    print(f"Essaidocker dir: {essaidocker_dir}")
    
    # Configurations des dumps à générer
    dumps_config = [
        {
            "sqlite_db": backend_dir / "db-fr.db",
            "output_file": essaidocker_dir / "initdb" / "dump.sql",
            "region": "FR"
        },
        {
            "sqlite_db": backend_dir / "db-us.db",
            "output_file": essaidocker_dir / "init_us" / "dumpus.sql",
            "region": "US"
        },
        {
            "sqlite_db": backend_dir / "db-ch.db",
            "output_file": essaidocker_dir / "init_ch" / "dumpch.sql",
            "region": "CH"
        }
    ]
    
    success_count = 0
    
    for config in dumps_config:
        print(f"\nGeneration du dump pour la region {config['region']}...")
        print(f"SQLite DB: {config['sqlite_db']}")
        print(f"Output file: {config['output_file']}")
        print(f"SQLite exists: {config['sqlite_db'].exists()}")
        
        # Créer le répertoire de sortie si nécessaire
        config["output_file"].parent.mkdir(parents=True, exist_ok=True)
        
        if generate_postgresql_dump(
            str(config["sqlite_db"]),
            str(config["output_file"]),
            config["region"]
        ):
            success_count += 1
    
    print(f"\nGeneration terminee: {success_count}/{len(dumps_config)} dumps generes avec succes")
    
    if success_count == len(dumps_config):
        print("\nTous les dumps PostgreSQL ont ete generes avec succes!")
        print("Les fichiers suivants ont ete crees/mis a jour:")
        for config in dumps_config:
            print(f"  - {config['output_file']}")
    else:
        print(f"\nCertains dumps n'ont pas pu etre generes. Verifiez les erreurs ci-dessus.")

if __name__ == "__main__":
    main()
