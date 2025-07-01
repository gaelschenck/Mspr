<template>
  <div class="graphs">
    <h2>{{ $t('prediction_results_title') }}</h2>
    
    <!-- Métriques de performance -->
    <div v-if="result" class="metrics">
      <h3>{{ $t('prediction_metrics_title') }}</h3>
      <div class="metrics-grid">
        <div class="metric-card">
          <span class="metric-label">{{ $t('prediction_rmse') }}</span>
          <span class="metric-value">{{ result.rmse?.toFixed(2) || 'N/A' }}</span>
          <span class="metric-desc">{{ $t('prediction_rmse_desc') }}</span>
        </div>
        <div class="metric-card">
          <span class="metric-label">{{ $t('prediction_r2') }}</span>
          <span class="metric-value">{{ result.r2?.toFixed(3) || 'N/A' }}</span>
          <span class="metric-desc">{{ $t('prediction_r2_desc') }}</span>
        </div>
        <div class="metric-card">
          <span class="metric-label">{{ $t('prediction_data_points') }}</span>
          <span class="metric-value">{{ getDataLength() }}</span>
          <span class="metric-desc">{{ $t('prediction_data_points_desc') }}</span>
        </div>
        <div v-if="result.metadata" class="metric-card">
          <span class="metric-label">{{ $t('prediction_period') }}</span>
          <span class="metric-value">{{ result.metadata.year_range || 'N/A' }}</span>
          <span class="metric-desc">{{ $t('prediction_period_desc') }}</span>
        </div>
      </div>
    </div>
    
    <!-- Graphique -->
    <div class="chart-container">
      <canvas v-if="hasValidPredictionData()" id="myChart"></canvas>
      <div v-else class="no-data">
        <p>{{ $t('prediction_no_data') }}</p>
        <div v-if="result" class="debug-info">
          <small>{{ $t('prediction_debug_data') }}: {{ Object.keys(result).join(', ') }}</small>
        </div>
      </div>
    </div>
    
    <!-- Prédiction future -->
    <div v-if="result && result.future_prediction !== undefined && result.future_year" class="future-prediction">
      <h3>{{ $t('prediction_future_title') }}</h3>
      <div class="future-content">
        <div class="future-year">{{ result.future_year }}</div>
        <div class="future-value">{{ result.future_prediction?.toFixed(2) }}</div>
        <div class="future-label">{{ $t('prediction_future_desc') }}</div>
      </div>
    </div>

    <div v-else-if="result && result.future_prediction === null" class="no-future">
      <p>{{ $t('prediction_no_future') }}</p>
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
import { useI18n } from 'vue-i18n';
import Chart from "chart.js/auto";

const route = useRoute();
const { t } = useI18n();
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

const getDataLength = () => {
  const dataArray = result.value?.prediction || result.value?.predictions;
  return dataArray && Array.isArray(dataArray) ? dataArray.length : 'N/A';
};

const hasValidPredictionData = () => {
  const dataArray = result.value?.prediction || result.value?.predictions;
  return !!(result.value && dataArray && Array.isArray(dataArray) && dataArray.length > 0);
};

const getChartTitle = () => {
  const filters = result.value?.filters;
  const metadata = result.value?.metadata;
  
  let title = t('prediction_chart_title');
  
  if (filters) {
    const parts = [];
    if (filters.pays) parts.push(filters.pays);
    if (filters.who_region && !filters.pays) parts.push(`${t('prediction_region')} ${filters.who_region}`);
    if (filters.indicator_types && filters.indicator_types.length > 0) {
      parts.push(filters.indicator_types[0]);
    }
    
    if (parts.length > 0) {
      title = `${parts.join(' - ')}`;
    }
  }
  
  return title;
};

const getXAxisLabel = () => {
  const labelsArray = result.value?.labels;
  const metadata = result.value?.metadata;
  
  if (labelsArray && labelsArray.length > 0) {
    // Si les labels ressemblent à des années
    const firstLabel = labelsArray[0];
    if (typeof firstLabel === 'number' && firstLabel > 1900 && firstLabel < 2100) {
      return t('prediction_years');
    }
  }
  
  return t('prediction_period_points');
};

const getYAxisLabel = () => {
  const filters = result.value?.filters;
  
  if (filters) {
    if (filters.value_types && filters.value_types.length > 0) {
      return `${t('prediction_values')} (${filters.value_types[0]})`;
    }
    if (filters.indicator_types && filters.indicator_types.length > 0) {
      return `${t('prediction_values')} - ${filters.indicator_types[0]}`;
    }
  }
  
  return t('prediction_predicted_values');
};

const createChart = () => {
  // Vérifier différents formats de données possibles
  const dataArray = result.value?.prediction || result.value?.predictions;
  const labelsArray = result.value?.labels;
  
  if (!result.value || !dataArray || !Array.isArray(dataArray)) {
    console.error("Aucune donnée de prédiction disponible", {
      hasResult: !!result.value,
      hasDataArray: !!dataArray,
      isArray: Array.isArray(dataArray),
      resultKeys: result.value ? Object.keys(result.value) : []
    });
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
  
  // Préparer les labels - utiliser les années si disponibles, sinon indices
  let finalLabels;
  if (labelsArray && Array.isArray(labelsArray) && labelsArray.length === dataArray.length) {
    finalLabels = labelsArray.map(label => label?.toString() || '');
  } else {
    finalLabels = dataArray.map((_, i) => `Point ${i + 1}`);
  }

  // Déterminer le titre dynamique
  const chartTitle = getChartTitle();
  
  // Créer le nouveau graphique avec style amélioré
  chartInstance = new Chart(ctx, {
    type: "line",
    data: {
      labels: finalLabels,
      datasets: [
        {
          label: t('prediction_predicted_values'),
          data: dataArray,
          borderColor: "#1976d2",
          backgroundColor: "rgba(25, 118, 210, 0.1)",
          borderWidth: 3,
          fill: true,
          tension: 0.3,
          pointRadius: 4,
          pointHoverRadius: 8,
          pointBackgroundColor: "#1976d2",
          pointBorderColor: "#ffffff",
          pointBorderWidth: 2,
          pointHoverBackgroundColor: "#0d47a1",
          pointHoverBorderColor: "#ffffff",
          pointHoverBorderWidth: 3
        }
      ]
    },
    options: {
      responsive: true,
      maintainAspectRatio: false,
      interaction: {
        intersect: false,
        mode: 'index'
      },
      plugins: {
        title: {
          display: true,
          text: chartTitle,
          font: {
            size: 18,
            weight: 'bold'
          },
          color: '#1976d2',
          padding: 20
        },
        legend: {
          display: true,
          position: 'top',
          labels: {
            usePointStyle: true,
            padding: 20,
            font: {
              size: 14
            }
          }
        },
        tooltip: {
          backgroundColor: 'rgba(0,0,0,0.8)',
          titleColor: '#ffffff',
          bodyColor: '#ffffff',
          borderColor: '#1976d2',
          borderWidth: 1,
          cornerRadius: 8,
          callbacks: {
            title: function(tooltipItems) {
              return `${t('prediction_tooltip_period')}: ${tooltipItems[0].label}`;
            },
            label: function(context) {
              return `${t('prediction_tooltip_value')}: ${context.parsed.y.toFixed(2)}`;
            },
            afterLabel: function(context) {
              const rmse = result.value?.rmse;
              const r2 = result.value?.r2;
              let info = '';
              if (rmse) info += `RMSE: ${rmse.toFixed(2)}`;
              if (r2) info += `${info ? ' | ' : ''}R²: ${r2.toFixed(3)}`;
              return info;
            }
          }
        }
      },
      scales: {
        y: {
          beginAtZero: false,
          title: {
            display: true,
            text: getYAxisLabel(),
            font: {
              size: 14,
              weight: 'bold'
            },
            color: '#333'
          },
          grid: {
            display: true,
            color: 'rgba(0,0,0,0.1)',
            drawBorder: false
          },
          ticks: {
            font: {
              size: 12
            },
            color: '#666',
            callback: function(value) {
              return typeof value === 'number' ? value.toFixed(1) : value;
            }
          }
        },
        x: {
          title: {
            display: true,
            text: getXAxisLabel(),
            font: {
              size: 14,
              weight: 'bold'
            },
            color: '#333'
          },
          grid: {
            display: true,
            color: 'rgba(0,0,0,0.1)',
            drawBorder: false
          },
          ticks: {
            font: {
              size: 12
            },
            color: '#666',
            maxTicksLimit: 10
          }
        }
      },
      animation: {
        duration: 1500,
        easing: 'easeInOutQuart'
      }
    }
  });
};

onUnmounted(() => {
  if (chartInstance) {
    chartInstance.destroy();
  }
});

// Expose utility functions for testing
defineExpose({
  getDataLength,
  hasValidPredictionData,
  getChartTitle,
  getXAxisLabel,
  getYAxisLabel,
  createChart,
  result
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
  transition: all 0.3s ease;
  box-shadow: 0 1px 3px rgba(0,0,0,0.1);
}

.metric-card:hover {
  box-shadow: 0 4px 12px rgba(0,0,0,0.15);
  transform: translateY(-2px);
}

.metric-label {
  display: block;
  font-size: 0.9em;
  color: #666;
  margin-bottom: 0.5em;
  font-weight: 600;
  text-transform: uppercase;
  letter-spacing: 0.5px;
}

.metric-value {
  display: block;
  font-size: 1.8em;
  font-weight: bold;
  color: #1976d2;
  margin-bottom: 0.3em;
}

.metric-desc {
  display: block;
  font-size: 0.75em;
  color: #999;
  font-style: italic;
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
  background: linear-gradient(135deg, #e3f2fd 0%, #bbdefb 100%);
  border: 2px solid #1976d2;
  border-radius: 12px;
  padding: 2em;
  margin: 2em 0;
  text-align: center;
  box-shadow: 0 4px 12px rgba(25, 118, 210, 0.2);
}

.future-prediction h3 {
  margin: 0 0 1em 0;
  color: #1976d2;
  font-size: 1.3em;
}

.future-content {
  display: flex;
  flex-direction: column;
  align-items: center;
  gap: 0.5em;
}

.future-year {
  font-size: 1.2em;
  font-weight: bold;
  color: #0d47a1;
}

.future-value {
  font-size: 2.5em;
  font-weight: bold;
  color: #1976d2;
  text-shadow: 0 2px 4px rgba(0,0,0,0.1);
}

.future-label {
  font-size: 0.9em;
  color: #666;
  font-style: italic;
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

.debug-info {
  margin-top: 1em;
  color: #999;
  font-size: 0.8em;
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