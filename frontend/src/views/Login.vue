<template>
  <div class="login-container">
    <h1>Connexion</h1>
    <form @submit.prevent="login">
      <div>
        <label for="country">Pays</label>
        <select v-model="country" id="country" required>
          <option value="fr">France</option>
          <option value="us">USA</option>
          <option value="ch">Suisse</option>
        </select>
      </div>
      <div>
        <label for="username">Nom d'utilisateur</label>
        <input v-model="username" id="username" required />
      </div>
      <div>
        <label for="password">Mot de passe</label>
        <input v-model="password" id="password" type="password" required />
      </div>
      <button type="submit">Se connecter</button>
      <p v-if="error" class="error">{{ error }}</p>
      

    </form>
  </div>
</template>

<script>
import apiClient from "../../services/api.js";
import { useUserStore } from '../stores/userStore';

export default {
  name: "Login",
  data() {
    return {
      username: "",
      password: "",
      country: localStorage.getItem("selectedCountry") || "fr",
      error: null,
    };
  },
  methods: {
    async login() {
      this.error = null;
      try {
        const params = new URLSearchParams();
        params.append("username", this.username);
        params.append("password", this.password);

        // Envoie le cluster dans le header
        const response = await apiClient.post("/token", params, {
          headers: {
            "Content-Type": "application/x-www-form-urlencoded",
            "X-Cluster": this.country,
          },
        });

        // Utilisation du store Pinia pour mettre à jour l'utilisateur
        const userStore = useUserStore();
        userStore.setToken(response.data.access_token);
        localStorage.setItem("selectedCountry", this.country);
        this.$router.push("/");
      } catch (err) {
        console.log('Erreur login:', err.response?.status, err.response?.data?.detail);
        
        if (err.response?.status === 404) {
          this.error = `Utilisateur "${this.username}" non trouvé dans la base ${this.country.toUpperCase()}`;
        } else if (err.response?.status === 401) {
          this.error = `Mot de passe incorrect pour l'utilisateur "${this.username}"`;
        } else if (err.response?.status === 400) {
          this.error = "Erreur de configuration (cluster non spécifié)";
        } else {
          this.error = err.response?.data?.detail || "Erreur de connexion";
        }
      }
    },
  },
};
</script>

<style scoped>
.login-container {
  max-width: 400px;
  margin: 80px auto;
  padding: 2em;
  background: #fff;
  border-radius: 8px;
  box-shadow: 0 2px 8px rgba(0,0,0,0.1);
}

.login-container h1 {
  text-align: center;
  margin-bottom: 1.5em;
  color: #333;
}

.login-container form {
  display: flex;
  flex-direction: column;
  gap: 1em;
}

.login-container div {
  display: flex;
  flex-direction: column;
}

.login-container label {
  margin-bottom: 0.5em;
  font-weight: 500;
  color: #555;
}

.login-container input,
.login-container select {
  padding: 10px;
  border: 1px solid #ddd;
  border-radius: 4px;
  font-size: 1rem;
  transition: border-color 0.3s;
}

.login-container input:focus,
.login-container select:focus {
  outline: none;
  border-color: #1976d2;
}

.login-container button {
  padding: 12px;
  background-color: #1976d2;
  color: white;
  border: none;
  border-radius: 4px;
  font-size: 1rem;
  cursor: pointer;
  transition: background-color 0.3s;
  margin-top: 1em;
}

.login-container button:hover {
  background-color: #1565c0;
}

.error {
  color: #d32f2f;
  margin-top: 1em;
  text-align: center;
  padding: 10px;
  background-color: #ffebee;
  border-radius: 4px;
}

/* Responsive Design */
@media (max-width: 768px) {
  .login-container {
    margin: 40px auto;
    padding: 1.5em;
    max-width: 90%;
  }
  
  .login-container h1 {
    font-size: 1.5rem;
  }
  
  .login-container input,
  .login-container select {
    font-size: 16px; /* Prevents zoom on iOS */
  }
}

@media (max-width: 480px) {
  .login-container {
    margin: 20px auto;
    padding: 1em;
    max-width: 95%;
  }
  
  .login-container h1 {
    font-size: 1.3rem;
    margin-bottom: 1em;
  }
  
  .login-container form {
    gap: 0.8em;
  }
}
</style>