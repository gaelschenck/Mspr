#!/usr/bin/env python3
# =============================================================================
# Script : verify_etl_models_consistency.py
# Description : Vérifie la correspondance entre les modèles SQLAlchemy et les ETL
# =============================================================================

import pandas as pd
import logging
from pathlib import Path

# Configuration du logging
logging.basicConfig(
    level=logging.INFO,
    format='%(asctime)s - %(levelname)s - %(message)s'
)

def analyze_table_structure():
    """Analyse la correspondance entre modèles et ETL"""
    
    logging.info("=== ANALYSE DE CORRESPONDANCE MODELES/ETL ===")
    
    # Définition des structures attendues selon les modèles SQLAlchemy
    expected_structures = {
        'pays': {
            'model_columns': ['id_pays', 'nom_pays', 'region', 'sous_region'],
            'etl_file': '../DatasetClean/pays_clean.csv',
            'etl_columns': ['id_pays', 'nom_pays', 'region', 'sous_region']
        },
        'unite': {
            'model_columns': ['id_unite', 'nom_unite'],
            'etl_file': '../DatasetClean/unite_clean.csv', 
            'etl_columns': ['id_unite', 'nom_unite']
        },
        'population_hiv': {
            'model_columns': ['id', 'id_pays', 'annee', 'valeur', 'id_unite'],
            'etl_file': '../DatasetClean/table_population_hiv.csv',
            'etl_columns': ['id', 'id_pays', 'annee', 'valeur', 'id_unite']
        },
        'mortalite': {
            'model_columns': ['id', 'id_pays', 'annee', 'valeur', 'id_unite'],
            'etl_file': '../DatasetClean/table_mortalite.csv',
            'etl_columns': ['id', 'id_pays', 'annee', 'valeur', 'id_unite']
        },
        'transmission_mere_enfant': {
            'model_columns': ['id', 'id_pays', 'besoin_arv_min', 'besoin_arv_median', 'besoin_arv_max', 
                             'pourcentage_recu_min', 'pourcentage_recu_median', 'pourcentage_recu_max'],
            'etl_file': '../DatasetClean/table_transmission_mere_enfant.csv',
            'etl_columns': ['id', 'id_pays', 'besoin_arv_min', 'besoin_arv_median', 'besoin_arv_max',
                           'pourcentage_recu_min', 'pourcentage_recu_median', 'pourcentage_recu_max']
        },
        'traitement': {
            'model_columns': ['id', 'id_pays', 'valeur', 'id_unite', 'id_type_traitement'],
            'etl_file': '../DatasetClean/table_traitement.csv',
            'etl_columns': ['id', 'id_pays', 'valeur', 'id_unite', 'id_type_traitement']
        },
        'statistique': {
            'model_columns': ['id', 'id_pays', 'annee', 'valeur', 'id_unite', 'id_type_statistique'],
            'etl_file': '../DatasetClean/table_statistique.csv',
            'etl_columns': ['id', 'id_pays', 'annee', 'valeur', 'id_unite', 'id_type_statistique']
        }
    }
    
    inconsistencies = []
    
    for table_name, structure in expected_structures.items():
        logging.info(f"\n--- Analyse de la table: {table_name} ---")
        
        etl_file = structure['etl_file']
        model_columns = structure['model_columns']
        etl_columns = structure['etl_columns']
        
        # Vérification de l'existence du fichier ETL
        if not Path(etl_file).exists():
            inconsistencies.append(f"❌ {table_name}: Fichier ETL manquant ({etl_file})")
            continue
        
        try:
            # Lecture du fichier ETL
            df = pd.read_csv(etl_file)
            actual_etl_columns = list(df.columns)
            
            logging.info(f"Modèle SQLAlchemy: {model_columns}")
            logging.info(f"ETL généré: {actual_etl_columns}")
            logging.info(f"ETL attendu: {etl_columns}")
            
            # Comparaison des colonnes
            if etl_columns:
                # Vérification ETL attendu vs ETL réel
                missing_etl_cols = set(etl_columns) - set(actual_etl_columns)
                extra_etl_cols = set(actual_etl_columns) - set(etl_columns)
                
                if missing_etl_cols:
                    inconsistencies.append(f"❌ {table_name}: Colonnes manquantes dans ETL: {missing_etl_cols}")
                if extra_etl_cols:
                    inconsistencies.append(f"⚠️ {table_name}: Colonnes supplémentaires dans ETL: {extra_etl_cols}")
                
                # Vérification modèle vs ETL
                missing_model_cols = set(model_columns) - set(actual_etl_columns)
                extra_model_cols = set(actual_etl_columns) - set(model_columns)
                
                if missing_model_cols:
                    inconsistencies.append(f"❌ {table_name}: Colonnes du modèle absentes de l'ETL: {missing_model_cols}")
            
            # Vérification de colonnes manquantes importantes (déjà dans la comparaison au-dessus)
            # Ces vérifications sont maintenant redondantes car incluses dans la comparaison générale
            
            # Affichage du nombre de lignes
            logging.info(f"Nombre de lignes dans l'ETL: {len(df)}")
            
        except Exception as e:
            inconsistencies.append(f"❌ {table_name}: Erreur lors de la lecture du fichier ETL: {str(e)}")
    
    return inconsistencies

def check_foreign_keys():
    """Vérifie la cohérence des clés étrangères"""
    
    logging.info("\n=== VERIFICATION DES CLES ETRANGERES ===")
    
    fk_issues = []
    
    try:
        # Lecture des tables principales
        pays_df = pd.read_csv('../DatasetClean/pays_clean.csv')
        unite_df = pd.read_csv('../DatasetClean/unite_clean.csv')
        
        # Listes des IDs valides
        valid_pays_ids = set(pays_df['id_pays'].unique())
        valid_unite_ids = set(unite_df['id_unite'].unique())
        
        # Vérification des tables avec clés étrangères
        tables_with_fk = [
            ('table_population_hiv.csv', 'id_pays', valid_pays_ids),
            ('table_mortalite.csv', 'id_pays', valid_pays_ids),
            ('table_transmission_mere_enfant.csv', 'id_pays', valid_pays_ids),
            ('table_traitement.csv', 'id_pays', valid_pays_ids),
            ('table_statistique.csv', 'id_pays', valid_pays_ids)
        ]
        
        for table_file, fk_column, valid_ids in tables_with_fk:
            table_path = f'../DatasetClean/{table_file}'
            if Path(table_path).exists():
                df = pd.read_csv(table_path)
                if fk_column in df.columns:
                    invalid_fks = set(df[fk_column].unique()) - valid_ids
                    if invalid_fks:
                        fk_issues.append(f"❌ {table_file}: IDs pays invalides: {invalid_fks}")
                    else:
                        logging.info(f"✅ {table_file}: Toutes les clés étrangères {fk_column} sont valides")
                else:
                    fk_issues.append(f"❌ {table_file}: Colonne {fk_column} manquante")
    
    except Exception as e:
        fk_issues.append(f"❌ Erreur lors de la vérification des clés étrangères: {str(e)}")
    
    return fk_issues

def generate_recommendations():
    """Génère des recommandations pour corriger les incohérences"""
    
    recommendations = [
        "\n=== RECOMMANDATIONS POUR CORRIGER LES INCOHERENCES ===",
        "",
        "1. NOMMAGE DES COLONNES:",
        "   - Adapter les modèles SQLAlchemy pour correspondre aux noms ETL:",
        "     * pays.nom_pays → pays.pays",
        "     * pays.region → pays.region_who", 
        "     * unite.nom_unite → unite.unite",
        "     * transmission_mere_enfant.id → transmission_mere_enfant.id_transmission",
        "",
        "2. COLONNES MANQUANTES:",
        "   - Ajouter id_unite aux tables population_hiv et mortalite",
        "   - Ajouter id_type_traitement à la table traitement",
        "   - Ajouter id_type_statistique à la table statistique",
        "",
        "3. STRUCTURE MANQUANTE:",
        "   - Ajouter sous_region à la table pays si nécessaire",
        "",
        "4. MODIFICATIONS RECOMMANDEES DANS LES MODELES:",
        "   ```python",
        "   # Dans models.py, adapter les noms:",
        "   class Pays(Base):",
        "       id_pays: Mapped[int] = mapped_column(Integer, primary_key=True)",
        "       pays: Mapped[str] = mapped_column(String(100), nullable=False)  # au lieu de nom_pays",
        "       region_who: Mapped[str] = mapped_column(String(100))  # au lieu de region",
        "   ",
        "   class Unite(Base):",
        "       id_unite: Mapped[int] = mapped_column(Integer, primary_key=True)",
        "       unite: Mapped[str] = mapped_column(String(50))  # au lieu de nom_unite",
        "   ```",
        "",
        "5. MODIFICATIONS RECOMMANDEES DANS LES ETL:",
        "   - Ajouter la génération des colonnes id_unite manquantes",
        "   - Ajouter la génération des colonnes id_type_* manquantes",
        "   - Renommer id_transmission en id dans l'ETL transmission"
    ]
    
    return recommendations

def main():
    """Fonction principale d'analyse"""
    
    logging.info("DEBUT DE L'ANALYSE DE COHERENCE ETL/MODELES")
    logging.info("=" * 60)
    
    # Analyse des structures
    inconsistencies = analyze_table_structure()
    
    # Vérification des clés étrangères
    fk_issues = check_foreign_keys()
    
    # Résumé des problèmes
    all_issues = inconsistencies + fk_issues
    
    logging.info("\n" + "=" * 60)
    logging.info("RESUME DES INCOHERENCES DETECTEES")
    logging.info("=" * 60)
    
    if all_issues:
        for issue in all_issues:
            logging.info(issue)
    else:
        logging.info("✅ Aucune incohérence détectée!")
    
    # Génération des recommandations
    recommendations = generate_recommendations()
    for rec in recommendations:
        logging.info(rec)
    
    # Conclusion
    logging.info("\n" + "=" * 60)
    if all_issues:
        logging.info("❌ CONCLUSION: Des incohérences ont été détectées entre les modèles et les ETL")
        logging.info("🔧 ACTIONS REQUISES: Suivez les recommandations ci-dessus")
    else:
        logging.info("✅ CONCLUSION: Les modèles et ETL sont cohérents")
    
    return len(all_issues) == 0

if __name__ == "__main__":
    success = main()
    exit(0 if success else 1)
