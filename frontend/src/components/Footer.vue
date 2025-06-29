<!-- src/components/footer.vue -->
<template>
    <footer class="footer">
      <p>&copy; 2025 {{ $t('footer_title') }}. {{ $t('footer_rights') }}</p>
      <template v-if="isFrenchCluster">
        <a href="#" @click.prevent="showCookies">{{ $t('cookies') }}</a>
        <router-link to="/confidentialite">{{ $t('privacy_policy') }}</router-link>
      </template>
    </footer>
  </template>
  
  <script>
  export default {
    name: "Footer",
    data() {
      return {
        showRGPD: false
      };
    },
    computed: {
      isFrenchCluster() {
        return localStorage.getItem("selectedCountry") === "fr";
      }
    },
    methods: {
      showCookies() {
        if (window.showRGPDConsent) {
          window.showRGPDConsent();
        } else {
          alert('Fonctionnalité de gestion des cookies à venir.');
        }
      }
    }
  };
  </script>
  
  <style scoped>
  .footer {
    background-color: #333;
    color: white;
    text-align: center;
    padding: 15px 20px;
    position: fixed;
    bottom: 0;
    width: 100%;
    box-sizing: border-box;
    display: flex;
    justify-content: center;
    align-items: center;
    gap: 20px;
    flex-wrap: wrap;
    min-height: 60px;
  }
  
  .footer p {
    margin: 0;
    flex: 1;
    min-width: 200px;
  }
  
  .footer a {
    color: #ffd700;
    text-decoration: none;
    transition: color 0.3s;
  }
  
  .footer a:hover {
    color: #fff;
    text-decoration: underline;
  }
  
  /* Responsive Design */
  @media (max-width: 768px) {
    .footer {
      flex-direction: column;
      gap: 10px;
      padding: 12px 15px;
      min-height: auto;
    }
    
    .footer p {
      font-size: 0.9em;
      min-width: auto;
      text-align: center;
    }
    
    .footer a {
      font-size: 0.9em;
    }
  }
  
  @media (max-width: 480px) {
    .footer {
      padding: 10px;
      font-size: 0.8em;
    }
    
    .footer p {
      font-size: 0.8em;
    }
    
    .footer a {
      font-size: 0.8em;
    }
  }
  </style>