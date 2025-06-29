<template>
  <div>
    <h1>{{ $t('transmission_mere_enfant_title') }}</h1>
    <div v-if="loading" class="loading">Chargement en cours...</div>
    <div v-else-if="error" class="error">
      Erreur lors du chargement des données : {{ error.message }}
      <button @click="loadData" class="retry-btn">Réessayer</button>
    </div>
    <div v-else>
      <table v-if="data.length > 0" class="data-table">
        <thead>
          <tr>
            <th>{{ $t('pays') }}</th>
            <th>{{ $t('valeur') }}</th>
            <th>Confiance Min</th>
            <th>Confiance Médian</th>
            <th>Confiance Max</th>
            <th>Type de valeur</th>
          </tr>
        </thead>
        <tbody>
          <tr v-for="item in data" :key="item.id">
            <td>{{ item.country_name || item.id_pays || 'N/A' }}</td>
            <td>{{ formatNumber(item.value) }}</td>
            <td>{{ formatNumber(item.confidence_min) }}</td>
            <td>{{ formatNumber(item.confidence_median) }}</td>
            <td>{{ formatNumber(item.confidence_max) }}</td>
            <td>{{ item.value_type || 'N/A' }}</td>
          </tr>
        </tbody>
      </table>
      <div v-else class="no-data">Aucune donnée disponible</div>
    </div>
    
    <!-- Pagination toujours visible sauf en cas d'erreur -->
    <div v-if="!error" class="pagination">
      <button @click="prevPage" :disabled="page === 0 || loading">Précédent</button>
      <span>Page {{ page + 1 }}</span>
      <button @click="nextPage" :disabled="!hasNextPage || loading">Suivant</button>
    </div>
  </div>
</template>

<script setup>
import { ref, onMounted, watch } from "vue";
import { fetchHealthIndicatorsDetailed } from "../../services/api.js";

const data = ref([]);
const page = ref(0);
const limit = 25;
const loading = ref(false);
const error = ref(null);
const hasNextPage = ref(false); // Nouvelle variable pour gérer la pagination

async function loadData() {
  loading.value = true;
  error.value = null;
  try {
    // Demander une donnée de plus pour savoir s'il y a une page suivante
    const result = await fetchHealthIndicatorsDetailed({
      offset: page.value * limit,
      limit: limit + 1,
      indicator_type_name: 'Prevention of Mother-to-Child Transmission'
    });
    
    let rawData = [];
    // Gérer les différents formats de réponse
    if (Array.isArray(result)) {
      rawData = result;
    } else if (result && Array.isArray(result.items)) {
      rawData = result.items;
    } else if (result && Array.isArray(result.data)) {
      rawData = result.data;
    } else {
      rawData = [];
    }
    
    // Vérifier s'il y a une page suivante
    hasNextPage.value = rawData.length > limit;
    
    // Ne garder que les éléments de la page actuelle
    data.value = rawData.slice(0, limit);
    
  } catch (err) {
    error.value = err;
    console.error('Erreur lors du chargement des données de transmission mère-enfant:', err);
  } finally {
    loading.value = false;
  }
}

function nextPage() {
  if (!loading.value && hasNextPage.value) {
    page.value++;
  }
}

function prevPage() {
  if (page.value > 0 && !loading.value) {
    page.value--;
  }
}

function formatNumber(value) {
  if (value === null || value === undefined) return 'N/A';
  return Number(value).toLocaleString('fr-FR', { maximumFractionDigits: 2 });
}

onMounted(loadData);
watch(page, loadData);
</script>

<style scoped>
.pagination {
  margin-top: 1em;
  margin-bottom: 2em; /* Ajouter de l'espace pour éviter la superposition avec le footer */
  display: flex;
  align-items: center;
  gap: 1em;
  justify-content: center;
}

.loading {
  padding: 1em;
  text-align: center;
  color: #666;
}

.error {
  padding: 1em;
  background-color: #fee;
  border: 1px solid #fcc;
  border-radius: 4px;
  color: #c66;
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

.no-data {
  padding: 1em;
  text-align: center;
  color: #999;
  font-style: italic;
}

button:disabled {
  opacity: 0.5;
  cursor: not-allowed;
}

.data-table {
  width: 100%;
  border-collapse: collapse;
  margin: 1em 0 3em 0; /* Marge en bas plus importante pour éviter le footer */
}

.data-table th,
.data-table td {
  border: 1px solid #ddd;
  padding: 0.75em;
  text-align: left;
}

.data-table th {
  background-color: #f8f9fa;
  font-weight: bold;
  color: #495057;
}

.data-table tr:nth-child(even) {
  background-color: #f8f9fa;
}

.data-table tr:hover {
  background-color: #e9ecef;
}

.data-table td {
  color: #495057;
}

.pagination {
  display: flex;
  justify-content: center;
  align-items: center;
  gap: 1em;
  margin: 2em 0;
  padding: 1em 0;
  background-color: white;
  position: relative;
  z-index: 1;
}

.pagination button {
  padding: 0.5em 1em;
  background-color: #007bff;
  color: white;
  border: none;
  border-radius: 4px;
  cursor: pointer;
  transition: background-color 0.2s;
}

.pagination button:hover:not(:disabled) {
  background-color: #0056b3;
}

.pagination button:disabled {
  background-color: #6c757d;
  cursor: not-allowed;
}
</style>