# ETL Scripts - Version Optimisée

## 📋 Description

Ce dossier contient les scripts ETL (Extract, Transform, Load) optimisés pour transformer les données sources en datasets clean utilisables.

## 🚀 Scripts Principaux

### Scripts ETL de Production
- `etl_table_unite.py` - Table de référence des unités
- `etl_table_type_statistique.py` - Table de référence des types statistiques
- `etl_table_type_traitement.py` - Table de référence des types de traitement
- `etl_table_pays.py` - Table des pays avec régions OMS
- `etl_table_population_hiv.py` - Données population HIV
- `etl_table_mortalite.py` - Données de mortalité
- `etl_table_transmission_mere_enfant.py` - Données transmission mère-enfant
- `etl_table_traitement.py` - Données de traitement
- `etl_table_statistique.py` - Données statistiques consolidées

### Scripts d'Exécution
- `run_etl.bat` - Script batch Windows pour exécuter tous les ETL
- `run_etl.sh` - Script bash (ancien, remplacé par le .bat)

### Scripts de Validation et Test
- `validate_etl.py` - Validation complète des scripts ETL
- `test_run_etl.py` - Test de performance et fonctionnalité
- `clean_emojis_etl.py` - Nettoyage des emojis dans le code

### Scripts d'Optimisation
- `optimize_etl.py` - Module d'optimisation des performances
- `template_etl_optimized.py` - Template ETL optimisé

## 🔧 Installation et Configuration

### Prérequis
```bash
# Vérification Python
python --version  # Requis: Python 3.8+

# Installation des dépendances
pip install -r requirements.txt
```

## 🏃‍♂️ Utilisation

### Exécution Complète (Recommandée)
```cmd
# Windows
run_etl.bat
```

### Validation Avant Exécution
```cmd
python validate_etl.py
```

## 📊 Optimisations Implémentées

### Performance
- **Suppression des emojis** - Compatibilité encodage améliorée
- **Gestion d'erreurs robuste** - Try/catch complets
- **Logging détaillé** - Traçabilité des opérations
- **Tests automatisés** - Validation continue

### Temps d'Exécution Typiques
- Scripts de référence: ~0.6s chacun
- Scripts principaux: ~0.6s chacun
- **Total ETL complet: ~5.5s**

## 🚨 Support

Pour toute question, consulter les logs d'erreur et exécuter `validate_etl.py`.

**Version**: 2.0 Optimisée
- `etl_table_population_hiv.py` : Données VIH
- `etl_table_mortalite.py` : Données mortalité
- `etl_table_transmission_mere_enfant.py` : Transmission mère-enfant
- `etl_table_traitement.py` : Données traitements
- `etl_table_statistique.py` : Statistiques générales

## Dépendances
- Python 3.8+
- pandas : Traitement des données
- numpy : Calculs numériques
- python-dateutil : Gestion des dates
- pytz : Gestion des fuseaux horaires

## Fonctionnement
1. Lecture des CSV depuis `../SourceData`
2. Nettoyage :
   - Suppression des lignes vides
   - Standardisation des noms de pays
   - Conversion des valeurs
3. Génération des fichiers dans `../DatasetClean`

## Installation
```bash
# Créer l'environnement virtuel
python3 -m venv etl_env
source etl_env/bin/activate  # Unix
# ou
.\etl_env\Scripts\activate   # Windows

# Installer les dépendances
pip install -r requirements.txt
```

## Utilisation
```bash
# Lancer le traitement
bash run_etl.sh
``` 