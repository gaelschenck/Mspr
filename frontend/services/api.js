import axios from 'axios';

// Récupère le pays/langue sélectionné (ex: 'fr', 'us', 'ch_fr', 'ch_en', 'ch_de')
const country = localStorage.getItem("selectedCountry") || "fr";
console.log(localStorage.getItem("selectedCountry"));

// Obtenir l'URL de base dynamiquement à partir de window.location
const host = window.location.hostname;
const port = window.location.port || "32655"; // Port par défaut si non spécifié

// Créer l'URL avec le port actuel du navigateur
let baseURL;
if (country === "fr" || country === "us") {
  baseURL = `http://${host}:${port}/api/${country}/`;
} else if (country.startsWith("ch_")) {
  const lang = country.split("_")[1];
  baseURL = `http://${host}:${port}/api/ch/${lang}/`;
} else {
  baseURL = `http://${host}:${port}/api/fr/`; // fallback
}

const apiClient = axios.create({
  baseURL,
  headers: {
    'Content-Type': 'application/json',
  },
});

apiClient.interceptors.request.use(config => {
  const token = localStorage.getItem('access_token');
  if (token) {
    config.headers.Authorization = `Bearer ${token}`;
  }
  return config;
});

/**
 * Récupère les données de mortalité avec pagination.
 * @param {number} offset - Index de départ
 * @param {number} limit - Nombre d'éléments par page
 * @returns {Promise<Array>} - Tableau de résultats
 */
/**
 * Fonction générique pour faire des appels API.
 * @param {string} endpoint - L'endpoint de l'API (ex: "/tables/")
 * @param {Object} options - Options pour la requête (method, data, etc.)
 * @returns {Promise<any>} - Réponse de l'API
 */
export async function fetchFromAPI(endpoint, options = {}) {
  try {
    const method = options.method || 'GET';
    const config = {
      method,
      url: endpoint,
      ...options
    };
    
    if (method.toLowerCase() === 'post' && options.data) {
      config.data = options.data;
    }
    
    const response = await apiClient(config);
    return response.data;
  } catch (error) {
    console.error(`Erreur lors de l'appel API vers ${endpoint}:`, error);
    throw error;
  }
}

// === NOUVEAUX ENDPOINTS - Structure unifiée ===

export async function fetchCountries(offset = 0, limit = 25) {
  try {
    const response = await apiClient.get('/countries/paginated/', { params: { offset, limit } });
    return response.data;
  } catch (error) {
    console.error('Erreur lors du chargement des pays:', error);
    throw error;
  }
}

export async function fetchIndicatorTypes() {
  try {
    const response = await apiClient.get('/indicator-types/');
    return response.data;
  } catch (error) {
    console.error('Erreur lors du chargement des types d\'indicateurs:', error);
    throw error;
  }
}

export async function fetchHealthIndicators(offset = 0, limit = 25, filters = {}) {
  try {
    const params = { offset, limit, ...filters };
    const response = await apiClient.get('/health-indicators/paginated/', { params });
    return response.data;
  } catch (error) {
    console.error('Erreur lors du chargement des indicateurs de santé:', error);
    throw error;
  }
}

export async function fetchHealthIndicatorsDetailed(filters = {}) {
  try {
    // Utilise l'endpoint paginé au lieu de detailed pour avoir une vraie pagination
    const response = await apiClient.get('/health-indicators/paginated/', { params: filters });
    return response.data;
  } catch (error) {
    console.error('Erreur lors du chargement des indicateurs détaillés:', error);
    throw error;
  }
}

// === ANCIENS ENDPOINTS (compatibilité) - SUPPRIMÉS AU PROFIT DE L'UTILISATION DIRECTE ===
// Les composants utilisent maintenant directement fetchHealthIndicatorsDetailed avec les bons filtres

export default apiClient;