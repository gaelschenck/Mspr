<template>
  <div class="graphs">
    <h2>{{ $t('prediction_graphs_title') }}</h2>
    <canvas v-if="result && (result.predictions || result.prediction)" id="myChart" width="400" height="200"></canvas>
    
    <div v-if="result && result.future_prediction !== undefined && result.future_year">
      <h3>
        {{ $t('prediction_next_year') }} {{ result.future_year }} :
        <span class="prediction">{{ result.future_prediction }}</span>
      </h3>
    </div>

    <div v-else-if="result && result.future_prediction === null">
      <p>{{ $t('prediction_no_future') }}</p>
    </div>

    <div v-else>
      <p>{{ $t('prediction_graphs_no_result') }}</p>
    </div>
  </div>
</template>

<script setup>
import { ref, onMounted, onUnmounted } from "vue";
import { useRoute } from "vue-router";
import { usePredictionStore } from "@/stores/predictionStore";
import Chart from "chart.js/auto";

const route = useRoute();
const predictionStore = usePredictionStore();
const result = ref(predictionStore.result);

// Si le store est vide, on tente de récupérer depuis la query
if (!result.value && route.query.result) {
  console.log("Résultat reçu pour affichage :", result.value);
  try {
    result.value = JSON.parse(route.query.result);
    predictionStore.setResult(result.value); // Optionnel : pour garder la donnée en mémoire
  } catch (e) {
    result.value = null;
  }
}

onMounted(() => {
  const dataArray = result.value?.predictions || result.value?.prediction;
  if (result.value && dataArray) {
    const ctx = document.getElementById("myChart").getContext("2d");
    new Chart(ctx, {
      type: "bar",
      data: {
        labels: result.value.labels || dataArray.map((_, i) => i + 1),
        datasets: [{
          label: "Prédictions",
          data: dataArray,
          borderWidth: 1
        }]
      },
      options: {
        responsive: true,
        maintainAspectRatio: false
      }
    });
  }
});

onUnmounted(() => {
  predictionStore.setResult(null);
});
</script>

<style scoped>
.graphs {
  text-align: center;
  margin-top: 20px;
}
canvas {
  width: 100% !important;
  height: 400px !important;
  display: block;
}
.prediction {
  font-weight: bold;
  color: #1976d2;
}
</style>