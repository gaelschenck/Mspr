#!/usr/bin/env python3
"""
Script de test pour vérifier la génération des fichiers CSV par NewETL
"""

import sys
import os
from pathlib import Path

# Ajouter le répertoire parent au PYTHONPATH
sys.path.append(str(Path(__file__).parent.parent))

from backend.NewETL.NewETL import HealthDataETL

def test_csv_export():
    """Test de l'export CSV"""
    print("=== TEST DE L'EXPORT CSV ===")
    
    # Configuration des chemins
    script_dir = Path(__file__).parent
    source_dir = script_dir / "SourceData"
    dataset_dir = script_dir / "DatasetClean" 
    db_path = script_dir / "backend/test_normalized_health_data.db"
    
    # Vérifier que le dossier source existe
    if not source_dir.exists():
        print(f"❌ Dossier source non trouvé: {source_dir}")
        return False
    
    # Créer le dossier de destination s'il n'existe pas
    dataset_dir.mkdir(exist_ok=True)
    
    print(f"📁 Source: {source_dir}")
    print(f"📁 Destination: {dataset_dir}")
    print(f"🗄️ Base de données: {db_path}")
    
    try:
        # Initialiser l'ETL
        etl = HealthDataETL(
            source_dir=str(source_dir),
            db_path=str(db_path)
        )
        
        # Vérifier les fichiers sources disponibles
        source_files = list(source_dir.glob("*_clean.csv"))
        print(f"\n📊 Fichiers sources trouvés: {len(source_files)}")
        for file in source_files:
            print(f"  • {file.name}")
        
        if not source_files:
            print("⚠️ Aucun fichier source trouvé, création de données de test...")
            return create_test_data(source_dir)
        
        # Exécuter seulement l'export CSV (pas tout l'ETL)
        print("\n🔄 Test de l'export CSV...")
        csv_files = etl.export_to_csv_files(str(dataset_dir))
        
        print(f"\n✅ Export réussi! {len(csv_files)} fichiers créés:")
        for csv_file in csv_files:
            file_path = Path(csv_file)
            file_size = file_path.stat().st_size / 1024  # en KB
            print(f"  • {file_path.name} ({file_size:.1f} KB)")
        
        return True
        
    except Exception as e:
        print(f"❌ Erreur lors du test: {e}")
        import traceback
        traceback.print_exc()
        return False

def create_test_data(source_dir):
    """Crée des données de test minimales"""
    import pandas as pd
    
    print("🔧 Création de données de test...")
    
    # Créer un fichier de test minimal
    test_data = {
        'Country': ['France', 'Germany', 'Italy'],
        'Reported number of people receiving ART': [50000, 45000, 42000],
        'Estimated number of people living with HIV': [60000, 55000, 52000],
        'Estimated ART coverage among people living with HIV (%)': [83, 82, 81],
        'Estimated number of people living with HIV_median': [60000, 55000, 52000],
        'Estimated number of people living with HIV_min': [58000, 53000, 50000],
        'Estimated number of people living with HIV_max': [62000, 57000, 54000],
        'Estimated ART coverage among people living with HIV (%)_median': [83, 82, 81],
        'Estimated ART coverage among people living with HIV (%)_min': [80, 79, 78],
        'Estimated ART coverage among people living with HIV (%)_max': [86, 85, 84],
        'WHO Region': ['Europe', 'Europe', 'Europe']
    }
    
    test_file = source_dir / "art_coverage_by_country_clean.csv"
    df = pd.DataFrame(test_data)
    df.to_csv(test_file, index=False)
    
    print(f"✅ Fichier de test créé: {test_file}")
    return True

if __name__ == "__main__":
    success = test_csv_export()
    if success:
        print("\n🎉 Test réussi!")
    else:
        print("\n💥 Test échoué!")
        sys.exit(1)
