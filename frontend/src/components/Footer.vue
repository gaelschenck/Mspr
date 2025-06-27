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
    padding: 10px;
    position: fixed;
    bottom: 0;
    width: 100%;
  }
  </style>