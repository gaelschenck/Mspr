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
    print(f"Taille du DataFrame avant préparation : {df.shape}")
    print(f"Colonnes présentes : {df.columns}")

    
    if target_column and target_column in df.columns:
        # Séparer la cible et les caractéristiques
        X = df.drop(columns=[target_column, "region", "nom_pays", "sous_region","id_unite"])
        y = df[target_column]
        print(f"🔍 Colonne cible : { target_column }")
        print("Index actuel :", df.index)
        df.set_index('annee', inplace=True)
        print("Index actuel :", df.index)

    else:
        # Si la colonne cible n'est pas spécifiée ou introuvable, on ne retourne que les features
        print("🔍 Colonne cible non spécifiée ou absente. Utilisation des seules caractéristiques.")
        X = df
        y = None

    print(f"✅ Données préparées. Dimensions des caractéristiques : {X.shape}")
    if y is not None:
        print(f"✅ Colonne cible détectée. Nombre de cibles : {len(y)}")
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

def save_training_data(new_data, file_path="training_data.csv"):
    try:
        existing_data = pd.read_csv(file_path)
        combined_data = pd.concat([existing_data, pd.DataFrame(new_data)]).drop_duplicates()
    except FileNotFoundError:
        combined_data = pd.DataFrame(new_data)

    combined_data.to_csv(file_path, index=False)

def load_training_data(file_path="training_data.csv"):
    return pd.read_csv(file_path)


def preprocess_features(X):
    """
    Prépare les caractéristiques (features) pour l'entraînement du modèle.
    - Supprime ou encode les colonnes non numériques.
    """
    print(f"Avant prétraitement, types des colonnes :\n{X.dtypes}")

    # Identifier les colonnes catégoriques
    categorical_cols = X.select_dtypes(include=['object', 'string']).columns

    if len(categorical_cols) > 0:
        print(f"Colonnes catégoriques détectées : {categorical_cols.tolist()}")

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
        print("Aucune colonne catégorique détectée.")

    # Vérifier les colonnes non numériques restantes et les supprimer
    non_numeric_cols = X.select_dtypes(exclude=['number']).columns
    if len(non_numeric_cols) > 0:
        print(f"Colonnes non numériques détectées après encodage : {non_numeric_cols.tolist()}")
        X = X.drop(columns=non_numeric_cols)

    print(f"Après prétraitement, dimensions de X : {X.shape}")
    return X

def train_voting_regressor(model, X, y):
    """
    Entraîne un modèle VotingRegressor avec les caractéristiques (X) et la cible (y).
    Évalue le modèle après l'entraînement.
    """

    # Séparer les données en ensemble d'entraînement et de test
    X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2, random_state=42)
    print(f"Taille de X_train : {X_train.shape}, Taille de y_train : {y_train.shape}")
    print(f"Taille de X_test : {X_test.shape}, Taille de y_test : {y_test.shape}")

    # Entraîner le modèle
    print("🚀 Entraînement du modèle...")
    model.fit(X_train, y_train)
    print("✅ Modèle entraîné avec succès !")

    # Faire des prédictions
    print("📊 Évaluation du modèle...")
    y_pred = model.predict(X_test)

    # Calculer les métriques
    mse = mean_squared_error(y_test, y_pred)
    rmse = np.sqrt(mse)
    r2 = r2_score(y_test, y_pred)

    print(f"📈 Résultats :")
    print(f"Root Mean Squared Error (RMSE) : {rmse:.2f}")
    print(f"R² score : {r2:.2f}")

    


    plt.figure(figsize=(10, 6))
    plt.plot(y_test.values, label="Valeurs réelles", color="blue", marker="o")
    plt.plot(y_pred, label="Prédictions", color="orange", linestyle="--", marker="x")
    plt.xlabel("Index")
    plt.ylabel("Valeurs")
    plt.title("📈 Comparaison des valeurs réelles et prédictions")
    plt.legend()
    plt.grid(True)
    plt.tight_layout()
    plt.show()

    return model

def save_training_data(new_data, file_path="training_data.csv"):
    try:
        existing_data = pd.read_csv(file_path)
        combined_data = pd.concat([existing_data, pd.DataFrame(new_data)]).drop_duplicates()
    except FileNotFoundError:
        combined_data = pd.DataFrame(new_data)

    combined_data.to_csv(file_path, index=False)

def load_training_data(file_path="training_data.csv"):
    return pd.read_csv(file_path)


def preprocess_features(X):
    """
    Prépare les caractéristiques (features) pour l'entraînement du modèle.
    - Supprime ou encode les colonnes non numériques.
    """
    

    print(f"Avant prétraitement, types des colonnes :\n{X.dtypes}")

    # Identifier les colonnes catégoriques
    categorical_cols = X.select_dtypes(include=['object', 'string']).columns

    if len(categorical_cols) > 0:
        print(f"Colonnes catégoriques détectées : {categorical_cols.tolist()}")

        # OneHotEncoder pour les colonnes catégoriques
        encoder = OneHotEncoder(sparse_output=False)
        encoded = pd.DataFrame(encoder.fit_transform(X[categorical_cols]), columns=encoder.get_feature_names_out(categorical_cols))
        
        # Retirer les colonnes non numériques et ajouter les colonnes encodées
        X = X.drop(columns=categorical_cols).reset_index(drop=True)
        X = pd.concat([X, encoded], axis=1)
    else:
        print("Aucune colonne catégorique détectée.")

    print(f"Après prétraitement, dimensions de X : {X.shape}")
    return X
