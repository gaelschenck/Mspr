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
 * Récupère les données de mortalité US avec pagination et filtrage par année.
 * @param {number} page - Numéro de page (défaut 1)
 * @param {number} pageSize - Nombre d'éléments par page (défaut 100)
 * @param {number|null} year - Année à filtrer (optionnel)
 * @returns {Promise<Array>} - Tableau de résultats
 */
export async function fetchUSMortalite(offset, limit) {
  const response = await apiClient.get('/us/mortalite/', { params: { offset, limit } });
  return response.data;
}
export async function fetchPopulationHiv(offset = 0, limit = 25) {
  const res = await apiClient.get(`/population_hiv/paginated/?offset=${offset}&limit=${limit}`);
  return res.data;
}
export async function fetchTraitement(offset = 0, limit = 25) {
  const res = await apiClient.get(`/traitement/paginated/?offset=${offset}&limit=${limit}`);
  return res.data;
}
export async function fetchTransmissionMereEnfant(offset, limit) {
  const res = await apiClient.get('/transmission_mere_en_enfant/paginated/', { params: { offset, limit } });
  return res.data;
}

export default apiClient;