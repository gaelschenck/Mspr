<template>
  <div class="cluster-switch-blocked">
    <h2>{{ $t('cluster_switch_title') }}</h2>
    <p>{{ $t('cluster_switch_message') }}</p>
    <button @click="logout">{{ $t('logout') }}</button>
    <button @click="goBack">{{ $t('back') }}</button>
  </div>
</template>

<script setup>
import { useRouter } from 'vue-router';
import { useUserStore } from '../stores/userStore';

const router = useRouter();
const userStore = useUserStore();

function logout() {
  userStore.clearUser();
  localStorage.removeItem('selectedCountry');
  router.push('/login');
}
function goBack() {
  router.back();
}
</script>

<style scoped>
.cluster-switch-blocked {
  margin: 2em auto;
  max-width: 400px;
  text-align: center;
}
button {
  margin: 1em;
}
</style>