<!-- src/components/header.vue -->
<template>
    <header class="header">
      <nav>
        <ul>
          <li><router-link to="/">Accueil</router-link></li>
          <li><router-link to="/prediction">Prédiction</router-link></li>
        </ul>
      </nav>
    </header>
  </template>
  
  <script>
  export default {
    name: "Header",
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