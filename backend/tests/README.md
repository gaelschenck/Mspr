# Tests Backend MSPR

## Structure des tests

```
backend/
├── tests/                          # Dossier contenant tous les tests
│   ├── __init__.py                 # Fichier pour que tests soit un package Python
│   ├── test_basic.py               # Tests de base (toujours fonctionnels)
│   ├── test_data_validation.py     # Tests de validation des données
│   ├── test_models.py              # Tests des modèles SQLAlchemy
│   ├── test_schemas.py             # Tests des schémas Pydantic
│   └── test_api_endpoints.py       # Tests des endpoints API
├── pytest.ini                     # Configuration pytest
├── requirements.txt                # Dépendances (inclut aiohttp maintenant)
└── update_dependencies.py         # Script de mise à jour
```

## Commandes utiles

### Mise à jour des dépendances
```bash
python update_dependencies.py
```

### Lancer tous les tests
```bash
python -m pytest tests/ -v
```

### Lancer des tests spécifiques
```bash
python -m pytest tests/test_basic.py -v
python -m pytest tests/test_data_validation.py -v
```

### Tests avec marqueurs
```bash
python -m pytest -m unit          # Tests unitaires seulement
python -m pytest -m integration   # Tests d'intégration seulement
```

## Types de tests

1. **test_basic.py** - Tests de base qui passent toujours
2. **test_data_validation.py** - Validation de la logique métier
3. **test_models.py** - Tests des modèles SQLAlchemy (optionnels)
4. **test_schemas.py** - Tests des schémas Pydantic (optionnels)
5. **test_api_endpoints.py** - Tests des endpoints (nécessite serveur actif)

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
