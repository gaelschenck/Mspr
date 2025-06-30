<template>
  <div>
    <div>
    <h1>{{ $t('testprediction_title') }}</h1>
    
    <!-- Sélection région WHO -->
    <label for="region">{{ $t('testprediction_choose_region') }}</label>
    <select v-model="selectedRegion" id="region" @change="onRegionChange">
      <option value="">-- {{ $t('all_regions') }} --</option>
      <option v-for="region in regions" :key="region" :value="region">{{ region }}</option>
    </select>
  </div>
  
  <div>
    <!-- Sélection pays (filtré par région) -->
    <label for="pays">{{ $t('testprediction_choose_country') }}</label>
    <select v-model="selectedPays" id="pays">
      <option value="">-- {{ $t('all_countries') }} --</option>
      <option v-for="country in filteredCountries" :key="country.id" :value="country.nom">{{ country.nom }}</option>
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
    <!-- Sélection type de valeur -->
    <label for="value_type">{{ $t('value_type') }}</label>
    <select v-model="selectedValueType" id="value_type">
      <option value="">-- {{ $t('all_values') }} --</option>
      <option v-for="valueType in valueTypes" :key="valueType" :value="valueType">{{ valueType }}</option>
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

// État réactif - NOUVEAU SYSTÈME
const regions = ref([]);
const paysList = ref([]);
const indicatorTypes = ref([]);
const valueTypes = ref([]);
const availableYears = ref([]);

const selectedRegion = ref("");
const selectedPays = ref("");
const selectedIndicatorType = ref("");
const selectedValueType = ref("");
const yearMin = ref("");
const yearMax = ref("");

const loading = ref(false);
const error = ref(null);
const success = ref(null);
const debugInfo = ref(null);

// Pays filtrés par région
const filteredCountries = computed(() => {
  if (!selectedRegion.value) return paysList.value;
  return paysList.value.filter(country => country.region === selectedRegion.value);
});

// Vérification si on peut soumettre
const canSubmit = computed(() => {
  // Au minimum, on doit avoir soit une région, soit un pays, soit un type d'indicateur
  return selectedRegion.value || selectedPays.value || selectedIndicatorType.value;
});

// Chargement initial des vraies métadonnées
onMounted(async () => {
  console.log("🚀 TESTPREDICTION.VUE - VERSION MÉTADONNÉES RÉELLES !");
  
  try {
    loading.value = true;
    error.value = null;
    
    // Charger toutes les métadonnées en parallèle
    const [
      responsePays,
      responseRegions, 
      responseIndicatorTypes,
      responseValueTypes,
      responseYears
    ] = await Promise.all([
      fetchFromAPI("/countries/"),
      fetchFromAPI("/countries/regions/"),
      fetchFromAPI("/indicator-types/list/"),
      fetchFromAPI("/health-indicators/value-types/"),
      fetchFromAPI("/health-indicators/years/")
    ]);

    console.log("📊 Métadonnées chargées:");
    console.log("- Pays:", responsePays.length);
    console.log("- Régions:", responseRegions);
    console.log("- Types d'indicateurs:", responseIndicatorTypes);
    console.log("- Types de valeurs:", responseValueTypes);
    console.log("- Années:", responseYears);

    // Stocker les données
    paysList.value = responsePays.map(country => ({
      id: country.id,
      nom: country.name,
      region: country.who_region
    }));
    
    regions.value = responseRegions.who_regions || [];
    indicatorTypes.value = responseIndicatorTypes.indicator_types || [];
    valueTypes.value = responseValueTypes.value_types || [];
    availableYears.value = responseYears.years || [];

    console.log("✅ Données transformées et prêtes");

  } catch (err) {
    console.error("❌ Erreur lors du chargement des métadonnées:", err);
    error.value = "Erreur lors du chargement des métadonnées: " + err.message;
  } finally {
    loading.value = false;
  }
});

// Gestionnaires d'événements
const onRegionChange = () => {
  // Réinitialiser le pays si la région change
  selectedPays.value = "";
  updateDebugInfo();
};

const onIndicatorTypeChange = () => {
  updateDebugInfo();
};

const updateDebugInfo = () => {
  const criteria = {
    region: selectedRegion.value,
    pays: selectedPays.value,
    indicator_type: selectedIndicatorType.value,
    value_type: selectedValueType.value,
    year_range: yearMin.value && yearMax.value ? `${yearMin.value}-${yearMax.value}` : null,
    filtered_countries: filteredCountries.value.length
  };
  
  debugInfo.value = JSON.stringify(criteria, null, 2);
};

// Soumettre les choix et lancer la prédiction
const submitChoices = async () => {
  // Validation améliorée
  if (!canSubmit.value) {
    error.value = "Veuillez sélectionner au moins une région, un pays ou un type d'indicateur";
    return;
  }

  // Construction du payload optimisé
  const payload = {
    // Filtres géographiques
    who_region: selectedRegion.value || null,
    pays: selectedPays.value || null,
    
    // Filtres sur les indicateurs
    indicator_types: selectedIndicatorType.value ? [selectedIndicatorType.value] : null,
    value_types: selectedValueType.value ? [selectedValueType.value] : null,
    
    // Filtres temporels
    year_min: yearMin.value ? parseInt(yearMin.value) : null,
    year_max: yearMax.value ? parseInt(yearMax.value) : null,
    
    // Configuration
    target_column: "value", // Toujours utiliser 'value' comme cible
    table: "statistique", // Mode général
    max_records: 1000, // Limiter pour les performances
    include_confidence: true // Inclure les intervalles de confiance
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
      errorMessage = "Aucune donnée trouvée avec ces critères. Essayez de modifier vos filtres.";
    } else if (err.message.includes('500')) {
      errorMessage = "Erreur serveur. Vérifiez que les données sont disponibles.";
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

h1 {
  color: #333;
  margin-bottom: 1.5em;
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
