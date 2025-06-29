<!-- src/views/home.vue -->
<template>
    <div class="home">
      <h1>{{ $t('welcome') }}</h1>
    <p>{{ $t('home_description') }}</p>
    </div>
  </template>
  
  <script>
  export default {
    name: "Home",
  };
  </script>
  
  <style scoped>
  .home {
    text-align: center;
    margin-top: 50px;
    padding: 20px;
    max-width: 800px;
    margin-left: auto;
    margin-right: auto;
  }
  
  .home h1 {
    color: #333;
    margin-bottom: 20px;
    font-size: 2.5rem;
  }
  
  .home p {
    color: #666;
    font-size: 1.2rem;
    line-height: 1.6;
    margin-bottom: 20px;
  }
  
  /* Responsive Design */
  @media (max-width: 768px) {
    .home {
      margin-top: 30px;
      padding: 15px;
    }
    
    .home h1 {
      font-size: 2rem;
      margin-bottom: 15px;
    }
    
    .home p {
      font-size: 1.1rem;
    }
  }
  
  @media (max-width: 480px) {
    .home {
      margin-top: 20px;
      padding: 10px;
    }
    
    .home h1 {
      font-size: 1.7rem;
      margin-bottom: 10px;
    }
    
    .home p {
      font-size: 1rem;
    }
  }
  </style>