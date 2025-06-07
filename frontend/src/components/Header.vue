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
        <button @click="setCountry('fr')">FR</button>
        <button @click="setCountry('us')">US</button>
        <button @click="setCountry('ch')">CH</button>
      </div>
    </header>
  </template>
  
  <script>
  import axios from "axios";
  export default {
    name: "Header",
     methods: {
    setCountry(country) {
      // On stocke le code pays en minuscule dans le localStorage
      localStorage.setItem("selectedCountry", country.toLowerCase());
      // Optionnel : recharger la page ou émettre un event pour prévenir les autres composants
      window.location.reload();
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