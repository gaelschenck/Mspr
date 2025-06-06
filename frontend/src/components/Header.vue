<!-- src/components/header.vue -->
<template>
    <header class="header">
      <nav>
        <ul>
          <li><router-link to="/">Accueil</router-link></li>
          <li><router-link to="/graphiques">Graphiques</router-link></li>
          <li><router-link to="/prediction">Prédiction</router-link></li>
        </ul>
      </nav>
      <div>
        <button @click="setCountry('FR')">FR</button>
        <button @click="setCountry('US')">US</button>
        <button @click="setCountry('CH')">CH</button>
      </div>
    </header>
  </template>
  
  <script>
  import axios from "axios";
  export default {
    name: "Header",
    methods: {
    async setCountry(country) {
      try {
        const response = await axios.post("api/set-country", { country });
        console.log(response.data.message);
      } catch (error) {
        console.error("Erreur de connexion :", error);
      }
    }
  }
  };
  </script>
  
  <style scoped>
  .header {
    background-color: #333;
    color: white;
    padding: 10px;
    text-align: center;
  }
  
  nav ul {
    list-style: none;
    padding: 0;
  }
  
  nav li {
    display: inline-block;
    margin: 0 15px;
  }
  
  nav a {
    color: white;
    text-decoration: none;
  }
  
  nav a:hover {
    text-decoration: underline;
  }
  </style>