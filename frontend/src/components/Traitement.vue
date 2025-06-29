<template>
  <div>
    <h1>{{ $t('traitement_title') }}</h1>
    <div v-if="loading" class="loading">{{ $t('chargement') }}</div>
    <div v-else-if="error" class="error">
      {{ $t('erreur_chargement') }} : {{ error.message }}
      <button @click="loadData" class="retry-btn">{{ $t('reessayer') }}</button>
    </div>
    <div v-else>
      <div v-if="data.length > 0" class="data-info">
        <p>{{ data.length }} {{ $t('resultats_par_page') }} - Couverture du traitement antirétroviral (ART)</p>
        <p v-if="hasNextPage">{{ $t('page_courante') }} {{ page + 1 }} - {{ $t('plus_resultats') }}</p>
        <p v-else-if="page > 0">{{ $t('page_courante') }} {{ page + 1 }} - {{ $t('derniere_page') }}</p>
      </div>
      
      <table v-if="data.length > 0" class="data-table">
        <thead>
          <tr>
            <th>{{ $t('pays') }}</th>
            <th>{{ $t('region_oms') }}</th>
            <th>{{ $t('annee') }}</th>
            <th>{{ $t('type_valeur') }}</th>
            <th>{{ $t('valeur') }}</th>
            <th>{{ $t('intervalle_confiance') }}</th>
          </tr>
        </thead>
        <tbody>
          <tr v-for="item in data" :key="item.id">
            <td>{{ item.country_name || item.id_pays || 'N/A' }}</td>
            <td>{{ item.who_region || 'N/A' }}</td>
            <td>{{ item.year || item.annee || 'N/A' }}</td>
            <td>{{ formatValueType(item.value_type) }}</td>
            <td>{{ formatNumber(item.value) }}</td>
            <td>{{ formatConfidenceInterval(item.confidence_min, item.confidence_max) }}</td>
          </tr>
        </tbody>
      </table>
      <div v-else class="no-data">Aucune donnée disponible pour la couverture ART</div>
    </div>
    
    <!-- Pagination toujours visible sauf en cas d'erreur -->
    <div v-if="!error" class="pagination">
      <button @click="prevPage" :disabled="page === 0 || loading">Précédent</button>
      <span class="page-info">
        {{ $t('page_courante') }} {{ page + 1 }}
        <span v-if="hasNextPage"> - {{ $t('plus_resultats') }}</span>
        <span v-else-if="page > 0"> - {{ $t('derniere_page') }}</span>
      </span>
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
    const response = await fetchHealthIndicatorsDetailed({
      offset: page.value * limit,
      limit: limit + 1,
      indicator_type_name: 'ART Coverage'
    });
    console.log('Réponse API Traitement:', response); // Debug temporaire
    
    let rawData = [];
    // Gérer les différents formats de réponse
    if (Array.isArray(response)) {
      rawData = response;
    } else if (response && Array.isArray(response.items)) {
      rawData = response.items;
    } else if (response && Array.isArray(response.data)) {
      rawData = response.data;
    } else {
      console.error('Format de réponse inattendu:', response);
      rawData = [];
    }
    
    // Vérifier s'il y a une page suivante
    hasNextPage.value = rawData.length > limit;
    
    // Ne garder que les éléments de la page actuelle
    data.value = rawData.slice(0, limit);
    
  } catch (err) {
    error.value = err;
    console.error('Erreur lors du chargement des données de traitement:', err);
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
  if (value === null || value === undefined || value === '') return 'N/A';
  
  // Si c'est déjà une chaîne (ex: "No data"), la retourner telle quelle
  if (typeof value === 'string') return value;
  
  const num = Number(value);
  if (isNaN(num)) return 'N/A';
  
  // Formatage différent selon la taille du nombre
  if (num >= 1000000) {
    return (num / 1000000).toLocaleString('fr-FR', { maximumFractionDigits: 1 }) + 'M';
  } else if (num >= 1000) {
    return (num / 1000).toLocaleString('fr-FR', { maximumFractionDigits: 1 }) + 'K';
  } else {
    return num.toLocaleString('fr-FR', { maximumFractionDigits: 2 });
  }
}

function formatValueType(valueType) {
  if (!valueType) return 'N/A';
  
  // Traductions des types de valeurs les plus courants pour ART Coverage
  const translations = {
    'reported_receiving_art': 'Personnes sous traitement ART',
    'estimated_living_with_hiv': 'Personnes vivant avec le VIH (estimé)',
    'estimated_art_coverage_percent': 'Couverture ART (pourcentage)',
    'count': 'Nombre',
    'percent': 'Pourcentage'
  };
  
  return translations[valueType] || valueType;
}

function formatConfidenceInterval(min, max) {
  if (!min && !max) return 'N/A';
  if (min && max) return `[${Number(min).toFixed(0)} - ${Number(max).toFixed(0)}]`;
  if (min) return `≥ ${Number(min).toFixed(0)}`;
  if (max) return `≤ ${Number(max).toFixed(0)}`;
  return 'N/A';
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

.data-info {
  background: #e9ecef;
  padding: 1rem;
  border-radius: 4px;
  margin-bottom: 1rem;
}

.data-info p {
  margin: 0.25rem 0;
  color: #495057;
}

.page-info {
  font-weight: 500;
  color: #495057;
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