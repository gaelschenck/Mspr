import { createApp } from 'vue';
import App from './App.vue';
import router from './router';
import store from './store';
import axios from 'axios';
import './assets/main.css';
import { createPinia } from 'pinia';
import { library } from '@fortawesome/fontawesome-svg-core'
import { FontAwesomeIcon } from '@fortawesome/vue-fontawesome'
import { faInfoCircle } from '@fortawesome/free-solid-svg-icons'
library.add(faInfoCircle)
const app = createApp(App);

app.config.globalProperties.$axios = axios;
app.component('font-awesome-icon', FontAwesomeIcon)
app.use(createPinia());
app.use(router);
app.use(store);
app.mount('#app');