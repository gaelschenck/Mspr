<template>
  <div>
    <div>
    <h1>{{ $t('testprediction_title') }}</h1>
    <label for="region">{{ $t('testprediction_choose_region') }}</label>
    <select v-model="selectedRegion" id="region">
      <option v-for="region in regions" :key="region" :value="region">{{ region }}</option>
    </select>
  </div>
  <div>
    <label for="pays">{{ $t('testprediction_choose_country') }}</label>
    <select v-model="selectedPays" id="pays">
      <option v-for="pays in paysList" :key="pays.id" :value="pays.nom">{{ pays.nom }}</option>
    </select>
  </div>
  <div>
    <label for="table">{{ $t('testprediction_choose_table') }}</label>
    <select v-model="selectedTable" id="table" @change="fetchColumns">
      <option v-for="table in tables" :key="table" :value="table">{{ table }}</option>
    </select>
  </div>
  <div>
    <label for="target_column">{{ $t('testprediction_choose_column') }}</label>
    <select v-model="selectedColumn" id="target_column" v-if="columns.length > 0">
      <option v-for="column in columns" :key="column" :value="column">{{ column }}</option>
    </select>
  </div>

    <button @click="submitChoices" :disabled="!selectedTable || !selectedColumn || loading">
      {{ loading ? $t('testprediction_loading') : $t('testprediction_submit') }}
    </button>
    
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
import { ref, onMounted } from "vue";
import { useRouter } from "vue-router";
import { fetchFromAPI } from "../../services/api.js";

const router = useRouter();

// État réactif
const regions = ref([]);
const paysList = ref([]);
const tables = ref([]);
const columns = ref([]);
const selectedRegion = ref(null);
const selectedPays = ref(null);
const selectedTable = ref(null);
const selectedColumn = ref(null);
const loading = ref(false);
const error = ref(null);
const success = ref(null);

// Chargement initial des données
onMounted(async () => {
  console.log("🚀 NOUVEAU TESTPREDICTION.VUE CHARGÉ - VERSION CORRIGÉE !");
  
  try {
    loading.value = true;
    error.value = null;
    
    // Charger les tables disponibles
    const responseTables = await fetchFromAPI("/tables/");
    console.log("Tables disponibles:", responseTables);
    tables.value = Object.keys(responseTables.tables);

    // Charger la liste des pays
    const responsePays = await fetchFromAPI("/payslist/");
    console.log("Pays disponibles:", responsePays);
    paysList.value = responsePays;

    // Extraire les régions uniques
    const regionsSet = new Set(responsePays.map(p => p.region));
    regions.value = [...regionsSet].filter(Boolean); // Filtrer les valeurs nulles

  } catch (err) {
    console.error("Erreur lors du chargement:", err);
    error.value = "Erreur lors du chargement des données initiales";
  } finally {
    loading.value = false;
  }
});

// Récupérer les colonnes d'une table
const fetchColumns = async () => {
  if (!selectedTable.value) return;

  try {
    loading.value = true;
    error.value = null;
    
    console.log("🔧 NOUVEAU CODE - fetchColumns appelé avec table:", selectedTable.value);
    
    // Définir les colonnes selon la table sélectionnée
    const columnsByTable = {
      'health_indicators': [
        'value',           // Valeur numérique principale
        'year',           // Année 
        'confidence_min', // Confiance minimum
        'confidence_max', // Confiance maximum
        'confidence_median' // Confiance médiane
      ],
      'table_mortalite': [
        'value',
        'year'
      ],
      'table_population_hiv': [
        'value',
        'year'
      ],
      'table_statistique': [
        'value',
        'year'
      ],
      'table_traitement': [
        'value',
        'year'
      ],
      'table_transmission_mere_enfant': [
        'value',
        'year'
      ]
    };
    
    // Utiliser les colonnes prédéfinies ou des valeurs par défaut
    columns.value = columnsByTable[selectedTable.value] || ['value', 'year'];
    console.log("Colonnes pour", selectedTable.value, ":", columns.value);
    
    // Réinitialiser la colonne sélectionnée
    selectedColumn.value = null;
    
  } catch (err) {
    console.error("Erreur lors de la récupération des colonnes:", err);
    error.value = "Erreur lors de la récupération des colonnes";
  } finally {
    loading.value = false;
  }
};

// Soumettre les choix et lancer la prédiction
const submitChoices = async () => {
  // Validation
  if (!selectedTable.value || !selectedColumn.value) {
    error.value = "Veuillez sélectionner une table et une colonne cible";
    return;
  }

  if (!selectedRegion.value && !selectedPays.value) {
    error.value = "Veuillez sélectionner une région ou un pays";
    return;
  }

  const payload = {
    region: selectedRegion.value || null,
    pays: selectedPays.value || null,
    table: selectedTable.value,
    target_column: selectedColumn.value,
  };

  console.log("Payload envoyé:", payload);

  try {
    loading.value = true;
    error.value = null;
    success.value = null;
    
    // Étape 1: Créer le DataFrame
    const response = await fetchFromAPI("/dataframe/", {
      method: "POST",
      body: JSON.stringify(payload)
    });
    
    console.log("DataFrame créé:", response);
    
    if (!response.dataframe || response.dataframe.length === 0) {
      throw new Error("Aucune donnée trouvée avec ces critères");
    }

    // Étape 2: Entraîner le modèle
    const trainPayload = {
      dataframe: response.dataframe,
      target_column: payload.target_column,
    };
    
    console.log("Payload d'entraînement:", trainPayload);

    const trainResponse = await fetchFromAPI("/train_model/", {
      method: "POST",
      body: JSON.stringify(trainPayload)
    });
    
    console.log("Modèle entraîné avec succès:", trainResponse);
    
    success.value = `Modèle entraîné avec succès ! RMSE: ${trainResponse.rmse?.toFixed(2)}, R²: ${trainResponse.r2?.toFixed(2)}`;

    // Rediriger vers la page de graphiques
    router.push({
      name: 'PredictionGraphs',
      query: { result: JSON.stringify(trainResponse) }
    });

  } catch (err) {
    console.error("Erreur lors de la prédiction:", err);
    error.value = err.message || "Erreur lors de la prédiction";
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
</style>
