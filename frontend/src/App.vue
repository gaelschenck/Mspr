<template>
  <div class="min-h-screen bg-gray-100">
    <!-- En-tête du site -->
    <Header role="banner" aria-label="En-tête principal du site" />

    <!-- Contenu principal -->
    <div
      class="container mx-auto px-4 py-8"
      role="main"
      aria-label="Contenu principal"
    >
      <router-view />
    </div>

    <!-- Pied de page -->
    <Footer role="contentinfo" aria-label="Pied de page du site" />
  </div>
</template>

<script>
import Header from "./components/Header.vue";
import Footer from "./components/Footer.vue";

export default {
  components: {
    Header,
    Footer,
  },
};
</script>

<style scoped>
/* Tu peux ajouter des styles si nécessaire */
</style>

<!-- App.vue -->
