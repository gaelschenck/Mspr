<template>
  <div class="container">

    <div aria-label="Formulaire de sélection des données" class="form-container">
      <h1 class="form-title" id="data-form-title">Choix des données</h1>
      <form aria-labelledby="data-form-title">
        <div class="form-group">
          <label for="region" id="label-region">Choisissez une région :</label>
          <select id="region" v-model="selectedRegion" aria-labelledby="label-region" required>
            <option disabled value="">-- Sélectionner une région --</option>
            <option v-for="region in regions" :key="region" :value="region">{{ region }}</option>
          </select>
        </div>
        <div class="form-group">
          <label for="pays" id="label-pays">Choisissez un pays :</label>
          <select id="pays" v-model="selectedPays" aria-labelledby="label-pays" required>
            <option disabled value="">-- Sélectionner un pays --</option>
            <option v-for="pays in filteredPaysList" :key="pays.id" :value="pays.nom">
              {{ pays.nom }}
            </option>
          </select>
        </div>
        <div class="form-group">
          <label for="table" id="label-table">Choisisser une indicateur:</label>
          <select id="table" v-model="selectedTable" aria-labelledby="label-table" required>
            <option disabled value="">-- Sélectionner une table --</option>
            <option v-for="table in filteredTables" :key="table" :value="table">
              {{ table }}
            </option>
          </select>
        </div>
        <button type="submit" @click.prevent="submitChoices" :disabled="!selectedTable" class="submit-btn"
          aria-label="Soumettre le formulaire">
          Soumettre
        </button>
      </form>
    </div>

    <div v-if="showChart" class="chart-wrapper">
      <p id="chart-desc" class="sr-only">
        Ce graphique compare les données réelles et les prédictions pour le pays et la table sélectionnés. Les lignes
        bleues et rouges montrent l'évolution des valeurs de 2018 à 2000.
      </p>
      <section aria-label="Graphique des prédictions" class="graph-section" tabindex="0">
        <h2 class="graph-title">Prédiction vs Réel</h2>
        <div aria-labelledby="chart-desc" role="img" class="chart-area">
          <div class="chart-container">
            
              <Line :data="chartData" :options="chartOptions"
                aria-label="Graphique comparatif entre les données réelles et les prédictions" role="img"
                aria-describedby="chart-desc" tabindex="0" />
            
          </div>
        </div>
        <div class="chart-legend" aria-hidden="true">
          <span class="legend-item">
            <span class="legend-color bg-a11yblue"></span>
            <span class="legend-label">Données réelles</span>
          </span>
          <span class="legend-item">
            <span class="legend-color bg-a11yred"></span>
            <span class="legend-label">Prédictions</span>
          </span>
        </div>
      </section>
    </div>

  </div>
</template>

<script>
import apiClient from "/services/api";
import { Line } from "vue-chartjs";

import {
  Chart as ChartJS,
  Title,
  Tooltip,
  Legend,
  LineElement,
  PointElement,
  CategoryScale,
  LinearScale,
} from "chart.js";

ChartJS.register(Title, Tooltip, Legend, LineElement, PointElement, CategoryScale, LinearScale);

export default {
  components: { Line },
  data() {
    return {
      regions: [],
      paysList: [],
      tables: [],

      selectedRegion: "",
      selectedPays: "",
      selectedTable: null,
      selectedColumn: null,
      showChart: false,
      chartData: null,
      chartOptions: {
        responsive: true,
        plugins: {
          legend: {
            position: "top",
            labels: {
              color: "#333",
              usePointStyle: true,
              font: { size: 14 },
            },
          },
          title: {
            display: true,
            text: "Comparaison entre les données réelles et prédites",
            font: {
              size: 18,
            },
            color: "#111",
            ariaLabel: "Titre du graphique : Comparaison entre données réelles et prédictions",
          },
          tooltip: {
            callbacks: {
              label: (context) => `${context.dataset.label}: ${context.formattedValue}`,
            },
            ariaLabel: "Tooltip de graphique",
          },
        },
        scales: {
          x: {
            title: {
              display: true,
              text: "Années",
              font: { size: 14 },
              color: "#111",
            },
            ticks: {
              color: "#444",
            },
            ariaLabel: "Axe X : Années, représentant les années de mesure",
          },
          y: {
            title: {
              display: true,
              text: "Valeurs de l’indicateur",
              font: { size: 14 },
              color: "#111",
            },
            ticks: {
              color: "#444",
            },
            ariaLabel: "Axe Y : Valeurs de l'indicateur mesuré",
          },
        },
      },
    };
  },
  computed: {
    filteredPaysList() {
      return this.selectedRegion
        ? this.paysList.filter((p) => p.region === this.selectedRegion)
        : [];
    },
    filteredTables() {
      return (this.tables || []).filter((table) => table !== "pays");
    },
  },
  async mounted() {
    try {
      const tablesRes = await apiClient.get("/tables/");
      this.tables = tablesRes.data.tables;

      const paysRes = await apiClient.get("/payslist/");
      this.paysList = paysRes.data;

      const regionsSet = new Set(this.paysList.map((p) => p.region));
      this.regions = [...regionsSet];
    } catch (error) {
      console.error("Erreur lors du chargement initial :", error);
    }
  },
  methods: {

    async submitChoices() {
      const payload = {
        table: this.selectedTable,
        target_column: "valeur",
        region: this.selectedRegion || null,
        pays: this.selectedPays || null,
      };

      if (!payload.region && !payload.pays) {
        alert("Veuillez sélectionner une région ou un pays !");
        return;
      }

      try {
        const response = await apiClient.post("/dataframe/", payload);
        const dataframe = response.data.dataframe;

        const trainPayload = {
          dataframe,
          target_column: payload.target_column,
        };

        const result = await apiClient.post("/train_model/", trainPayload);
        const { real_data, predicted_data, labels } = result.data;

        this.chartData = {
          labels,
          datasets: [
            {
              label: "Données réelles",
              data: real_data,
              borderColor: "#0052cc",
              backgroundColor: "transparent",
            },
            {
              label: "Prédictions",
              data: predicted_data,
              borderColor: "#cc0000",
              backgroundColor: "transparent",
            },
          ],
        };
        this.showChart = true;
      } catch (error) {
        console.error("Erreur submitChoices :", error);
      }
    },
  },
};
</script>

<style scoped>
.container {
  display: flex;
  flex-wrap: wrap;
  gap: 2rem;
  padding: 1rem;
  justify-content: space-around;
  align-items: flex-start;
}

.form-container {
  background: #fff;
  border-radius: 16px;

  padding: 2rem;
  box-shadow: 0 4px 32px rgba(136, 150, 255, 0.10);
  flex: 1;
  min-width: 320px;
  max-width: 380px;
 /* Modification pour une meilleure gestion de la largeur initiale */
}

.chart-wrapper {
  flex: 2; /* Modification pour une meilleure gestion de la largeur initiale */
 /* Prend toute la largeur par défaut */
  min-width: 400px; /* Empêche le graphique de devenir trop étroit */
}


.graph-section {
  background-color: white;
  border-radius: 1rem;
  box-shadow: 0 10px 15px -3px rgba(0,0,0,0.1), 0 4px 6px -2px rgba(0,0,0,0.05);
  padding: 1rem 1rem 1.5rem;
  width: 100%;
  height: 100%;
}

.chart-area {
  height: 300px;
}

.graph-title {
  font-size: 1.125rem;
  font-weight: 600;
  text-align: center;
  margin-bottom: 0.5rem;
  font-family: 'Atkinson Hyperlegible', sans-serif;
}

.chart-container {
  width: 100%;
  height: 100%;
  background: #f3f4f6;
  display: flex;
  align-items: center;
  justify-content: center;
  border-radius: 12px;
}

.chart-placeholder {
  color: #8E9196;
  font-style: italic;
}

.chart-legend {
  display: flex;
  align-items: center;
  justify-content: center;
  gap: 1.5rem;
  margin-top: 0.75rem;
}

.legend-item {
  display: flex;
  align-items: center;
}

.legend-color {
  display: inline-block;
  width: 1.25rem;
  height: 0.5rem;
  border-radius: 0.25rem;
  margin-right: 0.25rem;
}

.bg-a11yblue {
  background-color: #2B6CB0;
}

.bg-a11yred {
  background-color: #C53030;
}

.legend-label {
  color: #8E9196;
  font-size: 0.875rem;
  font-family: 'Atkinson Hyperlegible', sans-serif;
}

.form-title {
  font-size: 2rem;
  font-weight: bold;
  color: #666;
  text-align: center;
  margin-bottom: 1.5rem;
  font-family: 'Atkinson Hyperlegible', Arial, sans-serif;
}

.form-group {
  margin-bottom: 1rem;
}

.form-group label {
  display: block;
  font-weight: 600;
  margin-bottom: 0.25rem;
  color: #3d3d3d;
  font-size: 1rem;
}

.form-group select {
  width: 100%;
  border-radius: 8px;
  border: 1px solid #d1d5db;
  padding: 0.5rem;
  font-size: 1rem;
  transition: border 0.2s, box-shadow 0.2s;
  outline: none;
}

.form-group select:focus {
  border: 1px solid #3849fa;
  box-shadow: 0 0 0 3px #b2b8ff44;
}

.submit-btn {
  width: 100%;
  background: #3849fa;
  color: #fff;
  font-weight: bold;
  font-size: 1rem;
  padding: 0.75rem;
  border-radius: 8px;
  border: none;
  transition: background 0.2s, box-shadow 0.2s;
  margin-top: 1rem;
  cursor: pointer;
}

.submit-btn:hover,
.submit-btn:focus {
  background: #1e34bf;
  box-shadow: 0 0 0 3px #ef444488;
  outline: none;
}

.sr-only {
  position: absolute !important;
  width: 1px !important;
  height: 1px !important;
  padding: 0 !important;
  margin: -1px !important;
  overflow: hidden !important;
  clip: rect(0, 0, 0, 0) !important;
  white-space: nowrap !important;
  border: 0 !important;
}

/* Pour les écrans plus grands (tablettes et ordinateurs) */

</style>