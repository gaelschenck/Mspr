# CI/CD MSPR Pandemic Platform

Ce dépôt utilise GitHub Actions pour automatiser l'intégration continue (CI) et le déploiement continu (CD) de la plateforme MSPR Pandemic.

## Déclencheurs
- **push** et **pull_request** sur les branches `main` et `kubernetes` :
  - Le pipeline s'exécute à chaque push ou PR sur ces branches.

## Variables d'environnement
- `BACKEND_IMAGE_NAME` : Nom de l'image Docker du backend principal
- `API_IA_IMAGE_NAME` : Nom de l'image Docker de l'API IA
- `FRONTEND_IMAGE_NAME` : Nom de l'image Docker du frontend

## Jobs du pipeline

### 1. checkout
- Récupère le code source du dépôt (action de base pour tous les jobs suivants).

### 2. backend-tests
- Lance les tests pour les deux sous-dossiers backend : `msprapi` et `api_ia`.
- Utilise Python 3.9, installe les dépendances, puis exécute les tests avec couverture (`pytest --cov`).

### 3. frontend-tests
- Lance les tests unitaires du frontend.
- Utilise Node.js 16, installe les dépendances (`npm ci`), puis exécute les tests (`npm run test:unit`).

### 4. sonarcloud
- Analyse la qualité du code avec SonarCloud (adaptable à SonarQube si besoin).
- Nécessite les secrets `SONAR_ORG` et `SONAR_TOKEN`.

### 5. build-and-push
- Construit et pousse les images Docker sur Docker Hub (uniquement sur la branche `main`).
- Utilise les secrets Docker Hub pour l'authentification.
- Build et push pour : `backend/msprapi`, `backend/api_ia`, `frontend` (avec build npm pour le frontend).

### 6. deploy-fr, deploy-us, deploy-ch
- Déploie automatiquement sur les serveurs France, US et Suisse via SSH (uniquement sur la branche `main`).
- Utilise l'action `appleboy/ssh-action` et des secrets pour les accès SSH.
- Fait un `git pull` puis relance les conteneurs avec `docker-compose`.

### 7. cleanup
- Nettoie l'espace de travail à la fin du pipeline (toujours exécuté).

### 8. notify
- Envoie un mail à l'équipe en cas d'échec du pipeline (nécessite les secrets SMTP).

## Points forts
- **Parallélisation** : les tests backend et frontend peuvent s'exécuter en parallèle, ce qui accélère le pipeline.
- **Sécurité** : toutes les informations sensibles (Docker Hub, SSH, SMTP, Sonar) sont gérées via les secrets GitHub.
- **Déploiement automatisé** : dès qu'un build passe sur `main`, le déploiement est fait sur tous les environnements.
- **Qualité** : intégration de Sonar pour la qualité du code.
- **Notification** : l'équipe est prévenue en cas d'échec.

## Secrets nécessaires
- `DOCKERHUB_USERNAME` / `DOCKERHUB_TOKEN` : pour push sur Docker Hub
- `SONAR_ORG` / `SONAR_TOKEN` : pour l'analyse SonarCloud
- `FR_SERVER_HOST`, `FR_SERVER_USER`, `FR_SERVER_SSH_KEY` : accès SSH France
- `US_SERVER_HOST`, `US_SERVER_USER`, `US_SERVER_SSH_KEY` : accès SSH US
- `CH_SERVER_HOST`, `CH_SERVER_USER`, `CH_SERVER_SSH_KEY` : accès SSH Suisse
- `SMTP_USER`, `SMTP_PASS` : pour l'envoi de mails en cas d'échec

## Adaptations possibles
- SonarQube local (remplacer l'action SonarCloud)
- Notifications Slack ou autres outils
- Ajout d'environnements de staging, etc.

Pour toute question ou adaptation, contactez l'équipe DevOps !
