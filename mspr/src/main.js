import { createApp } from 'vue';
import App from './App.vue';
import router from './router';
import store from './store';
import axios from 'axios';
import { createPinia } from 'pinia';
import './assets/main.css';

const app = createApp(App);
app.config.globalProperties.$axios = axios;
app.use(createPinia());
app.use(router);
app.use(store);
app.mount('#app');