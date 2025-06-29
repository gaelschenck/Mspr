import { createRouter, createWebHistory } from 'vue-router';
import Home from '../views/home.vue';
import PredictionGraphs from '../components/predictionGraphs.vue';
import Graphiques from '../components/predictionGraphs.vue';
import Prediction from '../components/TestPrediction.vue';
import USMortalite from '../components/USMortalite.vue';
import Data from '../components/Data.vue';
import HealthData from '../components/HealthData.vue';
import Confidentialite from '../components/Confidentialite.vue';
import Login from '../views/Login.vue';
import PopulationHiv from '../components/PopulationHiv.vue';
import Traitement from '../components/Traitement.vue';
import TransmissionMereEnfant from '../components/TransmissionMereEnfant.vue';
import ClusterSwitchNotAllowed from '../components/ClusterSwitchNotAllowed.vue';
import ETLDashboard from '../components/ETLDashboard.vue';
import AccessDenied from '../components/AccessDenied.vue';
import AccessDenied from '../components/AccessDenied.vue';

const routes = [
  { path: '/', component: Home },
  { path: '/graphiques', component: Graphiques },
  { path: '/prediction', component: Prediction },
  { path: '/prediction-graphs',name: 'PredictionGraphs', component: PredictionGraphs},
  // route pour faciliter la scalabilité
  { path: '/data', component: Data },
  { path: '/health-data', name: 'HealthData', component: HealthData }, // Nouvelle route unifiée
  { path: '/etl', name: 'ETL', component: ETLDashboard }, // Nouvel onglet ETL
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
  {
    path: '/access-denied',
    name: 'AccessDenied',
    component: AccessDenied
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

  // Contrôle d'accès basé sur le pays
  const selectedCountry = localStorage.getItem('selectedCountry');
  if (selectedCountry && authRequired) {
    // Détermine le pays de base
    let baseCountry = selectedCountry;
    if (selectedCountry.startsWith('ch_')) {
      baseCountry = 'ch';
    }

    // Définir les pages autorisées par pays
    const allowedPages = {
      'fr': ['/', '/data', '/graphiques', '/prediction', '/etl', '/health-data', '/us-mortalite', '/population-hiv', '/traitement', '/transmission-mere-enfant', '/confidentialite', '/prediction-graphs'],
      'us': ['/data', '/etl', '/health-data', '/us-mortalite', '/population-hiv', '/traitement', '/transmission-mere-enfant'],
      'ch': ['/etl']
    };

    const allowed = allowedPages[baseCountry] || ['/'];
    
    // Vérifier si la route demandée est autorisée
    if (!allowed.includes(to.path) && !publicPages.includes(to.path) && to.path !== '/cluster-switch-not-allowed' && to.path !== '/access-denied') {
      // Rediriger vers la page access-denied avec info sur la première page autorisée
      return next('/access-denied');
    }
  }

  next();
});
export default router;