// vitest.setup.js
import { vi } from 'vitest'

// Mock crypto.getRandomValues pour les tests
Object.defineProperty(global, 'crypto', {
  value: {
    getRandomValues: vi.fn(() => new Uint32Array(10))
  }
})

// Mock localStorage avec un vrai stockage
const localStorageMock = (() => {
  let store = {}
  return {
    getItem: vi.fn((key) => store[key] || null),
    setItem: vi.fn((key, value) => {
      store[key] = value.toString()
    }),
    removeItem: vi.fn((key) => {
      delete store[key]
    }),
    clear: vi.fn(() => {
      store = {}
    }),
  }
})()

Object.defineProperty(window, 'localStorage', {
  value: localStorageMock,
  writable: true,
})

// Mock window.location.reload
Object.defineProperty(window, 'location', {
  value: {
    reload: vi.fn()
  },
  writable: true
})
