# Checklist - Migration vers branche addauth

## ✅ Actions à effectuer

### 1. Configuration GitHub
- [ ] Changer la branche par défaut vers `addauth` dans GitHub Settings
- [ ] Vérifier que les secrets sont bien configurés :
  - [ ] `SONAR_TOKEN`
  - [ ] `SONAR_HOST_URL`
  - [ ] `DOCKERHUB_USERNAME`
  - [ ] `DOCKERHUB_TOKEN`

### 2. Configuration SonarQube Local
- [ ] SonarQube démarré : `docker-compose ps sonarqube`
- [ ] Interface accessible : http://localhost:9000
- [ ] Projet créé avec clé : `Mspr`
- [ ] Token généré pour GitHub Actions

### 3. Tests locaux
- [ ] Tests backend : `cd backend && python -m pytest --cov=.`
- [ ] Tests frontend : `cd frontend && npm run test -- --coverage`
- [ ] Analyse SonarQube : `run_sonar_analysis.bat`

### 4. Validation pipeline
- [ ] Push vers `addauth`
- [ ] Vérifier que le pipeline se déclenche
- [ ] Vérifier que l'analyse SonarQube fonctionne
- [ ] Vérifier que les images Docker sont poussées

## 🚀 Scripts disponibles

- `test_addauth_ready.bat` : Test complet de votre environnement
- `start_sonarqube.bat` : Démarrer SonarQube
- `run_sonar_analysis.bat` : Analyse locale
- `configure_sonar_host.bat` : Configuration automatique

## 📊 Ce qui va changer

### Avant (branche main)
- Pipeline se déclenche sur push vers `main`
- Déploiement depuis `main`

### Après (branche addauth)
- Pipeline se déclenche sur push vers `addauth` (prioritaire)
- Déploiement depuis `addauth` en priorité
- `main` reste fonctionnel mais secondaire

## 🔧 En cas de problème

### SonarQube page blanche
1. Attendre 1-2 minutes
2. Vider le cache navigateur (Ctrl+F5)
3. Essayer en navigation privée
4. Essayer un autre navigateur

### Pipeline GitHub échoue
1. Vérifier les secrets GitHub
2. Vérifier que SonarQube est accessible depuis Internet
3. Consulter les logs du pipeline

### Tests échouent
1. Vérifier l'environnement Python : `python --version`
2. Installer les dépendances : `pip install -r backend/requirements.txt`
3. Vérifier Node.js : `npm --version`
4. Installer les dépendances : `cd frontend && npm ci`

## 📝 Prochaines étapes

1. **Immédiat** : Tester avec `test_addauth_ready.bat`
2. **Court terme** : Push vers `addauth` et valider le pipeline
3. **Moyen terme** : Fusionner `addauth` dans `main` si tout fonctionne
4. **Long terme** : Nettoyer les anciennes branches
