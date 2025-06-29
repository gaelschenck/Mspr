<template>
  <div v-if="show" class="rgpd-banner">
    Ce site utilise des cookies pour améliorer votre expérience et réaliser des statistiques anonymes.
    <button @click="accept">Accepter</button>
    <button @click="decline">Refuser</button>
  </div>
</template>

<script setup>
import { ref } from "vue";
import apiClient from "../../services/api.js";

const show = ref(false);

// Vérifie le cluster sélectionné
const currentCountry = localStorage.getItem("selectedCountry");

// Affiche le bandeau RGPD uniquement si cluster FR
show.value = currentCountry === "fr" && localStorage.getItem("rgpdConsent") === null;

async function accept() {
  localStorage.setItem("rgpdConsent", "accepted");
  show.value = false;
  loadAnalytics();
  await saveConsent(1);
}

async function decline() {
  localStorage.setItem("rgpdConsent", "declined");
  show.value = false;
  await saveConsent(0);
}

async function saveConsent(val) {
  const token = localStorage.getItem("access_token");
  if (token) {
    try {
      await apiClient.put(
        "/me/rgpd",
        { rgpd_accept: val },
        { headers: { Authorization: "Bearer " + token } }
      );
    } catch (e) {
      // Optionnel : afficher une erreur ou logger
    }
  }
}

function loadAnalytics() {
  if (!window.gtag) {
    const script = document.createElement("script");
    script.src = "https://www.googletagmanager.com/gtag/js?id=UA-XXXXXXX-X";
    script.async = true;
    document.head.appendChild(script);

    window.dataLayer = window.dataLayer || [];
    window.gtag = function(){dataLayer.push(arguments);}
    window.gtag('js', new Date());
    window.gtag('config', 'UA-XXXXXXX-X');
  }
}

// Charge analytics si déjà accepté (et cluster FR)
if (currentCountry === "fr" && localStorage.getItem("rgpdConsent") === "accepted") {
  loadAnalytics();
}

// Permet d'afficher le bandeau depuis le footer
window.showRGPDConsent = () => { 
  if (localStorage.getItem("selectedCountry") === "fr") show.value = true;
};
</script>

<style scoped>
.rgpd-banner {
  position: fixed;
  bottom: 0;
  left: 0;
  right: 0;
  background: #222;
  color: #fff;
  padding: 15px 20px;
  text-align: center;
  z-index: 1000;
  box-shadow: 0 -4px 6px rgba(0, 0, 0, 0.1);
  display: flex;
  justify-content: center;
  align-items: center;
  gap: 15px;
  flex-wrap: wrap;
}

.rgpd-banner p {
  margin: 0;
  flex: 1;
  min-width: 200px;
}

.rgpd-banner button {
  background-color: #1976d2;
  color: white;
  border: none;
  padding: 8px 16px;
  border-radius: 4px;
  cursor: pointer;
  transition: background-color 0.3s;
  font-size: 0.9em;
}

.rgpd-banner button:hover {
  background-color: #1565c0;
}

.rgpd-banner button + button {
  background-color: #666;
}

.rgpd-banner button + button:hover {
  background-color: #555;
}

/* Responsive Design */
@media (max-width: 768px) {
  .rgpd-banner {
    flex-direction: column;
    gap: 10px;
    padding: 12px 15px;
    text-align: center;
  }
  
  .rgpd-banner p {
    font-size: 0.9em;
    min-width: auto;
    margin-bottom: 5px;
  }
  
  .rgpd-banner button {
    width: 100%;
    max-width: 200px;
    padding: 10px 16px;
    font-size: 0.9em;
  }
}

@media (max-width: 480px) {
  .rgpd-banner {
    padding: 10px;
  }
  
  .rgpd-banner p {
    font-size: 0.8em;
  }
  
  .rgpd-banner button {
    font-size: 0.8em;
    padding: 8px 12px;
  }
}
</style>