import { describe, it, expect, beforeEach, vi } from 'vitest'
import { mount } from '@vue/test-utils'
import RGPDConsent from '../src/components/RGPDConsent.vue'

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

// Mock API client
vi.mock('../../services/api.js', () => ({
  default: {
    put: vi.fn()
  }
}))

describe('RGPDConsent', () => {
  let wrapper

  beforeEach(() => {
    vi.clearAllMocks()
    delete window.gtag
    delete window.dataLayer
    delete window.showRGPDConsent
  })

  const createWrapper = () => {
    return mount(RGPDConsent, {
      attachTo: document.body
    })
  }

  it('shows banner for French cluster without consent', () => {
    localStorageMock.getItem.mockImplementation((key) => {
      if (key === 'selectedCountry') return 'fr'
      if (key === 'rgpdConsent') return null
      return null
    })
    
    wrapper = createWrapper()
    expect(wrapper.find('.rgpd-banner').exists()).toBe(true)
  })

  it('does not show banner for non-French cluster', () => {
    localStorageMock.getItem.mockImplementation((key) => {
      if (key === 'selectedCountry') return 'us'
      if (key === 'rgpdConsent') return null
      return null
    })
    
    wrapper = createWrapper()
    expect(wrapper.find('.rgpd-banner').exists()).toBe(false)
  })

  it('does not show banner if consent already given', () => {
    localStorageMock.getItem.mockImplementation((key) => {
      if (key === 'selectedCountry') return 'fr'
      if (key === 'rgpdConsent') return 'accepted'
      return null
    })
    
    wrapper = createWrapper()
    expect(wrapper.find('.rgpd-banner').exists()).toBe(false)
  })

  it('renders accept and decline buttons', () => {
    localStorageMock.getItem.mockImplementation((key) => {
      if (key === 'selectedCountry') return 'fr'
      if (key === 'rgpdConsent') return null
      return null
    })
    
    wrapper = createWrapper()
    const buttons = wrapper.findAll('button')
    expect(buttons).toHaveLength(2)
    expect(buttons[0].text()).toBe('Accepter')
    expect(buttons[1].text()).toBe('Refuser')
  })

  it('handles accept button click', async () => {
    localStorageMock.getItem.mockImplementation((key) => {
      if (key === 'selectedCountry') return 'fr'
      if (key === 'rgpdConsent') return null
      return null
    })
    
    wrapper = createWrapper()
    const acceptButton = wrapper.findAll('button')[0]
    
    await acceptButton.trigger('click')
    
    expect(localStorageMock.setItem).toHaveBeenCalledWith('rgpdConsent', 'accepted')
    expect(wrapper.find('.rgpd-banner').exists()).toBe(false)
  })

  it('handles decline button click', async () => {
    localStorageMock.getItem.mockImplementation((key) => {
      if (key === 'selectedCountry') return 'fr'
      if (key === 'rgpdConsent') return null
      return null
    })
    
    wrapper = createWrapper()
    const declineButton = wrapper.findAll('button')[1]
    
    await declineButton.trigger('click')
    
    expect(localStorageMock.setItem).toHaveBeenCalledWith('rgpdConsent', 'declined')
    expect(wrapper.find('.rgpd-banner').exists()).toBe(false)
  })

  it('creates window.showRGPDConsent function', () => {
    localStorageMock.getItem.mockImplementation((key) => {
      if (key === 'selectedCountry') return 'fr'
      return null
    })
    
    wrapper = createWrapper()
    expect(typeof window.showRGPDConsent).toBe('function')
  })
})
