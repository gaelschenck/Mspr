<template>
  <div>
    <h1>{{ $t('population_hiv_title') }}</h1>
    
    <!-- Informations sur la pagination et le total -->
    <div v-if="!error && !loading" class="pagination-info">
      <p>Affichage de {{ startIndex + 1 }} à {{ endIndex }} résultats ({{ limit }} par page)</p>
    </div>
    
    <div v-if="loading" class="loading">
      <div class="spinner"></div>
      {{ $t('chargement') }}
    </div>
    <div v-else-if="error" class="error">
      {{ $t('erreur_chargement') }} : {{ error.message }}
      <button @click="loadData" class="retry-btn">{{ $t('reessayer') }}</button>
    </div>
    <div v-else>
      <table v-if="data.length > 0" class="data-table">
        <thead>
          <tr>
            <th>{{ $t('pays') }}</th>
            <th>{{ $t('region_oms') }}</th>
            <th>{{ $t('annee') }}</th>
            <th>{{ $t('indicateur') }}</th>
            <th>{{ $t('type_valeur') }}</th>
            <th>{{ $t('valeur') }}</th>
            <th>{{ $t('intervalle_confiance') }}</th>
            <th>{{ $t('unite') }}</th>
          </tr>
        </thead>
        <tbody>
          <tr v-for="item in data" :key="item.id">
            <td class="country-cell">{{ item.country_name || item.id_pays || 'N/A' }}</td>
            <td class="region-cell">{{ item.who_region || 'N/A' }}</td>
            <td class="year-cell">{{ item.year || 'N/A' }}</td>
            <td class="indicator-cell">{{ item.indicator_name || 'People Living with HIV' }}</td>
            <td class="value-type-cell">{{ $t(translateValueType(item.value_type)) }}</td>
            <td class="value-cell">{{ formatNumber(item.value) }}</td>
            <td class="confidence-cell">{{ formatConfidenceInterval(item.confidence_interval_lower, item.confidence_interval_upper) }}</td>
            <td class="unit-cell">{{ item.unit_name || 'N/A' }}</td>
          </tr>
        </tbody>
      </table>
      <div v-else class="no-data">
        <div class="no-data-icon"></div>
        <p>{{ $t('aucune_donnee') }} pour la population vivant avec le VIH</p>
      </div>
    </div>
    
    <!-- Pagination améliorée -->
    <div v-if="!error" class="pagination">
      <button @click="prevPage" :disabled="page === 0 || loading" class="pagination-btn">
        ← Précédent
      </button>
      <div class="pagination-info-inline">
        <span class="current-page">{{ $t('page_courante') }} {{ page + 1 }}</span>
        <span v-if="hasNextPage" class="page-indicator">•••</span>
      </div>
      <button @click="nextPage" :disabled="!hasNextPage || loading" class="pagination-btn">
        Suivant →
      </button>
    </div>
  </div>
</template>

<script setup>
import { ref, onMounted, watch, computed } from "vue";
import { fetchHealthIndicatorsDetailed } from "../../services/api.js";

const data = ref([]);
const page = ref(0);
const limit = 25;
const loading = ref(false);
const error = ref(null);
const hasNextPage = ref(false);

// Informations pour l'affichage de pagination
const startIndex = computed(() => page.value * limit);
const endIndex = computed(() => {
  const maxEnd = startIndex.value + limit;
  const actualEnd = startIndex.value + data.value.length;
  return Math.min(maxEnd, actualEnd);
});

async function loadData() {
  loading.value = true;
  error.value = null;
  console.log(' PopulationHiv: Chargement des données, page:', page.value);
  
  try {
    const result = await fetchHealthIndicatorsDetailed({
      offset: page.value * limit,
      limit: limit + 1, // +1 pour détecter s'il y a une page suivante
      indicator_type_name: 'People Living with HIV'
    });
    
    console.log(' PopulationHiv: Données reçues:', result.length, 'éléments');
    
    if (result.length > limit) {
      // Il y a plus de données disponibles
      hasNextPage.value = true;
      data.value = result.slice(0, limit); // Prendre seulement les 25 premiers
      console.log(' PopulationHiv: Page suivante disponible');
    } else {
      // Pas de page suivante
      hasNextPage.value = false;
      data.value = result;
      console.log(' PopulationHiv: Dernière page atteinte');
    }
    
    // Log des premières données pour debug
    if (data.value.length > 0) {
      console.log(' PopulationHiv: Premier élément:', data.value[0]);
    }
    
  } catch (err) {
    error.value = err;
    console.error(' PopulationHiv: Erreur lors du chargement des données:', err);
  } finally {
    loading.value = false;
  }
}

function nextPage() {
  if (!loading.value && hasNextPage.value) {
    console.log(' PopulationHiv: Navigation vers page suivante');
    page.value++;
  }
}

function prevPage() {
  if (page.value > 0 && !loading.value) {
    console.log(' PopulationHiv: Navigation vers page précédente');
    page.value--;
  }
}

function formatNumber(value) {
  if (value === null || value === undefined || value === '') return 'N/A';
  const num = Number(value);
  if (isNaN(num)) return 'N/A';
  return num.toLocaleString('fr-FR', { maximumFractionDigits: 2 });
}

function formatConfidenceInterval(lower, upper) {
  if (lower !== null && lower !== undefined && upper !== null && upper !== undefined) {
    const lowerNum = Number(lower);
    const upperNum = Number(upper);
    if (!isNaN(lowerNum) && !isNaN(upperNum)) {
      return `[${lowerNum.toLocaleString('fr-FR', { maximumFractionDigits: 2 })} - ${upperNum.toLocaleString('fr-FR', { maximumFractionDigits: 2 })}]`;
    }
  }
  return 'N/A';
}

function translateValueType(valueType) {
  if (!valueType) return 'aucune_donnee';
  
  const translations = {
    'Estimate': 'estimation',
    'estimate': 'estimation',
    'Lower bound': 'borne_inferieure',
    'lower bound': 'borne_inferieure',
    'Upper bound': 'borne_superieure',
    'upper bound': 'borne_superieure',
    'Median': 'mediane',
    'median': 'mediane',
    'Mean': 'moyenne',
    'mean': 'moyenne'
  };
  
  // Retourner la clé de traduction si elle existe, sinon retourner le texte original
  return translations[valueType] || 'type_valeur';
}

onMounted(() => {
  console.log(' PopulationHiv: Composant monté, chargement initial des données');
  loadData();
});

watch(page, () => {
  console.log(' PopulationHiv: Changement de page détecté:', page.value);
  loadData();
});
</script>

<style scoped>
.pagination-info {
  margin-bottom: 1em;
  color: #6c757d;
  font-size: 0.9em;
  text-align: center;
}

.pagination {
  margin-top: 2em;
  margin-bottom: 2em;
  display: flex;
  align-items: center;
  gap: 1.5em;
  justify-content: center;
  flex-wrap: wrap;
}

.pagination-info-inline {
  display: flex;
  align-items: center;
  gap: 0.5em;
  font-weight: 500;
  color: #495057;
}

.current-page {
  background-color: #007bff;
  color: white;
  padding: 0.5em 1em;
  border-radius: 20px;
  font-size: 0.9em;
}

.page-indicator {
  color: #6c757d;
  font-size: 1.2em;
}

.pagination-btn {
  padding: 0.75em 1.5em;
  background-color: #007bff;
  color: white;
  border: none;
  border-radius: 25px;
  cursor: pointer;
  transition: all 0.3s ease;
  font-weight: 500;
  font-size: 0.9em;
}

.pagination-btn:hover:not(:disabled) {
  background-color: #0056b3;
  transform: translateY(-2px);
  box-shadow: 0 4px 8px rgba(0, 123, 255, 0.3);
}

.pagination-btn:disabled {
  background-color: #6c757d;
  cursor: not-allowed;
  transform: none;
  box-shadow: none;
}

.loading {
  padding: 2em;
  text-align: center;
  color: #6c757d;
  display: flex;
  align-items: center;
  justify-content: center;
  gap: 1em;
  font-size: 1.1em;
}

.spinner {
  width: 24px;
  height: 24px;
  border: 3px solid #f3f3f3;
  border-top: 3px solid #007bff;
  border-radius: 50%;
  animation: spin 1s linear infinite;
}

@keyframes spin {
  0% { transform: rotate(0deg); }
  100% { transform: rotate(360deg); }
}

.error {
  padding: 1.5em;
  background-color: #fee;
  border: 1px solid #fcc;
  border-radius: 8px;
  color: #c66;
  margin: 1.5em 0;
  text-align: center;
}

.retry-btn {
  margin-left: 1em;
  padding: 0.5em 1.5em;
  background-color: #007bff;
  color: white;
  border: none;
  border-radius: 6px;
  cursor: pointer;
  transition: background-color 0.2s;
}

.retry-btn:hover {
  background-color: #0056b3;
}

.no-data {
  padding: 3em;
  text-align: center;
  color: #6c757d;
  background-color: #f8f9fa;
  border-radius: 8px;
  margin: 2em 0;
}

.no-data-icon {
  font-size: 3em;
  margin-bottom: 0.5em;
  opacity: 0.5;
}

.no-data p {
  font-size: 1.1em;
  margin: 0;
  font-style: italic;
}

.data-table {
  width: 100%;
  border-collapse: collapse;
  margin: 1em 0;
  box-shadow: 0 2px 8px rgba(0,0,0,0.1);
  border-radius: 8px;
  overflow: hidden;
}

.data-table th,
.data-table td {
  border: 1px solid #dee2e6;
  padding: 0.75em;
  text-align: left;
  vertical-align: top;
}

.data-table th {
  background-color: #f8f9fa;
  font-weight: 600;
  color: #495057;
  font-size: 0.9em;
  text-transform: uppercase;
  letter-spacing: 0.5px;
}

.data-table tr:nth-child(even) {
  background-color: #f8f9fa;
}

.data-table tr:hover {
  background-color: #e3f2fd;
  transition: background-color 0.2s;
}

.data-table td {
  color: #495057;
  font-size: 0.9em;
}

/* Styles spécifiques par colonne */
.country-cell {
  font-weight: 500;
  color: #2c3e50;
}

.region-cell {
  color: #7b68ee;
  font-style: italic;
}

.year-cell {
  text-align: center;
  font-weight: 500;
}

.indicator-cell {
  color: #17a2b8;
  font-size: 0.85em;
}

.value-type-cell {
  background-color: #e8f4f8;
  font-size: 0.85em;
  text-align: center;
}

.value-cell {
  font-weight: 600;
  color: #28a745;
  text-align: right;
}

.confidence-cell {
  color: #6c757d;
  font-size: 0.85em;
  text-align: center;
}

.unit-cell {
  color: #6f42c1;
  font-size: 0.85em;
  text-align: center;
}

/* Responsive design */
@media (max-width: 768px) {
  .data-table {
    font-size: 0.8em;
  }
  
  .data-table th,
  .data-table td {
    padding: 0.5em;
  }
  
  .pagination {
    flex-direction: column;
    gap: 1em;
  }
  
  .pagination-btn {
    padding: 0.6em 1.2em;
  }
}
</style>