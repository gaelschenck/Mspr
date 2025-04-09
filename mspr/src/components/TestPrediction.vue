<template>
    <div>
        <h1>Choix des données</h1>
        <label for="region">Choisissez un pays ou une région :</label>
        <select v-model="selectedRegion" id="region">
        <option v-for="region in regions" :key="region" :value="region">{{ region }}</option>
        </select>

        <label for="table">Choisissez une table :</label>
        <select v-model="selectedTable" id="table">
        <option v-for="table in tables" :key="table" :value="table">{{ table }}</option>
        </select>

        <button @click="submitChoices">Soumettre</button>
    </div>
</template>
  
<script>
import apiClient from "/services/api";

export default {
data() {
    return {
    regions: [],
    tables: [],
    selectedRegion: null,
    selectedTable: null,
    };
},
async mounted() {
  try {
    const responseTables = await apiClient.get("/tables");
    this.tables = Object.keys(responseTables.data.tables);

    const responsePays = await apiClient.get("/pays/");
    const regionsSet = new Set(responsePays.data.map(p => p.region));
    this.regions = [...regionsSet]; // dédoublonné

  } catch (error) {
    console.error("Erreur lors du chargement des données :", error);
  }
},
methods: {
    async submitChoices() {
      const payload = {
        region: this.selectedRegion,
        table: this.selectedTable,
      };
      try {
        const response = await apiClient.post("/dataframe", payload);
        console.log("Dataframe généré :", response.data);
      } catch (error) {
        console.error("Erreur lors de la soumission :", error);
      }
    },
  },
};
</script>
  