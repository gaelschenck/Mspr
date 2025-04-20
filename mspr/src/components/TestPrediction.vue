<template>
  <div class="form-container">
    <h1 class="title">Choix des données</h1>

    <!-- Choix des filtres -->
    <div class="form-group">
      <label for="region">Choisissez une région :</label>
      <select v-model="selectedRegion" id="region">
        <option disabled value="">-- Sélectionner une région --</option>
        <option v-for="region in regions" :key="region" :value="region">{{ region }}</option>
      </select>
    </div>

    <div class="form-group">
      <label for="pays">Choisissez un pays :</label>
      <select v-model="selectedPays" id="pays">
        <option disabled value="">-- Sélectionner un pays --</option>
        <option v-for="pays in filteredPaysList" :key="pays.id" :value="pays.nom">
          {{ pays.nom }}
        </option>
      </select>
    </div>

    <div class="form-group">
      <label for="table">Choisissez une table :</label>
      <select v-model="selectedTable" id="table" @change="fetchColumns">
        <option disabled value="">-- Sélectionner une table --</option>
        <option v-for="table in tables" v-if="table !== 'pays'" :key="table" :value="table">
          {{ table }}
        </option>
      </select>
    </div>

    <div class="form-group" v-if="columns.length > 0">
      <label for="target_column">Choisissez une colonne cible :</label>
      <select v-model="selectedColumn" id="target_column">
        <option disabled value="">-- Sélectionner une colonne --</option>
        <option v-for="column in columns" :key="column" :value="column">
          {{ column }}
        </option>
      </select>
    </div>

    <button type="button" @click="submitChoices" :disabled="!selectedTable || !selectedColumn">
      Soumettre
    </button>

    <!-- 🎨 Affichage du graphique -->
    <div v-if="showChart" class="chart-container">
      <Line :data="chartData" :options="chartOptions" />
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
      columns: [],
      selectedRegion: "",
      selectedPays: "",
      selectedTable: null,
      selectedColumn: null,

      // Pour le graphique
      showChart: false,
      chartData: null,
      chartOptions: {
        responsive: true,
        plugins: {
          legend: { position: "top" },
          title: {
            display: true,
            text: "Prédiction vs Réel",
          },
        },
      },
    };
  },
  computed: {
    filteredPaysList() {
      return this.selectedRegion
        ? this.paysList.filter(p => p.region === this.selectedRegion)
        : [];
    },
  },
  async mounted() {
    try {
      const tablesRes = await apiClient.get("/tables/");
      this.tables = Object.keys(tablesRes.data.tables);

      const paysRes = await apiClient.get("/payslist/");
      this.paysList = paysRes.data;
      const regionsSet = new Set(this.paysList.map(p => p.region));
      this.regions = [...regionsSet];
    } catch (error) {
      console.error("Erreur lors du chargement initial :", error);
    }
  },
  methods: {
    async fetchColumns() {
      if (!this.selectedTable) return;
      try {
        const response = await apiClient.get(`/columns/${this.selectedTable}`);
        this.columns = response.data.columns;
      } catch (error) {
        console.error("Erreur colonnes :", error);
      }
    },
    async submitChoices() {
      const payload = {
        table: this.selectedTable,
        target_column: this.selectedColumn,
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
              borderColor: "#3498db",
              backgroundColor: "transparent",
            },
            {
              label: "Prédictions",
              data: predicted_data,
              borderColor: "#e74c3c",
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
.form-container {
  max-width: 600px;
  margin: 2rem auto;
  padding: 1.5rem;
  border-radius: 12px;
  background: #f9f9f9;
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
}

.title {
  text-align: center;
  margin-bottom: 1.5rem;
  font-size: 1.6rem;
  font-weight: bold;
}

.form-group {
  margin-bottom: 1rem;
}

label {
  display: block;
  font-weight: 500;
  margin-bottom: 0.4rem;
}

select {
  width: 100%;
  padding: 0.4rem;
  border: 1px solid #ccc;
  border-radius: 6px;
}

button {
  display: block;
  width: 100%;
  padding: 0.6rem;
  margin-top: 1rem;
  background-color: #2d72d9;
  color: white;
  border: none;
  border-radius: 8px;
  font-weight: bold;
  cursor: pointer;
}

button:disabled {
  background-color: #cccccc;
  cursor: not-allowed;
}

.chart-container {
  margin-top: 2rem;
}
</style>
