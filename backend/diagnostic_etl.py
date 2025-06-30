#!/usr/bin/env python3
"""
Script de diagnostic pour vérifier la structure des fichiers ETL
"""
from pathlib import Path
import os

def check_etl_structure():
    """Vérifie la structure des répertoires ETL"""
    print("🔍 DIAGNOSTIC DE LA STRUCTURE ETL")
    print("=" * 50)
    
    # Répertoire de travail actuel
    current_dir = Path.cwd()
    print(f"📍 Répertoire courant: {current_dir}")
    
    # Vérification des répertoires
    directories_to_check = [
        "NewETL",
        "NewETL/SourceData", 
        "NewETL/DatasetClean"
    ]
    
    for dir_path in directories_to_check:
        full_path = current_dir / dir_path
        if full_path.exists():
            print(f"✅ {dir_path} : EXISTS")
            
            if dir_path.endswith("SourceData"):
                csv_files = list(full_path.glob("*.csv"))
                print(f"   📄 Fichiers CSV: {len(csv_files)}")
                for csv_file in csv_files:
                    size_kb = csv_file.stat().st_size / 1024
                    print(f"      • {csv_file.name} ({size_kb:.1f} KB)")
                    
            elif dir_path.endswith("DatasetClean"):
                csv_files = list(full_path.glob("*.csv"))
                db_files = list(full_path.glob("*.db"))
                print(f"   📊 Fichiers CSV: {len(csv_files)}")
                print(f"   🗄️  Fichiers DB: {len(db_files)}")
                
        else:
            print(f"❌ {dir_path} : MISSING")
            print(f"   💡 Créer avec: mkdir -p {full_path}")
    
    # Vérification du fichier de log
    log_file = current_dir / "NewETL" / "new_etl.log"
    if log_file.exists():
        size_kb = log_file.stat().st_size / 1024
        print(f"✅ Log ETL: {log_file} ({size_kb:.1f} KB)")
    else:
        print(f"❌ Log ETL: {log_file} (MISSING)")
    
    print("\n" + "=" * 50)
    print("🎯 RECOMMANDATIONS:")
    
    # Vérifier si on est dans le bon répertoire
    if not (current_dir / "NewETL").exists():
        print("⚠️  Vous n'êtes pas dans le bon répertoire!")
        print("   Naviguez vers le répertoire backend avant de lancer ce script")
        print("   cd backend && python diagnostic_etl.py")
    
    source_dir = current_dir / "NewETL" / "SourceData"
    if source_dir.exists():
        csv_count = len(list(source_dir.glob("*.csv")))
        if csv_count == 0:
            print("⚠️  Aucun fichier CSV dans SourceData!")
            print("   Copiez vos fichiers CSV sources dans NewETL/SourceData/")
        elif csv_count < 6:
            print(f"⚠️  Seulement {csv_count} fichiers CSV trouvés (6 attendus)")
        else:
            print(f"✅ {csv_count} fichiers CSV trouvés dans SourceData")

if __name__ == "__main__":
    check_etl_structure()
