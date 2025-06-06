import { createRouter, createWebHistory } from 'vue-router';
import Home from '../views/home.vue';
import Graphiques from '../components/predictionGraphs.vue';
import Prediction from '../components/TestPrediction.vue';

const routes = [
  { path: '/', component: Home },
  { path: '/graphiques', component: Graphiques },
  { path: '/prediction', component: Prediction },
];
const router = createRouter({
  history: createWebHistory(),
  routes,
});
export default router;