<template>
  <div class="access-denied-container">
    <div class="access-denied-card">
      <div class="icon">
        <svg width="64" height="64" fill="currentColor" viewBox="0 0 16 16">
          <path d="M8 15A7 7 0 1 1 8 1a7 7 0 0 1 0 14zm0 1A8 8 0 1 0 8 0a8 8 0 0 0 0 16z"/>
          <path d="M7.002 11a1 1 0 1 1 2 0 1 1 0 0 1-2 0zM7.1 4.995a.905.905 0 1 1 1.8 0l-.35 3.507a.552.552 0 0 1-1.1 0L7.1 4.995z"/>
        </svg>
      </div>
      
      <h1>{{ t('access_denied_title') }}</h1>
      <p class="message">{{ getAccessMessage() }}</p>
      
      <div class="country-info">
        <p><strong>{{ t('current_cluster') }} :</strong> {{ displayCountry }}</p>
        <p><strong>{{ t('available_features') }} :</strong></p>
        <ul class="features-list">
          <li v-for="feature in availableFeatures" :key="feature">{{ feature }}</li>
        </ul>
      </div>
      
      <div class="actions">
        <router-link :to="getDefaultRoute()" class="btn btn-primary">
          {{ t('go_to_dashboard') }}
        </router-link>
        <button @click="goBack" class="btn btn-secondary">
          {{ t('go_back') }}
        </button>
      </div>
    </div>
  </div>
</template>

<script>
import { useI18n } from 'vue-i18n'

export default {
  name: 'AccessDenied',
  setup() {
    const { t } = useI18n()
    return { t }
  },
  computed: {
    selectedCountry() {
      return localStorage.getItem('selectedCountry') || null;
    },
    baseCountry() {
      if (!this.selectedCountry) return null;
      return this.selectedCountry.startsWith('ch_') ? 'ch' : this.selectedCountry;
    },
    displayCountry() {
      if (!this.selectedCountry) return "";
      if (this.selectedCountry.startsWith("ch")) return "Suisse";
      if (this.selectedCountry === "fr") return "France";
      if (this.selectedCountry === "us") return "USA";
      return this.selectedCountry;
    },
    availableFeatures() {
      const features = {
        'fr': [
          this.t('nav_home'),
          this.t('nav_data'),
          this.t('nav_charts'),
          this.t('nav_prediction'),
          this.t('nav_etl')
        ],
        'us': [
          this.t('nav_data'),
          this.t('nav_etl')
        ],
        'ch': [
          this.t('nav_etl')
        ]
      };
      return features[this.baseCountry] || [];
    }
  },
  methods: {
    getAccessMessage() {
      switch(this.baseCountry) {
        case 'fr':
          return this.t('access_message_fr');
        case 'us':
          return this.t('access_message_us');
        case 'ch':
          return this.t('access_message_ch');
        default:
          return this.t('access_message_default');
      }
    },
    getDefaultRoute() {
      const defaultRoutes = {
        'fr': '/',
        'us': '/data',
        'ch': '/etl'
      };
      return defaultRoutes[this.baseCountry] || '/';
    },
    goBack() {
      this.$router.go(-1);
    }
  }
}
</script>

<style scoped>
.access-denied-container {
  display: flex;
  justify-content: center;
  align-items: center;
  min-height: 60vh;
  padding: 20px;
}

.access-denied-card {
  background: white;
  border-radius: 12px;
  box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
  padding: 40px;
  text-align: center;
  max-width: 500px;
  width: 100%;
}

.icon {
  color: #ff9800;
  margin-bottom: 20px;
}

.access-denied-card h1 {
  color: #333;
  margin-bottom: 20px;
  font-size: 1.8rem;
}

.message {
  color: #666;
  font-size: 1.1rem;
  margin-bottom: 30px;
  line-height: 1.5;
}

.country-info {
  background-color: #f8f9fa;
  border-radius: 8px;
  padding: 20px;
  margin-bottom: 30px;
  text-align: left;
}

.country-info p {
  margin: 0 0 10px 0;
  color: #333;
}

.features-list {
  list-style: none;
  padding: 0;
  margin: 10px 0 0 0;
}

.features-list li {
  background-color: #e3f2fd;
  color: #1976d2;
  padding: 8px 12px;
  margin: 5px 0;
  border-radius: 4px;
  border-left: 4px solid #1976d2;
}

.actions {
  display: flex;
  gap: 15px;
  justify-content: center;
  flex-wrap: wrap;
}

.btn {
  padding: 12px 24px;
  border-radius: 6px;
  text-decoration: none;
  font-weight: 500;
  transition: all 0.3s ease;
  border: none;
  cursor: pointer;
  font-size: 1rem;
}

.btn-primary {
  background-color: #1976d2;
  color: white;
}

.btn-primary:hover {
  background-color: #1565c0;
  transform: translateY(-2px);
}

.btn-secondary {
  background-color: #6c757d;
  color: white;
}

.btn-secondary:hover {
  background-color: #5a6268;
  transform: translateY(-2px);
}

/* Responsive Design */
@media (max-width: 768px) {
  .access-denied-card {
    padding: 30px 20px;
  }
  
  .access-denied-card h1 {
    font-size: 1.5rem;
  }
  
  .message {
    font-size: 1rem;
  }
  
  .actions {
    flex-direction: column;
  }
  
  .btn {
    width: 100%;
  }
}

@media (max-width: 480px) {
  .access-denied-container {
    padding: 10px;
  }
  
  .access-denied-card {
    padding: 20px 15px;
  }
  
  .access-denied-card h1 {
    font-size: 1.3rem;
  }
}
</style>
