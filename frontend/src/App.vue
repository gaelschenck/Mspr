<template>
  <div class="min-h-screen bg-gray-100">
    <Header />
    <div class="container mx-auto px-4 py-8">
      <!-- Utilisation du router-view pour afficher les vues associées aux routes -->
      <RGPDConsent />
      <router-view />
    </div>
    <Footer />
  </div>
</template>

<script>
import Header from './components/Header.vue';
import Footer from './components/Footer.vue';
import RGPDConsent from "./components/RGPDConsent.vue";

export default {
  components: {
    Header,
    Footer,
    RGPDConsent,
  }
};
</script>

<style scoped>
.min-h-screen {
  min-height: 100vh;
  display: flex;
  flex-direction: column;
}

.bg-gray-100 {
  background-color: #f5f5f5;
}

.container {
  flex: 1;
  max-width: 1200px;
  margin: 0 auto;
  padding: 20px 16px;
  padding-bottom: 80px; /* Espace pour le footer fixe */
}

/* Responsive Design */
@media (max-width: 768px) {
  .container {
    padding: 15px 12px;
    padding-bottom: 100px; /* Plus d'espace pour le footer sur mobile */
  }
}

@media (max-width: 480px) {
  .container {
    padding: 10px 8px;
    padding-bottom: 120px;
  }
}

/* Classes utilitaires responsive */
.mx-auto {
  margin-left: auto;
  margin-right: auto;
}

.px-4 {
  padding-left: 16px;
  padding-right: 16px;
}

.py-8 {
  padding-top: 32px;
  padding-bottom: 32px;
}

@media (max-width: 768px) {
  .px-4 {
    padding-left: 12px;
    padding-right: 12px;
  }
  
  .py-8 {
    padding-top: 20px;
    padding-bottom: 20px;
  }
}

@media (max-width: 480px) {
  .px-4 {
    padding-left: 8px;
    padding-right: 8px;
  }
  
  .py-8 {
    padding-top: 15px;
    padding-bottom: 15px;
  }
}
</style>