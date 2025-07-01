import { describe, it, expect, beforeEach } from 'vitest'
import { setActivePinia, createPinia } from 'pinia'
import { usePredictionStore } from '../src/stores/predictionStore'

describe('usePredictionStore', () => {
  beforeEach(() => {
    setActivePinia(createPinia())
  })

  describe('initial state', () => {
    it('initializes with null result', () => {
      const store = usePredictionStore()
      expect(store.result).toBeNull()
    })
  })

  describe('setResult action', () => {
    it('sets result data', () => {
      const store = usePredictionStore()
      const testData = {
        prediction: 123.45,
        confidence: 0.85,
        timestamp: '2025-01-01T00:00:00Z'
      }
      
      store.setResult(testData)
      
      expect(store.result).toEqual(testData)
    })

    it('overwrites previous result', () => {
      const store = usePredictionStore()
      const firstData = { prediction: 100 }
      const secondData = { prediction: 200 }
      
      store.setResult(firstData)
      expect(store.result).toEqual(firstData)
      
      store.setResult(secondData)
      expect(store.result).toEqual(secondData)
    })

    it('accepts null as result', () => {
      const store = usePredictionStore()
      store.setResult({ prediction: 100 })
      
      store.setResult(null)
      
      expect(store.result).toBeNull()
    })

    it('accepts undefined as result', () => {
      const store = usePredictionStore()
      store.setResult({ prediction: 100 })
      
      store.setResult(undefined)
      
      expect(store.result).toBeUndefined()
    })

    it('accepts complex objects', () => {
      const store = usePredictionStore()
      const complexData = {
        prediction: {
          value: 123.45,
          unit: 'percentage'
        },
        metadata: {
          model: 'randomforest',
          version: '1.0.0',
          features: ['age', 'gender', 'location']
        },
        confidence: {
          score: 0.85,
          interval: [0.75, 0.95]
        }
      }
      
      store.setResult(complexData)
      
      expect(store.result).toEqual(complexData)
    })

    it('accepts arrays', () => {
      const store = usePredictionStore()
      const arrayData = [
        { prediction: 100, confidence: 0.8 },
        { prediction: 200, confidence: 0.9 }
      ]
      
      store.setResult(arrayData)
      
      expect(store.result).toEqual(arrayData)
    })
  })

  describe('clearResult action', () => {
    it('clears result data', () => {
      const store = usePredictionStore()
      store.setResult({ prediction: 123.45 })
      
      store.clearResult()
      
      expect(store.result).toBeNull()
    })

    it('clears result when already null', () => {
      const store = usePredictionStore()
      expect(store.result).toBeNull()
      
      store.clearResult()
      
      expect(store.result).toBeNull()
    })
  })

  describe('state persistence', () => {
    it('maintains state between actions', () => {
      const store = usePredictionStore()
      const testData = { prediction: 456.78 }
      
      store.setResult(testData)
      expect(store.result).toEqual(testData)
      
      // State should persist
      expect(store.result).toEqual(testData)
    })

    it('handles multiple store instances correctly', () => {
      const store1 = usePredictionStore()
      const store2 = usePredictionStore()
      
      // Should be the same instance (singleton)
      expect(store1).toBe(store2)
      
      store1.setResult({ prediction: 100 })
      expect(store2.result).toEqual({ prediction: 100 })
    })
  })

  describe('reactive state', () => {
    it('is reactive to changes', () => {
      const store = usePredictionStore()
      let reactiveValue = null
      
      // Simulate reactive dependency
      const updateReactiveValue = () => {
        reactiveValue = store.result
      }
      
      updateReactiveValue()
      expect(reactiveValue).toBeNull()
      
      store.setResult({ prediction: 789 })
      updateReactiveValue()
      expect(reactiveValue).toEqual({ prediction: 789 })
      
      store.clearResult()
      updateReactiveValue()
      expect(reactiveValue).toBeNull()
    })
  })

  describe('error handling', () => {
    it('handles setting result with primitive values', () => {
      const store = usePredictionStore()
      
      store.setResult(42)
      expect(store.result).toBe(42)
      
      store.setResult('string result')
      expect(store.result).toBe('string result')
      
      store.setResult(true)
      expect(store.result).toBe(true)
    })

    it('handles circular references gracefully', () => {
      const store = usePredictionStore()
      const circularObj = { name: 'test' }
      circularObj.self = circularObj
      
      // Should not throw error
      expect(() => store.setResult(circularObj)).not.toThrow()
      expect(store.result).toStrictEqual(circularObj)
    })
  })
})
