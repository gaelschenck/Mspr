import { describe, it, expect } from 'vitest'
import {
  CountrySchema,
  IndicatorTypeSchema,
  HealthIndicatorSchema,
  HealthIndicatorDetailedSchema,
  HealthDataFilters,
  PredictionRequestSchema,
  PredictionResponseSchema,
  isValidCountry,
  isValidIndicatorType,
  isValidHealthIndicator,
  WHO_REGIONS,
  DATA_QUALITY_TYPES,
  VALUE_TYPES
} from '../src/types/healthDataTypes.js'

describe('healthDataTypes.js', () => {
  
  describe('Schema Definitions', () => {
    it('should have correct CountrySchema structure', () => {
      expect(CountrySchema).toEqual({
        id: 'number',
        name: 'string',
        who_region: 'string|null',
        iso_code: 'string|null',
        created_at: 'string',
        updated_at: 'string'
      })
    })

    it('should have correct IndicatorTypeSchema structure', () => {
      expect(IndicatorTypeSchema).toEqual({
        id: 'number',
        name: 'string',
        description: 'string|null',
        unit: 'string|null',
        created_at: 'string'
      })
    })

    it('should have correct HealthIndicatorSchema structure', () => {
      expect(HealthIndicatorSchema).toHaveProperty('id', 'number')
      expect(HealthIndicatorSchema).toHaveProperty('country_id', 'number')
      expect(HealthIndicatorSchema).toHaveProperty('indicator_type_id', 'number')
      expect(HealthIndicatorSchema).toHaveProperty('year', 'number')
      expect(HealthIndicatorSchema).toHaveProperty('value_type', 'string')
      expect(HealthIndicatorSchema).toHaveProperty('value', 'number|null')
      expect(HealthIndicatorSchema).toHaveProperty('created_at', 'string')
      expect(HealthIndicatorSchema).toHaveProperty('updated_at', 'string')
    })

    it('should have HealthIndicatorDetailedSchema extending HealthIndicatorSchema', () => {
      expect(HealthIndicatorDetailedSchema).toHaveProperty('id', 'number')
      expect(HealthIndicatorDetailedSchema).toHaveProperty('country')
      expect(HealthIndicatorDetailedSchema).toHaveProperty('indicator_type')
      expect(HealthIndicatorDetailedSchema.country).toEqual(CountrySchema)
      expect(HealthIndicatorDetailedSchema.indicator_type).toEqual(IndicatorTypeSchema)
    })
  })

  describe('Filter and Request Schemas', () => {
    it('should have correct HealthDataFilters structure', () => {
      expect(HealthDataFilters).toEqual({
        country_name: 'string|undefined',
        indicator_name: 'string|undefined',
        who_region: 'string|undefined',
        year: 'number|string|undefined',
        value_type: 'string|undefined',
        min_value: 'number|undefined',
        max_value: 'number|undefined',
        offset: 'number',
        limit: 'number'
      })
    })

    it('should have correct PredictionRequestSchema structure', () => {
      expect(PredictionRequestSchema).toEqual({
        region: 'string|null',
        country: 'string|null',
        indicator_type: 'string',
        value_type: 'string|null'
      })
    })

    it('should have correct PredictionResponseSchema structure', () => {
      expect(PredictionResponseSchema).toEqual({
        prediction: 'number[]',
        labels: 'number[]',
        message: 'string',
        rmse: 'number',
        r2: 'number',
        future_prediction: 'number|null',
        future_year: 'number|null'
      })
    })
  })

  describe('Validation Functions', () => {
    describe('isValidCountry', () => {
      it('should return true for valid country object', () => {
        const validCountry = {
          id: 1,
          name: 'France',
          who_region: 'Europe',
          iso_code: 'FR',
          created_at: '2023-01-01T00:00:00Z',
          updated_at: '2023-01-01T00:00:00Z'
        }
        expect(isValidCountry(validCountry)).toBe(true)
      })

      it('should return true for valid country with null optional fields', () => {
        const validCountry = {
          id: 2,
          name: 'Unknown Country',
          who_region: null,
          iso_code: null,
          created_at: '2023-01-01T00:00:00Z',
          updated_at: '2023-01-01T00:00:00Z'
        }
        expect(isValidCountry(validCountry)).toBe(true)
      })

      it('should return false for invalid country object - missing required fields', () => {
        const invalidCountry = {
          name: 'France'
          // missing id
        }
        expect(isValidCountry(invalidCountry)).toBe(false)
      })

      it('should return false for invalid country object - wrong types', () => {
        const invalidCountry = {
          id: '1', // should be number
          name: 'France',
          who_region: 'Europe',
          iso_code: 'FR'
        }
        expect(isValidCountry(invalidCountry)).toBe(false)
      })

      it('should return falsy value for null or undefined', () => {
        expect(isValidCountry(null)).toBeFalsy()
        expect(isValidCountry(undefined)).toBeFalsy()
        expect(isValidCountry({})).toBeFalsy()
      })
    })

    describe('isValidIndicatorType', () => {
      it('should return true for valid indicator type object', () => {
        const validIndicatorType = {
          id: 1,
          name: 'HIV Prevalence',
          description: 'HIV prevalence rate',
          unit: 'percentage',
          created_at: '2023-01-01T00:00:00Z'
        }
        expect(isValidIndicatorType(validIndicatorType)).toBe(true)
      })

      it('should return true for valid indicator type with minimal fields', () => {
        const validIndicatorType = {
          id: 2,
          name: 'Mortality Rate'
        }
        expect(isValidIndicatorType(validIndicatorType)).toBe(true)
      })

      it('should return false for invalid indicator type - missing required fields', () => {
        const invalidIndicatorType = {
          id: 1
          // missing name
        }
        expect(isValidIndicatorType(invalidIndicatorType)).toBe(false)
      })

      it('should return false for invalid indicator type - wrong types', () => {
        const invalidIndicatorType = {
          id: '1', // should be number
          name: 'HIV Prevalence'
        }
        expect(isValidIndicatorType(invalidIndicatorType)).toBe(false)
      })

      it('should return falsy value for null or undefined', () => {
        expect(isValidIndicatorType(null)).toBeFalsy()
        expect(isValidIndicatorType(undefined)).toBeFalsy()
        expect(isValidIndicatorType({})).toBeFalsy()
      })
    })

    describe('isValidHealthIndicator', () => {
      it('should return true for valid health indicator object', () => {
        const validHealthIndicator = {
          id: 1,
          country_id: 1,
          indicator_type_id: 1,
          year: 2020,
          value_type: 'estimate',
          value: 5.5,
          value_text: null,
          confidence_min: 4.0,
          confidence_max: 7.0,
          confidence_median: 5.5,
          data_quality: 'good',
          source_file: 'data.csv',
          raw_value_text: '5.5%',
          created_at: '2023-01-01T00:00:00Z',
          updated_at: '2023-01-01T00:00:00Z'
        }
        expect(isValidHealthIndicator(validHealthIndicator)).toBe(true)
      })

      it('should return true for valid health indicator with minimal fields', () => {
        const validHealthIndicator = {
          id: 2,
          country_id: 2,
          indicator_type_id: 2,
          year: 2021,
          value_type: 'percentage'
        }
        expect(isValidHealthIndicator(validHealthIndicator)).toBe(true)
      })

      it('should return false for invalid health indicator - missing required fields', () => {
        const invalidHealthIndicator = {
          id: 1,
          country_id: 1
          // missing indicator_type_id, year, value_type
        }
        expect(isValidHealthIndicator(invalidHealthIndicator)).toBe(false)
      })

      it('should return false for invalid health indicator - wrong types', () => {
        const invalidHealthIndicator = {
          id: 1,
          country_id: '1', // should be number
          indicator_type_id: 1,
          year: 2020,
          value_type: 'estimate'
        }
        expect(isValidHealthIndicator(invalidHealthIndicator)).toBe(false)
      })

      it('should return falsy value for null or undefined', () => {
        expect(isValidHealthIndicator(null)).toBeFalsy()
        expect(isValidHealthIndicator(undefined)).toBeFalsy()
        expect(isValidHealthIndicator({})).toBeFalsy()
      })
    })
  })

  describe('Constants', () => {
    describe('WHO_REGIONS', () => {
      it('should contain all expected WHO regions', () => {
        expect(WHO_REGIONS).toEqual([
          'Africa',
          'Americas', 
          'South-East Asia',
          'Europe',
          'Eastern Mediterranean',
          'Western Pacific'
        ])
      })

      it('should contain exactly 6 regions', () => {
        expect(WHO_REGIONS).toHaveLength(6)
      })

      it('should contain only strings', () => {
        WHO_REGIONS.forEach(region => {
          expect(typeof region).toBe('string')
          expect(region.length).toBeGreaterThan(0)
        })
      })
    })

    describe('DATA_QUALITY_TYPES', () => {
      it('should contain all expected data quality types', () => {
        expect(DATA_QUALITY_TYPES).toEqual([
          'excellent',
          'good',
          'fair',
          'poor',
          'unknown'
        ])
      })

      it('should contain exactly 5 quality types', () => {
        expect(DATA_QUALITY_TYPES).toHaveLength(5)
      })

      it('should contain only strings', () => {
        DATA_QUALITY_TYPES.forEach(quality => {
          expect(typeof quality).toBe('string')
          expect(quality.length).toBeGreaterThan(0)
        })
      })
    })

    describe('VALUE_TYPES', () => {
      it('should contain all expected value types', () => {
        expect(VALUE_TYPES).toEqual([
          'estimate',
          'percentage',
          'rate',
          'count',
          'ratio',
          'index'
        ])
      })

      it('should contain exactly 6 value types', () => {
        expect(VALUE_TYPES).toHaveLength(6)
      })

      it('should contain only strings', () => {
        VALUE_TYPES.forEach(valueType => {
          expect(typeof valueType).toBe('string')
          expect(valueType.length).toBeGreaterThan(0)
        })
      })
    })
  })

  describe('Edge Cases and Integration', () => {
    it('should handle complex validation scenarios', () => {
      // Test d'objets avec des propriétés supplémentaires
      const countryWithExtraProps = {
        id: 1,
        name: 'France',
        who_region: 'Europe',
        iso_code: 'FR',
        extraProp: 'should not affect validation'
      }
      expect(isValidCountry(countryWithExtraProps)).toBe(true)
    })

    it('should handle arrays and objects as invalid inputs', () => {
      expect(isValidCountry([])).toBeFalsy()
      expect(isValidIndicatorType([])).toBeFalsy()
      expect(isValidHealthIndicator([])).toBeFalsy()
      
      expect(isValidCountry('string')).toBeFalsy()
      expect(isValidIndicatorType(123)).toBeFalsy()
      expect(isValidHealthIndicator(true)).toBeFalsy()
    })

    it('should validate WHO_REGIONS contains standard WHO regions', () => {
      const standardRegions = ['Africa', 'Americas', 'Europe']
      standardRegions.forEach(region => {
        expect(WHO_REGIONS).toContain(region)
      })
    })

    it('should validate VALUE_TYPES contains common statistical types', () => {
      const commonTypes = ['estimate', 'percentage', 'rate', 'count']
      commonTypes.forEach(type => {
        expect(VALUE_TYPES).toContain(type)
      })
    })
  })

  describe('Type Consistency', () => {
    it('should have consistent schema field naming conventions', () => {
      // Vérifier que les champs suivent les conventions snake_case
      Object.keys(HealthIndicatorSchema).forEach(key => {
        expect(key).toMatch(/^[a-z][a-z0-9_]*$/)
      })
    })

    it('should have all schemas as objects', () => {
      expect(typeof CountrySchema).toBe('object')
      expect(typeof IndicatorTypeSchema).toBe('object')
      expect(typeof HealthIndicatorSchema).toBe('object')
      expect(typeof HealthDataFilters).toBe('object')
      expect(typeof PredictionRequestSchema).toBe('object')
      expect(typeof PredictionResponseSchema).toBe('object')
    })

    it('should have all validation functions as functions', () => {
      expect(typeof isValidCountry).toBe('function')
      expect(typeof isValidIndicatorType).toBe('function')
      expect(typeof isValidHealthIndicator).toBe('function')
    })

    it('should have all constants as arrays', () => {
      expect(Array.isArray(WHO_REGIONS)).toBe(true)
      expect(Array.isArray(DATA_QUALITY_TYPES)).toBe(true)
      expect(Array.isArray(VALUE_TYPES)).toBe(true)
    })
  })
})
