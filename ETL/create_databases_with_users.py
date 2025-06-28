#!/usr/bin/env python3
# =============================================================================
# Script : create_databases_with_users.py
# Description : Crée les trois bases de données SQLite du projet avec utilisateurs
# Utilise les fichiers SQL corrigés générés par verify_sql_consistency.py
# =============================================================================

import sqlite3
import os
import logging
from pathlib import Path
from passlib.context import CryptContext
import hashlib

# Configuration du logging
logging.basicConfig(
    level=logging.INFO,
    format='%(asctime)s - %(levelname)s - %(message)s'
)

class DatabaseCreator:
    """Classe pour créer les bases de données avec utilisateurs"""
    
    def __init__(self):
        self.project_root = Path(__file__).parent.parent
        self.sql_dir = self.project_root / 'SQL'
        self.dataset_dir = self.project_root / 'DatasetClean'
        self.backends_dir = self.project_root / 'backend'
        
        # Configuration des bases de données
        self.databases = {
            'fr': {
                'name': 'db-fr.db',
                'users': [
                    {'username': 'adminfr', 'password': 'adminfr', 'role': 'admin'},
                    {'username': 'userfr', 'password': 'userfr', 'role': 'user'}
                ]
            },
            'us': {
                'name': 'db-us.db', 
                'users': [
                    {'username': 'adminus', 'password': 'adminus', 'role': 'admin'},
                    {'username': 'userus', 'password': 'userus', 'role': 'user'}
                ]
            },
            'ch': {
                'name': 'db-ch.db',
                'users': [
                    {'username': 'adminch', 'password': 'adminch', 'role': 'admin'},
                    {'username': 'userch', 'password': 'userch', 'role': 'user'}
                ]
            }
        }
        
        # Configuration du hashage des mots de passe (même méthode que le projet)
        self.pwd_context = CryptContext(schemes=["bcrypt"], deprecated="auto")
    
    def hash_password(self, password: str) -> str:
        """Hash un mot de passe avec bcrypt"""
        return self.pwd_context.hash(password)
    
    def execute_sql_file(self, db_path: Path, sql_file: Path):
        """Exécute un fichier SQL sur une base de données"""
        try:
            conn = sqlite3.connect(db_path)
            cursor = conn.cursor()
            
            with open(sql_file, 'r', encoding='utf-8') as f:
                sql_content = f.read()
            
            # Diviser le contenu en commandes individuelles
            commands = [cmd.strip() for cmd in sql_content.split(';') if cmd.strip()]
            
            for command in commands:
                # Ignorer les commandes SQLite spéciales
                if command.upper().startswith(('.MODE', '.HEADERS', '.IMPORT')):
                    continue
                elif 'SELECT' in command.upper() and ('COUNT(*)' in command.upper() or 'TEST' in command.upper()):
                    # Ignorer les commandes de vérification
                    continue
                else:
                    try:
                        cursor.execute(command)
                    except Exception as e:
                        if 'syntax error' not in str(e).lower():
                            logging.warning(f"Commande ignorée: {command[:50]}... - {str(e)}")
            
            conn.commit()
            conn.close()
            return True
            
        except Exception as e:
            logging.error(f"Erreur lors de l'exécution de {sql_file}: {str(e)}")
            if 'conn' in locals():
                conn.close()
            return False
    
    def import_csv_to_table(self, cursor, csv_file: str, table_name: str):
        """Importe un fichier CSV dans une table SQLite"""
        try:
            import pandas as pd
            
            # Lire le CSV
            df = pd.read_csv(csv_file)
            
            # Insérer les données
            placeholders = ','.join(['?' for _ in df.columns])
            insert_sql = f"INSERT OR REPLACE INTO {table_name} ({','.join(df.columns)}) VALUES ({placeholders})"
            
            for _, row in df.iterrows():
                cursor.execute(insert_sql, tuple(row))
            
            logging.info(f"Importé {len(df)} lignes dans {table_name}")
            
        except Exception as e:
            logging.error(f"Erreur lors de l'import de {csv_file} dans {table_name}: {str(e)}")
    
    def import_all_csv_data(self, db_path: Path):
        """Importe tous les fichiers CSV dans la base de données"""
        try:
            import pandas as pd
            conn = sqlite3.connect(db_path)
            
            # Définir l'ordre d'import (tables de référence d'abord)
            csv_mappings = [
                ('unite_clean.csv', 'unite'),
                ('type_statistique_clean.csv', 'type_statistique'),
                ('type_traitement_clean.csv', 'type_traitement'),
                ('pays_clean.csv', 'pays'),
                ('table_population_hiv.csv', 'population_hiv'),
                ('table_mortalite.csv', 'mortalite'),
                ('table_transmission_mere_enfant.csv', 'transmission_mere_enfant'),
                ('table_traitement.csv', 'traitement'),
                ('table_statistique.csv', 'statistique')
            ]
            
            for csv_file, table_name in csv_mappings:
                csv_path = self.dataset_dir / csv_file
                if csv_path.exists():
                    df = pd.read_csv(csv_path)
                    df.to_sql(table_name, conn, if_exists='replace', index=False)
                    logging.info(f"Importé {len(df)} lignes dans {table_name}")
                else:
                    logging.warning(f"Fichier CSV manquant: {csv_path}")
            
            conn.close()
            return True
            
        except Exception as e:
            logging.error(f"Erreur lors de l'import des CSV: {str(e)}")
            return False
    
    def create_users_table(self, db_path: Path):
        """Crée la table utilisateur dans la base de données"""
        try:
            conn = sqlite3.connect(db_path)
            cursor = conn.cursor()
            
            # Créer la table utilisateur
            cursor.execute("""
                CREATE TABLE IF NOT EXISTS utilisateur (
                    id INTEGER PRIMARY KEY AUTOINCREMENT,
                    username VARCHAR UNIQUE NOT NULL,
                    hashed_password VARCHAR NOT NULL,
                    role VARCHAR NOT NULL,
                    rgpd_accept INTEGER NOT NULL DEFAULT 0
                )
            """)
            
            conn.commit()
            conn.close()
            return True
            
        except Exception as e:
            logging.error(f"Erreur lors de la création de la table utilisateur: {str(e)}")
            return False
    
    def add_users_to_database(self, db_path: Path, users: list):
        """Ajoute les utilisateurs à la base de données"""
        try:
            conn = sqlite3.connect(db_path)
            cursor = conn.cursor()
            
            for user in users:
                hashed_password = self.hash_password(user['password'])
                
                # Vérifier si l'utilisateur existe déjà
                cursor.execute("SELECT id FROM utilisateur WHERE username = ?", (user['username'],))
                if cursor.fetchone() is None:
                    # Insérer le nouvel utilisateur
                    cursor.execute("""
                        INSERT INTO utilisateur (username, hashed_password, role, rgpd_accept) 
                        VALUES (?, ?, ?, 0)
                    """, (user['username'], hashed_password, user['role']))
                    logging.info(f"Utilisateur {user['username']} ajouté avec rôle {user['role']}")
                else:
                    logging.info(f"Utilisateur {user['username']} existe déjà")
            
            conn.commit()
            conn.close()
            return True
            
        except Exception as e:
            logging.error(f"Erreur lors de l'ajout des utilisateurs: {str(e)}")
            return False
    
    def create_single_database(self, region: str, config: dict):
        """Crée une base de données pour une région donnée"""
        db_path = self.backends_dir / config['name']
        
        logging.info(f"=== Création de la base {region.upper()} ===")
        logging.info(f"Fichier: {db_path}")
        
        # Supprimer la base existante si elle existe
        if db_path.exists():
            os.remove(db_path)
            logging.info("Ancienne base supprimée")
        
        # Étape 1: Créer la structure des tables uniquement
        create_tables_file = self.sql_dir / 'create_tables_corrected.sql'
        if not create_tables_file.exists():
            logging.error(f"Fichier SQL manquant: {create_tables_file}")
            return False
        
        logging.info("Création des tables...")
        if not self.execute_sql_file(db_path, create_tables_file):
            return False
        
        # Étape 2: Importer les données CSV
        logging.info("Import des données CSV...")
        if not self.import_all_csv_data(db_path):
            return False
        
        # Étape 3: Créer la table utilisateur
        logging.info("Création de la table utilisateur...")
        if not self.create_users_table(db_path):
            return False
        
        # Étape 4: Ajouter les utilisateurs
        logging.info("Ajout des utilisateurs...")
        if not self.add_users_to_database(db_path, config['users']):
            return False
        
        # Étape 5: Vérifications finales
        self.verify_database(db_path, region)
        
        logging.info(f"✅ Base {region.upper()} créée avec succès!")
        return True
    
    def verify_database(self, db_path: Path, region: str):
        """Vérifie le contenu de la base de données créée"""
        try:
            conn = sqlite3.connect(db_path)
            cursor = conn.cursor()
            
            logging.info(f"\n--- Vérification de la base {region.upper()} ---")
            
            # Lister les tables
            cursor.execute("SELECT name FROM sqlite_master WHERE type='table'")
            tables = cursor.fetchall()
            logging.info(f"Tables créées: {[t[0] for t in tables]}")
            
            # Compter les enregistrements
            for table in ['pays', 'unite', 'population_hiv', 'utilisateur']:
                try:
                    cursor.execute(f"SELECT COUNT(*) FROM {table}")
                    count = cursor.fetchone()[0]
                    logging.info(f"Table {table}: {count} enregistrements")
                except:
                    logging.warning(f"Table {table} non trouvée ou vide")
            
            # Lister les utilisateurs
            cursor.execute("SELECT username, role FROM utilisateur")
            users = cursor.fetchall()
            logging.info(f"Utilisateurs: {users}")
            
            conn.close()
            
        except Exception as e:
            logging.error(f"Erreur lors de la vérification: {str(e)}")
    
    def create_all_databases(self):
        """Crée toutes les bases de données du projet"""
        logging.info("DEBUT DE LA CREATION DES BASES DE DONNEES")
        logging.info("=" * 60)
        
        # Vérifier que les fichiers SQL existent
        required_files = [
            self.sql_dir / 'create_tables_corrected.sql'
        ]
        
        for file in required_files:
            if not file.exists():
                logging.error(f"Fichier SQL manquant: {file}")
                logging.error("Exécutez d'abord verify_sql_consistency.py pour générer les fichiers SQL")
                return False
        
        success_count = 0
        for region, config in self.databases.items():
            if self.create_single_database(region, config):
                success_count += 1
            logging.info("")
        
        # Résumé final
        logging.info("=" * 60)
        if success_count == len(self.databases):
            logging.info("🎉 TOUTES LES BASES ONT ETE CREEES AVEC SUCCES!")
            logging.info("\nBases créées:")
            for region, config in self.databases.items():
                db_path = self.backends_dir / config['name']
                logging.info(f"  - {region.upper()}: {db_path}")
                for user in config['users']:
                    logging.info(f"    └─ {user['username']} ({user['role']})")
        else:
            logging.error(f"❌ Échec: {success_count}/{len(self.databases)} bases créées")
        
        return success_count == len(self.databases)

def main():
    """Fonction principale"""
    try:
        creator = DatabaseCreator()
        success = creator.create_all_databases()
        return 0 if success else 1
    except Exception as e:
        logging.error(f"Erreur fatale: {str(e)}")
        return 1

if __name__ == "__main__":
    exit(main())
