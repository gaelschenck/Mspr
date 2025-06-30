#  README - Pipeline CI/CD MSPR

##  Vue d'ensemble

Ce projet utilise un pipeline CI/CD automatisé avec GitHub Actions pour tester, construire et déployer une application web composée d'un backend Python (FastAPI) et d'un frontend Vue.js sur un cluster Kubernetes local (Kind).

##  Architecture

```
┌─────────────────┐    ┌─────────────────┐    ┌─────────────────┐
│   GitHub Repo   │───▶│ GitHub Actions  │───▶│   Docker Hub    │
│   (Code Source) │    │   (CI/CD)       │    │   (Registry)    │
└─────────────────┘    └─────────────────┘    └─────────────────┘
                                                        │
                                                        ▼
┌─────────────────┐    ┌─────────────────┐    ┌─────────────────┐
│   Application   │◀───│      Kind       │◀───│ Déploiement     │
│   (Localhost)   │    │  (Kubernetes)   │    │    Local        │
└─────────────────┘    └─────────────────┘    └─────────────────┘
```

##  Workflow Automatisé

###  **Ce qui se passe automatiquement** :

1. **Push sur `addauth` ou `main`** → Déclenche GitHub Actions
2. **Tests Backend** → Tests Python avec pytest
3. **Tests Frontend** → Tests Vue.js avec Vitest
4. **Build Docker** → Construction des images backend et frontend
5. **Push Docker Hub** → Upload des images vers le registry
6. **Instructions de déploiement** → Affichage des étapes suivantes

###  **Ce qui nécessite une action manuelle** :

7. **Déploiement local** → Lancement de `init_and_deploy.bat`

##  Structure du Projet

```
MSPR/
├── .github/workflows/
│   └── ci.yml                    # Pipeline CI/CD
├── backend/                      # API Python (FastAPI)
│   ├── Dockerfile
│   ├── main.py
│   ├── requirements.txt
│   └── tests/
├── frontend/                     # Interface Vue.js
│   ├── Dockerfile
│   ├── package.json
│   ├── src/
│   └── tests/
├── k8s_manifests/               # Configurations Kubernetes
├── init_and_deploy.bat          # Script de déploiement local
└── CONFIGURATION_SECRETS_GITHUB.md
```

##  Démarrage Rapide

### 1⃣ **Prérequis**

- [Docker Desktop](https://www.docker.com/products/docker-desktop)
- [Kind](https://kind.sigs.k8s.io/docs/user/quick-start/)
- [kubectl](https://kubernetes.io/docs/tasks/tools/)
- Compte [Docker Hub](https://hub.docker.com)
- Repository GitHub

### 2⃣ **Configuration initiale**

1. **Cloner le repository** :
   ```bash
   git clone <votre-repo>
   cd MSPR
   ```

2. **Configurer les secrets Docker Hub** :
   - Suivre le guide : `CONFIGURATION_SECRETS_GITHUB.md`
   - Créer un token Docker Hub
   - Ajouter les secrets dans GitHub

### 3⃣ **Premier déploiement**

1. **Push sur la branche de développement** :
   ```bash
   git checkout addauth
   git add .
   git commit -m "Configuration initiale"
   git push origin addauth
   ```

2. **Vérifier le pipeline** :
   - Aller sur GitHub → onglet "Actions"
   - Attendre que tous les tests passent 

3. **Déployer localement** :
   ```bash
   # Lancer le script de déploiement
   init_and_deploy.bat
   # Choisir l'option [3] : Déploiement complet
   ```

4. **Accéder à l'application** :
   - Frontend : http://localhost:8080
   - API : http://localhost:8080/api

##  Développement Quotidien

### **Pour ajouter une nouvelle fonctionnalité** :

1. **Créer une branche** :
   ```bash
   git checkout -b feature/ma-nouvelle-fonctionnalite
   ```

2. **Développer et tester localement** :
   ```bash
   # Backend
   cd backend
   python -m pytest

   # Frontend  
   cd frontend
   npm test
   ```

3. **Push et tests automatiques** :
   ```bash
   git add .
   git commit -m "Ajout de ma nouvelle fonctionnalité"
   git push origin feature/ma-nouvelle-fonctionnalite
   ```

4. **Merge vers addauth** :
   ```bash
   git checkout addauth
   git merge feature/ma-nouvelle-fonctionnalite
   git push origin addauth
   ```

5. **Déployer** :
   - Attendre que GitHub Actions termine
   - Lancer `init_and_deploy.bat` → option [3]

### **Pour un hotfix urgent** :

```bash
git checkout addauth
# Faire les modifications
git add .
git commit -m "Hotfix: correction urgente"
git push origin addauth
# Déployer immédiatement avec init_and_deploy.bat
```

##  Monitoring et Debugging

### **Vérifier l'état du cluster** :

```bash
kubectl get pods                    # État des pods
kubectl get services               # Services exposés
kubectl logs <nom-du-pod>         # Logs d'un pod spécifique
```

### **Accéder aux logs** :

- **Logs du pipeline** : GitHub → Actions → Cliquer sur le run
- **Logs des pods** : Sauvegardés automatiquement dans `logs_pods/`
- **Logs en temps réel** : `kubectl logs -f <nom-du-pod>`

### **Résoudre les problèmes courants** :

1. **Pipeline failed** → Vérifier l'onglet Actions sur GitHub
2. **Images non trouvées** → Vérifier les secrets Docker Hub
3. **Pods en erreur** → `kubectl describe pod <nom-du-pod>`
4. **Port-forward échoue** → Vérifier que les services sont démarrés

##  Fonctionnalités Avancées

### **Sauvegarde automatique** :
- **Bases de données** → Sauvegardées automatiquement après chaque déploiement
- **Logs** → Archivés par date dans `logs_pods/`

### **Multi-environnement** :
- **Développement** → Branche `addauth`
- **Production** → Branche `main`
- **Tests** → Branches `feature/*`

### **Sécurité** :
- **Secrets chiffrés** → GitHub Secrets pour Docker Hub
- **Tests obligatoires** → Le déploiement ne se fait que si les tests passent
- **Isolation** → Cluster Kind isolé du système

##  Support

### **Problèmes fréquents** :

| Problème | Solution |
|----------|----------|
| Docker Desktop non lancé | Démarrer Docker Desktop |
| Kind cluster introuvable | `kind create cluster --name mspr` |
| Tests frontend échouent | Vérifier `npm test` vs `npm run test:unit` |
| Images Docker Hub inaccessibles | Vérifier les secrets GitHub |

### **Obtenir de l'aide** :

1. **Vérifier** le guide `CONFIGURATION_SECRETS_GITHUB.md`
2. **Consulter** les logs dans l'onglet Actions de GitHub
3. **Créer** une issue avec les logs d'erreur

##  Documentation Complète

-  **Configuration détaillée** : `CONFIGURATION_SECRETS_GITHUB.md`
-  **Debugging** : `logs_pods/` pour les logs historiques
-  **Sauvegarde/Restauration** : `BACKUP_RESTORE.md`

---

** Félicitations !** Vous avez maintenant un pipeline CI/CD moderne, automatisé et robuste pour votre application MSPR !
##  Secrets nécessaires pour votre setup Kind

Pour votre configuration actuelle (déploiement local avec Kind), vous n'avez besoin que de :

| Secret | Description | Obligatoire |
|--------|-------------|-------------|
| `DOCKERHUB_USERNAME` | Votre nom d'utilisateur Docker Hub |  Oui |
| `DOCKERHUB_TOKEN` | Token d'accès Docker Hub |  Oui |

###  **Secrets NON nécessaires** (ancien pipeline) :
- ~~`SONAR_ORG` / `SONAR_TOKEN`~~ → Pas de SonarCloud dans votre pipeline
- ~~`FR_SERVER_HOST`, `FR_SERVER_USER`, `FR_SERVER_SSH_KEY`~~ → Pas de serveur distant
- ~~`US_SERVER_HOST`, `US_SERVER_USER`, `US_SERVER_SSH_KEY`~~ → Pas de serveur distant  
- ~~`CH_SERVER_HOST`, `CH_SERVER_USER`, `CH_SERVER_SSH_KEY`~~ → Pas de serveur distant
- ~~`SMTP_USER`, `SMTP_PASS`~~ → Pas de notifications mail configurées

###  **Configuration simplifiée** :

1. **Allez sur Docker Hub** → Créer un token
2. **Allez sur GitHub** → Settings → Secrets → Ajouter les 2 secrets
3. **C'est tout !** Votre pipeline fonctionnera

###  **Pourquoi ces 2 secrets suffisent** :

- **Tests** → Se lancent sur GitHub (pas de secrets requis)
- **Build** → Se fait sur GitHub (pas de secrets requis)  
- **Push Docker Hub** → Nécessite l'authentification (secrets requis)
- **Déploiement** → Se fait en local avec votre script (pas de secrets requis)

---
