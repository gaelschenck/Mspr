import { describe, it, expect, beforeEach, vi } from 'vitest'
import { mount } from '@vue/test-utils'
import { createI18n } from 'vue-i18n'
import Footer from '../src/components/Footer.vue'

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

// Mock window.showRGPDConsent
Object.defineProperty(window, 'showRGPDConsent', {
  value: vi.fn(),
  writable: true
})

// Configuration i18n simplifiée
const i18n = createI18n({
  legacy: false,
  locale: 'fr',
  messages: {
    fr: {
      footer_title: 'Données de Santé',
      footer_rights: 'Tous droits réservés',
      cookies: 'Cookies',
      privacy_policy: 'Politique de confidentialité'
    }
  }
})

describe('Footer (Simple)', () => {
  let wrapper

  beforeEach(() => {
    vi.clearAllMocks()
    localStorageMock.getItem.mockReturnValue(null)
  })

  const createWrapper = () => {
    return mount(Footer, {
      global: {
        plugins: [i18n],
        stubs: {
          'router-link': {
            template: '<a><slot /></a>',
            props: ['to']
          }
        }
      }
    })
  }

  it('renders footer element', () => {
    wrapper = createWrapper()
    
    expect(wrapper.find('footer').exists()).toBe(true)
    expect(wrapper.find('.footer').exists()).toBe(true)
  })

  it('displays copyright text', () => {
    wrapper = createWrapper()
    
    expect(wrapper.text()).toContain('2025')
    expect(wrapper.text()).toContain('Données de Santé')
    expect(wrapper.text()).toContain('Tous droits réservés')
  })

  it('computes isFrenchCluster correctly', () => {
    localStorageMock.getItem.mockReturnValue('fr')
    wrapper = createWrapper()
    
    expect(wrapper.vm.isFrenchCluster).toBe(true)
    
    localStorageMock.getItem.mockReturnValue('us')
    wrapper = createWrapper()
    
    expect(wrapper.vm.isFrenchCluster).toBe(false)
  })

  it('shows RGPD elements for French cluster', async () => {
    localStorageMock.getItem.mockReturnValue('fr')
    wrapper = createWrapper()
    
    await wrapper.vm.$nextTick()
    
    const cookiesLink = wrapper.find('a[href="#"]')
    expect(cookiesLink.exists()).toBe(true)
    expect(cookiesLink.text()).toBe('Cookies')
  })

  it('handles cookies click when showRGPDConsent exists', async () => {
    localStorageMock.getItem.mockReturnValue('fr')
    window.showRGPDConsent = vi.fn()
    wrapper = createWrapper()
    
    await wrapper.vm.$nextTick()
    
    const cookiesLink = wrapper.find('a[href="#"]')
    await cookiesLink.trigger('click')
    
    expect(window.showRGPDConsent).toHaveBeenCalled()
  })

  it('shows alert when showRGPDConsent not available', async () => {
    localStorageMock.getItem.mockReturnValue('fr')
    window.showRGPDConsent = undefined
    const alertSpy = vi.spyOn(window, 'alert').mockImplementation(() => {})
    wrapper = createWrapper()
    
    await wrapper.vm.$nextTick()
    
    wrapper.vm.showCookies()
    
    expect(alertSpy).toHaveBeenCalledWith('Fonctionnalité de gestion des cookies à venir.')
    
    alertSpy.mockRestore()
  })
})
