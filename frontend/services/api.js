import axios from 'axios';

// Récupère le pays sélectionné (par défaut 'fr')
const country = localStorage.getItem("selectedCountry") || "fr";

const apiClient = axios.create({
  baseURL: `/api/${country}`,
  headers: {
    'Content-Type': 'application/json',
  },
});
export default apiClient;