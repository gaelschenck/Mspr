# Rapports de Tests

Ce dossier contient les rapports générés par les tests automatisés, organisés par session.

## Structure des dossiers

Chaque exécution de tests crée un nouveau sous-dossier daté :

```
reports/
├── session_20241220_143022/
│   ├── session_metadata.json          # Métadonnées de la session
│   ├── test_report_Tests_critiques_CI_CD.html
│   ├── test_report_Tests_des_modeles_normalises.html
│   ├── test_report_Tests_des_schemas_normalises.html
│   ├── test_report_Tests_de_logique_metier.html
│   └── coverage/
│       ├── index.html                 # Rapport de couverture principal
│       └── htmlcov/
├── session_20241220_151045/
│   └── ...
└── README.md (ce fichier)
```

## Types de rapports

### Métadonnées de session (`session_metadata.json`)
- Résumé complet de la session de tests
- Statistiques de réussite/échec
- Configuration utilisée (mode rapide/complet, rapports activés)
- Détails de chaque test exécuté

### Rapports HTML individuels (`test_report_*.html`)
- Un fichier par module de test
- Détails d'exécution de chaque test
- Logs complets en cas d'erreur
- Usage : Ouvrir dans un navigateur

### Rapport de couverture (`coverage/index.html`)
- Pourcentage de couverture du code
- Lignes non testées par fichier
- Statistiques détaillées par module

## Commandes pour générer les rapports

```bash
# Tests rapides avec rapport HTML
python tests/run_all_tests.py --quick --html

# Tests complets avec couverture
python tests/run_all_tests.py --coverage

# Tous les tests avec tous les rapports
python tests/run_all_tests.py --all-reports
```

## Avantages de cette organisation

- **Historique complet** : Chaque session est conservée
- **Comparaison facile** : Comparer les résultats entre sessions
- **Traçabilité** : Métadonnées complètes pour chaque exécution
- **Organisation claire** : Pas de conflits entre sessions
