# Configuration SonarQube pour MSPR

## Vue d'ensemble

SonarQube est intégré dans notre pipeline CI/CD pour analyser automatiquement la qualité du code à chaque push et pull request. Cette version on-premise vous donne un contrôle total sur vos données et une personnalisation avancée.

## Configuration requise

### 1. Démarrage de SonarQube Local

```bash
# Démarrer SonarQube avec Docker
./start_sonarqube.bat

# Ou manuellement
cd essaidocker
docker-compose up -d sonarqube db_sonar
```

### 2. Configuration initiale SonarQube

1. Accédez à http://localhost:9000
2. Connectez-vous avec `admin` / `admin`
3. Changez le mot de passe administrateur
4. Créez un nouveau projet :
   - Project key: `mspr-platform`
   - Display name: `MSPR Platform`
5. Générez un token d'authentification :
   - Account > Security > Generate Token
   - Nom: `GitHub Actions`
   - Type: `Global Analysis Token`

### 3. Configuration des secrets GitHub

Dans votre repository GitHub, allez dans Settings > Secrets and variables > Actions et ajoutez :

- `SONAR_TOKEN` : Token généré depuis SonarQube
- `SONAR_HOST_URL` : URL de votre serveur SonarQube (ex: `http://votre-serveur:9000`)

### 4. Fichiers de configuration

- `sonar-project.properties` : Configuration principale de SonarQube
- `essaidocker/docker-compose.yaml` : Services SonarQube et PostgreSQL
- `.github/workflows/ci.yml` : Pipeline CI/CD avec intégration SonarQube

## Analyse locale

Pour analyser votre code localement avant le push :

```bash
# Script automatisé
./run_sonar_analysis.bat

# Ou manuellement
# 1. Tests avec couverture
cd backend && python -m pytest --cov=. --cov-report=xml
cd frontend && npm run test -- --coverage

# 2. Analyse SonarQube
sonar-scanner \
  -Dsonar.projectKey=mspr-platform \
  -Dsonar.host.url=http://localhost:9000 \
  -Dsonar.login=YOUR_TOKEN
```

## Métriques analysées

### Backend (Python)
- Couverture de code via pytest-cov
- Complexité cyclomatique
- Duplications de code
- Vulnérabilités de sécurité
- Code smells
- Bugs potentiels
- Standards PEP8

### Frontend (Vue.js/JavaScript)
- Couverture de code via Vitest
- Qualité du code JavaScript/Vue
- Complexité des composants
- Standards ESLint
- Vulnérabilités npm

## Architecture

```
┌─────────────────┐    ┌─────────────────┐    ┌─────────────────┐
│   GitHub        │    │   CI/CD         │    │   SonarQube     │
│   Repository    │───▶│   Pipeline      │───▶│   Analysis      │
└─────────────────┘    └─────────────────┘    └─────────────────┘
                              │
                              ▼
                       ┌─────────────────┐
                       │   Docker        │
                       │   Containers    │
                       └─────────────────┘
```

## Quality Gate

Le pipeline échouera si :
- La couverture de code diminue de plus de 5%
- De nouveaux bugs critiques ou majeurs sont introduits
- La note de sécurité est inférieure à A
- La note de maintenabilité est inférieure à A
- Plus de 3% de duplications de code

## Visualisation

Les résultats sont visibles :
1. Dans les checks GitHub sur les PR
2. Sur le dashboard SonarQube (http://localhost:9000)
3. Rapports détaillés par module/composant

## Maintenance

```bash
# Sauvegarder les données SonarQube
docker-compose exec db_sonar pg_dump -U sonar sonar > backup_sonar.sql

# Mettre à jour SonarQube
docker-compose pull sonarqube
docker-compose up -d sonarqube

# Nettoyer les anciennes analyses
# Via l'interface SonarQube : Administration > Projects > Housekeeping
```

## Troubleshooting

### SonarQube ne démarre pas
```bash
# Vérifier les logs
docker-compose logs sonarqube

# Augmenter la mémoire si nécessaire
# Ajouter dans docker-compose.yaml :
# environment:
#   - "SONAR_ES_BOOTSTRAP_CHECKS_DISABLE=true"
```

### Erreur d'analyse
```bash
# Vérifier la connectivité
curl http://localhost:9000/api/system/status

# Nettoyer le cache local
rm -rf .sonar/
```

## Personnalisation avancée

- **Règles personnalisées** : Administration > Rules
- **Quality Profiles** : Administration > Quality Profiles  
- **Quality Gates** : Administration > Quality Gates
- **Webhooks** : Administration > Configuration > Webhooks
