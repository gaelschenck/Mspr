#!/usr/bin/env python3
"""
Script de vérification des colonnes pour s'assurer qu'aucune donnée n'est laissée de côté
"""

import pandas as pd
from pathlib import Path
import os

# Configuration identique à NewETL.py
csv_configs = {
    'prevention_of_mother_to_child_transmission_by_country_clean.csv': {
        'value_columns': ['Received Antiretrovirals', 'Needing antiretrovirals', 'Percentage Recieved'],
        'confidence_columns': {
            'Needing antiretrovirals': ['Needing antiretrovirals_median', 'Needing antiretrovirals_min', 'Needing antiretrovirals_max'],
            'Percentage Recieved': ['Percentage Recieved_median', 'Percentage Recieved_min', 'Percentage Recieved_max']
        }
    },
    'art_coverage_by_country_clean.csv': {
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
        'value_columns': ['Count'],
        'confidence_columns': {'Count': ['Count_median', 'Count_min', 'Count_max']},
        'additional_columns': ['Year']
    },
    'no_of_deaths_by_country_clean.csv': {
        'value_columns': ['Count'],
        'confidence_columns': {'Count': ['Count_median', 'Count_min', 'Count_max']},
        'additional_columns': ['Year']
    },
    'no_of_cases_adults_15_to_49_by_country_clean.csv': {
        'value_columns': ['Count'],
        'confidence_columns': {'Count': ['Count_median', 'Count_min', 'Count_max']},
        'additional_columns': ['Year']
    },
    'art_pediatric_coverage_by_country_clean.csv': {
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

def verify_file_coverage(csv_file_path, config):
    """Vérifie si toutes les colonnes d'un fichier CSV sont couvertes"""
    
    if not os.path.exists(csv_file_path):
        return f"❌ Fichier non trouvé: {csv_file_path}"
    
    try:
        # Lit le fichier CSV
        df = pd.read_csv(csv_file_path)
        all_columns = set(df.columns.str.strip())
        
        # Colonnes système toujours traitées
        system_columns = {'Country', 'WHO Region'}
        
        # Colonnes configurées pour traitement
        configured_columns = set()
        
        # Ajoute les colonnes de valeurs
        configured_columns.update(config.get('value_columns', []))
        
        # Ajoute les colonnes de confiance
        for conf_list in config.get('confidence_columns', {}).values():
            configured_columns.update(conf_list)
        
        # Ajoute les colonnes additionnelles
        configured_columns.update(config.get('additional_columns', []))
        
        # Colonnes traitées au total
        treated_columns = system_columns | configured_columns
        
        # Colonnes manquantes
        missing_columns = all_columns - treated_columns
        
        result = {
            'file': os.path.basename(csv_file_path),
            'total_columns': len(all_columns),
            'treated_columns': len(treated_columns),
            'missing_columns': list(missing_columns),
            'coverage_rate': round(len(treated_columns & all_columns) / len(all_columns) * 100, 1)
        }
        
        return result
        
    except Exception as e:
        return f"❌ Erreur lors de la lecture de {csv_file_path}: {e}"

def main():
    """Fonction principale de vérification"""
    
    # Chemin vers les fichiers CSV
    source_dir = Path(__file__).parent.parent
    
    print("🔍 AUDIT DE COUVERTURE DES DONNÉES CSV")
    print("=" * 50)
    
    total_files = 0
    total_missing = 0
    
    for filename, config in csv_configs.items():
        file_path = source_dir / filename
        result = verify_file_coverage(file_path, config)
        
        if isinstance(result, dict):
            total_files += 1
            
            print(f"\n📄 {result['file']}")
            print(f"   Colonnes totales: {result['total_columns']}")
            print(f"   Colonnes traitées: {result['treated_columns']}")
            print(f"   Taux de couverture: {result['coverage_rate']}%")
            
            if result['missing_columns']:
                total_missing += len(result['missing_columns'])
                print(f"   ⚠️  Colonnes NON traitées:")
                for col in result['missing_columns']:
                    print(f"      - {col}")
            else:
                print(f"   ✅ Toutes les colonnes sont traitées!")
        else:
            print(f"\n{result}")
    
    print("\n" + "=" * 50)
    print(f"🎯 RÉSUMÉ GLOBAL")
    print(f"Fichiers analysés: {total_files}")
    print(f"Colonnes manquées au total: {total_missing}")
    
    if total_missing == 0:
        print("✅ PARFAIT! Aucune donnée n'est laissée de côté!")
    else:
        print(f"⚠️  {total_missing} colonnes pourraient être ajoutées à la configuration")

if __name__ == "__main__":
    main()
