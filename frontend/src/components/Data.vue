<template>
  <div>
    <h1>{{ $t('data_title') }}</h1>
    <ul>
      <li><router-link to="/us-mortalite">{{ $t('data_mortalite_us') }}</router-link></li>
      <li><router-link to="/population-hiv">{{ $t('data_population_hiv') }}</router-link></li>
      <li><router-link to="/traitement">{{ $t('data_traitement') }}</router-link></li>
      <li><router-link to="/transmission-mere-enfant">{{ $t('data_transmission_mere_enfant') }}</router-link></li>
    </ul>
  </div>
</template>

<script setup>
// Pas besoin de script pour un simple hub de navigation
</script>