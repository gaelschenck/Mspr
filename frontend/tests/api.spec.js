import { describe, it, expect, beforeEach, vi } from 'vitest'
import axios from 'axios'
import apiClient, { fetchFromAPI, fetchCountries, fetchIndicatorTypes, fetchHealthIndicators } from '../services/api.js'

// Mock axios
vi.mock('axios')
const mockedAxios = vi.mocked(axios)

// Mock localStorage
const localStorageMock = {
  getItem: vi.fn(),
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

describe('API Service', () => {
  const mockApiClient = {
    get: vi.fn(),
    post: vi.fn(),
    put: vi.fn(),
    delete: vi.fn(),
    interceptors: {
      request: {
        use: vi.fn()
      }
    }
  }

  beforeEach(() => {
    vi.clearAllMocks()
    mockedAxios.create.mockReturnValue(mockApiClient)
    localStorageMock.getItem.mockReturnValue('fr')
  })

  it('creates axios instance with correct base URL for France', () => {
    localStorageMock.getItem.mockReturnValue('fr')
    
    // Re-import pour trigger la création
    vi.resetModules()
    
    expect(mockedAxios.create).toHaveBeenCalledWith({
      baseURL: 'http://localhost:8080/api/fr/',
      headers: {
        'Content-Type': 'application/json'
      }
    })
  })

  it('creates correct base URL for US', () => {
    localStorageMock.getItem.mockReturnValue('us')
    
    vi.resetModules()
    
    expect(mockedAxios.create).toHaveBeenCalledWith({
      baseURL: 'http://localhost:8080/api/us/',
      headers: {
        'Content-Type': 'application/json'
      }
    })
  })

  it('creates correct base URL for Swiss languages', () => {
    localStorageMock.getItem.mockReturnValue('ch_fr')
    
    vi.resetModules()
    
    expect(mockedAxios.create).toHaveBeenCalledWith({
      baseURL: 'http://localhost:8080/api/ch/fr/',
      headers: {
        'Content-Type': 'application/json'
      }
    })
  })

  it('sets up request interceptor for authorization', () => {
    expect(mockApiClient.interceptors.request.use).toHaveBeenCalled()
  })

  describe('fetchFromAPI', () => {
    it('makes GET request by default', async () => {
      mockApiClient.mockResolvedValue({ data: { test: 'data' } })
      
      const result = await fetchFromAPI('/test')
      
      expect(mockApiClient).toHaveBeenCalledWith({
        method: 'GET',
        url: '/test'
      })
      expect(result).toEqual({ test: 'data' })
    })

    it('makes POST request with data', async () => {
      mockApiClient.mockResolvedValue({ data: { success: true } })
      
      const postData = { name: 'test' }
      await fetchFromAPI('/test', { method: 'POST', data: postData })
      
      expect(mockApiClient).toHaveBeenCalledWith({
        method: 'POST',
        url: '/test',
        data: postData
      })
    })
  })

  describe('fetchCountries', () => {
    it('fetches countries with pagination', async () => {
      const mockResponse = { data: [{ id: 1, name: 'France' }] }
      mockApiClient.get.mockResolvedValue(mockResponse)
      
      const result = await fetchCountries(0, 10)
      
      expect(mockApiClient.get).toHaveBeenCalledWith('/countries/paginated/', {
        params: { offset: 0, limit: 10 }
      })
      expect(result).toEqual([{ id: 1, name: 'France' }])
    })

    it('uses default pagination values', async () => {
      const mockResponse = { data: [] }
      mockApiClient.get.mockResolvedValue(mockResponse)
      
      await fetchCountries()
      
      expect(mockApiClient.get).toHaveBeenCalledWith('/countries/paginated/', {
        params: { offset: 0, limit: 25 }
      })
    })
  })

  describe('fetchIndicatorTypes', () => {
    it('fetches indicator types', async () => {
      const mockResponse = { data: [{ id: 1, name: 'Mortality' }] }
      mockApiClient.get.mockResolvedValue(mockResponse)
      
      const result = await fetchIndicatorTypes()
      
      expect(mockApiClient.get).toHaveBeenCalledWith('/indicator-types/')
      expect(result).toEqual([{ id: 1, name: 'Mortality' }])
    })
  })

  describe('fetchHealthIndicators', () => {
    it('fetches health indicators with filters', async () => {
      const mockResponse = { data: [{ id: 1, indicator: 'Test' }] }
      mockApiClient.get.mockResolvedValue(mockResponse)
      
      const filters = { country: 'France' }
      const result = await fetchHealthIndicators(0, 20, filters)
      
      expect(mockApiClient.get).toHaveBeenCalledWith('/health-indicators/paginated/', {
        params: { offset: 0, limit: 20, country: 'France' }
      })
      expect(result).toEqual([{ id: 1, indicator: 'Test' }])
    })
  })

  describe('Error handling', () => {
    it('handles API errors in fetchCountries', async () => {
      const error = new Error('Network Error')
      mockApiClient.get.mockRejectedValue(error)
      
      await expect(fetchCountries()).rejects.toThrow('Network Error')
    })

    it('handles API errors in fetchFromAPI', async () => {
      const error = new Error('API Error')
      mockApiClient.mockRejectedValue(error)
      
      await expect(fetchFromAPI('/test')).rejects.toThrow('API Error')
    })
  })
})
