<template>
  <div class="graphs">
    <h2>Résultats de Prédiction</h2>
    
    <!-- Métriques de performance -->
    <div v-if="result" class="metrics">
      <h3>Métriques de Performance</h3>
      <div class="metrics-grid">
        <div class="metric-card">
          <span class="metric-label">RMSE</span>
          <span class="metric-value">{{ result.rmse?.toFixed(2) || 'N/A' }}</span>
        </div>
        <div class="metric-card">
          <span class="metric-label">R² Score</span>
          <span class="metric-value">{{ result.r2?.toFixed(3) || 'N/A' }}</span>
        </div>
        <div class="metric-card">
          <span class="metric-label">Échantillons</span>
          <span class="metric-value">{{ result.prediction?.length || 'N/A' }}</span>
        </div>
      </div>
    </div>
    
    <!-- Graphique -->
    <div class="chart-container">
      <canvas v-if="result && (result.predictions || result.prediction)" id="myChart"></canvas>
      <div v-else class="no-data">
        <p>Aucune donnée de prédiction disponible</p>
      </div>
    </div>
    
    <!-- Prédiction future -->
    <div v-if="result && result.future_prediction !== undefined && result.future_year" class="future-prediction">
      <h3>
        Prédiction pour {{ result.future_year }} :
        <span class="prediction">{{ result.future_prediction?.toFixed(2) }}</span>
      </h3>
    </div>

    <div v-else-if="result && result.future_prediction === null" class="no-future">
      <p>Pas de prédiction future disponible</p>
    </div>

    <!-- Message de succès -->
    <div v-if="result && result.message" class="success-message">
      <p>{{ result.message }}</p>
    </div>
  </div>
</template>

<script setup>
import { ref, onMounted, onUnmounted, nextTick } from "vue";
import { useRoute } from "vue-router";
import Chart from "chart.js/auto";

const route = useRoute();
const result = ref(null);
let chartInstance = null;

// Récupérer le résultat depuis la query
onMounted(async () => {
  try {
    if (route.query.result) {
      result.value = JSON.parse(route.query.result);
      console.log("Résultat reçu pour affichage :", result.value);
      
      // Attendre que le DOM soit mis à jour
      await nextTick();
      createChart();
    }
  } catch (e) {
    console.error("Erreur lors du parsing du résultat:", e);
    result.value = null;
  }
});

const createChart = () => {
  const dataArray = result.value?.predictions || result.value?.prediction;
  
  if (!result.value || !dataArray || !Array.isArray(dataArray)) {
    console.error("Aucune donnée de prédiction disponible");
    return;
  }

  const canvas = document.getElementById("myChart");
  if (!canvas) {
    console.error("Canvas non trouvé");
    return;
  }

  const ctx = canvas.getContext("2d");
  
  // Détruire le graphique existant s'il y en a un
  if (chartInstance) {
    chartInstance.destroy();
  }
  
  // Créer le nouveau graphique
  chartInstance = new Chart(ctx, {
    type: "line",
    data: {
      labels: result.value.labels || dataArray.map((_, i) => `Point ${i + 1}`),
      datasets: [
        {
          label: "Prédictions",
          data: dataArray,
          borderColor: "#1976d2",
          backgroundColor: "rgba(25, 118, 210, 0.1)",
          borderWidth: 2,
          fill: true,
          tension: 0.1
        }
      ]
    },
    options: {
      responsive: true,
      maintainAspectRatio: false,
      plugins: {
        title: {
          display: true,
          text: "Résultats de Prédiction"
        },
        legend: {
          display: true,
          position: 'top'
        }
      },
      scales: {
        y: {
          beginAtZero: false,
          title: {
            display: true,
            text: 'Valeurs Prédites'
          }
        },
        x: {
          title: {
            display: true,
            text: 'Points de Données'
          }
        }
      }
    }
  });
};

onUnmounted(() => {
  if (chartInstance) {
    chartInstance.destroy();
  }
});
</script>

<style scoped>
.graphs {
  padding: 2em;
  max-width: 1200px;
  margin: 0 auto;
}

.metrics {
  margin-bottom: 2em;
}

.metrics h3 {
  margin-bottom: 1em;
  color: #333;
}

.metrics-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
  gap: 1em;
  margin-bottom: 2em;
}

.metric-card {
  background: #f8f9fa;
  border: 1px solid #e9ecef;
  border-radius: 8px;
  padding: 1.5em;
  text-align: center;
  transition: box-shadow 0.2s;
}

.metric-card:hover {
  box-shadow: 0 2px 8px rgba(0,0,0,0.1);
}

.metric-label {
  display: block;
  font-size: 0.9em;
  color: #666;
  margin-bottom: 0.5em;
  font-weight: 500;
}

.metric-value {
  display: block;
  font-size: 1.8em;
  font-weight: bold;
  color: #1976d2;
}

.chart-container {
  position: relative;
  height: 400px;
  width: 100%;
  margin: 2em 0;
  background: white;
  border: 1px solid #e9ecef;
  border-radius: 8px;
  padding: 1em;
}

canvas {
  width: 100% !important;
  height: 100% !important;
}

.no-data {
  display: flex;
  align-items: center;
  justify-content: center;
  height: 100%;
  color: #666;
  font-style: italic;
}

.future-prediction {
  background: #e3f2fd;
  border: 1px solid #1976d2;
  border-radius: 8px;
  padding: 1.5em;
  margin: 2em 0;
  text-align: center;
}

.future-prediction h3 {
  margin: 0;
  color: #1976d2;
}

.prediction {
  font-weight: bold;
  color: #1976d2;
  font-size: 1.2em;
}

.no-future {
  background: #fff3e0;
  border: 1px solid #ff9800;
  border-radius: 8px;
  padding: 1em;
  margin: 2em 0;
  text-align: center;
  color: #ff9800;
}

.success-message {
  background: #e8f5e8;
  border: 1px solid #4caf50;
  border-radius: 8px;
  padding: 1em;
  margin: 2em 0;
  text-align: center;
  color: #4caf50;
  font-weight: 500;
}

@media (max-width: 768px) {
  .graphs {
    padding: 1em;
  }
  
  .metrics-grid {
    grid-template-columns: 1fr;
  }
  
  .chart-container {
    height: 300px;
  }
}
</style>