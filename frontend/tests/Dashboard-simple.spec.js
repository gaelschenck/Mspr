import { describe, it, expect, beforeEach, vi } from 'vitest'
import { mount } from '@vue/test-utils'
import { createI18n } from 'vue-i18n'
import Dashboard from '../src/components/Dashboard.vue'

// Mock du service API
const mockApiClient = {
  get: vi.fn()
}

vi.mock('../../services/api.js', () => ({
  default: mockApiClient
}))

// Configuration i18n simplifiée
const i18n = createI18n({
  legacy: false,
  locale: 'fr',
  messages: {
    fr: {
      dashboard_title: 'Tableau de bord',
      dashboard_loading: 'Chargement...',
      dashboard_error: 'Erreur lors du chargement',
      dashboard_retry: 'Réessayer',
      dashboard_no_data: 'Aucune donnée disponible'
    }
  }
})

describe('Dashboard (Simple)', () => {
  let wrapper

  beforeEach(() => {
    vi.clearAllMocks()
    mockApiClient.get.mockResolvedValue({ data: [] })
  })

  const createWrapper = () => {
    return mount(Dashboard, {
      global: {
        plugins: [i18n]
      }
    })
  }

  it('renders dashboard title', () => {
    wrapper = createWrapper()
    
    expect(wrapper.find('h1').text()).toBe('Tableau de bord')
  })

  it('has loading, error and items state', () => {
    wrapper = createWrapper()
    
    // Vérifie que les états sont bien définis (les refs sont accessibles via wrapper.vm)
    expect(wrapper.vm.loading).toBeDefined()
    expect(wrapper.vm.error).toBeDefined()
    expect(wrapper.vm.items).toBeDefined()
  })

  it('shows loading message when loading', async () => {
    mockApiClient.get.mockImplementation(() => new Promise(() => {})) // Never resolves
    wrapper = createWrapper()
    
    expect(wrapper.find('.loading-message').text()).toBe('Chargement...')
  })

  it('has proper structure for dashboard container', () => {
    wrapper = createWrapper()
    
    expect(wrapper.find('.dashboard-container').exists()).toBe(true)
    expect(wrapper.find('h1').exists()).toBe(true)
  })

  it('uses correct translations', () => {
    wrapper = createWrapper()
    
    expect(wrapper.text()).toContain('Tableau de bord')
    expect(wrapper.text()).toContain('Chargement...')
  })
})
