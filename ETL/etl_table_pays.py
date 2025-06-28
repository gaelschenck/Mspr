# =============================================================================
# Script : etl_table_pays.py
# Description : 
# Ce script extrait et transforme les données des pays à partir des fichiers sources.
# 
# EXTRACTION :
# - Sources : 
#   * art_coverage_by_country_clean.csv
#   * art_pediatric_coverage_by_country_clean.csv
#   * no_of_cases_adults_15_to_49_by_country_clean.csv
#   * no_of_deaths_by_country_clean.csv
#   * no_of_people_living_with_hiv_by_country_clean.csv
#   * prevention_of_mother_to_child_transmission_by_country_clean.csv
# - Données : Noms des pays et leurs régions OMS
# 
# TRANSFORMATION :
# - Standardisation des noms de pays (minuscules, sans espaces)
# - Dédoublonnage des pays
# - Attribution d'identifiants uniques
# - Structure : id_pays, pays, region_who
# 
# CHARGEMENT :
# - Fichier : pays_clean.csv
# - Format : CSV (séparateur: ',', encodage: UTF-8)
# =============================================================================

import pandas as pd
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
        list: Liste des DataFrames extraits ou None en cas d'erreur
    """
    try:
        logging.info("[PROCESSING] Début de l'extraction...")
        
        files = [
            "../SourceData/art_coverage_by_country_clean.csv",
            "../SourceData/art_pediatric_coverage_by_country_clean.csv",
            "../SourceData/no_of_cases_adults_15_to_49_by_country_clean.csv",
            "../SourceData/no_of_deaths_by_country_clean.csv",
            "../SourceData/no_of_people_living_with_hiv_by_country_clean.csv",
            "../SourceData/prevention_of_mother_to_child_transmission_by_country_clean.csv"
        ]
        
        dataframes = []
        for file_path in files:
            path = Path(file_path)
            if not path.exists():
                raise FileNotFoundError(f"Fichier introuvable : {file_path}")
                
            df = pd.read_csv(file_path)
            if df.empty:
                logging.warning(f"[WARNING] Le fichier {file_path} est vide")
                continue
                
            # Vérification des colonnes nécessaires
            country_col = next((col for col in df.columns if "Country" in col), None)
            region_col = next((col for col in df.columns if "WHO Region" in col), None)
            
            if country_col:
                df.rename(columns={country_col: "pays"}, inplace=True)
                if region_col:
                    df.rename(columns={region_col: "region_who"}, inplace=True)
                    df = df[["pays", "region_who"]].drop_duplicates()
                else:
                    df = df[["pays"]].drop_duplicates()
                dataframes.append(df)
            else:
                logging.warning(f"[WARNING] Aucune colonne 'Country' trouvée dans {file_path}")
                continue
        
        if not dataframes:
            raise ValueError("Aucune donnée valide extraite des fichiers sources")
            
        logging.info("[SUCCESS] Extraction réussie")
        return dataframes
        
    except FileNotFoundError as e:
        logging.error(f"[ERROR] Erreur d'accès fichier : {str(e)}")
        return None
    except ValueError as e:
        logging.error(f"[ERROR] Erreur de données : {str(e)}")
        return None
    except Exception as e:
        logging.error(f"[ERROR] Erreur inattendue lors de l'extraction : {str(e)}")
        return None

# ----------------------  TRANSFORMATION (Transform) ----------------------
def transform_data(dataframes):
    """
    TRANSFORMATION : Nettoyage et structuration des données
    Args:
        dataframes (list): Liste des DataFrames à transformer
    Returns:
        DataFrame: Données transformées ou None en cas d'erreur
    """
    try:
        logging.info("[PROCESSING] Début de la transformation...")
        
        # 1. Concaténation des DataFrames
        try:
            pays_df = pd.concat(dataframes, ignore_index=True)
            if pays_df.empty:
                raise ValueError("Aucune donnée après concaténation")
        except Exception as e:
            raise ValueError(f"Erreur lors de la concaténation : {str(e)}")
            
        # 2. Nettoyage des données
        try:
            # Standardisation des noms de pays
            pays_df["pays"] = pays_df["pays"].str.strip().str.lower().str.replace(r"\s+", " ", regex=True)
            
            # Nettoyage des régions si présentes
            if "region_who" in pays_df.columns:
                pays_df["region_who"] = pays_df["region_who"].str.strip().str.lower()
            
            # Suppression des doublons
            pays_df.drop_duplicates(subset=["pays"], inplace=True)
            
            if pays_df.empty:
                raise ValueError("Aucune donnée valide après nettoyage")
                
        except Exception as e:
            raise ValueError(f"Erreur lors du nettoyage : {str(e)}")
            
        # 3. Ajout des identifiants et nommage selon le modèle SQLAlchemy
        pays_df.insert(0, "id_pays", range(1, len(pays_df) + 1))
        
        # Renommage des colonnes pour correspondre au modèle SQLAlchemy
        pays_df = pays_df.rename(columns={
            'pays': 'nom_pays',
            'region_who': 'region'
        })
        
        # Ajout de la colonne sous_region (vide pour l'instant)
        pays_df['sous_region'] = None
        
        logging.info("[SUCCESS] Transformation réussie")
        return pays_df
        
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
        
        output_file = Path('../DatasetClean/pays_clean.csv')
        
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
            
        logging.info(f"[SUCCESS] Chargement réussi - {len(df)} pays enregistrés")
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
        logging.info("[START] Début du processus ETL pour pays")
        
        # EXTRACTION
        dataframes = extract_data()
        if dataframes is None:
            raise Exception("Échec de l'extraction des données")
            
        # TRANSFORMATION
        transformed_df = transform_data(dataframes)
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
