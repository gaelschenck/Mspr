<template>
  <header class="header">
    <div class="header-content">
      <div class="left-section">
        <!-- Choix de pays -->
        <div class="country-select">
          <button @click="setCountry('fr')">FR</button>
          <button @click="setCountry('us')">US</button>
          <button @click="setCountry('ch')">CH</button>
        </div>
        
        <!-- Langues suisses (si applicables) -->
        <div v-if="showSwissLanguages" class="swiss-lang">
          <button @click="setSwissLang('fr')">FR-CH</button>
          <button @click="setSwissLang('en')">EN-CH</button>
          <button @click="setSwissLang('de')">DE-CH</button>
          <button @click="setSwissLang('it')">IT-CH</button>
        </div>
        
        <!-- Informations de connexion -->
        <div class="connection-info">
          <span v-if="currentCountry" class="cluster-info">
            {{ $t('cluster') }} : {{ displayCountry }}
          </span>
          <span v-if="currentUser" class="user-info">
            | {{ $t('connected_as') }} : {{ currentUser }}
          </span>
          <button @click="logout" class="logout-btn">{{ $t('logout') }}</button>
        </div>
      </div>
      
      <!-- Navigation à droite -->
      <nav class="right-nav">
        <!-- Menu burger pour mobile -->
        <button class="burger-menu" @click="toggleMobileMenu" :class="{ active: mobileMenuOpen }">
          <span></span>
          <span></span>
          <span></span>
        </button>
        
        <!-- Navigation normale -->
        <ul class="nav-list" :class="{ 'mobile-open': mobileMenuOpen }">
          <li v-for="navItem in allowedNavigation" :key="navItem.route">
            <router-link :to="navItem.route" @click="closeMobileMenu">{{ navItem.label }}</router-link>
          </li>
        </ul>
      </nav>
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
      mobileMenuOpen: false,
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
    },
    allowedNavigation() {
      const allNavigation = [
        { route: '/', label: this.$t('nav_home'), countries: ['fr'] },
        { route: '/data', label: this.$t('nav_data'), countries: ['fr', 'us'] },
        { route: '/graphiques', label: this.$t('nav_charts'), countries: ['fr'] },
        { route: '/prediction', label: this.$t('nav_prediction'), countries: ['fr'] },
        { route: '/etl', label: this.$t('nav_etl') || 'ETL', countries: ['fr', 'us', 'ch'] }
      ];

      // Si pas de pays sélectionné, afficher tout (mode par défaut)
      if (!this.currentCountry) {
        return allNavigation;
      }

      // Détermine le pays de base (sans le suffixe de langue pour la Suisse)
      let baseCountry = this.currentCountry;
      if (this.currentCountry.startsWith('ch_')) {
        baseCountry = 'ch';
      }

      // Filtre la navigation selon le pays
      return allNavigation.filter(nav => nav.countries.includes(baseCountry));
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
      
      // Rediriger vers une page autorisée après changement de pays
      this.redirectToAllowedPage(country.toLowerCase());
      
      window.location.reload();
    },
    setSwissLang(lang) {
      const oldCountry = localStorage.getItem("selectedCountry");
      const newCountry = `ch_${lang}`;
      // Si déjà sur un cluster suisse, autorise le changement de langue suisse
      if (oldCountry && oldCountry.startsWith("ch")) {
        localStorage.setItem("selectedCountry", newCountry);
        this.$i18n.locale = lang;
        
        // Rediriger vers une page autorisée après changement de langue
        this.redirectToAllowedPage(newCountry);
        
        window.location.reload();
        return;
      }
      // Sinon, redirige vers la page d'avertissement
      this.$router.push('/cluster-switch-not-allowed');
    },
    redirectToAllowedPage(country) {
      const currentRoute = this.$route.path;
      let baseCountry = country;
      
      // Gestion des langues suisses
      if (country.startsWith('ch_')) {
        baseCountry = 'ch';
      }
      
      // Définir les pages autorisées par pays
      const allowedPages = {
        'fr': ['/', '/data', '/graphiques', '/prediction', '/etl'],
        'us': ['/data', '/etl'],
        'ch': ['/etl']
      };
      
      const allowed = allowedPages[baseCountry] || ['/'];
      
      // Si la page actuelle n'est pas autorisée, rediriger vers la première page autorisée
      if (!allowed.includes(currentRoute)) {
        this.$router.push(allowed[0]);
      }
    },
    logout() {
      this.userStore.clearUser();
      localStorage.removeItem('selectedCountry');
      this.$router.push('/login');
    },
    toggleMobileMenu() {
      this.mobileMenuOpen = !this.mobileMenuOpen;
    },
    closeMobileMenu() {
      this.mobileMenuOpen = false;
    }
  }
};
</script>

<style scoped>
.header {
  background-color: #333;
  color: white;
  padding: 15px 20px;
}

.header-content {
  display: flex;
  justify-content: space-between;
  align-items: flex-start;
  max-width: 1200px;
  margin: 0 auto;
}

/* Section gauche : pays, langues suisses, infos connexion */
.left-section {
  display: flex;
  flex-direction: column;
  gap: 8px;
  align-items: flex-start;
}

.country-select {
  display: flex;
  gap: 5px;
}

.swiss-lang {
  display: flex;
  gap: 5px;
  margin-left: 10px;
}

.connection-info {
  display: flex;
  align-items: center;
  gap: 10px;
  flex-wrap: wrap;
  font-size: 0.9em;
}

/* Navigation à droite */
.right-nav {
  margin-top: 5px;
  position: relative;
}

.burger-menu {
  display: none;
  flex-direction: column;
  justify-content: space-around;
  width: 30px;
  height: 25px;
  background: transparent;
  border: none;
  cursor: pointer;
  padding: 0;
}

.burger-menu span {
  width: 100%;
  height: 3px;
  background-color: white;
  transition: all 0.3s ease;
  transform-origin: center;
}

.burger-menu.active span:nth-child(1) {
  transform: rotate(45deg) translate(6px, 6px);
}

.burger-menu.active span:nth-child(2) {
  opacity: 0;
}

.burger-menu.active span:nth-child(3) {
  transform: rotate(-45deg) translate(6px, -6px);
}

.nav-list {
  list-style: none;
  padding: 0;
  margin: 0;
  display: flex;
  gap: 20px;
}

.nav-list li {
  display: inline-block;
}

.nav-list a {
  color: white;
  text-decoration: none;
  padding: 8px 12px;
  border-radius: 4px;
  transition: background-color 0.3s;
}

.nav-list a:hover,
.nav-list a.router-link-active {
  background-color: #555;
  text-decoration: none;
}

/* Boutons */
button {
  background: #444;
  color: white;
  border: none;
  padding: 6px 12px;
  border-radius: 4px;
  cursor: pointer;
  font-size: 0.9em;
  transition: background-color 0.3s;
}

button:hover {
  background: #666;
}

.logout-btn {
  background: #d32f2f;
  font-size: 0.85em;
  padding: 4px 8px;
}

.logout-btn:hover {
  background: #b71c1c;
}

/* Informations */
.cluster-info {
  font-weight: bold;
  color: #ffd700;
}

.user-info {
  color: #ccc;
  font-size: 0.85em;
}

/* Responsive */
@media (max-width: 768px) {
  .header {
    padding: 10px 15px;
  }

  .header-content {
    flex-direction: column;
    gap: 15px;
    align-items: center;
    position: relative;
  }
  
  .left-section {
    align-items: center;
    width: 100%;
  }
  
  .country-select {
    justify-content: center;
    flex-wrap: wrap;
  }
  
  .swiss-lang {
    margin-left: 0;
    justify-content: center;
    flex-wrap: wrap;
  }
  
  .connection-info {
    justify-content: center;
    text-align: center;
    flex-direction: column;
    gap: 5px;
  }
  
  /* Menu burger visible sur mobile */
  .burger-menu {
    display: flex;
    position: absolute;
    top: -5px;
    right: 0;
  }
  
  /* Navigation mobile */
  .nav-list {
    position: absolute;
    top: 100%;
    left: 0;
    right: 0;
    background-color: #333;
    flex-direction: column;
    gap: 0;
    padding: 10px 0;
    border-radius: 0 0 8px 8px;
    box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
    transform: translateY(-10px);
    opacity: 0;
    visibility: hidden;
    transition: all 0.3s ease;
    z-index: 1000;
  }
  
  .nav-list.mobile-open {
    transform: translateY(0);
    opacity: 1;
    visibility: visible;
  }
  
  .nav-list li {
    display: block;
    width: 100%;
    text-align: center;
  }
  
  .nav-list a {
    display: block;
    padding: 12px 20px;
    border-radius: 0;
    border-bottom: 1px solid #555;
  }
  
  .nav-list li:last-child a {
    border-bottom: none;
  }
}

@media (max-width: 480px) {
  .header {
    padding: 8px 10px;
  }
  
  .country-select button,
  .swiss-lang button {
    padding: 4px 8px;
    font-size: 0.8em;
  }
  
  .connection-info {
    font-size: 0.8em;
  }
  
  .cluster-info,
  .user-info {
    text-align: center;
  }
}
</style>