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
export async function fetchMortalite(offset = 0, limit = 25) {
  try {
    const response = await apiClient.get('/mortalite/paginated/', { params: { offset, limit } });
    return response.data;
  } catch (error) {
    console.error('Erreur lors du chargement des données de mortalité:', error);
    throw error;
  }
}

export async function fetchPopulationHiv(offset = 0, limit = 25) {
  try {
    const response = await apiClient.get('/population_hiv/paginated/', { params: { offset, limit } });
    return response.data;
  } catch (error) {
    console.error('Erreur lors du chargement des données de population HIV:', error);
    throw error;
  }
}

export async function fetchTraitement(offset = 0, limit = 25) {
  try {
    const response = await apiClient.get('/traitement/paginated/', { params: { offset, limit } });
    return response.data;
  } catch (error) {
    console.error('Erreur lors du chargement des données de traitement:', error);
    throw error;
  }
}

export async function fetchTransmissionMereEnfant(offset = 0, limit = 25) {
  try {
    const response = await apiClient.get('/transmission_mere_enfant/paginated/', { params: { offset, limit } });
    return response.data;
  } catch (error) {
    console.error('Erreur lors du chargement des données de transmission mère-enfant:', error);
    throw error;
  }
}

export default apiClient;