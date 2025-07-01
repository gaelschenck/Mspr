import { describe, it, expect, beforeEach, vi } from 'vitest'

// Mock localStorage
const localStorageMock = {
  getItem: vi.fn(() => 'fr'),
  setItem: vi.fn(),
  removeItem: vi.fn(),
  clear: vi.fn()
}
Object.defineProperty(window, 'localStorage', {
  value: localStorageMock
})

// Mock window.location
Object.defineProperty(window, 'location', {
  value: {
    hostname: 'localhost',
    port: '8080'
  }
})

// Create a mock axios instance that can be called as a function
const mockAxiosInstance = vi.fn((config) => {
  // Default behavior based on method
  if (config.method?.toLowerCase() === 'post') {
    return mockAxiosInstance.post(config.url, config.data)
  } else {
    return mockAxiosInstance.get(config.url, config.params ? { params: config.params } : undefined)
  }
})

// Add method properties to the function
mockAxiosInstance.get = vi.fn()
mockAxiosInstance.post = vi.fn()
mockAxiosInstance.put = vi.fn()
mockAxiosInstance.delete = vi.fn()
mockAxiosInstance.interceptors = {
  request: {
    use: vi.fn()
  }
}

// Mock axios
vi.mock('axios', () => ({
  default: {
    create: vi.fn(() => mockAxiosInstance)
  }
}))

describe('API Service', () => {
  beforeEach(() => {
    vi.clearAllMocks()
    localStorageMock.getItem.mockReturnValue('fr')
  })

  it('should mock axios correctly', () => {
    // Test simple pour vérifier que le mock fonctionne
    expect(mockAxiosInstance).toBeDefined()
    expect(mockAxiosInstance.get).toBeDefined()
  })

  describe('fetchFromAPI', () => {
    it('should handle successful GET request', async () => {
      // Import après les mocks
      const { fetchFromAPI } = await import('../services/api.js')
      
      mockAxiosInstance.mockResolvedValue({
        data: { test: 'data' }
      })

      const result = await fetchFromAPI('/test-endpoint')
      expect(result).toEqual({ test: 'data' })
    })

    it('should handle POST request with data', async () => {
      const { fetchFromAPI } = await import('../services/api.js')
      
      mockAxiosInstance.mockResolvedValue({
        data: { success: true }
      })

      const result = await fetchFromAPI('/test-endpoint', {
        method: 'POST',
        data: { test: 'data' }
      })
      
      expect(result).toEqual({ success: true })
    })
  })

  describe('fetchCountries', () => {
    it('should fetch countries with pagination', async () => {
      const { fetchCountries } = await import('../services/api.js')
      
      mockAxiosInstance.get.mockResolvedValue({
        data: [{ id: 1, name: 'France' }]
      })

      const result = await fetchCountries(0, 10)
      expect(result).toEqual([{ id: 1, name: 'France' }])
    })
  })

  describe('fetchIndicatorTypes', () => {
    it('should fetch indicator types', async () => {
      const { fetchIndicatorTypes } = await import('../services/api.js')
      
      mockAxiosInstance.get.mockResolvedValue({
        data: [{ id: 1, type: 'health' }]
      })

      const result = await fetchIndicatorTypes()
      expect(result).toEqual([{ id: 1, type: 'health' }])
    })
  })

  describe('fetchHealthIndicators', () => {
    it('should fetch health indicators with filters', async () => {
      const { fetchHealthIndicators } = await import('../services/api.js')
      
      mockAxiosInstance.get.mockResolvedValue({
        data: [{ id: 1, indicator: 'mortality' }]
      })

      const result = await fetchHealthIndicators({ country: 'fr' })
      expect(result).toEqual([{ id: 1, indicator: 'mortality' }])
    })
  })

  describe('Error handling', () => {
    it('should handle API errors', async () => {
      const { fetchFromAPI } = await import('../services/api.js')
      
      mockAxiosInstance.mockRejectedValue(new Error('Network error'))

      await expect(fetchFromAPI('/test-endpoint')).rejects.toThrow('Network error')
    })
  })
})
