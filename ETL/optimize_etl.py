# =============================================================================
# Script : optimize_etl.py
# Description : Script d'optimisation pour améliorer les performances des ETL
# =============================================================================

import pandas as pd
import numpy as np
import time
import logging
from pathlib import Path
import multiprocessing as mp
from functools import partial

# Configuration du logging
logging.basicConfig(
    level=logging.INFO,
    format='%(asctime)s - %(levelname)s - %(message)s'
)

class ETLOptimizer:
    """Classe pour optimiser les performances des ETL"""
    
    def __init__(self):
        self.chunk_size = 10000  # Taille des chunks pour le traitement
        self.use_multiprocessing = True
        self.optimize_memory = True
    
    def read_csv_optimized(self, file_path, columns=None, dtype=None):
        """Lecture optimisée des fichiers CSV"""
        try:
            # Configuration optimisée pour pandas
            read_params = {
                'low_memory': False,
                'engine': 'c',  # Moteur C plus rapide
                'encoding': 'utf-8'
            }
            
            if columns:
                read_params['usecols'] = columns
            
            if dtype:
                read_params['dtype'] = dtype
            
            # Lecture par chunks pour les gros fichiers
            file_size = Path(file_path).stat().st_size
            if file_size > 50 * 1024 * 1024:  # 50MB
                logging.info(f"Lecture par chunks du fichier volumineux: {file_path}")
                chunks = pd.read_csv(file_path, chunksize=self.chunk_size, **read_params)
                df = pd.concat(chunks, ignore_index=True)
            else:
                df = pd.read_csv(file_path, **read_params)
            
            return df
            
        except Exception as e:
            logging.error(f"Erreur lors de la lecture de {file_path}: {e}")
            return None
    
    def optimize_dataframe_types(self, df):
        """Optimise les types de données pour réduire l'usage mémoire"""
        if not self.optimize_memory:
            return df
        
        original_memory = df.memory_usage(deep=True).sum()
        
        for col in df.columns:
            col_type = df[col].dtype
            
            if col_type != 'object':
                c_min = df[col].min()
                c_max = df[col].max()
                
                if str(col_type)[:3] == 'int':
                    if c_min > np.iinfo(np.int8).min and c_max < np.iinfo(np.int8).max:
                        df[col] = df[col].astype(np.int8)
                    elif c_min > np.iinfo(np.int16).min and c_max < np.iinfo(np.int16).max:
                        df[col] = df[col].astype(np.int16)
                    elif c_min > np.iinfo(np.int32).min and c_max < np.iinfo(np.int32).max:
                        df[col] = df[col].astype(np.int32)
                
                elif str(col_type)[:5] == 'float':
                    if c_min > np.finfo(np.float32).min and c_max < np.finfo(np.float32).max:
                        df[col] = df[col].astype(np.float32)
            
            # Optimisation des chaînes de caractères
            elif col_type == 'object':
                try:
                    # Essai de conversion en catégorie si peu de valeurs uniques
                    if df[col].nunique() / len(df) < 0.5:
                        df[col] = df[col].astype('category')
                except:
                    pass
        
        new_memory = df.memory_usage(deep=True).sum()
        reduction = (original_memory - new_memory) / original_memory * 100
        
        if reduction > 0:
            logging.info(f"Optimisation mémoire: {reduction:.1f}% de réduction")
        
        return df
    
    def process_chunk(self, chunk, transformation_func):
        """Traite un chunk de données"""
        return transformation_func(chunk)
    
    def parallel_transform(self, df, transformation_func, n_cores=None):
        """Transformation parallèle des données"""
        if not self.use_multiprocessing or len(df) < self.chunk_size:
            return transformation_func(df)
        
        if n_cores is None:
            n_cores = min(mp.cpu_count(), 4)  # Maximum 4 cores
        
        # Division en chunks
        chunks = np.array_split(df, n_cores)
        
        # Traitement parallèle
        with mp.Pool(n_cores) as pool:
            processed_chunks = pool.map(
                partial(self.process_chunk, transformation_func=transformation_func),
                chunks
            )
        
        # Reconstitution
        return pd.concat(processed_chunks, ignore_index=True)
    
    def benchmark_function(self, func, *args, **kwargs):
        """Mesure le temps d'exécution d'une fonction"""
        start_time = time.time()
        result = func(*args, **kwargs)
        end_time = time.time()
        
        execution_time = end_time - start_time
        logging.info(f"Temps d'exécution de {func.__name__}: {execution_time:.2f}s")
        
        return result, execution_time

def create_optimized_etl_template():
    """Crée un template ETL optimisé"""
    template = '''# =============================================================================
# Template ETL Optimisé
# =============================================================================

import pandas as pd
import numpy as np
import sys
import logging
import time
from pathlib import Path
from optimize_etl import ETLOptimizer

# Configuration du logging
logging.basicConfig(
    level=logging.INFO,
    format='%(asctime)s - %(levelname)s - %(message)s'
)

def extract_data_optimized():
    """Extraction optimisée des données"""
    optimizer = ETLOptimizer()
    
    try:
        start_time = time.time()
        logging.info("[PROCESSING] Début de l'extraction optimisée...")
        
        # Spécification des colonnes nécessaires pour réduire la mémoire
        required_columns = ['Column1', 'Column2', 'Column3']
        
        # Types de données optimisés
        dtype_mapping = {
            'Column1': 'category',
            'Column2': 'int32',
            'Column3': 'float32'
        }
        
        # Lecture optimisée
        df = optimizer.read_csv_optimized(
            '../SourceData/source_file.csv',
            columns=required_columns,
            dtype=dtype_mapping
        )
        
        if df is None:
            raise ValueError("Échec de la lecture du fichier")
        
        # Optimisation des types de données
        df = optimizer.optimize_dataframe_types(df)
        
        execution_time = time.time() - start_time
        logging.info(f"[SUCCESS] Extraction réussie en {execution_time:.2f}s")
        
        return df
        
    except Exception as e:
        logging.error(f"[ERROR] Erreur lors de l'extraction : {str(e)}")
        return None

def transform_data_optimized(df):
    """Transformation optimisée des données"""
    optimizer = ETLOptimizer()
    
    try:
        start_time = time.time()
        logging.info("[PROCESSING] Début de la transformation optimisée...")
        
        def transformation_logic(chunk):
            # Logique de transformation
            chunk['new_column'] = chunk['Column1'].str.lower()
            chunk = chunk.dropna()
            return chunk
        
        # Transformation parallèle si applicable
        result_df = optimizer.parallel_transform(df, transformation_logic)
        
        execution_time = time.time() - start_time
        logging.info(f"[SUCCESS] Transformation réussie en {execution_time:.2f}s")
        
        return result_df
        
    except Exception as e:
        logging.error(f"[ERROR] Erreur lors de la transformation : {str(e)}")
        return None

def load_data_optimized(df, output_path):
    """Chargement optimisé des données"""
    try:
        start_time = time.time()
        logging.info("[PROCESSING] Début du chargement optimisé...")
        
        # Sauvegarde optimisée
        df.to_csv(output_path, index=False, encoding='utf-8')
        
        execution_time = time.time() - start_time
        logging.info(f"[SUCCESS] Chargement réussi en {execution_time:.2f}s")
        
        return True
        
    except Exception as e:
        logging.error(f"[ERROR] Erreur lors du chargement : {str(e)}")
        return False

def main():
    """Fonction principale optimisée"""
    total_start_time = time.time()
    
    try:
        logging.info("[START] Début du processus ETL optimisé")
        
        # EXTRACTION
        df = extract_data_optimized()
        if df is None:
            raise Exception("Échec de l'extraction")
        
        # TRANSFORMATION
        transformed_df = transform_data_optimized(df)
        if transformed_df is None:
            raise Exception("Échec de la transformation")
        
        # CHARGEMENT
        if not load_data_optimized(transformed_df, '../DatasetClean/output.csv'):
            raise Exception("Échec du chargement")
        
        total_time = time.time() - total_start_time
        logging.info(f"[SUCCESS] Processus ETL terminé en {total_time:.2f}s")
        
    except Exception as e:
        logging.error(f"[ERROR] Erreur dans le processus ETL : {str(e)}")
        sys.exit(1)

if __name__ == "__main__":
    main()
'''
    
    with open('template_etl_optimized.py', 'w', encoding='utf-8') as f:
        f.write(template)
    
    logging.info("Template ETL optimisé créé: template_etl_optimized.py")

if __name__ == "__main__":
    create_optimized_etl_template()
    logging.info("Module d'optimisation ETL prêt à être utilisé")
