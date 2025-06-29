# 🔄 Migration Frontend - Nouvelle Architecture de Données

## 📋 Vue d'ensemble des changements

Le frontend a été mis à jour pour s'adapter à la nouvelle architecture backend unifiée avec les schémas `Country`, `IndicatorType` et `HealthIndicator`.

## 🏗️ Nouvelle Architecture

### Structure des données Backend
```
Countries (Pays)
├── id, name, who_region, iso_code
├── created_at, updated_at

IndicatorTypes (Types d'indicateurs)
├── id, name, description, unit
├── created_at

HealthIndicators (Indicateurs de santé)
├── id, country_id, indicator_type_id
├── year, value_type, value, value_text
├── confidence_min, confidence_max, confidence_median
├── data_quality, source_file, raw_value_text
├── created_at, updated_at
└── Relations: country, indicator_type
```

### Nouveaux Endpoints Backend
```
GET /countries/                    # Liste des pays
GET /countries/paginated/         # Pays avec pagination
GET /countries/regions/           # Régions OMS disponibles

GET /indicator-types/             # Types d'indicateurs
GET /indicator-types/list/        # Liste simple

GET /health-indicators/           # Indicateurs de santé
GET /health-indicators/paginated/ # Avec pagination
GET /health-indicators/detailed/  # Avec relations (pays + type)
GET /health-indicators/years/     # Années disponibles
GET /health-indicators/value-types/ # Types de valeurs
```

## 🔧 Fichiers modifiés

### 1. Services API (`frontend/services/api.js`)
- ✅ **Ajout** de nouveaux services pour la structure unifiée
- ✅ **Maintien** des anciens services pour compatibilité 
- ✅ **Redirection** des anciens endpoints vers les nouveaux

```javascript
// Nouveaux services
fetchCountries()
fetchIndicatorTypes() 
fetchHealthIndicators()
fetchHealthIndicatorsDetailed()

// Anciens services (compatibilité)
fetchMortalite() → redirigé vers fetchHealthIndicatorsDetailed()
fetchPopulationHiv() → redirigé vers fetchHealthIndicatorsDetailed()
// etc.
```

### 2. Nouveau composant principal (`src/components/HealthData.vue`)
- ✅ **Interface moderne** avec filtres avancés
- ✅ **Pagination** optimisée
- ✅ **Filtres** par pays, région, type d'indicateur, année
- ✅ **Tableau responsive** avec toutes les données unifiées
- ✅ **Gestion d'erreurs** améliorée

### 3. Composant de navigation (`src/components/Data.vue`)
- ✅ **Nouveau design** avec navigation vers la vue unifiée
- ✅ **Maintien** des liens vers les anciennes vues spécialisées
- ✅ **Interface moderne** avec descriptions

### 4. Router (`src/router/index.js`)
- ✅ **Ajout** de la route `/health-data` vers `HealthData.vue`
- ✅ **Maintien** des routes existantes pour compatibilité

### 5. Types et validation (`src/types/healthDataTypes.js`)
- ✅ **Documentation** complète des schémas de données
- ✅ **Fonctions de validation** pour les réponses API
- ✅ **Constantes** utiles (régions OMS, types de qualité, etc.)

## 🚀 Comment utiliser la nouvelle interface

### Accès à la vue unifiée
1. Naviguez vers `/data` ou cliquez sur "Data" dans le menu
2. Cliquez sur "Explorer les données de santé" 
3. Vous arrivez sur `/health-data` avec la nouvelle interface

### Fonctionnalités disponibles
- **Filtrage** par pays, région OMS, type d'indicateur, année
- **Pagination** avec navigation fluide
- **Affichage** des intervalles de confiance 
- **Tri** et **recherche** dans les données
- **Messages d'erreur** explicites
- **Chargement** avec indicateurs visuels

## 🔄 Compatibilité et migration

### Anciennes vues maintenues
Les composants suivants restent fonctionnels :
- `USMortalite.vue` → utilise `fetchMortalite()` (redirigé)
- `PopulationHiv.vue` → utilise `fetchPopulationHiv()` (redirigé)  
- `Traitement.vue` → utilise `fetchTraitement()` (redirigé)
- `TransmissionMereEnfant.vue` → utilise `fetchTransmissionMereEnfant()` (redirigé)

### Migration progressive
1. **Phase 1** ✅ : Nouvelle API compatible, anciennes vues fonctionnelles
2. **Phase 2** : Test de la nouvelle interface `/health-data`
3. **Phase 3** : Migration des utilisateurs vers la nouvelle interface
4. **Phase 4** : Suppression progressive des anciennes vues (optionnel)

## 🛠️ Développement

### Pour ajouter un nouveau filtre
1. Modifiez `filters` dans `HealthData.vue`
2. Ajoutez le champ dans la section filtres du template
3. Vérifiez que le backend supporte ce paramètre

### Pour personnaliser l'affichage
- Modifiez les styles dans `HealthData.vue`
- Utilisez les classes CSS existantes
- Respectez le design responsive

### Pour ajouter une nouvelle colonne
1. Vérifiez que la donnée existe dans `HealthIndicatorDetailed`
2. Ajoutez la colonne dans le `<table>` du template
3. Implémentez le formatage dans les méthodes

## 📊 Types de données supportés

### Pays (Countries)
- Nom, région OMS, code ISO
- Tous pays de la base de données

### Types d'indicateurs (IndicatorTypes)  
- Mortalité, VIH, traitement, transmission, etc.
- Avec unités et descriptions

### Indicateurs de santé (HealthIndicators)
- Valeurs numériques et textuelles
- Intervalles de confiance
- Qualité des données
- Années de 1990 à 2023+

## 🔍 Débogage

### Problèmes courants
1. **Données vides** → Vérifiez les filtres, la connexion API
2. **Erreurs 404** → Vérifiez que le backend expose les nouveaux endpoints  
3. **Lenteur** → Optimisez la pagination, réduisez les filtres
4. **Formatage** → Vérifiez les fonctions `formatValue()` et `formatConfidenceInterval()`

### Console de développement
Activez les logs pour voir les requêtes API :
```javascript
console.log('Requête API:', endpoint, params);
console.log('Réponse API:', response);
```

## 📝 TODO

### Améliorations possibles
- [ ] **Exportation** des données filtrées (CSV, Excel)
- [ ] **Graphiques** intégrés pour visualiser les tendances
- [ ] **Comparaison** entre pays/régions
- [ ] **Favoris** et **signets** pour sauvegarder des filtres
- [ ] **Mode sombre** pour l'interface
- [ ] **Responsive** amélioré pour mobile

### Optimisations techniques
- [ ] **Cache** côté client pour les listes (pays, indicateurs)
- [ ] **Lazy loading** pour les grandes listes
- [ ] **WebSocket** pour les mises à jour en temps réel
- [ ] **Service Worker** pour le mode hors ligne

---

**🎯 Objectif** : Fournir une interface moderne et unifiée pour explorer toutes les données de santé, tout en maintenant la compatibilité avec l'existant.
