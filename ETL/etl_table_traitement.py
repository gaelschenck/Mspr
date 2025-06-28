# =============================================================================
# Script : etl_table_traitement.py
# Description : 
# Ce script traite les données sur les traitements HIV par pays.
# 
# EXTRACTION :
# - Sources : 
#   * art_coverage_by_country_clean.csv (adultes)
#   * art_pediatric_coverage_by_country_clean.csv (enfants)
# - Données : Taux de couverture des traitements par pays
# - Période : 2018
# 
# TRANSFORMATION :
# - Standardisation des noms de pays (minuscules, sans espaces)
# - Liaison avec la table pays pour obtenir les id_pays
# - Conversion des valeurs en pourcentages
# - Structure : id_traitement, id_pays, id_type_traitement, couverture
# 
# CHARGEMENT :
# - Fichier : table_traitement.csv
# - Format : CSV (séparateur: ',', encodage: UTF-8)
# =============================================================================

import pandas as pd
import numpy as np
import sys
import logging
from pathlib import Path

# Configuration du logging
logging.basicConfig(
    level=logging.INFO,
    format='%(asctime)s - %(levelname)s - %(message)s',
    handlers=[
        logging.FileHandler('../ETL/etl.log'),
        logging.StreamHandler(sys.stdout)
    ]
)

# ----------------------  EXTRACTION (Extract) ----------------------
def extract_data():
    """
    EXTRACTION : Lecture des fichiers sources
    Returns:
        tuple: (DataFrame pays, DataFrame art_coverage, DataFrame art_pediatric) ou None en cas d'erreur
    """
    try:
        logging.info("[PROCESSING] Début de l'extraction...")
        
        # Vérification des fichiers sources
        files_to_check = {
            'pays': Path('../DatasetClean/pays_clean.csv'),
            'art_coverage': Path('../SourceData/art_coverage_by_country_clean.csv'),
            'art_pediatric': Path('../SourceData/art_pediatric_coverage_by_country_clean.csv')
        }
        
        # Vérifie l'existence de chaque fichier
        for name, file_path in files_to_check.items():
            if not file_path.exists():
                raise FileNotFoundError(f"Fichier {name} introuvable : {file_path}")
        
        # Lecture des données avec vérification
        pays_df = pd.read_csv(files_to_check['pays'])
        if pays_df.empty:
            raise ValueError("Le fichier pays est vide")
            
        art_coverage_df = pd.read_csv(files_to_check['art_coverage'])
        if art_coverage_df.empty:
            raise ValueError("Le fichier art_coverage est vide")
            
        art_pediatric_df = pd.read_csv(files_to_check['art_pediatric'])
        if art_pediatric_df.empty:
            raise ValueError("Le fichier art_pediatric est vide")
            
        logging.info("[SUCCESS] Extraction réussie")
        return pays_df, art_coverage_df, art_pediatric_df
        
    except FileNotFoundError as e:
        logging.error(f"[ERROR] Erreur d'accès fichier : {str(e)}")
        return None, None, None
    except ValueError as e:
        logging.error(f"[ERROR] Erreur de données : {str(e)}")
        return None, None, None
    except Exception as e:
        logging.error(f"[ERROR] Erreur inattendue lors de l'extraction : {str(e)}")
        return None, None, None

# ----------------------  TRANSFORMATION (Transform) ----------------------
def transform_data(pays_df, art_coverage_df, art_pediatric_df):
    """
    TRANSFORMATION : Nettoyage et structuration des données
    Args:
        pays_df (DataFrame): DataFrame des pays
        art_coverage_df (DataFrame): DataFrame des données de couverture adultes
        art_pediatric_df (DataFrame): DataFrame des données de couverture enfants
    Returns:
        DataFrame: Données transformées ou None en cas d'erreur
    """
    try:
        logging.info("[PROCESSING] Début de la transformation...")
        
        # 1. Nettoyage des colonnes
        try:
            art_coverage_df.columns = art_coverage_df.columns.str.strip()
            art_pediatric_df.columns = art_pediatric_df.columns.str.strip()
            
            # Vérification des colonnes requises
            required_columns_adult = ['Country', 'Estimated ART coverage among people living with HIV (%)_median']
            required_columns_pediatric = ['Country', 'Estimated ART coverage among children (%)_median']
            
            if not all(col in art_coverage_df.columns for col in required_columns_adult):
                raise ValueError("Colonnes manquantes dans le fichier art_coverage")
            if not all(col in art_pediatric_df.columns for col in required_columns_pediatric):
                raise ValueError("Colonnes manquantes dans le fichier art_pediatric")
                
        except Exception as e:
            raise ValueError(f"Erreur lors du nettoyage des colonnes : {str(e)}")
            
        # 2. Standardisation des pays
        try:
            art_coverage_df['Country'] = art_coverage_df['Country'].str.strip().str.lower()
            art_pediatric_df['Country'] = art_pediatric_df['Country'].str.strip().str.lower()
        except Exception as e:
            raise ValueError(f"Erreur lors de la standardisation des pays : {str(e)}")
            
        # 3. Fusion avec la table pays
        try:
            art_coverage_df = pd.merge(art_coverage_df, pays_df, 
                                     left_on='Country', 
                                     right_on='nom_pays',  # Changé de 'pays' vers 'nom_pays'
                                     how='inner')
            art_pediatric_df = pd.merge(art_pediatric_df, pays_df, 
                                      left_on='Country', 
                                      right_on='nom_pays',  # Changé de 'pays' vers 'nom_pays'
                                      how='inner')
            
            if art_coverage_df.empty and art_pediatric_df.empty:
                raise ValueError("Aucune correspondance trouvée après la fusion")
        except Exception as e:
            raise ValueError(f"Erreur lors de la fusion : {str(e)}")
            
        # 4. Construction du DataFrame final
        traitement_data = []
        id_traitement = 1
        error_count = 0
        
        # Traitement des données pour les adultes (type_traitement = 1)
        for _, row in art_coverage_df.iterrows():
            try:
                coverage = pd.to_numeric(row['Estimated ART coverage among people living with HIV (%)_median'], 
                                      errors='coerce')
                if pd.notna(coverage) and pd.notna(row['id_pays']):
                    traitement_data.append({
                        'id': id_traitement,  # Changé de id_traitement vers id
                        'id_pays': int(row['id_pays']),
                        'valeur': int(round(coverage)),  # Changé de couverture vers valeur
                        'id_unite': 2,  # 2 = "pourcentage" selon table unite
                        'id_type_traitement': 1
                    })
                    id_traitement += 1
            except ValueError as e:
                error_count += 1
                logging.warning(f"[WARNING] Ligne adulte ignorée - Pays: {row['Country']}")
                continue
        
        # Traitement des données pour les enfants (type_traitement = 2)
        for _, row in art_pediatric_df.iterrows():
            try:
                coverage = pd.to_numeric(row['Estimated ART coverage among children (%)_median'], 
                                      errors='coerce')
                if pd.notna(coverage) and pd.notna(row['id_pays']):
                    traitement_data.append({
                        'id': id_traitement,  # Changé de id_traitement vers id
                        'id_pays': int(row['id_pays']),
                        'valeur': int(round(coverage)),  # Changé de couverture vers valeur
                        'id_unite': 2,  # 2 = "pourcentage" selon table unite
                        'id_type_traitement': 2
                    })
                    id_traitement += 1
            except ValueError as e:
                error_count += 1
                logging.warning(f"[WARNING] Ligne enfant ignorée - Pays: {row['Country']}")
                continue
                
        if error_count > 0:
            logging.warning(f"[WARNING] {error_count} lignes ignorées pendant la transformation")
            
        result_df = pd.DataFrame(traitement_data)
        if result_df.empty:
            raise ValueError("Aucune donnée valide après transformation")
            
        logging.info("[SUCCESS] Transformation réussie")
        return result_df
        
    except ValueError as e:
        logging.error(f"[ERROR] Erreur de transformation : {str(e)}")
        return None
    except Exception as e:
        logging.error(f"[ERROR] Erreur inattendue lors de la transformation : {str(e)}")
        return None

# ----------------------  CHARGEMENT (Load) ----------------------
def load_data(df):
    """
    CHARGEMENT : Sauvegarde des données transformées
    Args:
        df (DataFrame): Données à sauvegarder
    Returns:
        bool: True si succès, False sinon
    """
    try:
        logging.info("[PROCESSING] Début du chargement...")
        
        output_file = Path('../DatasetClean/table_traitement.csv')
        
        # 1. Préparation du dossier de sortie
        try:
            output_file.parent.mkdir(parents=True, exist_ok=True)
        except Exception as e:
            raise IOError(f"Impossible de créer le dossier de sortie : {str(e)}")
            
        # 2. Sauvegarde des données
        try:
            df.to_csv(output_file, index=False)
        except Exception as e:
            raise IOError(f"Erreur lors de la sauvegarde : {str(e)}")
            
        # 3. Vérification
        if not output_file.exists():
            raise FileNotFoundError("Le fichier n'a pas été créé")
            
        # 4. Validation des données sauvegardées
        try:
            verification_df = pd.read_csv(output_file)
            if verification_df.empty or len(verification_df) != len(df):
                raise ValueError("Les données sauvegardées sont incomplètes")
        except Exception as e:
            raise ValueError(f"Erreur lors de la vérification : {str(e)}")
            
        logging.info(f"[SUCCESS] Chargement réussi - {len(df)} lignes sauvegardées")
        return True
        
    except (IOError, FileNotFoundError, ValueError) as e:
        logging.error(f"[ERROR] Erreur de chargement : {str(e)}")
        return False
    except Exception as e:
        logging.error(f"[ERROR] Erreur inattendue lors du chargement : {str(e)}")
        return False

# ---------------------- [START] EXECUTION ----------------------
def main():
    """
    Fonction principale : Orchestration du processus ETL
    """
    try:
        logging.info("[START] Début du processus ETL pour traitement")
        
        # EXTRACTION
        pays_df, art_coverage_df, art_pediatric_df = extract_data()
        if pays_df is None or art_coverage_df is None or art_pediatric_df is None:
            raise Exception("Échec de l'extraction des données")
            
        # TRANSFORMATION
        transformed_df = transform_data(pays_df, art_coverage_df, art_pediatric_df)
        if transformed_df is None:
            raise Exception("Échec de la transformation des données")
            
        # CHARGEMENT
        if not load_data(transformed_df):
            raise Exception("Échec du chargement des données")
            
        logging.info("[SUCCESS] Processus ETL terminé avec succès")
        
    except Exception as e:
        logging.error(f"[ERROR] Erreur dans le processus ETL : {str(e)}")
        sys.exit(1)

if __name__ == "__main__":
    main()
