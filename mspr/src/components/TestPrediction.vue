<template>
  <div>
      <h1>Choix des données</h1>
      <label for="region">Choisissez un pays ou une région :</label>
      <select v-model="selectedRegion" id="region">
      <option v-for="region in regions" :key="region" :value="region">{{ region }}</option>
      </select>

      <!-- Sélection des pays -->
      <label for="pays" aria-label="Sélection du pays">Choisissez un pays :</label>
      <select v-model="selectedPays" id="pays" tabindex="0">
        <option v-for="pays in paysList" :key="pays.id" :value="pays.nom">{{ pays.nom }}</option>
      </select>


      <!-- Sélection de la table -->
    <label for="table">Choisissez une table :</label>
    <select v-model="selectedTable" id="table" @change="fetchColumns">
      <option v-for="table in tables" :key="table" :value="table">{{ table }}</option>
    </select>

    <!-- Sélection de la colonne cible (après choix de la table) -->
    <label for="target_column">Choisissez une colonne cible :</label>
    <select v-model="selectedColumn" id="target_column" v-if="columns.length > 0">
      <option v-for="column in columns" :key="column" :value="column">{{ column }}</option>
    </select>

    <button @click="submitChoices" :disabled="!selectedTable || !selectedColumn">Soumettre</button>
  </div>

</template>

<script>
import apiClient from "/services/api";

export default {
data() {
  return {
  regions: [],
  paysList: [],
  tables: [],
  columns: [],
  selectedRegion: null,
  selectedPays: null,
  selectedTable: null,
  selectedColumn: null,
  };
},
async mounted() {
try {
  const responseTables = await apiClient.get("/tables/");
  this.tables = Object.keys(responseTables.data.tables);
  console.log("Tables disponibles :", responseTables.data);


  const responsePays = await apiClient.get("/payslist/");
  console.log("Réponse brute /payslist/ :", responsePays.data);
  const pays = responsePays.data;


  const regionsSet = new Set(pays.map(p => p.region));
  this.regions = [...regionsSet];
  console.log("Regions :", this.regions);


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
        console.log("Colonnes disponibles :", this.columns);
      } catch (error) {
        console.error("Erreur lors de la récupération des colonnes :", error);
      }
    },
  async submitChoices() {
    const payload = {
      region: this.selectedRegion || null,
      pays: this.selectedPays || null,
      table: this.selectedTable,
      target_column: this.selectedColumn,
    };

    console.log("Payload envoyé :", payload); 
    // Vérifie que les données sont valides avant envoi
    if (!payload.region && !payload.pays) {
      console.error("Erreur : Vous devez sélectionner soit une région, soit un pays.");
      alert("Veuillez sélectionner une région ou un pays avant de soumettre !");
      return; // Arrête la soumission
    }

    try {
      const response = await apiClient.post("/dataframe/", payload);
      const dataframe = response.data.dataframe;
      console.log("Dataframe généré :", response.data);
      // Envoyer le DataFrame et la colonne cible à /train_model/
    const trainPayload = {
      dataframe,
      target_column: payload.target_column, // Ajouter la colonne cible ici
    };
    console.log("Payload envoyé à /train_model/ :", trainPayload);

    await apiClient.post("/train_model/", trainPayload);
    console.log("Modèle entraîné avec succès !");

    } catch (error) {
      console.error("Erreur lors de la soumission :", error);
    }
  },
},
};
</script>