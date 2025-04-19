<template>
  <div class="form-container">
    <h1 class="title">Choix des données</h1>

    <!-- Choix de la région -->
    <div class="form-group">
      <label for="region">Choisissez une région :</label>
      <select v-model="selectedRegion" id="region">
        <option disabled value="">-- Sélectionner une région --</option>
        <option v-for="region in regions" :key="region" :value="region">{{ region }}</option>
      </select>
    </div>

    <!-- Choix du pays -->
    <div class="form-group">
      <label for="pays">Choisissez un pays :</label>
      <select v-model="selectedPays" id="pays">
        <option disabled value="">-- Sélectionner un pays --</option>
        <option
          v-for="pays in filteredPaysList"
          :key="pays.id"
          :value="pays.nom"
        >
          {{ pays.nom }}
        </option>
      </select>
    </div>

    <!-- Choix de la table -->
    <div class="form-group">
      <label for="table">Choisissez une table :</label>
      <select v-model="selectedTable" id="table" @change="fetchColumns">
        <option disabled value="">-- Sélectionner une table --</option>
        <option v-for="table in tables" v-if="table !== 'pays'" :key="table" :value="table">
          {{ table }}
        </option>
      </select>
    </div>

    <!-- Choix de la colonne cible -->
    <div class="form-group" v-if="columns.length > 0">
      <label for="target_column">Choisissez une colonne cible :</label>
      <select v-model="selectedColumn" id="target_column">
        <option disabled value="">-- Sélectionner une colonne --</option>
        <option v-for="column in columns" :key="column" :value="column">
          {{ column }}
        </option>
      </select>
    </div>

    <!-- Bouton de soumission -->
    <button
      type="button"
      @click="submitChoices"
      :disabled="!selectedTable || !selectedColumn"
    >
      Soumettre
    </button>
  </div>
</template>

<script>
import apiClient from "/services/api";
import { usePredictionStore } from "@/store/predictionStore";

export default {
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
    };
  },
  computed: {
    filteredPaysList() {
      // Filtrer les pays selon la région sélectionnée
      if (!this.selectedRegion) return [];
      return this.paysList.filter(p => p.region === this.selectedRegion);
    },
  },
  async mounted() {
    try {
      const responseTables = await apiClient.get("/tables/");
      this.tables = Object.keys(responseTables.data.tables);

      const responsePays = await apiClient.get("/payslist/");
      this.paysList = responsePays.data;

      const regionsSet = new Set(this.paysList.map(p => p.region));
      this.regions = [...regionsSet];
    } catch (error) {
      console.error("Erreur lors du chargement des données :", error);
    }
  },
  methods: {
    async fetchColumns() {
      if (!this.selectedTable) return;
      try {
        const response = await apiClient.get(`/columns/${this.selectedTable}`);
        this.columns = response.data.columns;
      } catch (error) {
        console.error("Erreur lors de la récupération des colonnes :", error);
      }
    },
    async submitChoices(event) {
      event?.preventDefault();
      const payload = {
        region: this.selectedRegion || null,
        pays: this.selectedPays || null,
        table: this.selectedTable,
        target_column: this.selectedColumn,
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

        const store = usePredictionStore();
        store.setPredictionData(real_data, predicted_data, labels);

        this.$router.push("/graphiques");
      } catch (error) {
        console.error("Erreur lors de la soumission :", error);
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
</style>
