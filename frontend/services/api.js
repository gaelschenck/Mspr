import axios from 'axios';

// Récupère le pays/langue sélectionné (ex: 'fr', 'us', 'ch_fr', 'ch_en', 'ch_de')
const country = localStorage.getItem("selectedCountry") || "fr";
console.log(localStorage.getItem("selectedCountry"));

let baseURL;
if (country === "fr" || country === "us") {
  baseURL = `/api/${country}/`;
} else if (country.startsWith("ch_")) {
  // country = 'ch_fr', 'ch_en', 'ch_de'
  const lang = country.split("_")[1];
  baseURL = `/api/ch/${lang}/`;
} else {
  baseURL = `/api/fr/`; // fallback
}

const apiClient = axios.create({
  baseURL,
  headers: {
    'Content-Type': 'application/json',
  },
});
export default apiClient;