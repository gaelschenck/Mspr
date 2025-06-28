<template>
  <div>
    <h1>{{ $t('population_hiv_title') }}</h1>
    <div v-if="loading" class="loading">Chargement en cours...</div>
    <div v-else-if="error" class="error">
      Erreur lors du chargement des données : {{ error.message }}
      <button @click="loadData" class="retry-btn">Réessayer</button>
    </div>
    <div v-else>
      <ul v-if="data.length > 0">
        <li v-for="item in data" :key="item.id">
          {{ $t('pays') }} : {{ item.nom_pays ? item.nom_pays : (item.id_pays ? item.id_pays : 'N/A') }} | 
          {{ $t('annee') }} : {{ item.annee }} | 
          {{ $t('valeur') }} : {{ item.valeur }}
        </li>
      </ul>
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
import { fetchPopulationHiv } from "../../services/api.js";

const data = ref([]);
const page = ref(0);
const limit = 25;
const loading = ref(false);
const error = ref(null);

async function loadData() {
  loading.value = true;
  error.value = null;
  try {
    data.value = await fetchPopulationHiv(page.value * limit, limit);
  } catch (err) {
    error.value = err;
    console.error('Erreur lors du chargement des données de population HIV:', err);
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

onMounted(loadData);
watch(page, loadData);
</script>

<style scoped>
.pagination {
  margin-top: 1em;
  display: flex;
  align-items: center;
  gap: 1em;
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
  color: #666;
  font-style: italic;
}

button:disabled {
  opacity: 0.5;
  cursor: not-allowed;
}
</style>