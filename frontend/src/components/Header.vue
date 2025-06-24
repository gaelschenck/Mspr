<template>
  <header class="header">
    <div class="header-content">
      <div class="lang-select">
        <button @click="setCountry('fr')">FR</button>
        <button @click="setCountry('us')">US</button>
        <button @click="showSwissLang = !showSwissLang">CH</button>
        <span v-if="showSwissLang" class="swiss-lang">
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
export default {
  name: "Header",
  data() {
    return {
      showSwissLang: false,
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
      const token = localStorage.getItem("access_token");
      if (!token) return null;
      try {
        const payload = JSON.parse(atob(token.split('.')[1]));
        return payload.sub;
      } catch {
        return null;
      }
    }
  },
  methods: {
    setCountry(country) {
      const oldCountry = localStorage.getItem("selectedCountry");
      if (oldCountry && oldCountry !== country.toLowerCase()) {
        // Déconnexion automatique si changement de cluster
        localStorage.removeItem("access_token");
        this.$router.push("/login");
      }
      localStorage.setItem("selectedCountry", country.toLowerCase());
      if (country === "fr") this.$i18n.locale = "fr";
      if (country === "us") this.$i18n.locale = "en";
      window.location.reload();
    },
    setSwissLang(lang) {
      const oldCountry = localStorage.getItem("selectedCountry");
      const newCountry = `ch_${lang}`;
      if (oldCountry && oldCountry !== newCountry) {
        localStorage.removeItem("access_token");
        this.$router.push("/login");
      }
      localStorage.setItem("selectedCountry", newCountry);
      this.$i18n.locale = lang;
      window.location.reload();
    },
    logout() {
      localStorage.removeItem('access_token');
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