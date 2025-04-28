<!-- src/components/footer.vue -->
<template>
  <footer class="footer" role="contentinfo" aria-label="Pied de page du site">
    <p>&copy; 2025 Visualisation VIH. Tous droits réservés.</p>
  </footer>
</template>

<script>
export default {
  name: "Footer",
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
