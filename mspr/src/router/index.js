import { createRouter, createWebHistory } from 'vue-router';
import Home from '../views/home.vue';
import Prediction from '../components/TestPrediction.vue';

const routes = [
  { path: '/', component: Home },
  { path: '/prediction', component: Prediction },
];
const router = createRouter({
  history: createWebHistory(),
  routes,
});
export default router;