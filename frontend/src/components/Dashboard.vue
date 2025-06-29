<template>
    <div class="dashboard-container">
      <h1>{{ t('dashboard_title') }}</h1>
      <div v-if="loading" class="loading-message">{{ t('dashboard_loading') }}</div>
      <div v-else-if="error" class="error-message">
        {{ t('dashboard_error') }}
        <button @click="retryLoad">{{ t('dashboard_retry') }}</button>
      </div>
      <ul v-else-if="items.length > 0">
        <li v-for="item in items" :key="item.id">{{ item.name }}</li>
      </ul>
      <div v-else class="no-data-message">{{ t('dashboard_no_data') }}</div>
    </div>
  </template>
  
  <script>
  import { ref, onMounted } from 'vue'
  import { useI18n } from 'vue-i18n'
  import apiClient from '../services/api.js'
  
  export default {
    name: 'Dashboard',
    setup() {
      const { t } = useI18n()
      const items = ref([])
      const loading = ref(true)
      const error = ref(false)
  
      const fetchData = async () => {
        try {
          loading.value = true
          error.value = false
          
          const response = await apiClient.get('/health-data/')
          items.value = response.data
        } catch (err) {
          console.error('Error fetching data:', err)
          error.value = true
        } finally {
          loading.value = false
        }
      }
  
      const retryLoad = () => {
        fetchData()
      }
  
      onMounted(() => {
        fetchData()
      })
  
      return {
        t,
        items,
        loading,
        error,
        retryLoad
      }
    }
  }
  </script>
  
  <style scoped>
  .dashboard-container {
    padding: 20px;
    max-width: 1200px;
    margin: 0 auto;
  }
  
  h1 {
    color: #333;
    margin-bottom: 20px;
    text-align: center;
  }
  
  .loading-message,
  .error-message,
  .no-data-message {
    text-align: center;
    padding: 40px 20px;
    font-size: 1.1em;
  }
  
  .loading-message {
    color: #666;
  }
  
  .error-message {
    color: #d32f2f;
    background-color: #ffebee;
    border-radius: 8px;
    margin: 20px 0;
  }
  
  .no-data-message {
    color: #888;
  }
  
  button {
    background-color: #1976d2;
    color: white;
    border: none;
    padding: 10px 20px;
    border-radius: 4px;
    cursor: pointer;
    margin-top: 10px;
    transition: background-color 0.3s;
  }
  
  button:hover {
    background-color: #1565c0;
  }
  
  ul {
    list-style: none;
    padding: 0;
    margin: 20px 0;
  }
  
  li {
    background-color: #f5f5f5;
    margin: 10px 0;
    padding: 15px;
    border-radius: 8px;
    border-left: 4px solid #1976d2;
    transition: transform 0.2s, box-shadow 0.2s;
  }
  
  li:hover {
    transform: translateY(-2px);
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
  }
  
  /* Responsive Design */
  @media (max-width: 768px) {
    .dashboard-container {
      padding: 15px 10px;
    }
    
    h1 {
      font-size: 1.5em;
      margin-bottom: 15px;
    }
    
    .loading-message,
    .error-message,
    .no-data-message {
      padding: 20px 15px;
      font-size: 1em;
    }
    
    li {
      padding: 12px;
      margin: 8px 0;
    }
    
    button {
      width: 100%;
      padding: 12px;
      font-size: 1em;
    }
  }
  
  @media (max-width: 480px) {
    .dashboard-container {
      padding: 10px 5px;
    }
    
    h1 {
      font-size: 1.3em;
    }
    
    li {
      padding: 10px;
      font-size: 0.9em;
    }
  }
  </style>