import { describe, it, expect, beforeEach, vi } from 'vitest'
import { mount } from '@vue/test-utils'
import { createI18n } from 'vue-i18n'
import { createPinia } from 'pinia'
import ClusterSwitchNotAllowed from '../src/components/ClusterSwitchNotAllowed.vue'

// Mock useRouter
const mockRouter = {
  push: vi.fn(),
  back: vi.fn()
}

// Mock vue-router
vi.mock('vue-router', () => ({
  useRouter: () => mockRouter
}))

// Mock userStore
const mockUserStore = {
  clearUser: vi.fn()
}
vi.mock('../src/stores/userStore', () => ({
  useUserStore: () => mockUserStore
}))

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

// Configuration i18n
const i18n = createI18n({
  legacy: false,
  locale: 'fr',
  messages: {
    fr: {
      cluster_switch_title: 'Changement de cluster non autorisé',
      cluster_switch_message: 'Vous ne pouvez pas changer de cluster en étant connecté',
      logout: 'Se déconnecter',
      back: 'Retour'
    }
  }
})

describe('ClusterSwitchNotAllowed', () => {
  let wrapper
  let pinia

  beforeEach(() => {
    vi.clearAllMocks()
    pinia = createPinia()
  })

  const createWrapper = () => {
    return mount(ClusterSwitchNotAllowed, {
      global: {
        plugins: [i18n, pinia]
      }
    })
  }

  it('renders component correctly', () => {
    wrapper = createWrapper()
    
    expect(wrapper.find('.cluster-switch-blocked').exists()).toBe(true)
    expect(wrapper.find('h2').text()).toBe('Changement de cluster non autorisé')
    expect(wrapper.text()).toContain('Vous ne pouvez pas changer de cluster en étant connecté')
  })

  it('displays logout and back buttons', () => {
    wrapper = createWrapper()
    
    const buttons = wrapper.findAll('button')
    expect(buttons).toHaveLength(2)
    expect(buttons[0].text()).toBe('Se déconnecter')
    expect(buttons[1].text()).toBe('Retour')
  })

  it('calls logout function when logout button is clicked', async () => {
    wrapper = createWrapper()
    
    const logoutButton = wrapper.findAll('button')[0]
    await logoutButton.trigger('click')
    
    expect(mockUserStore.clearUser).toHaveBeenCalled()
    expect(localStorageMock.removeItem).toHaveBeenCalledWith('selectedCountry')
    expect(mockRouter.push).toHaveBeenCalledWith('/login')
  })

  it('calls goBack function when back button is clicked', async () => {
    wrapper = createWrapper()
    
    const backButton = wrapper.findAll('button')[1]
    await backButton.trigger('click')
    
    expect(mockRouter.back).toHaveBeenCalled()
  })
})
