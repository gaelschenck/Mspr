# Onglet ETL Dashboard - Documentation d'intégration

## 🎯 Objectif Accompli
Création d'un nouvel onglet ETL dans le dashboard Vue.js permettant de :
- 📊 Visualiser les données CSV sources (dossier SourceData)
- 🔄 Lancer le processus ETL (script NewETL.py)
- 📈 Visualiser les données transformées (dossier DatasetClean)
- 📋 Consulter les logs d'exécution ETL

## 🔧 Modifications Réalisées

### 1. Backend (FastAPI) - `backend/main.py`
**Endpoints ETL ajoutés :**
- `GET /etl/source-files/` : Liste des fichiers CSV sources et traités
- `GET /etl/file-preview/{file_type}/{file_name}` : Aperçu d'un fichier CSV
- `POST /etl/run/` : Lance le processus ETL (NewETL.py)
- `GET /etl/logs/` : Récupère les logs d'exécution
- `GET /etl/status/` : Statut du système ETL

**Fonctionnalités :**
- ✅ Lecture des CSV avec aperçu (100 lignes max)
- ✅ Exécution du script NewETL.py via subprocess
- ✅ Gestion des logs en temps réel
- ✅ Informations sur le statut de la base de données
- ✅ Support de différents encodages (UTF-8, Latin1, etc.)

### 2. Frontend (Vue.js) - `frontend/src/components/ETLDashboard.vue`
**Interface utilisateur complète :**
- 📊 **Statut Système** : État de la base, nombre de fichiers, dernière exécution
- 🎛️ **Contrôles ETL** : Boutons pour lancer ETL, actualiser logs et données
- 📁 **Données Sources** : Grid des fichiers CSV avec aperçu au clic
- 🔄 **Données Transformées** : Grid des fichiers traités avec aperçu
- 📋 **Logs ETL** : Console des logs avec coloration (erreur, warning, info)
- 🪟 **Modal d'aperçu** : Affichage détaillé des CSV (colonnes, types, données)

**Fonctionnalités UX :**
- ✅ Design responsive (mobile/desktop)
- ✅ Notifications de statut (succès, erreur, info)
- ✅ Indicateurs de chargement
- ✅ Interface intuitive avec couleurs et icônes
- ✅ Modal d'aperçu avec tableau scrollable

### 3. Router - `frontend/src/router/index.js`
- ✅ Route `/etl` ajoutée
- ✅ Composant ETLDashboard importé et configuré

### 4. Navigation - `frontend/src/components/Header.vue`
- ✅ Lien "ETL" ajouté à la navigation principale
- ✅ Support i18n avec fallback

## 📋 Structure des Données

### Fichiers Sources (SourceData/)
```
art_coverage_by_country_clean.csv
no_of_people_living_with_hiv_by_country_clean.csv
no_of_deaths_by_country_clean.csv
prevention_of_mother_to_child_transmission_by_country_clean.csv
...
```

### Fichiers Transformés (DatasetClean/)
```
table_mortalite.csv
table_population_hiv.csv
table_statistique.csv
table_traitement.csv
table_transmission_mere_enfant.csv
...
```

### Script ETL (backend/NewETL/)
```
NewETL.py          # Script principal ETL
new_etl.log        # Logs d'exécution
generate_schema.py # Génération de schéma
verify_columns.py  # Vérification colonnes
```

## 🚀 Utilisation

### 1. Démarrage
```bash
# Backend
cd backend
uvicorn main:app --reload --port 8084

# Frontend  
cd frontend
npm run dev
```

### 2. Accès à l'onglet ETL
- URL : `http://localhost:3000/etl`
- Navigation : Cliquer sur "ETL" dans le header

### 3. Workflow ETL
1. **Consulter les données sources** : Voir les CSV dans SourceData
2. **Lancer l'ETL** : Cliquer sur "Lancer le processus ETL"
3. **Suivre les logs** : Observer l'exécution en temps réel
4. **Vérifier les résultats** : Consulter les fichiers transformés

## 🧪 Test d'Intégration

Script de test créé : `test_etl_integration.py`
```bash
python test_etl_integration.py
```

## 📊 Interface ETL Complète

L'onglet ETL offre une interface complète pour :
- ✅ **Transparence** : Visualisation avant/après transformation
- ✅ **Contrôle** : Lancement manuel du processus ETL
- ✅ **Monitoring** : Logs et statut en temps réel
- ✅ **Debugging** : Aperçu détaillé des données à chaque étape
- ✅ **Usabilité** : Interface intuitive et responsive

## 🎉 Statut Final

✅ **Onglet ETL opérationnel** et intégré dans le dashboard !

L'interface permet maintenant de :
- Voir les données brutes (CSV sources)
- Lancer l'ETL d'un clic
- Visualiser les données transformées
- Suivre l'exécution avec les logs

Prêt pour la démonstration et l'utilisation en production ! 🚀
