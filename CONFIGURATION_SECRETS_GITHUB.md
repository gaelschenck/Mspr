# 🔐 Configuration des Secrets GitHub pour CI/CD

Ce guide vous explique comment configurer les secrets GitHub pour votre pipeline CI/CD MSPR.

## 📋 Vue d'ensemble

Votre setup actuel :
- **Déploiement local** : Kind (Kubernetes in Docker)
- **Script de déploiement** : `init_and_deploy.bat`
- **Images Docker** : Construites localement sans push vers un registry

## 🎯 Deux options de configuration

### 📦 **Option 1 : Pipeline avec Docker Hub (Recommandée pour le partage)**

#### Étape 1 : Créer un compte Docker Hub

1. Allez sur [hub.docker.com](https://hub.docker.com)
2. Créez un compte gratuit
3. Connectez-vous

#### Étape 2 : Créer un Access Token Docker Hub

1. Dans Docker Hub, cliquez sur votre **nom d'utilisateur** (en haut à droite)
2. Allez dans **Account Settings** 
3. Onglet **Security** 
4. Cliquez sur **New Access Token** 
5. Nom : `github-actions-mspr`
6. Permissions : **Read, Write, Delete**
7. **Copiez le token** (vous ne pourrez plus le voir après !)

#### Étape 3 : Configurer les secrets GitHub

1. Allez sur votre repository GitHub
2. Cliquez sur **Settings** (onglet en haut)
3. Dans le menu de gauche : **Secrets and variables** → **Actions**
4. Cliquez sur **New repository secret**

Ajoutez ces secrets :

| Nom | Valeur | Description |
|-----|--------|-------------|
| `DOCKERHUB_USERNAME` | `votre_nom_utilisateur_dockerhub` | Votre nom d'utilisateur Docker Hub |
| `DOCKERHUB_TOKEN` | `le_token_copié_étape2` | Le token d'accès Docker Hub |

#### Étape 4 : Mettre à jour les noms d'images

Dans votre `ci.yml`, changez :

```yaml
env:
  BACKEND_IMAGE_NAME: votre_nom_dockerhub/mspr-backend
  FRONTEND_IMAGE_NAME: votre_nom_dockerhub/mspr-frontend
```

Remplacez `votre_nom_dockerhub` par votre vrai nom d'utilisateur Docker Hub.

#### Étape 5 : Adapter le déploiement local

**Option 5a : Déploiement automatique local (Avancé)**

Si vous voulez que GitHub Actions déclenche votre déploiement local :

1. Installez ngrok : [ngrok.com](https://ngrok.com)
2. Créez un webhook local
3. Configurez les secrets suivants :

| Nom | Valeur | Description |
|-----|--------|-------------|
| `WEBHOOK_URL` | `https://votre-tunnel-ngrok.com/deploy` | URL de votre webhook local |
| `WEBHOOK_SECRET` | `un_secret_aleatoire_fort` | Secret pour sécuriser le webhook |

**Option 5b : Déploiement manuel (Simple)**

Modifiez votre script `init_and_deploy.bat` pour utiliser les images de Docker Hub :

```bat
echo ============================
echo [2/6] Pull des images depuis Docker Hub
echo ============================
docker pull votre_nom_dockerhub/mspr-backend:latest
docker pull votre_nom_dockerhub/mspr-frontend:latest

echo ============================
echo [3/6] Tag des images pour Kind
echo ============================
docker tag votre_nom_dockerhub/mspr-backend:latest my_backend_image:latest
docker tag votre_nom_dockerhub/mspr-frontend:latest my_frontend_image:latest
```

---

### 🏠 **Option 2 : Pipeline sans Docker Hub (Local uniquement)**

Si vous voulez garder tout en local, modifiez votre `ci.yml` :

```yaml
  build-only:
    runs-on: ubuntu-latest
    needs: [backend-tests, frontend-tests]
    steps:
      - name: Checkout code
        uses: actions/checkout@v4
      - name: Build backend (test de compilation)
        run: |
          cd backend
          docker build -t my_backend_image:latest .
      - name: Build frontend (test de compilation)
        run: |
          cd frontend
          npm ci
          npm run build
          docker build -t my_frontend_image:latest .
      - name: Save build artifacts
        uses: actions/upload-artifact@v4
        with:
          name: docker-images
          path: |
            backend/Dockerfile
            frontend/Dockerfile
            frontend/dist/

  # Supprimez le job "deploy" et "build-and-push"
```

---

## 🚀 Workflow recommandé

### Pour le développement (branche `addauth`) :

1. **Push** → Tests automatiques + Build sans déploiement
2. **Déploiement manuel** avec votre script `init_and_deploy.bat`

### Pour la production (branche `main`) :

1. **Push** → Tests + Build + Push vers Docker Hub
2. **Déploiement** soit automatique (webhook) soit manuel

---

## 🔧 Commandes utiles

### Vérifier vos secrets GitHub :
```bash
# Dans votre repository GitHub
Settings → Secrets and variables → Actions
```

### Tester la connexion Docker Hub :
```bash
docker login -u votre_nom_utilisateur
# Entrez votre token comme mot de passe
```

### Tester le push d'image :
```bash
docker build -t gaelschenck/mspr-backend:test backend/
docker push gaelschenck/mspr-backend:test
```

---

## ❓ FAQ

**Q : Dois-je configurer les secrets SERVER_HOST, SERVER_USER, etc. ?**
**R :** Non, pas avec votre setup Kind local. Ces secrets sont pour un déploiement sur serveur distant.

**Q : Mes tests échouent avec "npm run test:unit", que faire ?**
**R :** Changez dans le CI/CD :
```yaml
- name: Run unit tests
  run: |
    cd frontend
    npm test
```

**Q : Comment voir les logs du pipeline ?**
**R :** GitHub → votre repo → onglet "Actions" → cliquez sur le run qui vous intéresse.

**Q : L'image est trop grosse pour Docker Hub gratuit ?**
**R :** Utilisez l'Option 2 (sans Docker Hub) ou optimisez vos Dockerfiles avec des images multi-stage.

---

## 🎯 Étapes suivantes

1. Choisissez votre option (1 ou 2)
2. Configurez les secrets correspondants
3. Testez avec un push sur `addauth`
4. Vérifiez les logs dans l'onglet "Actions" de GitHub

**Besoin d'aide ?** Créez une issue dans le repository avec les logs d'erreur !
