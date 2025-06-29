<template>
  <div>
    <h1>{{ $t('mortalite_title') }}</h1>
    <div v-if="loading" class="loading">Chargement en cours...</div>
    <div v-else-if="error" class="error">
      Erreur lors du chargement des données : {{ error.message }}
      <button @click="loadData" class="retry-btn">Réessayer</button>
    </div>
    <div v-else>
      <div v-if="usData.length > 0" class="data-info">
        <p>{{ usData.length }} résultat(s) trouvé(s) pour les décès liés au VIH</p>
      </div>
      <table v-if="usData.length > 0" class="data-table">
        <thead>
          <tr>
            <th>{{ $t('pays') }}</th>
            <th>{{ $t('annee') }}</th>
            <th>{{ $t('valeur') }}</th>
            <th>Type</th>
            <th>Région WHO</th>
          </tr>
        </thead>
        <tbody>
          <tr v-for="item in usData" :key="item.id">
            <td>{{ item.country_name || item.nom_pays || item.name || 'N/A' }}</td>
            <td>{{ item.year || item.annee || 'N/A' }}</td>
            <td>{{ formatNumber(item.value) || item.valeur || 'N/A' }}</td>
            <td>{{ item.value_type || 'N/A' }}</td>
            <td>{{ item.who_region || item.region || 'N/A' }}</td>
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

const usData = ref([]);
const page = ref(0);
const limit = 25;
const loading = ref(false);
const error = ref(null);
const hasNextPage = ref(false);

async function loadData() {
  loading.value = true;
  error.value = null;
  try {
    const result = await fetchHealthIndicatorsDetailed({
      offset: page.value * limit,
      limit: limit + 1, // +1 pour détecter s'il y a une page suivante
      indicator_type_name: 'HIV-related Deaths'
    });
    
    if (result.length > limit) {
      // Il y a plus de données disponibles
      hasNextPage.value = true;
      // Pour l'instant, on ne filtre pas pour voir toutes les données
      usData.value = result.slice(0, limit);
    } else {
      // Pas de page suivante
      hasNextPage.value = false;
      usData.value = result;
    }
  } catch (err) {
    error.value = err;
    console.error('Erreur lors du chargement des données de mortalité:', err);
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

onMounted(loadData);
watch(() => page.value, loadData);
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

.data-info {
  margin: 1em 0;
  padding: 0.5em;
  background-color: #e9ecef;
  border-radius: 4px;
  font-size: 0.9em;
  color: #495057;
}

.data-info p {
  margin: 0;
  font-weight: 500;
}

.data-table {
  width: 100%;
  border-collapse: collapse;
  margin: 1em 0;
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