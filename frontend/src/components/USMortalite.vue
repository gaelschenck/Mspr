<template>
  <div>
    <h1>{{ $t('mortalite_title') }}</h1>
    <ul>
      <li v-for="item in usData" :key="item.id">
         {{ $t('pays') }} : {{ item.nom_pays || item.id_pays }} | {{ $t('annee') }} : {{ item.annee }} | {{ $t('valeur') }} : {{ item.valeur }}
      </li>
    </ul>
  </div>
</template>

<script setup>
import { ref, onMounted } from "vue";
import { fetchUSMortalite } from "../../services/api.js";

const usData = ref([]);

onMounted(async () => {
  usData.value = await fetchUSMortalite(0, 25);
  console.log("usData :", usData.value);
});
</script>