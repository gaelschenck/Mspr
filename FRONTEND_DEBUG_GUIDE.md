# Guide de Debug Frontend - Endpoints et API

## Problème résolu : Erreur 405 sur /columns/health_indicators

### ❌ Problème
```
GET http://localhost:8080/api/fr/columns/health_indicators 405 (Method Not Allowed)
```

### ✅ Solution appliquée
Le composant `TestPrediction.vue` a été corrigé pour ne plus utiliser l'endpoint `/columns/` qui n'existe pas dans le backend.

**Avant** :
```javascript
const response = await fetchFromAPI(`/columns/${selectedTable.value}`);
```

**Après** :
```javascript
// Colonnes prédéfinies selon la table
const columnsByTable = {
  'health_indicators': ['value', 'year', 'confidence_min', 'confidence_max', 'confidence_median'],
  'table_mortalite': ['value', 'year'],
  // ... autres tables
};
columns.value = columnsByTable[selectedTable.value] || ['value', 'year'];
```

## Endpoints Backend Disponibles

### ✅ Endpoints principaux
- `GET /countries/list/` - Liste des pays
- `GET /countries/regions/` - Régions OMS disponibles
- `GET /indicator-types/` - Types d'indicateurs
- `GET /health-indicators/paginated/` - Indicateurs paginés (UTILISÉ)
- `GET /health-indicators/years/` - Années disponibles
- `GET /tables/` - Tables disponibles
- `GET /payslist/` - Liste pays format legacy
- `POST /dataframe/` - Création DataFrame pour prédiction
- `POST /train_model/` - Entraînement modèle ML

### ❌ Endpoints qui N'EXISTENT PAS
- `GET /columns/{table}` - ⚠️ N'existe pas dans le backend
- `GET /health-indicators/detailed/` - ⚠️ Remplacé par paginated

## Dépannage

### Si vous voyez encore des erreurs 405
1. **Vider le cache du navigateur** : Ctrl+Shift+R ou F12 > Network > Disable cache
2. **Redémarrer le frontend** : `npm run dev` dans le dossier frontend
3. **Vérifier les imports** : Assurez-vous que tous les composants importent les bonnes fonctions du service API

### Si les filtres ne marchent pas
1. **Ouvrir la console F12** et vérifier les logs de debug ajoutés
2. **Vérifier les endpoints fallback** : Les années/régions ont des valeurs par défaut si les endpoints échouent
3. **Vérifier les noms de champs** : Les filtres correspondent aux noms exacts de l'API

### Composants corrigés
- ✅ `TestPrediction.vue` - Utilise des colonnes prédéfinies
- ✅ `HealthData.vue` - Utilise l'endpoint paginé + fallbacks
- ✅ `USMortalite.vue` - Utilise l'endpoint paginé
- ✅ `PopulationHiv.vue` - Utilise l'endpoint paginé

## Structure API Utilisée

```
frontend/services/api.js
├── fetchFromAPI() - Fonction générique
├── fetchHealthIndicatorsDetailed() - Utilise /health-indicators/paginated/
├── fetchCountries() - Utilise /countries/paginated/
└── fetchIndicatorTypes() - Utilise /indicator-types/
```

## Tester les corrections

1. **Page de Prédiction** :
   - Sélectionner Austria + health_indicators
   - Vérifier qu'aucune erreur 405 n'apparaît
   - Les colonnes doivent s'afficher automatiquement

2. **Page Indicateurs de Santé** :
   - Vérifier que les filtres années/régions se chargent
   - Pagination fonctionnelle
   - Fallback si endpoints échouent

3. **Console F12** :
   - Aucune erreur 405
   - Logs de debug pour années/régions visible
   - Données chargées correctement
