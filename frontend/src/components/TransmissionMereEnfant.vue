<template>
  <div>
    <h1>{{ $t('transmission_mere_enfant_title') }}</h1>
    <ul>
      <li v-for="item in data" :key="item.id">
        {{ $t('pays') }} : {{ item.nom_pays || item.id_pays }} |
        {{ $t('annee') }} : {{ item.annee }} |
        {{ $t('valeur') }} : {{ item.valeur }}
      </li>
    </ul>
    <div class="pagination">
      <button @click="prevPage" :disabled="page === 0">Précédent</button>
      <span>Page {{ page + 1 }}</span>
      <button @click="nextPage" :disabled="data.length < limit">Suivant</button>
    </div>
  </div>
</template>

<script setup>
import { ref, onMounted, watch } from "vue";
import { fetchTransmissionMereEnfant } from "../../services/api.js";

const data = ref([]);
const page = ref(0);
const limit = 25;

async function loadData() {
  data.value = await fetchTransmissionMereEnfant(page.value * limit, limit);
}

function nextPage() {
  page.value++;
}

function prevPage() {
  if (page.value > 0) page.value--;
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
</style>