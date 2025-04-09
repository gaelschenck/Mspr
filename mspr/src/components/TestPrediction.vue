<template>
    <div>
      <h1>Choix des données</h1>
      <label for="region">Choisissez un pays ou une région :</label>
      <select v-model="selectedRegion" id="region">
        <option v-for="region in regions" :value="region">{{ region }}</option>
      </select>
  
      <label for="table">Choisissez une table :</label>
      <select v-model="selectedTable" id="table">
        <option v-for="table in tables" :value="table">{{ table }}</option>
      </select>
  
      <button @click="submitChoices">Soumettre</button>
    </div>
  </template>
  
  <script>
  import apiClient from "../services/api";
  
  export default {
    data() {
      return {
        regions: [],
        tables: [],
        selectedRegion: null,
        selectedTable: null,
      };
    },
    async created() {
      const response = await apiClient.get("/tables");
      this.tables = Object.keys(response.data.tables);
      this.regions = ["Europe", "Afrique", "Asie"]; // Simule une liste régionale.
    },
    methods: {
      async submitChoices() {
        const payload = {
          region: this.selectedRegion,
          table: this.selectedTable,
        };
        const response = await apiClient.post("/dataframe", payload);
        console.log("Dataframe généré :", response.data);
      },
    },
  };
  </script>
  