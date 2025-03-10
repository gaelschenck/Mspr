#!/bin/bash

echo "🚀 Démarrage du processus ETL..."

# Se déplacer dans le répertoire ETL
cd "$(dirname "$0")"

# Création de l'environnement virtuel si nécessaire
if [ ! -d "etl_env" ]; then
    echo "📦 Création de l'environnement virtuel..."
    python3 -m venv etl_env
fi

# Activation de l'environnement virtuel
echo "🔌 Activation de l'environnement virtuel..."
source etl_env/bin/activate

# Vérification et installation des dépendances si nécessaire
echo "📥 Vérification des dépendances..."
if ! pip show pandas > /dev/null 2>&1; then
    echo "📦 Installation de pandas..."
    pip install pandas
else
    echo "✅ pandas est déjà installé"
fi

# Vérification de l'existence des fichiers Python
echo "🔍 Vérification des fichiers Python..."
python_files=(
    "etl_table_pays.py"
    "etl_table_unite.py"
    "etl_table_type_statistique.py"
    "etl_table_type_traitement.py"
    "etl_table_population_hiv.py"
    "etl_table_mortalite.py"
    "etl_table_transmission_mere_enfant.py"
    "etl_table_traitement.py"
    "etl_table_statistique.py"
)

for file in "${python_files[@]}"; do
    if [ ! -f "$file" ]; then
        echo "❌ Erreur : Le fichier $file n'existe pas"
        exit 1
    fi
done

# Exécution des scripts ETL dans l'ordre
echo "🔄 Exécution des scripts ETL..."

# 1. Tables de référence
echo "📊 Création des tables de référence..."
python etl_table_pays.py
python etl_table_unite.py
python etl_table_type_statistique.py
python etl_table_type_traitement.py

# 2. Tables principales
echo "📈 Création des tables principales..."
python etl_table_population_hiv.py
python etl_table_mortalite.py
python etl_table_transmission_mere_enfant.py
python etl_table_traitement.py
python etl_table_statistique.py

# Désactivation de l'environnement virtuel
echo "🔌 Désactivation de l'environnement virtuel..."
deactivate

echo "✅ Processus ETL terminé avec succès !" 