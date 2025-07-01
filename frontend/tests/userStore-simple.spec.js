import { describe, it, expect, beforeEach, vi } from 'vitest'
import { setActivePinia, createPinia } from 'pinia'
import { useUserStore } from '../src/stores/userStore'

// Mock localStorage
const localStorageMock = {
  getItem: vi.fn(),
  setItem: vi.fn(),
  removeItem: vi.fn(),
  clear: vi.fn()
}
Object.defineProperty(global, 'localStorage', {
  value: localStorageMock
})

describe('useUserStore (Simple)', () => {
  let store

  beforeEach(() => {
    setActivePinia(createPinia())
    vi.clearAllMocks()
    localStorageMock.getItem.mockReturnValue(null)
    store = useUserStore()
  })

  describe('initialization', () => {
    it('initializes with null username when no token', () => {
      expect(store.username).toBeNull()
    })
  })

  describe('actions', () => {
    it('clearUser removes token and clears username', () => {
      store.username = 'testuser'
      
      store.clearUser()
      
      expect(localStorageMock.removeItem).toHaveBeenCalledWith('access_token')
      expect(store.username).toBeNull()
    })

    it('refreshUser updates username from token', () => {
      const payload = { sub: 'refresheduser' }
      const encodedPayload = btoa(JSON.stringify(payload))
      const mockToken = `header.${encodedPayload}.signature`
      
      localStorageMock.getItem.mockReturnValue(mockToken)
      
      store.refreshUser()
      
      expect(store.username).toBe('refresheduser')
    })

    it('refreshUser sets username to null when no token', () => {
      localStorageMock.getItem.mockReturnValue(null)
      store.username = 'olduser'
      
      store.refreshUser()
      
      expect(store.username).toBeNull()
    })
  })

  describe('error handling', () => {
    it('handles invalid token gracefully', () => {
      localStorageMock.getItem.mockReturnValue('invalid.token')
      
      const newStore = useUserStore()
      expect(newStore.username).toBeNull()
    })

    it('handles token with empty payload', () => {
      const mockToken = 'header..signature'
      
      localStorageMock.getItem.mockReturnValue(mockToken)
      
      const newStore = useUserStore()
      expect(newStore.username).toBeNull()
    })
  })
})
