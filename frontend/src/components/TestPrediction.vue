<template>
  <div>
    <div>
    <h1>{{ $t('testprediction_title') }}</h1>
    
    <!-- Encart d'informations importantes -->
    <div class="info-panel">
      <h3>📊 {{ $t('prediction_guidelines_title') || 'Guide pour une prédiction réussie' }}</h3>
      
      <div class="guidelines-grid">
        <div class="guideline-item success">
          <h4>✅ {{ $t('what_works') || 'Combinaisons qui fonctionnent bien' }}</h4>
          <ul>
            <li><strong>{{ $t('region_only') || 'Région seule' }}</strong> : {{ $t('region_simple_effective') || 'Sélectionnez juste une région (Europe, Americas...) - Simple et efficace !' }}</li>
            <li><strong>{{ $t('region_plus_indicator') || 'Région + Indicateur' }}</strong> : {{ $t('combine_region_indicator') || 'Combinez une région avec un indicateur spécifique' }}</li>
            <li><strong>{{ $t('popular_indicators') || 'Indicateurs avec beaucoup de données' }}</strong> : 
              <br>• "{{ $t('column_people_living_hiv') }}" {{ $t('hiv_excellent') || '(excellent)' }}
              <br>• "{{ $t('column_art_coverage') }}" {{ $t('art_very_good') || '(très bon)' }}
              <br>• "{{ $t('column_hiv_deaths') }}" {{ $t('hiv_deaths_good') || '(bon)' }}</li>
            <li><strong>{{ $t('period_tip') || 'Période' }}</strong> : {{ $t('leave_years_empty') || 'Laissez les années vides pour utiliser toutes les données disponibles' }}</li>
          </ul>
        </div>
        
        <div class="guideline-item warning">
          <h4>⚠️ {{ $t('what_to_avoid') || 'À éviter absolument' }}</h4>
          <ul>
            <li><strong>{{ $t('no_filter') || 'Aucun filtre' }}</strong> : {{ $t('select_at_least_region') || 'Sélectionnez au moins une région OU un indicateur' }}</li>
            <li><strong>{{ $t('too_specific') || 'Trop de filtres' }}</strong> : {{ $t('avoid_rare_short') || 'Évitez de combiner indicateur rare + période courte' }}</li>
            <li><strong>{{ $t('short_periods') || 'Périodes très courtes' }}</strong> : {{ $t('less_3_4_years') || 'Moins de 3-4 ans donnent peu de données' }}</li>
            <li><strong>{{ $t('rare_combinations') || 'Combinaisons rares' }}</strong> : {{ $t('pediatric_small_regions') || 'Indicateurs pédiatriques + petites régions' }}</li>
          </ul>
        </div>
      </div>
      
      <div class="guidelines-grid">
        <div class="guideline-item info">
          <h4>🎯 {{ $t('recommended_start') || 'Pour commencer facilement' }}</h4>
          <ul>
            <li><strong>{{ $t('beginner') }}</strong> : {{ $t('select_europe_americas') || 'Sélectionnez juste "Europe" ou "Americas"' }}</li>
            <li><strong>{{ $t('intermediate') }}</strong> : {{ $t('europe_plus_column') || '"Europe" + "' + $t('column_people_living_hiv') + '"' }}</li>
            <li><strong>{{ $t('advanced') }}</strong> : {{ $t('add_period_example') || 'Ajoutez une période (ex: 2015-2023)' }}</li>
          </ul>
        </div>
        
        <div class="guideline-item technical">
          <h4>⚙️ {{ $t('technical_info') || 'Informations techniques' }}</h4>
          <ul>
            <li><strong>{{ $t('minimum_required') }}</strong> : {{ $t('min_10_data_points') || '10+ points de données' }}</li>
            <li><strong>{{ $t('optimal') }}</strong> : {{ $t('optimal_50_data_points') || '50+ points de données' }}</li>
            <li><strong>{{ $t('processing') }}</strong> : {{ $t('max_1000_records') || 'Max 1000 enregistrements par requête' }}</li>
            <li><strong>{{ $t('columns') }}</strong> : {{ $t('automatic_value_types') || 'Gestion automatique des types de valeurs' }}</li>
          </ul>
        </div>
      </div>
    </div>
    
    <!-- Sélection région WHO -->
    <label for="region">{{ $t('testprediction_choose_region') }}</label>
    <select v-model="selectedRegion" id="region" @change="onRegionChange">
      <option value="">-- {{ $t('all_regions') }} --</option>
      <option v-for="region in regions" :key="region" :value="region">{{ region }}</option>
    </select>
  </div>
  
  <div>
    <!-- Sélection type d'indicateur -->
    <label for="indicator_type">{{ $t('indicator_type') }}</label>
    <select v-model="selectedIndicatorType" id="indicator_type" @change="onIndicatorTypeChange">
      <option value="">-- {{ $t('all_indicators') }} --</option>
      <option v-for="type in indicatorTypes" :key="type" :value="type">{{ type }}</option>
    </select>
  </div>
  
  <div>
    <!-- Sélection période -->
    <label for="year_range">{{ $t('data_period') }}</label>
    <div class="year-range">
      <select v-model="yearMin" id="year_min">
        <option value="">{{ $t('min_year') }}</option>
        <option v-for="year in availableYears" :key="year" :value="year">{{ year }}</option>
      </select>
      <span> {{ $t('to') }} </span>
      <select v-model="yearMax" id="year_max">
        <option value="">{{ $t('max_year') }}</option>
        <option v-for="year in availableYears" :key="year" :value="year">{{ year }}</option>
      </select>
    </div>
  </div>

    <button @click="submitChoices" :disabled="!canSubmit || loading">
      {{ loading ? `🔄 ${$t('processing_in_progress')}` : `🚀 ${$t('launch_prediction')}` }}
    </button>
    
    <!-- Message d'aide simplifié -->
    <div class="help-info-simple">
      💡 <strong>{{ $t('quick_tip') || 'Conseil express' }}</strong> : 
      {{ $t('quick_tip_text') || 'Pour commencer, sélectionnez juste une région (Europe, Americas...). C\'est simple et ça marche très bien !' }}
    </div>
    
    <!-- Informations de debug -->
    <div v-if="debugInfo" class="debug-info">
      <h3>{{ $t('filter_info') }}</h3>
      <pre>{{ debugInfo }}</pre>
    </div>
    
    <!-- Affichage des erreurs -->
    <div v-if="error" class="error">
      {{ error }}
      <button @click="error = null" class="retry-btn">{{ $t('testprediction_clear_error') }}</button>
    </div>
    
    <!-- Affichage du succès -->
    <div v-if="success" class="success">
      {{ success }}
    </div>
  </div>
</template>

<script setup>
import { ref, onMounted, computed } from "vue";
import { useRouter } from "vue-router";
import { fetchFromAPI } from "../../services/api.js";

const router = useRouter();

// État réactif - VERSION SIMPLIFIÉE
const regions = ref([]);
const indicatorTypes = ref([]);
const availableYears = ref([]);

const selectedRegion = ref("");
const selectedIndicatorType = ref("");
const yearMin = ref("");
const yearMax = ref("");

const loading = ref(false);
const error = ref(null);
const success = ref(null);
const debugInfo = ref(null);

// Vérification si on peut soumettre - VERSION SIMPLIFIÉE
const canSubmit = computed(() => {
  // Au moins une région OU un indicateur doit être sélectionné
  return selectedRegion.value || selectedIndicatorType.value;
});

// Chargement des métadonnées essentielles
onMounted(async () => {
  console.log("🚀 TESTPREDICTION.VUE - VERSION SIMPLIFIÉE !");
  
  try {
    loading.value = true;
    error.value = null;
    
    // Charger seulement les métadonnées nécessaires
    const [
      responseRegions, 
      responseIndicatorTypes,
      responseYears
    ] = await Promise.all([
      fetchFromAPI("/countries/regions/"),
      fetchFromAPI("/indicator-types/list/"),
      fetchFromAPI("/health-indicators/years/")
    ]);

    console.log("📊 Métadonnées chargées:");
    console.log("- Régions:", responseRegions);
    console.log("- Types d'indicateurs:", responseIndicatorTypes);
    console.log("- Années:", responseYears);

    // Stocker les données
    regions.value = responseRegions.who_regions || [];
    indicatorTypes.value = responseIndicatorTypes.indicator_types || [];
    availableYears.value = responseYears.years || [];

    console.log("✅ Interface simplifiée prête");

  } catch (err) {
    console.error("❌ Erreur lors du chargement des métadonnées:", err);
    error.value = t('metadata_loading_error') + ": " + err.message;
  } finally {
    loading.value = false;
  }
});

// Gestionnaires d'événements simplifiés
const onRegionChange = () => {
  updateDebugInfo();
};

const onIndicatorTypeChange = () => {
  updateDebugInfo();
};

const updateDebugInfo = () => {
  const criteria = {
    region: selectedRegion.value,
    indicator_type: selectedIndicatorType.value,
    year_range: yearMin.value && yearMax.value ? `${yearMin.value}-${yearMax.value}` : null
  };
  
  debugInfo.value = JSON.stringify(criteria, null, 2);
};

// Soumettre les choix et lancer la prédiction - VERSION SIMPLIFIÉE
const submitChoices = async () => {
  // Validation simplifiée
  if (!canSubmit.value) {
    error.value = `💡 ${t('tip_select_region')}`;
    return;
  }

  // Construction du payload simplifié et optimisé selon le schéma backend
  const payload = {
    // Configuration obligatoire
    table: "statistique", // Valeur obligatoire selon le schéma backend
    target_column: "value", // Colonne cible obligatoire
    max_records: 1000, // Plus petit pour commencer
    include_confidence: true
  };

  // Ajouter les filtres seulement s'ils sont définis
  if (selectedRegion.value) {
    payload.who_region = selectedRegion.value;
  }
  
  if (selectedIndicatorType.value) {
    payload.indicator_types = [selectedIndicatorType.value];
  }
  
  if (yearMin.value) {
    payload.year_min = parseInt(yearMin.value);
  }
  
  if (yearMax.value) {
    payload.year_max = parseInt(yearMax.value);
  }

  console.log("📤 Payload optimisé envoyé:", payload);
  console.log("📋 Validation du payload:");
  console.log(`  - table: ${payload.table} (requis)`);
  console.log(`  - target_column: ${payload.target_column} (requis)`);
  console.log(`  - max_records: ${payload.max_records} (entre 100-100000)`);
  console.log(`  - who_region: ${payload.who_region || 'non défini'}`);
  console.log(`  - indicator_types: ${payload.indicator_types || 'non défini'}`);
  console.log(`  - années: ${payload.year_min || 'min non défini'} - ${payload.year_max || 'max non défini'}`);

  try {
    loading.value = true;
    error.value = null;
    success.value = null;
    
    // Étape 1: Créer le DataFrame avec la nouvelle API flexible
    console.log("📊 Création du DataFrame...");
    const response = await fetchFromAPI("/dataframe/", {
      method: "POST",
      data: payload  // Changer de 'body' à 'data' pour correspondre au service API
    });
    
    console.log("✅ DataFrame créé:", response);
    console.log(`📈 ${response.data.length} enregistrements, ${response.shape[1]} colonnes`);
    console.log("📊 Statistiques:", response.statistics);
    
    if (!response.data || response.data.length === 0) {
      throw new Error(t('no_data_found_widen'));
    }

    if (response.data.length < 10) {
      console.warn(`⚠️ ${t('few_data_imprecise')}`);
    }

    // Étape 2: Entraîner le modèle avec les données structurées
    console.log("🤖 Entraînement du modèle...");
    const trainPayload = {
      dataframe: response.data, // Utiliser les données structurées
      target_column: "value" // Toujours 'value' dans le nouveau schéma
    };

    const trainResponse = await fetchFromAPI("/train_model/", {
      method: "POST",
      data: trainPayload  // Changer de 'body' à 'data'
    });
    
    console.log("🎯 Modèle entraîné avec succès:", trainResponse);
    
    // Message de succès détaillé
    const rmse = trainResponse.rmse?.toFixed(2) || 'N/A';
    const r2 = trainResponse.r2?.toFixed(3) || 'N/A';
    const dataCount = response.data.length;
    
    success.value = `✅ ${t('model_trained_success')} 
📊 ${dataCount} ${t('data_points_used')}
📈 RMSE: ${rmse}
🎯 R²: ${r2}
${trainResponse.future_prediction ? `🔮 ${t('future_prediction')}: ${trainResponse.future_prediction.toFixed(2)} (${trainResponse.future_year})` : ''}`;

    // Rediriger vers la page de graphiques avec toutes les infos
    setTimeout(() => {
      router.push({
        name: 'PredictionGraphs',
        query: { 
          result: JSON.stringify({
            ...trainResponse,
            metadata: response.statistics,
            filters: payload
          })
        }
      });
    }, 2000);

  } catch (err) {
    console.error("❌ Erreur lors de la prédiction:", err);
    
    // Messages d'erreur plus informatifs avec détection du problème
    let errorMessage = t('prediction_error');
    
    if (err.response && err.response.status === 422) {
      // Erreur de validation des paramètres
      const detail = err.response.data?.detail;
      if (detail && Array.isArray(detail)) {
        // Erreurs de validation Pydantic
        const validationErrors = detail.map(e => `${e.loc?.join('.')}: ${e.msg}`).join(', ');
        errorMessage = `❌ ${t('invalid_parameters')}: ${validationErrors}`;
      } else {
        errorMessage = `❌ ${t('invalid_parameters')}. ${t('detail') || 'Détail'}: ${detail || t('incorrect_data_structure') || 'Structure des données incorrecte'}`;
      }
      
      // Logs de debug pour identifier le problème
      console.log("🔍 Payload envoyé qui a causé l'erreur 422:", payload);
      console.log("🔍 Réponse d'erreur complète:", err.response.data);
      
    } else if (err.response && err.response.status === 404) {
      errorMessage = `❌ ${t('no_data_found_region')}`;
    } else if (err.response && err.response.status === 500) {
      errorMessage = `❌ ${t('server_error_check')}`;
    } else if (err.message && err.message.includes('assez de données')) {
      errorMessage = `❌ ${t('not_enough_data')}`;
    } else {
      errorMessage = err.message || errorMessage;
    }
    
    error.value = errorMessage;
  } finally {
    loading.value = false;
  }
};
</script>

<style scoped>
.error {
  background-color: #fee;
  border: 1px solid #fcc;
  border-radius: 4px;
  color: #c66;
  padding: 1em;
  margin: 1em 0;
}

.success {
  background-color: #efe;
  border: 1px solid #cfc;
  border-radius: 4px;
  color: #6c6;
  padding: 1em;
  margin: 1em 0;
  white-space: pre-line;
}

.debug-info {
  background-color: #f8f9fa;
  border: 1px solid #dee2e6;
  border-radius: 4px;
  color: #495057;
  padding: 1em;
  margin: 1em 0;
  font-family: monospace;
  font-size: 0.9em;
}

.year-range {
  display: flex;
  align-items: center;
  gap: 0.5em;
}

.year-range select {
  flex: 1;
  margin-bottom: 0;
}

.retry-btn {
  margin-left: 1em;
  padding: 0.5em 1em;
  background-color: #007bff;
  color: white;
  border: none;
  border-radius: 4px;
  cursor: pointer;
}

.retry-btn:hover {
  background-color: #0056b3;
}

button:disabled {
  opacity: 0.5;
  cursor: not-allowed;
}

label {
  display: block;
  margin-top: 1em;
  margin-bottom: 0.5em;
  font-weight: bold;
}

select {
  width: 100%;
  padding: 0.5em;
  border: 1px solid #ddd;
  border-radius: 4px;
  margin-bottom: 1em;
}

button {
  padding: 1em 2em;
  background-color: #28a745;
  color: white;
  border: none;
  border-radius: 4px;
  cursor: pointer;
  font-size: 1em;
  margin-top: 1em;
}

button:hover:not(:disabled) {
  background-color: #218838;
}

/* Styles pour améliorer la lisibilité */
div > div {
  margin-bottom: 1.5em;
}

.help-info-simple {
  background-color: #fff3cd;
  border: 1px solid #ffeaa7;
  border-radius: 4px;
  padding: 0.8em;
  margin: 1em 0;
  font-size: 0.9em;
  color: #856404;
  text-align: center;
}

h1 {
  color: #333;
  margin-bottom: 1.5em;
}

/* Encart d'informations importantes */
.info-panel {
  background: linear-gradient(135deg, #f8f9fa 0%, #e9ecef 100%);
  border: 1px solid #dee2e6;
  border-radius: 8px;
  padding: 1.5em;
  margin: 1.5em 0 2em 0;
  box-shadow: 0 2px 4px rgba(0,0,0,0.1);
}

.info-panel h3 {
  margin-top: 0;
  color: #495057;
  text-align: center;
  font-size: 1.2em;
  margin-bottom: 1em;
}

.guidelines-grid {
  display: grid;
  grid-template-columns: 1fr 1fr;
  gap: 1.5em;
  margin-bottom: 1em;
}

@media (max-width: 768px) {
  .guidelines-grid {
    grid-template-columns: 1fr;
  }
}

.guideline-item {
  background: white;
  border-radius: 6px;
  padding: 1em;
  border-left: 4px solid;
}

.guideline-item.success {
  border-left-color: #28a745;
  background: #f8fff9;
}

.guideline-item.warning {
  border-left-color: #ffc107;
  background: #fffdf5;
}

.guideline-item.info {
  border-left-color: #17a2b8;
  background: #f1f9ff;
}

.guideline-item.technical {
  border-left-color: #6f42c1;
  background: #f8f7ff;
}

.guideline-item h4 {
  margin-top: 0;
  margin-bottom: 0.8em;
  font-size: 1em;
}

.guideline-item ul {
  margin-bottom: 0;
  padding-left: 1.2em;
}

.guideline-item li {
  margin-bottom: 0.5em;
  font-size: 0.9em;
  line-height: 1.4;
}

.technical-note {
  background: #e3f2fd;
  border: 1px solid #bbdefb;
  border-radius: 4px;
  padding: 0.8em;
  text-align: center;
  font-size: 0.9em;
  color: #1565c0;
}

/* Animation de chargement */
button[disabled] {
  position: relative;
}

button[disabled]::after {
  content: '';
  position: absolute;
  top: 50%;
  right: 1em;
  transform: translateY(-50%);
  width: 1em;
  height: 1em;
  border: 2px solid transparent;
  border-top: 2px solid currentColor;
  border-radius: 50%;
  animation: spin 1s linear infinite;
}

@keyframes spin {
  0% { transform: translateY(-50%) rotate(0deg); }
  100% { transform: translateY(-50%) rotate(360deg); }
}
</style>
