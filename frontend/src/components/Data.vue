<template>
  <div>
    <h1>{{ $t('data_title') }}</h1>
    
    <!-- Navigation vers les différentes vues de données -->
    <div class="data-navigation">
      <h2>{{ $t('data_sources') }}</h2>
      
      <!-- Nouveau composant unifié -->
      <div class="nav-section modern">
        <h3>{{ $t('unified_data') }}</h3>
        <p>{{ $t('unified_description') }}</p>
        <router-link to="/health-data" class="nav-link primary">
          {{ $t('explore_health_data') }}
        </router-link>
      </div>
      
      <!-- Anciennes vues spécialisées (compatibilité) -->
      <div class="nav-section legacy">
        <h3>{{ $t('specialized_views') }}</h3>
        <ul class="specialized-links">
          <li><router-link to="/us-mortalite">{{ $t('data_mortalite_us') }}</router-link></li>
          <li><router-link to="/population-hiv">{{ $t('data_population_hiv') }}</router-link></li>
          <li><router-link to="/traitement">{{ $t('data_traitement') }}</router-link></li>
          <li><router-link to="/transmission-mere-enfant">{{ $t('data_transmission_mere_enfant') }}</router-link></li>
        </ul>
      </div>
    </div>
  </div>
</template>

<script setup>
// Pas besoin de script pour un simple hub de navigation
</script>

<style scoped>
.data-navigation {
  max-width: 800px;
  margin: 0 auto;
  padding: 1rem;
}

.nav-section {
  margin-bottom: 2rem;
  padding: 1.5rem;
  border-radius: 8px;
  box-shadow: 0 2px 4px rgba(0,0,0,0.1);
}

.nav-section.modern {
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
  color: white;
  text-align: center;
}

.nav-section.legacy {
  background: #f8f9fa;
  border-left: 4px solid #007bff;
}

.nav-section h3 {
  margin-top: 0;
  margin-bottom: 0.5rem;
}

.nav-section p {
  margin-bottom: 1rem;
  opacity: 0.9;
}

.nav-link.primary {
  display: inline-block;
  padding: 0.75rem 1.5rem;
  background: rgba(255,255,255,0.2);
  color: white;
  text-decoration: none;
  border-radius: 25px;
  font-weight: 600;
  border: 2px solid rgba(255,255,255,0.3);
  transition: all 0.3s ease;
}

.nav-link.primary:hover {
  background: rgba(255,255,255,0.3);
  border-color: rgba(255,255,255,0.5);
  transform: translateY(-2px);
}

.specialized-links {
  list-style: none;
  padding: 0;
}

.specialized-links li {
  margin-bottom: 0.5rem;
}

.specialized-links a {
  color: #007bff;
  text-decoration: none;
  padding: 0.25rem 0;
  display: block;
  border-bottom: 1px solid transparent;
  transition: border-color 0.3s ease;
}

.specialized-links a:hover {
  border-bottom-color: #007bff;
}
</style>