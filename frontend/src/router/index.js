import { createRouter, createWebHistory } from 'vue-router';
import Home from '../views/home.vue';
import PredictionGraphs from '../components/predictionGraphs.vue';
import Graphiques from '../components/predictionGraphs.vue';
import Prediction from '../components/TestPrediction.vue';
import USMortalite from '../components/USMortalite.vue';
import Data from '../components/Data.vue';
import Confidentialite from '../components/Confidentialite.vue';
import Login from '../views/Login.vue';
import PopulationHiv from '../components/PopulationHiv.vue';
import Traitement from '../components/Traitement.vue';
import TransmissionMereEnfant from '../components/TransmissionMereEnfant.vue';
import ClusterSwitchNotAllowed from '../components/ClusterSwitchNotAllowed.vue';

const routes = [
  { path: '/', component: Home },
  { path: '/graphiques', component: Graphiques },
  { path: '/prediction', component: Prediction },
  { path: '/prediction-graphs',name: 'PredictionGraphs', component: PredictionGraphs},
  // route pour faciliter la scalabilité
  { path: '/data', component: Data },
  { path: '/us-mortalite', component: USMortalite },
  { path: '/population-hiv', component: PopulationHiv },
  { path: '/traitement', component: Traitement },
  { path: '/transmission-mere-enfant', component: TransmissionMereEnfant },
  { path: '/confidentialite', name: 'Confidentialite', component: Confidentialite },
  { path: '/login', component: Login },
  {
    path: '/cluster-switch-not-allowed',
    name: 'ClusterSwitchNotAllowed',
    component: ClusterSwitchNotAllowed
  },
];
const router = createRouter({
  history: createWebHistory(),
  routes,
});
router.beforeEach((to, from, next) => {
  const publicPages = ['/login'];
  const authRequired = !publicPages.includes(to.path);
  const token = localStorage.getItem('access_token');

  if (authRequired && !token) {
    return next('/login');
  }
  next();
});
export default router;