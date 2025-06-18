<template>
  <div>
    <h1>{{ $t('data_title') }}</h1>
    <ul>
      <li><router-link to="/us-mortalite">{{ $t('data_mortalite_us') }}</router-link></li>
      <!-- Ajoute ici d'autres liens vers tes futurs endpoints/pages -->
      <!-- <li><router-link to="/fr-mortalite">Mortalité FR</router-link></li> -->
      <!-- <li><router-link to="/ch-mortalite">Mortalité CH</router-link></li> -->
    </ul>
  </div>
</template>

<script setup>
// Pas besoin de script pour un simple hub de navigation
</script>