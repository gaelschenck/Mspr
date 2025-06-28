#!/usr/bin/env python3
"""
Script de test pour générer un dump PostgreSQL simple
"""

import sqlite3
import os
from pathlib import Path

def test_single_dump():
    """Test de génération d'un seul dump"""
    
    # Chemin de la base SQLite
    sqlite_db = Path(__file__).parent.parent / "backend" / "db-fr.db"
    output_file = Path(__file__).parent.parent / "essaidocker" / "initdb" / "dump.sql"
    
    print(f"Base SQLite: {sqlite_db}")
    print(f"Fichier de sortie: {output_file}")
    print(f"Base SQLite existe: {sqlite_db.exists()}")
    
    if not sqlite_db.exists():
        print("❌ Base SQLite non trouvée")
        return False
    
    try:
        # Connexion à la base SQLite
        conn = sqlite3.connect(str(sqlite_db))
        cursor = conn.cursor()
        
        # Lister les tables
        cursor.execute("SELECT name FROM sqlite_master WHERE type='table';")
        tables = cursor.fetchall()
        print(f"Tables trouvées: {tables}")
        
        # Test d'export d'une table simple
        cursor.execute("SELECT * FROM pays LIMIT 5")
        rows = cursor.fetchall()
        print(f"Échantillon de la table pays: {len(rows)} lignes")
        
        # Créer un dump minimal
        dump_content = [
            "-- Test dump PostgreSQL",
            "-- Structure minimale",
            "",
            "CREATE TABLE IF NOT EXISTS pays (",
            "    id_pays SERIAL PRIMARY KEY,",
            "    pays VARCHAR(100) NOT NULL,",
            "    region_who VARCHAR(100)",
            ");",
            "",
            "-- Données d'exemple"
        ]
        
        # Ajouter quelques données de test
        cursor.execute("SELECT * FROM pays LIMIT 3")
        for row in cursor.fetchall():
            id_pays, pays, region_who = row
            region_escaped = region_who.replace("'", "''") if region_who else "NULL"
            pays_escaped = pays.replace("'", "''") if pays else "NULL"
            
            if region_who:
                dump_content.append(f"INSERT INTO pays (id_pays, pays, region_who) VALUES ({id_pays}, '{pays_escaped}', '{region_escaped}');")
            else:
                dump_content.append(f"INSERT INTO pays (id_pays, pays, region_who) VALUES ({id_pays}, '{pays_escaped}', NULL);")
        
        # Créer le répertoire de sortie si nécessaire
        output_file.parent.mkdir(parents=True, exist_ok=True)
        
        # Écrire le fichier
        with open(output_file, 'w', encoding='utf-8') as f:
            f.write("\n".join(dump_content))
        
        conn.close()
        print(f"✅ Test réussi: {output_file}")
        return True
        
    except Exception as e:
        print(f"❌ Erreur: {e}")
        return False

if __name__ == "__main__":
    test_single_dump()
