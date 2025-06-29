<template>
  <div class="health-data-container">
    <h1>{{ $t('health_data_title', 'Indicateurs de Santé') }}</h1>
    
    <!-- Filtres -->
    <div class="filters-section">
      <h3>{{ $t('filters', 'Filtres') }}</h3>
      <div class="filters-grid">
        <div class="filter-group">
          <label>{{ $t('country', 'Pays') }}:</label>
          <select v-model="filters.country_name" @change="applyFilters">
            <option value="">{{ $t('all_countries', 'Tous les pays') }}</option>
            <option v-for="country in countries" :key="country.id" :value="country.name">
              {{ country.name }}
            </option>
          </select>
        </div>
        
        <div class="filter-group">
          <label>{{ $t('indicator_type', 'Type d\'indicateur') }}:</label>
          <select v-model="filters.indicator_name" @change="applyFilters">
            <option value="">{{ $t('all_indicators', 'Tous les indicateurs') }}</option>
            <option v-for="indicator in indicatorTypes" :key="indicator.id" :value="indicator.name">
              {{ indicator.name }}
            </option>
          </select>
        </div>
        
        <div class="filter-group">
          <label>{{ $t('year', 'Année') }}:</label>
          <select v-model="filters.year" @change="applyFilters">
            <option value="">{{ $t('all_years', 'Toutes les années') }}</option>
            <option v-for="year in availableYears" :key="year" :value="year">
              {{ year }}
            </option>
          </select>
        </div>
        
        <div class="filter-group">
          <label>{{ $t('who_region', 'Région OMS') }}:</label>
          <select v-model="filters.who_region" @change="applyFilters">
            <option value="">{{ $t('all_regions', 'Toutes les régions') }}</option>
            <option v-for="region in availableRegions" :key="region" :value="region">
              {{ region }}
            </option>
          </select>
        </div>
      </div>
      
      <div class="filter-actions">
        <button @click="clearFilters" class="clear-btn">{{ $t('clear_filters', 'Effacer les filtres') }}</button>
        <button @click="applyFilters" class="apply-btn">{{ $t('apply_filters', 'Appliquer') }}</button>
      </div>
    </div>
    
    <!-- État de chargement et erreurs -->
    <div v-if="loading" class="loading">{{ $t('loading', 'Chargement en cours...') }}</div>
    <div v-else-if="error" class="error">
      {{ $t('error_loading', 'Erreur lors du chargement des données') }} : {{ error.message }}
      <button @click="loadData" class="retry-btn">{{ $t('retry', 'Réessayer') }}</button>
    </div>
    
    <!-- Tableau de données -->
    <div v-else class="data-section">
      <div v-if="healthData.length === 0" class="no-data">
        {{ $t('no_data', 'Aucune donnée disponible pour les filtres sélectionnés') }}
      </div>
      
      <table v-else class="data-table">
        <thead>
          <tr>
            <th>{{ $t('country', 'Pays') }}</th>
            <th>{{ $t('who_region', 'Région OMS') }}</th>
            <th>{{ $t('indicator_type', 'Type d\'indicateur') }}</th>
            <th>{{ $t('year', 'Année') }}</th>
            <th>{{ $t('value_type', 'Type de valeur') }}</th>
            <th>{{ $t('value', 'Valeur') }}</th>
            <th>{{ $t('confidence_interval', 'Intervalle de confiance') }}</th>
          </tr>
        </thead>
        <tbody>
          <tr v-for="item in healthData" :key="`${item.id}-${item.country?.id}-${item.indicator_type?.id}`">
            <td>{{ item.country?.name || 'N/A' }}</td>
            <td>{{ item.country?.who_region || 'N/A' }}</td>
            <td>{{ item.indicator_type?.name || 'N/A' }}</td>
            <td>{{ item.year || 'N/A' }}</td>
            <td>{{ item.value_type || 'N/A' }}</td>
            <td>{{ formatValue(item.value, item.value_text) }}</td>
            <td>{{ formatConfidenceInterval(item.confidence_min, item.confidence_max) }}</td>
          </tr>
        </tbody>
      </table>
    </div>
    
    <!-- Pagination -->
    <div v-if="!error && !loading" class="pagination">
      <button @click="prevPage" :disabled="page === 0" class="page-btn">
        {{ $t('previous', 'Précédent') }}
      </button>
      <span class="page-info">
        {{ $t('page', 'Page') }} {{ page + 1 }}
        <span v-if="totalPages > 0">/ {{ totalPages }}</span>
        ({{ healthData.length }} {{ $t('results', 'résultats') }})
      </span>
      <button @click="nextPage" :disabled="!hasNextPage" class="page-btn">
        {{ $t('next', 'Suivant') }}
      </button>
    </div>
  </div>
</template>

<script setup>
import { ref, onMounted, watch } from "vue";
import { 
  fetchHealthIndicatorsDetailed, 
  fetchCountries, 
  fetchIndicatorTypes,
  fetchFromAPI 
} from "../../services/api.js";

// État réactif
const healthData = ref([]);
const countries = ref([]);
const indicatorTypes = ref([]);
const availableYears = ref([]);
const availableRegions = ref([]);

const page = ref(0);
const limit = 25;
const totalPages = ref(0);
const hasNextPage = ref(false);

const loading = ref(false);
const error = ref(null);

// Filtres
const filters = ref({
  country_name: '',
  indicator_name: '',
  year: '',
  who_region: ''
});

// Fonctions utilitaires
function formatValue(value, valueText) {
  if (valueText) return valueText;
  if (value === null || value === undefined) return 'N/A';
  return Number(value).toLocaleString('fr-FR', { maximumFractionDigits: 3 });
}

function formatConfidenceInterval(min, max) {
  if (!min && !max) return 'N/A';
  if (min && max) return `[${Number(min).toFixed(2)} - ${Number(max).toFixed(2)}]`;
  if (min) return `≥ ${Number(min).toFixed(2)}`;
  if (max) return `≤ ${Number(max).toFixed(2)}`;
  return 'N/A';
}

// Fonctions de chargement
async function loadInitialData() {
  try {
    // Charger les pays
    const countriesData = await fetchCountries(0, 1000); // Charger tous les pays
    countries.value = countriesData;
    
    // Charger les types d'indicateurs
    const indicatorsData = await fetchIndicatorTypes();
    indicatorTypes.value = indicatorsData;
    
    // Charger les années et régions disponibles
    const yearsData = await fetchFromAPI('/health-indicators/years/');
    availableYears.value = yearsData.sort((a, b) => b - a); // Tri décroissant
    
    const regionsData = await fetchFromAPI('/countries/regions/');
    availableRegions.value = regionsData;
    
  } catch (err) {
    console.error('Erreur lors du chargement des données initiales:', err);
  }
}

async function loadData() {
  loading.value = true;
  error.value = null;
  
  try {
    const queryParams = {
      offset: page.value * limit,
      limit: limit + 1, // +1 pour détecter s'il y a une page suivante
      ...Object.fromEntries(
        Object.entries(filters.value).filter(([, value]) => value !== '')
      )
    };
    
    const result = await fetchHealthIndicatorsDetailed(queryParams);
    
    if (result.length > limit) {
      hasNextPage.value = true;
      healthData.value = result.slice(0, limit);
    } else {
      hasNextPage.value = false;
      healthData.value = result;
    }
    
    // Estimation du nombre total de pages (approximative)
    if (hasNextPage.value) {
      totalPages.value = page.value + 2; // Au moins 2 pages
    } else {
      totalPages.value = page.value + 1;
    }
    
  } catch (err) {
    error.value = err;
    console.error('Erreur lors du chargement des données:', err);
  } finally {
    loading.value = false;
  }
}

// Actions utilisateur
function applyFilters() {
  page.value = 0; // Retour à la première page
  loadData();
}

function clearFilters() {
  filters.value = {
    country_name: '',
    indicator_name: '',
    year: '',
    who_region: ''
  };
  applyFilters();
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

// Lifecycle et watchers
onMounted(async () => {
  await loadInitialData();
  await loadData();
});

watch(() => page.value, loadData);
</script>

<style scoped>
.health-data-container {
  padding: 1rem;
  max-width: 1200px;
  margin: 0 auto;
}

.filters-section {
  background: #f8f9fa;
  padding: 1rem;
  border-radius: 8px;
  margin-bottom: 1.5rem;
}

.filters-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
  gap: 1rem;
  margin-bottom: 1rem;
}

.filter-group {
  display: flex;
  flex-direction: column;
}

.filter-group label {
  font-weight: 600;
  margin-bottom: 0.25rem;
  color: #495057;
}

.filter-group select {
  padding: 0.5rem;
  border: 1px solid #ced4da;
  border-radius: 4px;
  background: white;
}

.filter-actions {
  display: flex;
  gap: 0.5rem;
  justify-content: flex-end;
}

.clear-btn, .apply-btn {
  padding: 0.5rem 1rem;
  border: none;
  border-radius: 4px;
  cursor: pointer;
  font-weight: 500;
}

.clear-btn {
  background: #6c757d;
  color: white;
}

.apply-btn {
  background: #007bff;
  color: white;
}

.clear-btn:hover, .apply-btn:hover {
  opacity: 0.8;
}

.data-table {
  width: 100%;
  border-collapse: collapse;
  margin-bottom: 1rem;
  background: white;
  box-shadow: 0 1px 3px rgba(0,0,0,0.1);
  border-radius: 8px;
  overflow: hidden;
}

.data-table th,
.data-table td {
  padding: 0.75rem;
  text-align: left;
  border-bottom: 1px solid #dee2e6;
}

.data-table th {
  background: #e9ecef;
  font-weight: 600;
  color: #495057;
}

.data-table tr:hover {
  background: #f8f9fa;
}

.pagination {
  display: flex;
  align-items: center;
  justify-content: center;
  gap: 1rem;
  margin-top: 1rem;
  margin-bottom: 2rem;
}

.page-btn {
  padding: 0.5rem 1rem;
  border: 1px solid #007bff;
  background: white;
  color: #007bff;
  border-radius: 4px;
  cursor: pointer;
}

.page-btn:disabled {
  opacity: 0.5;
  cursor: not-allowed;
}

.page-btn:hover:not(:disabled) {
  background: #007bff;
  color: white;
}

.page-info {
  font-weight: 500;
  color: #495057;
}

.loading, .error, .no-data {
  text-align: center;
  padding: 2rem;
  font-weight: 500;
}

.error {
  color: #dc3545;
  background: #f8d7da;
  border: 1px solid #f5c6cb;
  border-radius: 4px;
}

.retry-btn {
  margin-left: 1rem;
  padding: 0.25rem 0.5rem;
  background: #dc3545;
  color: white;
  border: none;
  border-radius: 4px;
  cursor: pointer;
}

.no-data {
  color: #6c757d;
  background: #e9ecef;
  border-radius: 4px;
}

.loading {
  color: #007bff;
}
</style>
