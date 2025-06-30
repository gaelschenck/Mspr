<template>
  <div>
    <div>
    <h1>{{ $t('testprediction_title') }}</h1>
    
    <!-- Encart d'informations importantes -->
    <div class="info-panel">
      <h3>📊 {{ $t('prediction_guidelines_title') || 'Guide pour une prédiction réussie' }}</h3>
      
      <div class="guidelines-grid">
        <div class="guideline-item success">
          <h4>✅ {{ $t('what_works') || 'Ce qui fonctionne bien' }}</h4>
          <ul>
            <li><strong>{{ $t('region_strategy') || 'Stratégie régionale' }}</strong> : Sélectionnez une région entière (ex: Americas, Europe) pour maximiser les données</li>
            <li><strong>{{ $t('indicator_popular') || 'Indicateurs recommandés' }}</strong> : 
              <br>• "People Living with HIV" (excellent)
              <br>• "HIV-related Deaths" (très bon)
              <br>• "ART Coverage" (bon)</li>
            <li><strong>{{ $t('data_range') || 'Période large' }}</strong> : Laissez les années par défaut ou utilisez une plage étendue</li>
          </ul>
        </div>
        
        <div class="guideline-item warning">
          <h4>⚠️ {{ $t('what_to_avoid') || 'À éviter' }}</h4>
          <ul>
            <li><strong>{{ $t('no_selection') || 'Aucune sélection' }}</strong> : Sélectionnez au moins une région OU un indicateur</li>
            <li><strong>{{ $t('period_too_short') || 'Période trop courte' }}</strong> : Évitez les plages d\'années de moins de 5 ans</li>
            <li><strong>{{ $t('rare_indicators') || 'Indicateurs rares' }}</strong> : Certains indicateurs ont peu de données</li>
          </ul>
        </div>
      </div>
      
      <div class="technical-note">
        <strong>📋 {{ $t('technical_requirement') || 'Exigence technique' }}</strong> : 
        Le modèle de machine learning nécessite au minimum <strong>5 points de données</strong> pour générer une prédiction fiable.
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
      {{ loading ? $t('testprediction_loading') : $t('testprediction_submit') }}
    </button>
    
    <!-- Message d'aide simplifié -->
    <div class="help-info-simple">
      💡 <strong>{{ $t('quick_tip') || 'Conseil rapide' }}</strong> : 
      {{ $t('quick_tip_text') || 'Sélectionnez une région pour de meilleurs résultats. Les types de valeurs sont gérés automatiquement.' }}
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
    error.value = "Erreur lors du chargement des métadonnées: " + err.message;
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
    error.value = "Veuillez sélectionner au moins une région ou un type d'indicateur";
    return;
  }

  // Construction du payload simplifié et optimisé
  const payload = {
    // Filtres géographiques
    who_region: selectedRegion.value || null,
    
    // Filtres sur les indicateurs
    indicator_types: selectedIndicatorType.value ? [selectedIndicatorType.value] : null,
    
    // Filtres temporels
    year_min: yearMin.value ? parseInt(yearMin.value) : null,
    year_max: yearMax.value ? parseInt(yearMax.value) : null,
    
    // Configuration
    target_column: "value",
    table: "statistique", 
    max_records: 1000, // Minimum 100 requis par l'API
    include_confidence: true
  };

  console.log("📤 Payload optimisé envoyé:", payload);

  try {
    loading.value = true;
    error.value = null;
    success.value = null;
    
    // Étape 1: Créer le DataFrame avec la nouvelle API flexible
    console.log("📊 Création du DataFrame...");
    const response = await fetchFromAPI("/dataframe/", {
      method: "POST",
      body: JSON.stringify(payload)
    });
    
    console.log("✅ DataFrame créé:", response);
    console.log(`📈 ${response.data.length} enregistrements, ${response.shape[1]} colonnes`);
    console.log("📊 Statistiques:", response.statistics);
    
    if (!response.data || response.data.length === 0) {
      throw new Error("Aucune donnée trouvée avec ces critères. Essayez d'élargir vos filtres.");
    }

    if (response.data.length < 10) {
      console.warn("⚠️ Peu de données trouvées, la prédiction pourrait être imprécise");
    }

    // Étape 2: Entraîner le modèle avec les données structurées
    console.log("🤖 Entraînement du modèle...");
    const trainPayload = {
      dataframe: response.data, // Utiliser les données structurées
      target_column: "value" // Toujours 'value' dans le nouveau schéma
    };

    const trainResponse = await fetchFromAPI("/train_model/", {
      method: "POST",
      body: JSON.stringify(trainPayload)
    });
    
    console.log("🎯 Modèle entraîné avec succès:", trainResponse);
    
    // Message de succès détaillé
    const rmse = trainResponse.rmse?.toFixed(2) || 'N/A';
    const r2 = trainResponse.r2?.toFixed(3) || 'N/A';
    const dataCount = response.data.length;
    
    success.value = `✅ Modèle entraîné avec succès ! 
📊 ${dataCount} points de données utilisés
📈 RMSE: ${rmse}
🎯 R²: ${r2}
${trainResponse.future_prediction ? `🔮 Prédiction future: ${trainResponse.future_prediction.toFixed(2)} (${trainResponse.future_year})` : ''}`;

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
    
    // Messages d'erreur plus informatifs
    let errorMessage = "Erreur lors de la prédiction";
    
    if (err.message.includes('422')) {
      errorMessage = "❌ Paramètres invalides. Vérifiez vos sélections.";
    } else if (err.message.includes('404')) {
      errorMessage = "❌ Aucune donnée trouvée. Essayez de sélectionner une région entière ou de modifier vos filtres.";
    } else if (err.message.includes('500')) {
      errorMessage = "❌ Erreur serveur. Vérifiez que les données sont disponibles.";
    } else if (err.message.includes('assez de données')) {
      errorMessage = "❌ Pas assez de données pour la prédiction. Essayez de sélectionner une région entière ou moins de filtres.";
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
