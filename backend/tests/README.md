# Tests Backend - Organisation et Guide

## Structure des Tests

###  Organisation des Fichiers de Tests

```
tests/
├── README.md                          # Ce fichier
├── __init__.py                        # Module Python
├── run_all_tests.py                   # Script pour tous les tests
├── run_essential_tests.py             # Script pour tests rapides
│
├── test_cicd_critical.py              # Tests critiques CI/CD
├── test_models_normalized.py          # Tests des modèles SQLAlchemy
├── test_schemas_normalized.py         # Tests des schémas Pydantic
├── test_business_logic.py             # Tests de logique métier
├── test_database_integration.py       # Tests d'intégration DB
├── test_api_endpoints.py              # Tests des endpoints API
├── test_ml_endpoints.py               # Tests spécifiques ML
├── test_prediction_ml.py              # Tests de prédiction ML
└── test_performance.py                # Tests de performance
```

###  Types de Tests

#### 1. **Tests Critiques (test_cicd_critical.py)**
- Tests de base pour CI/CD
- Vérification de l'environnement
- Tests de dépendances
- Structure des fichiers

#### 2. **Tests de Modèles (test_models_normalized.py)**
- Tests des modèles SQLAlchemy
- Création d'objets
- Validation des champs
- Relations entre modèles

#### 3. **Tests de Schémas (test_schemas_normalized.py)**
- Tests des schémas Pydantic
- Validation des données
- Sérialisation/désérialisation
- Gestion des erreurs

#### 4. **Tests de Logique Métier (test_business_logic.py)**
- Validation des règles métier
- Cohérence des données
- Calculs et transformations
- Cas d'usage spécifiques

#### 5. **Tests d'Intégration DB (test_database_integration.py)**
- Tests avec base de données réelle
- Opérations CRUD
- Relations et contraintes
- Valeurs par défaut

#### 6. **Tests API (test_api_endpoints.py)**
- Tests des endpoints REST
- Réponses HTTP
- Gestion d'erreurs
- Formats de données

#### 7. **Tests ML Endpoints (test_ml_endpoints.py)**
- Tests spécifiques aux endpoints ML
- Validation des requêtes
- Gestion des erreurs ML
- Formats de réponse

#### 8. **Tests Prédiction ML (test_prediction_ml.py)**
- Pipeline ML complet
- Préparation des données
- Entraînement des modèles
- Validation des prédictions

#### 9. **Tests Performance (test_performance.py)**
- Temps de réponse
- Gestion de charge
- Efficacité mémoire
- Scalabilité

##  Comment Exécuter les Tests

### Tests Rapides (Essentiels)
```bash
cd backend
python tests/run_essential_tests.py
```

### Suite Complète
```bash
cd backend
python tests/run_all_tests.py
```

### Tests Individuels
```bash
cd backend
python -m pytest tests/test_models_normalized.py -v
python -m pytest tests/test_api_endpoints.py -v
```

### Avec Couverture
```bash
cd backend
python -m pytest tests/ --cov=. --cov-report=html
```

##  Priorités des Tests

###  Priorité Critique (CI/CD)
- `test_cicd_critical.py` - Doit toujours passer
- `test_models_normalized.py` - Structure de base
- `test_schemas_normalized.py` - Validation des données

###  Priorité Haute (Développement)
- `test_business_logic.py` - Logique métier
- `test_api_endpoints.py` - Fonctionnalités API

###  Priorité Moyenne (Stabilité)
- `test_database_integration.py` - Intégrations
- `test_ml_endpoints.py` - Fonctionnalités ML

###  Priorité Basse (Optimisation)
- `test_prediction_ml.py` - ML avancé
- `test_performance.py` - Performance

##  Configuration des Tests

### Prérequis
```bash
pip install pytest pytest-asyncio httpx aiosqlite
```

### Variables d'Environnement pour Tests
```bash
export TESTING=true
export DATABASE_URL=sqlite+aiosqlite:///:memory:
```

### Configuration Pytest
Le fichier `pytest.ini` se trouve dans le dossier backend racine.

##  Bonnes Pratiques

###  À Faire
- Utiliser `pytest.mark.asyncio` pour les tests async
- Mocker les dépendances externes
- Tester les cas d'erreur
- Vérifier les types de retour
- Utiliser des fixtures pour les données de test

###  À Éviter
- Tests dépendants de l'ordre d'exécution
- Hardcoder des valeurs spécifiques à un environnement
- Tests trop longs (> 30s)
- Dépendances entre tests

##  Debugging des Tests

### Exécution avec Debug
```bash
python -m pytest tests/test_name.py -v -s --tb=long
```

### Tests Spécifiques
```bash
python -m pytest tests/test_name.py::TestClass::test_method -v
```

### Arrêt au Premier Échec
```bash
python -m pytest tests/ -x
```

##  Métriques de Qualité

### Couverture Cible
- Code Coverage > 80%
- Tests critiques: 100%
- API endpoints: 95%
- Logique métier: 90%

### Temps d'Exécution Cible
- Tests essentiels: < 30 secondes
- Suite complète: < 5 minutes
- Tests individuels: < 10 secondes

##  Intégration CI/CD

### GitHub Actions
Les tests sont intégrés dans `.github/workflows/` avec:
- Tests essentiels à chaque push
- Suite complète sur PR
- Tests de performance sur release

### Hooks Git
Configurez des hooks pré-commit pour exécuter les tests essentiels:
```bash
# .git/hooks/pre-commit
#!/bin/bash
cd backend && python tests/run_essential_tests.py
```

##  Résolution de Problèmes

### Tests qui Échouent
1. Vérifier les logs détaillés
2. Contrôler l'environnement Python
3. Vérifier les dépendances
4. Tester individuellement

### Timeouts
1. Augmenter les timeouts si nécessaire
2. Optimiser les requêtes lentes
3. Mocker les services externes

### Erreurs de Base de Données
1. Vérifier la connexion DB
2. Contrôler les migrations
3. Nettoyer les données de test

## CI/CD

Les tests sont conçus pour être robustes :
- Les tests critiques (basic, data_validation) passent toujours
- Les tests optionnels sont ignorés si les dépendances manquent
- Les tests d'endpoints sont ignorés si le serveur n'est pas actif

## Corrections apportées

- Ajout d'aiohttp dans requirements.txt
- Correction de l'endpoint transmission_mere_enfant
- Tests robustes avec gestion d'erreurs
- Organisation en dossier dédié
- Suppression de tous les emojis
