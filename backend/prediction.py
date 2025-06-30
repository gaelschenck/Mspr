from sqlalchemy.ext.asyncio import AsyncSession
from sqlalchemy import select
import pandas as pd
from sklearn.model_selection import train_test_split
from sklearn.ensemble import RandomForestClassifier  
from sklearn.ensemble import VotingRegressor
from sklearn.ensemble import RandomForestRegressor
from sklearn.neighbors import KNeighborsRegressor
from sklearn.svm import SVR
from sklearn.preprocessing import OneHotEncoder
from sklearn.metrics import mean_squared_error, r2_score
import numpy as np
import matplotlib.pyplot as plt
import os
import sys


LANG = os.getenv("LANG", "fr")

TRANSLATIONS = {
    "df_shape": {
        "fr": "Taille du DataFrame avant préparation : {shape}",
        "en": "DataFrame size before preparation: {shape}",
        "de": "DataFrame-Größe vor der Vorbereitung: {shape}"
    },
    "df_columns": {
        "fr": "Colonnes présentes : {columns}",
        "en": "Columns present: {columns}",
        "de": "Vorhandene Spalten: {columns}"
    },
    "target_found": {
        "fr": "Colonne cible : {target}",
        "en": "Target column: {target}",
        "de": "Zielspalte: {target}"
    },
    "current_index": {
        "fr": "Index actuel : {index}",
        "en": "Current index: {index}",
        "de": "Aktueller Index: {index}"
    },
    "target_missing": {
        "fr": "Colonne cible non spécifiée ou absente. Utilisation des seules caractéristiques.",
        "en": "Target column not specified or missing. Using features only.",
        "de": "Zielspalte nicht angegeben oder fehlt. Nur Merkmale werden verwendet."
    },
    "features_shape": {
        "fr": "Données préparées. Dimensions des caractéristiques : {shape}",
        "en": "Data prepared. Features shape: {shape}",
        "de": "Daten vorbereitet. Merkmalsdimensionen: {shape}"
    },
    "target_count": {
        "fr": "Colonne cible détectée. Nombre de cibles : {count}",
        "en": "Target column detected. Number of targets: {count}",
        "de": "Zielspalte erkannt. Anzahl der Ziele: {count}"
    },
    "before_preprocessing": {
        "fr": "Avant prétraitement, types des colonnes :\n{dtypes}",
        "en": "Before preprocessing, column types:\n{dtypes}",
        "de": "Vorverarbeitung, Spaltentypen:\n{dtypes}"
    },
    "categorical_detected": {
        "fr": "Colonnes catégoriques détectées : {cols}",
        "en": "Categorical columns detected: {cols}",
        "de": "Kategorische Spalten erkannt: {cols}"
    },
    "no_categorical": {
        "fr": "Aucune colonne catégorique détectée.",
        "en": "No categorical columns detected.",
        "de": "Keine kategorischen Spalten erkannt."
    },
    "non_numeric_detected": {
        "fr": "Colonnes non numériques détectées après encodage : {cols}",
        "en": "Non-numeric columns detected after encoding: {cols}",
        "de": "Nicht-numerische Spalten nach Codierung erkannt: {cols}"
    },
    "after_preprocessing": {
        "fr": "Après prétraitement, dimensions de X : {shape}",
        "en": "After preprocessing, X shape: {shape}",
        "de": "Nach der Vorverarbeitung, X-Dimension: {shape}"
    },
    "train_size": {
        "fr": "Taille de X_train : {xtrain}, Taille de y_train : {ytrain}",
        "en": "X_train size: {xtrain}, y_train size: {ytrain}",
        "de": "X_train Größe: {xtrain}, y_train Größe: {ytrain}"
    },
    "test_size": {
        "fr": "Taille de X_test : {xtest}, Taille de y_test : {ytest}",
        "en": "X_test size: {xtest}, y_test size: {ytest}",
        "de": "X_test Größe: {xtest}, y_test Größe: {ytest}"
    },
    "training": {
        "fr": "Entraînement du modèle...",
        "en": "Training the model...",
        "de": "Modell wird trainiert..."
    },
    "trained": {
        "fr": "Modèle entraîné avec succès.",
        "en": "Model trained successfully.",
        "de": "Modell erfolgreich trainiert."
    },
    "evaluating": {
        "fr": "Évaluation du modèle...",
        "en": "Evaluating the model...",
        "de": "Modellbewertung..."
    },
    "results": {
        "fr": "Résultats :",
        "en": "Results:",
        "de": "Ergebnisse:"
    },
    "rmse": {
        "fr": "Root Mean Squared Error (RMSE) : {rmse:.2f}",
        "en": "Root Mean Squared Error (RMSE): {rmse:.2f}",
        "de": "Root Mean Squared Error (RMSE): {rmse:.2f}"
    },
    "r2": {
        "fr": "R² score : {r2:.2f}",
        "en": "R² score: {r2:.2f}",
        "de": "R² Wert: {r2:.2f}"
    },
    "plot_title": {
    "fr": "Comparaison des valeurs réelles et prédictions",
    "en": "Comparison of actual values and predictions",
    "de": "Vergleich von Ist-Werten und Vorhersagen"
    }
}

def tr(key, **kwargs):
    msg = TRANSLATIONS.get(key, {}).get(LANG, TRANSLATIONS.get(key, {}).get("fr", key))
    return msg.format(**kwargs) if kwargs else msg

def prepare_data_generic(df, target_column=None):
    """
    Prépare les données pour l'entraînement d'un modèle de machine learning.
    - Sépare les caractéristiques (`features`) et la cible (`target`).
    - Si `target_column` n'est pas fourni, essaye de l'inférer ou retourne uniquement les features.
    Args:
        df (pd.DataFrame): Le DataFrame à traiter.
        target_column (str): La colonne cible (si elle est connue).

    Returns:
        X (pd.DataFrame): Les caractéristiques.
        y (pd.Series ou None): La cible (ou None si non spécifiée).
    """
    print(tr("df_shape", shape=df.shape))
    print(tr("df_columns", columns=df.columns.tolist()))
    
    # Vérifications de base
    if df.empty:
        raise ValueError("Le DataFrame est vide. Impossible de préparer les données.")
    
    if target_column and target_column not in df.columns:
        available_cols = df.columns.tolist()
        raise ValueError(f"Colonne cible '{target_column}' non trouvée. Colonnes disponibles: {available_cols}")
    
    # Afficher des statistiques de base pour le debug
    print(f"DataFrame shape: {df.shape}")
    print(f"Valeurs non-nulles par colonne:")
    for col in df.columns:
        non_null_count = df[col].notna().sum()
        print(f"  {col}: {non_null_count}/{len(df)} valeurs non-nulles")
    
    if target_column:
        target_non_null = df[target_column].notna().sum()
        print(f"Colonne cible '{target_column}': {target_non_null} valeurs non-nulles")
        if target_non_null < 2:
            raise ValueError(f"Pas assez de données non-nulles dans la colonne cible '{target_column}' (besoin d'au moins 2 valeurs).")

    # Créer une copie pour éviter les modifications du DataFrame original
    df_work = df.copy()
    
    if target_column and target_column in df_work.columns:
        # Colonnes à exclure des features (métadonnées qui ne sont pas prédictives)
        # Adaptées au nouveau schéma normalisé
        columns_to_exclude = [
            target_column,
            "country_name",  # nom du pays (catégoriel, peut être encodé si nécessaire)
            "who_region",    # région WHO (catégoriel, peut être encodé si nécessaire)
            "indicator_type_name",  # nom du type d'indicateur (catégoriel)
            "value_text",    # texte de valeur (non numérique)
            "source_file",   # fichier source (métadonnée)
            "data_quality",  # qualité des données (métadonnée)
            "_sa_instance_state"  # SQLAlchemy internal
        ]
        
        # Séparer la cible et les caractéristiques
        X = df_work.drop(columns=columns_to_exclude, errors="ignore")
        y = df_work[target_column]
        print(tr("target_found", target=target_column))
        print(tr("current_index", index=df_work.index))
        
        # Créer des features additionnelles basées sur les données disponibles du nouveau schéma
        if 'year' in X.columns:
            # Garder l'année comme feature au lieu de l'utiliser comme index
            X['year_normalized'] = (X['year'] - X['year'].min()) / (X['year'].max() - X['year'].min() + 1e-8)
            X['year_squared'] = X['year'] ** 2
            print(f"Features temporelles ajoutées: year_normalized, year_squared")
        
        # Traiter l'ancienne colonne 'annee' si elle existe encore (compatibilité)
        if 'annee' in X.columns:
            X['annee_normalized'] = (X['annee'] - X['annee'].min()) / (X['annee'].max() - X['annee'].min() + 1e-8)
            X['annee_squared'] = X['annee'] ** 2
            print(f"Features temporelles ajoutées (legacy): annee_normalized, annee_squared")
        
        # Ajouter des features dérivées pour les IDs du nouveau schéma
        if 'country_id' in X.columns:
            X['country_id_log'] = np.log1p(X['country_id'])  # Log transform des IDs
            X['country_id_norm'] = X['country_id'] / (X['country_id'].max() + 1e-8)
        
        if 'indicator_type_id' in X.columns:
            X['indicator_type_id_norm'] = X['indicator_type_id'] / (X['indicator_type_id'].max() + 1e-8)
        
        if 'id' in X.columns:
            X['id_norm'] = X['id'] / (X['id'].max() + 1e-8)
        
        # Features basées sur les intervalles de confiance si disponibles
        if 'confidence_min' in X.columns and 'confidence_max' in X.columns:
            # Calculer l'incertitude
            X['confidence_range'] = X['confidence_max'] - X['confidence_min']
            X['confidence_mid'] = (X['confidence_max'] + X['confidence_min']) / 2
            print(f"Features de confiance ajoutées: confidence_range, confidence_mid")
        
        if 'confidence_median' in X.columns and 'value' in df_work.columns:
            # Écart entre médiane et valeur réelle (si value n'est pas la target)
            if target_column != 'value' and 'value' in X.columns:
                X['confidence_deviation'] = abs(X['value'] - X['confidence_median'])
        
        # Encodage des colonnes catégorielles importantes
        if 'value_type' in X.columns:
            # Encoder le type de valeur en numérique
            value_type_mapping = {vt: idx for idx, vt in enumerate(X['value_type'].unique())}
            X['value_type_encoded'] = X['value_type'].map(value_type_mapping)
            print(f"Value type encodé: {value_type_mapping}")
        
        # Si on a encore peu de features, créer des interactions
        numeric_cols = X.select_dtypes(include=[np.number]).columns
        if len(numeric_cols) >= 2:
            # Créer quelques interactions entre les premières colonnes numériques
            col1, col2 = numeric_cols[0], numeric_cols[1]
            X[f'{col1}_x_{col2}'] = X[col1] * X[col2]
            X[f'{col1}_plus_{col2}'] = X[col1] + X[col2]
            print(f"Features d'interaction ajoutées: {col1}_x_{col2}, {col1}_plus_{col2}")
        
        print(tr("current_index", index=X.index))

    else:
        # Si la colonne cible n'est pas spécifiée ou introuvable, on ne retourne que les features
        print(tr("target_missing"))
        # Exclure les colonnes non prédictives même sans target (nouveau schéma)
        columns_to_exclude = [
            "country_name",  # nom du pays
            "who_region",    # région WHO
            "indicator_type_name",  # nom du type d'indicateur
            "value_text",    # texte de valeur
            "source_file",   # fichier source
            "data_quality",  # qualité des données
            "_sa_instance_state"  # SQLAlchemy internal
        ]
        X = df_work.drop(columns=columns_to_exclude, errors="ignore")
        y = None
        
        # Ajouter des features même sans target (nouveau schéma)
        if 'year' in X.columns:
            X['year_normalized'] = (X['year'] - X['year'].min()) / (X['year'].max() - X['year'].min() + 1e-8)
            X['year_squared'] = X['year'] ** 2
        
        # Compatibilité avec l'ancien schéma
        if 'annee' in X.columns:
            X['annee_normalized'] = (X['annee'] - X['annee'].min()) / (X['annee'].max() - X['annee'].min() + 1e-8)
            X['annee_squared'] = X['annee'] ** 2
        
        if 'country_id' in X.columns:
            X['country_id_log'] = np.log1p(X['country_id'])
            X['country_id_norm'] = X['country_id'] / (X['country_id'].max() + 1e-8)
        
        if 'indicator_type_id' in X.columns:
            X['indicator_type_id_norm'] = X['indicator_type_id'] / (X['indicator_type_id'].max() + 1e-8)
        
        if 'id' in X.columns:
            X['id_norm'] = X['id'] / (X['id'].max() + 1e-8)
        
        # Features de confiance
        if 'confidence_min' in X.columns and 'confidence_max' in X.columns:
            X['confidence_range'] = X['confidence_max'] - X['confidence_min']
            X['confidence_mid'] = (X['confidence_max'] + X['confidence_min']) / 2
        
        # Encodage du type de valeur
        if 'value_type' in X.columns:
            value_type_mapping = {vt: idx for idx, vt in enumerate(X['value_type'].unique())}
            X['value_type_encoded'] = X['value_type'].map(value_type_mapping)

    print(tr("features_shape", shape=X.shape))
    if y is not None:
        print(tr("target_count", count=len(y)))
    
    return X, y

def create_voting_regressor():
    """
    Crée un modèle combiné VotingRegressor.
    """
    model = VotingRegressor([
        ('rf', RandomForestRegressor()),
        ('knn', KNeighborsRegressor(1)),
        ('svr', SVR())
    ])
    return model




def preprocess_features(X):
    """
    Prépare les caractéristiques (features) pour l'entraînement du modèle.
    - Supprime ou encode les colonnes non numériques.
    - Nettoie les valeurs NaN.
    """
    print(tr("before_preprocessing", dtypes=X.dtypes))

    # IMPORTANT: Nettoyer les valeurs NaN avant traitement
    print(f"Valeurs NaN détectées: {X.isnull().sum().sum()}")
    if X.isnull().sum().sum() > 0:
        # Remplacer les NaN par des valeurs appropriées
        for col in X.columns:
            if X[col].dtype in ['object', 'string']:
                # Pour les colonnes texte: remplacer par 'unknown'
                X[col] = X[col].fillna('unknown')
            else:
                # Pour les colonnes numériques: remplacer par la médiane ou 0
                if X[col].nunique() > 1:
                    X[col] = X[col].fillna(X[col].median())
                else:
                    X[col] = X[col].fillna(0)
        print(f"Après nettoyage NaN: {X.isnull().sum().sum()}")

    # Identifier les colonnes catégoriques
    categorical_cols = X.select_dtypes(include=['object', 'string']).columns

    if len(categorical_cols) > 0:
        print(tr("categorical_detected", cols=categorical_cols.tolist()))

        # Encoder les colonnes catégoriques avec OneHotEncoder
        encoder = OneHotEncoder(sparse_output=False, handle_unknown='ignore')  
        encoded = pd.DataFrame(
            encoder.fit_transform(X[categorical_cols]),
            columns=encoder.get_feature_names_out(categorical_cols)
        )

        # Supprimer les colonnes catégoriques et ajouter les colonnes encodées
        X = X.drop(columns=categorical_cols).reset_index(drop=True)
        X = pd.concat([X, encoded], axis=1)
    else:
        print(tr("no_categorical"))

    # Vérifier les colonnes non numériques restantes et les supprimer
    non_numeric_cols = X.select_dtypes(exclude=['number']).columns
    if len(non_numeric_cols) > 0:
        print(tr("non_numeric_detected", cols=non_numeric_cols.tolist()))
        X = X.drop(columns=non_numeric_cols)

    print(tr("after_preprocessing", shape=X.shape))
    return X

def train_voting_regressor(model, X, y):
    """
    Entraîne un modèle VotingRegressor avec les caractéristiques (X) et la cible (y).
    Évalue le modèle après l'entraînement.
    """
    
    # Vérifications préliminaires
    if len(X) < 5:
        raise ValueError(f"Pas assez de données pour l'entraînement (seulement {len(X)} échantillons, minimum 5 requis)")
    
    if len(y) < 5:
        raise ValueError(f"Pas assez de valeurs cibles pour l'entraînement (seulement {len(y)} valeurs, minimum 5 requis)")
    
    if X.shape[1] == 0:
        raise ValueError("Aucune caractéristique disponible après préprocessing")
    
    print(f"Données prêtes pour l'entraînement: {len(X)} échantillons, {X.shape[1]} caractéristiques")

    # Séparer les données en ensemble d'entraînement et de test
    X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2, random_state=42)
    print(tr("train_size", xtrain=X_train.shape, ytrain=y_train.shape))
    print(tr("test_size", xtest=X_test.shape, ytest=y_test.shape))

    # Entraîner le modèle
    print(tr("training"))
    model.fit(X_train, y_train)
    print(tr("trained"))

    # Faire des prédictions
    print(tr("evaluating"))
    y_pred = model.predict(X_test)

    # Calculer les métriques
    mse = mean_squared_error(y_test, y_pred)
    rmse = np.sqrt(mse)
    r2 = r2_score(y_test, y_pred)

    print(tr("results"))
    print(tr("rmse", rmse=rmse))
    print(tr("r2", r2=r2))

    # Sauvegarder le graphique sans l'afficher pour éviter les plantages
    try:
        plt.figure(figsize=(10, 6))
        plt.plot(y_test.values, label="Valeurs réelles", color="blue", marker="o")
        plt.plot(y_pred, label="Prédictions", color="orange", linestyle="--", marker="x")
        plt.xlabel("Index")
        plt.ylabel("Valeurs")
        plt.title(tr("plot_title"))
        plt.legend()
        plt.grid(True)
        plt.tight_layout()
        
        # Sauvegarder le graphique au lieu de l'afficher
        plt.savefig('prediction_plot.png', dpi=150, bbox_inches='tight')
        plt.close()  # Fermer la figure pour libérer la mémoire
        print("Graphique sauvegardé dans 'prediction_plot.png'")
    except Exception as e:
        print(f"Impossible de générer le graphique: {e}")

    # Prédiction sur l'année suivante (si 'year' ou 'annee' est une feature)
    future_pred_value = None
    future_year = None
    
    # Vérifier si 'year' ou 'annee' est dans les colonnes de X (nouveau et ancien schéma)
    has_year_column = 'year' in X.columns
    has_annee_column = 'annee' in X.columns
    has_year_index = isinstance(X.index, pd.DatetimeIndex) or (hasattr(X.index, 'name') and X.index.name in ['year', 'annee'])
    
    if has_year_column or has_annee_column or has_year_index:
        try:
            if has_year_column:
                last_year = X['year'].max()
                year_col = 'year'
            elif has_annee_column:
                last_year = X['annee'].max()
                year_col = 'annee'
            else:
                last_year = X.index.max()
                year_col = None
                
            future_year = last_year + 1
            
            # Créer les features pour l'année future
            future_features = X.mean(numeric_only=True).to_dict()
            if year_col:
                future_features[year_col] = future_year
                
            future_df = pd.DataFrame([future_features])
            
            # Préprocesser les features futures
            future_df = preprocess_features(future_df)
            
            # Assurer que les colonnes correspondent
            future_df = future_df.reindex(columns=X_train.columns, fill_value=0)
            
            future_pred = model.predict(future_df)
            future_pred_value = float(future_pred[0])
            print(tr("results"))
            print(f"Prédiction pour l'année {future_year} : {future_pred_value}")
        except Exception as e:
            print(f"Erreur lors de la prédiction future: {e}")
            future_pred_value = None
            future_year = None
    else:
        print("Impossible de prédire l'année suivante (pas de colonne 'year' ou 'annee').")

    return model, rmse, r2, future_pred_value, future_year


def save_training_data(new_data, file_path="training_data.csv"):
    try:
        existing_data = pd.read_csv(file_path)
        combined_data = pd.concat([existing_data, pd.DataFrame(new_data)]).drop_duplicates()
    except FileNotFoundError:
        combined_data = pd.DataFrame(new_data)

    combined_data.to_csv(file_path, index=False)

def load_training_data(file_path="training_data.csv"):
    return pd.read_csv(file_path)
