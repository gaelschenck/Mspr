<template>
  <div class="graphs">
    <h2>Graphiques de Prédiction</h2>
    <!-- Exemple avec Chart.js ou Plotly -->
    <canvas id="myChart" width="400" height="200"></canvas>
  </div>
</template>

<script>
import { onMounted } from "vue";
import Chart from "chart.js/auto";

export default {
  name: "PredictionGraphs",
  setup() {
    onMounted(() => {
      const ctx = document.getElementById("myChart").getContext("2d");
      const myChart = new Chart(ctx, {
        type: "bar",
        data: {
          labels: ["Jan", "Feb", "Mar", "Apr"],
          datasets: [{
            label: "Prédictions",
            data: [12, 19, 3, 5],
            borderWidth: 1
          }]
        },
      });
    });
  }
};
</script>

<style scoped>
.graphs {
  text-align: center;
  margin-top: 20px;
}
</style>
