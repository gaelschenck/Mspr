/**
 * Types et interfaces pour l'API de données de santé
 * Correspondance avec les schémas Pydantic du backend
 */

// === TYPES DE BASE ===

/**
 * Pays/Country
 */
export const CountrySchema = {
  id: 'number',
  name: 'string',
  who_region: 'string|null',
  iso_code: 'string|null',
  created_at: 'string', // ISO date
  updated_at: 'string'  // ISO date
};

/**
 * Type d'indicateur de santé
 */
export const IndicatorTypeSchema = {
  id: 'number',
  name: 'string',
  description: 'string|null',
  unit: 'string|null',
  created_at: 'string' // ISO date
};

/**
 * Indicateur de santé
 */
export const HealthIndicatorSchema = {
  id: 'number',
  country_id: 'number',
  indicator_type_id: 'number',
  year: 'number',
  value_type: 'string',
  value: 'number|null',
  value_text: 'string|null',
  confidence_min: 'number|null',
  confidence_max: 'number|null',
  confidence_median: 'number|null',
  data_quality: 'string',
  source_file: 'string|null',
  raw_value_text: 'string|null',
  created_at: 'string', // ISO date
  updated_at: 'string'  // ISO date
};

/**
 * Indicateur de santé avec relations (version détaillée)
 */
export const HealthIndicatorDetailedSchema = {
  ...HealthIndicatorSchema,
  country: CountrySchema,
  indicator_type: IndicatorTypeSchema
};

// === TYPES POUR LES REQUÊTES ===

/**
 * Paramètres de filtre pour les requêtes de données de santé
 */
export const HealthDataFilters = {
  // Filtres principaux
  country_name: 'string|undefined',
  indicator_name: 'string|undefined',
  who_region: 'string|undefined',
  year: 'number|string|undefined',
  value_type: 'string|undefined',
  
  // Filtres de valeur
  min_value: 'number|undefined',
  max_value: 'number|undefined',
  
  // Pagination
  offset: 'number',
  limit: 'number'
};

/**
 * Paramètres pour les prédictions ML
 */
export const PredictionRequestSchema = {
  region: 'string|null',
  country: 'string|null',
  indicator_type: 'string',
  value_type: 'string|null'
};

/**
 * Réponse de prédiction ML
 */
export const PredictionResponseSchema = {
  prediction: 'number[]',
  labels: 'number[]',
  message: 'string',
  rmse: 'number',
  r2: 'number',
  future_prediction: 'number|null',
  future_year: 'number|null'
};

// === UTILITAIRES POUR LA VALIDATION ===

/**
 * Vérifie si un objet correspond au schéma Country
 */
export function isValidCountry(obj) {
  return obj && 
    typeof obj.id === 'number' &&
    typeof obj.name === 'string' &&
    (obj.who_region === null || typeof obj.who_region === 'string') &&
    (obj.iso_code === null || typeof obj.iso_code === 'string');
}

/**
 * Vérifie si un objet correspond au schéma IndicatorType
 */
export function isValidIndicatorType(obj) {
  return obj && 
    typeof obj.id === 'number' &&
    typeof obj.name === 'string';
}

/**
 * Vérifie si un objet correspond au schéma HealthIndicator
 */
export function isValidHealthIndicator(obj) {
  return obj && 
    typeof obj.id === 'number' &&
    typeof obj.country_id === 'number' &&
    typeof obj.indicator_type_id === 'number' &&
    typeof obj.year === 'number' &&
    typeof obj.value_type === 'string';
}

// === CONSTANTES UTILES ===

/**
 * Régions OMS connues
 */
export const WHO_REGIONS = [
  'Africa',
  'Americas', 
  'South-East Asia',
  'Europe',
  'Eastern Mediterranean',
  'Western Pacific'
];

/**
 * Types de qualité de données
 */
export const DATA_QUALITY_TYPES = [
  'excellent',
  'good',
  'fair',
  'poor',
  'unknown'
];

/**
 * Types de valeurs courants
 */
export const VALUE_TYPES = [
  'estimate',
  'percentage',
  'rate',
  'count',
  'ratio',
  'index'
];

// === EXEMPLE D'USAGE ===

/*
// Exemple d'utilisation dans un composant Vue :

import { 
  HealthDataFilters, 
  isValidHealthIndicator,
  WHO_REGIONS 
} from '../types/healthDataTypes.js';

// Dans votre composant :
const filters = ref({
  country_name: '',
  indicator_name: '',
  who_region: '',
  year: '',
  offset: 0,
  limit: 25
});

// Validation des données reçues de l'API :
const healthData = ref([]);

function validateApiResponse(data) {
  return data.filter(item => isValidHealthIndicator(item));
}

async function loadData() {
  const response = await fetchHealthIndicatorsDetailed(filters.value);
  healthData.value = validateApiResponse(response);
}
*/
