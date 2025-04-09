from sqlalchemy.ext.asyncio import AsyncSession
from sqlalchemy import select
import models
import pandas as pd
from sklearn.model_selection import train_test_split
from sklearn.ensemble import RandomForestClassifier  
import joblib

async def load_data_from_db(db: AsyncSession):
    """
    Fonction pour charger les données nécessaires depuis la base de données.
    """
    result = await db.execute(select(models.PopulationHIV))  # Adapte à la table que tu utilises.
    data = result.scalars().all()
    return data

def preprocess_data(data):
    """
    Fonction pour transformer les données brutes en un DataFrame prêt à l'emploi.
    """
    df = pd.DataFrame([item.__dict__ for item in data])  # Convertir les objets SQLAlchemy en DataFrame.
    df = df.drop('_sa_instance_state', axis=1, errors='ignore')  # Supprimer les métadonnées SQLAlchemy.
    
    # Ajoute ici les transformations nécessaires (par ex : nettoyage, encodage, gestion des valeurs manquantes).
    return df

def train_model(df):
    """
    Fonction pour entraîner un modèle de machine learning.
    """
    # Séparer les caractéristiques (features) et la cible (target)
    X = df.drop(columns=['target_column'])  # Remplace 'target_column' par le nom de ta colonne cible.
    y = df['target_column']
    
    # Diviser les données en ensembles d'entraînement et de test
    X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2, random_state=42)
    
    # Créer et entraîner le modèle
    model = RandomForestClassifier()
    model.fit(X_train, y_train)
    
    # Évalue le modèle sur l'ensemble de test
    score = model.score(X_test, y_test)
    print(f"Score du modèle : {score}")
    
    # Sauvegarder le modèle pour utilisation future
    joblib.dump(model, "model.pkl")
    return model


# Charger ton modèle de prédiction (fichier .pkl)

# model = joblib.load("model.pkl")  # Assure-toi que le chemin est correct.

def make_prediction(features):
    """
    Fonction pour exécuter une prédiction basée sur les caractéristiques fournies.
    """
    prediction = model.predict([features])
    return prediction.tolist()