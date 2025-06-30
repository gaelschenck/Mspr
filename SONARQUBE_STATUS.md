# Configuration SonarQube - Guide Complet

## ✅ Configuration Actuelle

### 1. Secrets GitHub configurés
- `SONAR_TOKEN` : ✅ Configuré
- `SONAR_HOST_URL` : ✅ Configuré

### 2. Fichiers de configuration
- `sonar-project.properties` : ✅ Créé avec projectKey=Mspr
- `.github/workflows/ci.yml` : ✅ Mis à jour avec l'action officielle SonarQube
- `docker-compose.yaml` : ✅ SonarQube service ajouté

### 3. Scripts utilitaires
- `start_sonarqube.bat` : Démarrage SonarQube local
- `configure_sonar_host.bat` : Configuration automatique du host
- `run_sonar_analysis.bat` : Analyse locale complète

## 🚀 Étapes suivantes

### 1. Configuration SonarQube (première fois)

1. **Démarrer SonarQube localement** :
   ```cmd
   start_sonarqube.bat
   ```

2. **Accéder à l'interface** : http://localhost:9000
   - Login : `admin`
   - Password : `admin`

3. **Créer le projet** :
   - Project Key : `Mspr` (exactement comme dans votre config)
   - Display Name : `MSPR Platform`

4. **Générer un token** :
   - My Account > Security > Generate Token
   - Name : `GitHub Actions`
   - Type : `Global Analysis Token`

### 2. Configuration GitHub

Dans votre repository > Settings > Secrets and variables > Actions :
- `SONAR_TOKEN` : Le token généré ci-dessus
- `SONAR_HOST_URL` : URL de votre serveur SonarQube

### 3. Test local

```cmd
# Analyse complète locale
run_sonar_analysis.bat
```

### 4. Push vers GitHub

Le pipeline exécutera automatiquement l'analyse SonarQube avec :
- Tests backend + couverture
- Tests frontend + couverture  
- Analyse qualité complète
- Quality Gate (échec si qualité insuffisante)

## 📊 Métriques analysées

| Composant | Couverture | Qualité | Sécurité | Maintenabilité |
|-----------|------------|---------|----------|----------------|
| Backend Python | ✅ pytest-cov | ✅ PEP8, complexité | ✅ Vulnérabilités | ✅ Code smells |
| Frontend Vue.js | ✅ Vitest | ✅ ESLint, complexité | ✅ npm audit | ✅ Duplications |

## 🔧 Valeurs par défaut Quality Gate

- **Couverture** : ≥ 80%
- **Duplications** : ≤ 3%
- **Maintenabilité** : Rating A
- **Sécurité** : Rating A
- **Fiabilité** : Rating A

## 📁 Structure des rapports

```
backend/
├── coverage.xml          # Rapport coverage Python
├── htmlcov/              # Rapport HTML coverage
└── tests/

frontend/
├── coverage/
│   ├── lcov.info         # Rapport LCOV
│   └── coverage-final.json
└── tests/
```

## 🐛 Troubleshooting

### Pipeline GitHub échoue sur SonarQube

1. Vérifiez les secrets : `SONAR_TOKEN` et `SONAR_HOST_URL`
2. Vérifiez que le projet `Mspr` existe dans SonarQube
3. Vérifiez que votre serveur SonarQube est accessible depuis Internet

### Analyse locale échoue

1. Vérifiez que SonarQube est démarré : `docker-compose ps`
2. Testez la connexion : `curl http://localhost:9000/api/system/status`
3. Utilisez le configurateur : `configure_sonar_host.bat`

### Quality Gate échoue

1. Consultez le rapport SonarQube pour les détails
2. Ajustez les seuils si nécessaire (Administration > Quality Gates)
3. Corrigez les issues critiques identifiées

## 🎯 Prochaines améliorations possibles

- [ ] Intégration avec PR comments automatiques
- [ ] Rapports Slack/Teams sur échecs Quality Gate
- [ ] Archivage des rapports de couverture
- [ ] Métriques tendances sur plusieurs builds
