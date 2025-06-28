<template>
  <div>
    <h1>{{ $t('traitement_title') }}</h1>
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
          </tr>
        </thead>
        <tbody>
          <tr v-for="item in data" :key="item.id">
            <td>{{ item.nom_pays || item.id_pays || 'N/A' }}</td>
            <td>{{ formatNumber(item.valeur) }}</td>
          </tr>
        </tbody>
      </table>
      <div v-else class="no-data">Aucune donnée disponible</div>
      <div class="pagination">
        <button @click="prevPage" :disabled="page === 0 || loading">Précédent</button>
        <span>Page {{ page + 1 }}</span>
        <button @click="nextPage" :disabled="data.length < limit || loading">Suivant</button>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, onMounted, watch } from "vue";
import { fetchTraitement } from "../../services/api.js";

const data = ref([]);
const page = ref(0);
const limit = 25;
const loading = ref(false);
const error = ref(null);

async function loadData() {
  loading.value = true;
  error.value = null;
  try {
    data.value = await fetchTraitement(page.value * limit, limit);
  } catch (err) {
    error.value = err;
    console.error('Erreur lors du chargement des données de traitement:', err);
  } finally {
    loading.value = false;
  }
}

function nextPage() {
  if (!loading.value && data.value.length === limit) {
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