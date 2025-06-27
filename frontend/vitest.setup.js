// vitest.setup.js
import { vi } from 'vitest'

// Mock crypto.getRandomValues pour les tests
Object.defineProperty(global, 'crypto', {
  value: {
    getRandomValues: vi.fn(() => new Uint32Array(10))
  }
})

// Mock localStorage
Object.defineProperty(window, 'localStorage', {
  value: {
    getItem: vi.fn(),
    setItem: vi.fn(),
    removeItem: vi.fn(),
    clear: vi.fn(),
  },
  writable: true,
})

// Mock window.location.reload
Object.defineProperty(window, 'location', {
  value: {
    reload: vi.fn()
  },
  writable: true
})
