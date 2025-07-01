import { describe, it, expect, beforeEach, vi } from 'vitest'
import { mount } from '@vue/test-utils'
import { createI18n } from 'vue-i18n'
import AccessDenied from '../src/components/AccessDenied.vue'

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

// Mock router
const mockRouter = {
  go: vi.fn()
}

// Configuration i18n
const i18n = createI18n({
  legacy: false,
  locale: 'fr',
  messages: {
    fr: {
      access_denied_title: 'Accès non autorisé',
      current_cluster: 'Cluster actuel',
      available_features: 'Fonctionnalités disponibles',
      go_to_dashboard: 'Aller au tableau de bord',
      go_back: 'Retour',
      nav_home: 'Accueil',
      nav_data: 'Données',
      nav_charts: 'Graphiques',
      nav_prediction: 'Prédiction',
      nav_etl: 'ETL',
      access_message_fr: 'Message FR',
      access_message_us: 'Message US',
      access_message_ch: 'Message CH',
      access_message_default: 'Message par défaut'
    }
  }
})

describe('AccessDenied', () => {
  let wrapper

  beforeEach(() => {
    vi.clearAllMocks()
  })

  const createWrapper = () => {
    return mount(AccessDenied, {
      global: {
        plugins: [i18n],
        mocks: {
          $router: mockRouter
        },
        stubs: {
          'router-link': {
            template: '<a><slot /></a>',
            props: ['to']
          }
        }
      }
    })
  }

  it('renders component correctly', () => {
    localStorageMock.getItem.mockReturnValue('fr')
    wrapper = createWrapper()
    
    expect(wrapper.find('.access-denied-container').exists()).toBe(true)
    expect(wrapper.find('h1').text()).toBe('Accès non autorisé')
  })

  it('displays correct country for France', () => {
    localStorageMock.getItem.mockReturnValue('fr')
    wrapper = createWrapper()
    
    expect(wrapper.vm.displayCountry).toBe('France')
    expect(wrapper.vm.baseCountry).toBe('fr')
  })

  it('displays correct country for US', () => {
    localStorageMock.getItem.mockReturnValue('us')
    wrapper = createWrapper()
    
    expect(wrapper.vm.displayCountry).toBe('USA')
    expect(wrapper.vm.baseCountry).toBe('us')
  })

  it('displays correct country for Switzerland', () => {
    localStorageMock.getItem.mockReturnValue('ch_fr')
    wrapper = createWrapper()
    
    expect(wrapper.vm.displayCountry).toBe('Suisse')
    expect(wrapper.vm.baseCountry).toBe('ch')
  })

  it('returns correct available features for France', () => {
    localStorageMock.getItem.mockReturnValue('fr')
    wrapper = createWrapper()
    
    const features = wrapper.vm.availableFeatures
    expect(features).toContain('Accueil')
    expect(features).toContain('Données')
    expect(features.length).toBe(5)
  })

  it('returns correct default route for each country', () => {
    localStorageMock.getItem.mockReturnValue('fr')
    wrapper = createWrapper()
    expect(wrapper.vm.getDefaultRoute()).toBe('/')

    localStorageMock.getItem.mockReturnValue('us')
    wrapper = createWrapper()
    expect(wrapper.vm.getDefaultRoute()).toBe('/data')
  })

  it('calls router go back on goBack method', () => {
    localStorageMock.getItem.mockReturnValue('fr')
    wrapper = createWrapper()
    
    wrapper.vm.goBack()
    expect(mockRouter.go).toHaveBeenCalledWith(-1)
  })

  it('handles null selectedCountry', () => {
    localStorageMock.getItem.mockReturnValue(null)
    wrapper = createWrapper()
    
    expect(wrapper.vm.displayCountry).toBe('')
    expect(wrapper.vm.baseCountry).toBe(null)
  })
})
