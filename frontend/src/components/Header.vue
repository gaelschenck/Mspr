<template>
  <header class="header">
    <div class="header-content">
      <div class="lang-select">
        <button @click="setCountry('fr')">FR</button>
        <button @click="setCountry('us')">US</button>
        <button @click="setCountry('ch')">CH</button>
        <span v-if="showSwissLanguages" class="swiss-lang">
          <button @click="setSwissLang('fr')">FR-CH</button>
          <button @click="setSwissLang('en')">EN-CH</button>
          <button @click="setSwissLang('de')">DE-CH</button>
          <button @click="setSwissLang('it')">IT-CH</button>
        </span>
      </div>
      <nav>
        <ul>
          <li><router-link to="/">{{ $t('nav_home') }}</router-link></li>
          <li><router-link to="/data">{{ $t('nav_data') }}</router-link></li>
          <li><router-link to="/graphiques">{{ $t('nav_charts') }}</router-link></li>
          <li><router-link to="/prediction">{{ $t('nav_prediction') }}</router-link></li>
        </ul>
      </nav>
    </div>
    <div>
      <span v-if="currentCountry" class="cluster-info">
        Cluster : {{ displayCountry }}
      </span>
      <span v-if="currentUser" class="user-info">
        | Connecté en tant que : {{ currentUser }}
      </span>
      <button @click="logout">Déconnexion</button>
    </div>
  </header>
</template>

<script>
import { useUserStore } from '../stores/userStore';
import { storeToRefs } from 'pinia';

export default {
  name: "Header",
  setup() {
    const userStore = useUserStore();
    const { username } = storeToRefs(userStore);
    return { userStore, username };
  },
  data() {
    return {
      currentCountry: localStorage.getItem("selectedCountry") || null,
    };
  },
  computed: {
    displayCountry() {
      if (!this.currentCountry) return "";
      if (this.currentCountry.startsWith("ch")) return "Suisse";
      if (this.currentCountry === "fr") return "France";
      if (this.currentCountry === "us") return "USA";
      return this.currentCountry;
    },
    currentUser() {
      // Remplacé par le store Pinia
      return this.username;
    },
    showSwissLanguages() {
      // Affiche les langues suisses seulement si on est sur un cluster suisse ET qu'un utilisateur est connecté
      return this.currentCountry && this.currentCountry.startsWith("ch") && this.currentUser;
    }
  },
  methods: {
    setCountry(country) {
      const oldCountry = localStorage.getItem("selectedCountry");
      
      // Gestion spéciale pour la Suisse - se connecte automatiquement à ch_fr
      if (country === "ch") {
        country = "ch_fr";
      }
      
      // Si déjà connecté et cluster différent (hors suisse), redirige vers la page d'avertissement
      if (oldCountry && !oldCountry.startsWith("ch") && oldCountry !== country.toLowerCase() && this.currentUser) {
        this.$router.push('/cluster-switch-not-allowed');
        return;
      }
      
      localStorage.setItem("selectedCountry", country.toLowerCase());
      if (country === "fr") this.$i18n.locale = "fr";
      if (country === "us") this.$i18n.locale = "en";
      if (country === "ch_fr") this.$i18n.locale = "fr";
      
      window.location.reload();
    },
    setSwissLang(lang) {
      const oldCountry = localStorage.getItem("selectedCountry");
      const newCountry = `ch_${lang}`;
      // Si déjà sur un cluster suisse, autorise le changement de langue suisse
      if (oldCountry && oldCountry.startsWith("ch")) {
        localStorage.setItem("selectedCountry", newCountry);
        this.$i18n.locale = lang;
        window.location.reload();
        return;
      }
      // Sinon, redirige vers la page d'avertissement
      this.$router.push('/cluster-switch-not-allowed');
    },
    logout() {
      this.userStore.clearUser();
      localStorage.removeItem('selectedCountry');
      this.$router.push('/login');
    }
  }
};
</script>

<style scoped>
.header {
  background-color: #333;
  color: white;
  padding: 10px 0;
}

.header-content {
  display: flex;
  align-items: center;
  justify-content: center;
  position: relative;
}

.lang-select {
  position: absolute;
  left: 20px;
  display: flex;
  gap: 5px;
}

.swiss-lang {
  margin-left: 10px;
  display: flex;
  gap: 5px;
}

nav ul {
  list-style: none;
  padding: 0;
  margin: 0;
}

nav li {
  display: inline-block;
  margin: 0 15px;
}

nav a {
  color: white;
  text-decoration: none;
}

nav a:hover {
  text-decoration: underline;
}

button {
  background: #444;
  color: white;
  border: none;
  padding: 5px 10px;
  margin: 0 2px;
  border-radius: 3px;
  cursor: pointer;
  font-size: 0.95em;
}

button:hover {
  background: #666;
}

.cluster-info {
  margin-right: 1em;
  font-weight: bold;
}
.user-info {
  margin-right: 1em;
}
</style>