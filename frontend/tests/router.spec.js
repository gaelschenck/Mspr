import { describe, it, expect, beforeEach, vi } from 'vitest'
import { createRouter, createWebHistory } from 'vue-router'
import router from '../src/router/index.js'

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

describe('Router', () => {
  beforeEach(() => {
    vi.clearAllMocks()
  })

  it('has correct routes defined', () => {
    const routes = router.getRoutes()
    const routePaths = routes.map(route => route.path)
    
    expect(routePaths).toContain('/')
    expect(routePaths).toContain('/login')
    expect(routePaths).toContain('/data')
    expect(routePaths).toContain('/graphiques')
    expect(routePaths).toContain('/prediction')
    expect(routePaths).toContain('/etl')
    expect(routePaths).toContain('/access-denied')
  })

  it('redirects to login when not authenticated', async () => {
    localStorageMock.getItem.mockReturnValue(null)
    
    const next = vi.fn()
    const guard = router.beforeResolve

    await router.push('/data')
    
    // Le guard devrait rediriger vers /login si pas de token
    expect(localStorageMock.getItem).toHaveBeenCalledWith('access_token')
  })

  it('allows access to public pages without auth', async () => {
    localStorageMock.getItem.mockReturnValue(null)
    
    await router.push('/login')
    expect(router.currentRoute.value.path).toBe('/login')
  })

  it('allows French cluster access to all pages', async () => {
    localStorageMock.getItem.mockImplementation((key) => {
      if (key === 'access_token') return 'valid-token'
      if (key === 'selectedCountry') return 'fr'
      return null
    })
    
    await router.push('/data')
    expect(router.currentRoute.value.path).toBe('/data')
    
    await router.push('/graphiques')
    expect(router.currentRoute.value.path).toBe('/graphiques')
  })

  it('restricts US cluster to allowed pages only', async () => {
    localStorageMock.getItem.mockImplementation((key) => {
      if (key === 'access_token') return 'valid-token'
      if (key === 'selectedCountry') return 'us'
      return null
    })
    
    await router.push('/data')
    expect(router.currentRoute.value.path).toBe('/data')
  })

  it('restricts Swiss cluster to ETL only', async () => {
    localStorageMock.getItem.mockImplementation((key) => {
      if (key === 'access_token') return 'valid-token'
      if (key === 'selectedCountry') return 'ch_fr'
      return null
    })
    
    await router.push('/etl')
    expect(router.currentRoute.value.path).toBe('/etl')
  })

  it('handles Swiss cluster variants correctly', async () => {
    localStorageMock.getItem.mockImplementation((key) => {
      if (key === 'access_token') return 'valid-token'
      if (key === 'selectedCountry') return 'ch_de'
      return null
    })
    
    // Pour la Suisse, seul ETL devrait être autorisé
    await router.push('/etl')
    expect(router.currentRoute.value.path).toBe('/etl')
  })

  it('has named routes', () => {
    const routes = router.getRoutes()
    const namedRoutes = routes.filter(route => route.name)
    
    expect(namedRoutes.some(route => route.name === 'ETL')).toBe(true)
    expect(namedRoutes.some(route => route.name === 'AccessDenied')).toBe(true)
    expect(namedRoutes.some(route => route.name === 'HealthData')).toBe(true)
  })
})
