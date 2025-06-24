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
import apiClient from "/services/api";

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

        localStorage.setItem("access_token", response.data.access_token);
        localStorage.setItem("selectedCountry", this.country);
        this.$router.push("/");
      } catch (err) {
        this.error = "Identifiants invalides";
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
.error {
  color: red;
  margin-top: 1em;
}
</style>