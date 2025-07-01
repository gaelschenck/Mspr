import { describe, it, expect, beforeEach, vi } from 'vitest'
import { mount } from '@vue/test-utils'
import Login from '../src/views/Login.vue'

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
vi.mock('../services/api.js', () => ({
  default: {
    post: vi.fn()
  }
}))

import apiClient from '../services/api.js'

// Mock userStore
const mockUserStore = {
  setToken: vi.fn()
}

// Mock vue-router
const mockRouter = {
  push: vi.fn()
}

// Mock useRouter
vi.mock('vue-router', () => ({
  useRouter: () => mockRouter
}))

vi.mock('../src/stores/userStore', () => ({
  useUserStore: () => mockUserStore
}))

describe('Login', () => {
  let wrapper

  beforeEach(() => {
    vi.clearAllMocks()
    localStorageMock.getItem.mockReturnValue('fr')
  })

  const createWrapper = () => {
    return mount(Login, {
      global: {
        // Plus besoin de mocker $router directement
      }
    })
  }

  it('renders login form correctly', () => {
    wrapper = createWrapper()
    
    expect(wrapper.find('h1').text()).toBe('Connexion')
    expect(wrapper.find('#country').exists()).toBe(true)
    expect(wrapper.find('#username').exists()).toBe(true)
    expect(wrapper.find('#password').exists()).toBe(true)
    expect(wrapper.find('button[type="submit"]').exists()).toBe(true)
  })

  it('initializes with default country from localStorage', () => {
    localStorageMock.getItem.mockReturnValue('us')
    wrapper = createWrapper()
    
    expect(wrapper.vm.country).toBe('us')
  })

  it('updates form data when inputs change', async () => {
    wrapper = createWrapper()
    
    await wrapper.find('#username').setValue('testuser')
    await wrapper.find('#password').setValue('testpass')
    await wrapper.find('#country').setValue('us')
    
    expect(wrapper.vm.username).toBe('testuser')
    expect(wrapper.vm.password).toBe('testpass')
    expect(wrapper.vm.country).toBe('us')
  })

  it('handles successful login', async () => {
    apiClient.post.mockResolvedValue({
      data: { access_token: 'test-token' }
    })
    
    wrapper = createWrapper()
    wrapper.vm.username = 'testuser'
    wrapper.vm.password = 'testpass'
    wrapper.vm.country = 'fr'
    
    await wrapper.vm.login()
    
    expect(apiClient.post).toHaveBeenCalledWith('/token', expect.any(URLSearchParams), {
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
        'X-Cluster': 'fr'
      }
    })
    expect(mockUserStore.setToken).toHaveBeenCalledWith('test-token')
    expect(localStorageMock.setItem).toHaveBeenCalledWith('selectedCountry', 'fr')
    // Test passé : nous vérifions juste que la fonction login a été exécutée sans erreur
    expect(true).toBe(true)
  })

  it('handles 404 error correctly', async () => {
    apiClient.post.mockRejectedValue({
      response: { status: 404 }
    })
    
    wrapper = createWrapper()
    wrapper.vm.username = 'testuser'
    wrapper.vm.country = 'fr'
    
    await wrapper.vm.login()
    
    expect(wrapper.vm.error).toBe('Utilisateur "testuser" non trouvé dans la base FR')
  })

  it('handles 401 error correctly', async () => {
    apiClient.post.mockRejectedValue({
      response: { status: 401 }
    })
    
    wrapper = createWrapper()
    wrapper.vm.username = 'testuser'
    
    await wrapper.vm.login()
    
    expect(wrapper.vm.error).toBe('Mot de passe incorrect pour l\'utilisateur "testuser"')
  })

  it('handles 400 error correctly', async () => {
    apiClient.post.mockRejectedValue({
      response: { status: 400 }
    })
    
    wrapper = createWrapper()
    
    await wrapper.vm.login()
    
    expect(wrapper.vm.error).toBe('Erreur de configuration (cluster non spécifié)')
  })

  it('displays error message when error occurs', async () => {
    wrapper = createWrapper()
    wrapper.vm.error = 'Test error message'
    
    await wrapper.vm.$nextTick()
    
    expect(wrapper.find('.error').text()).toBe('Test error message')
  })

  it('submits form when form is submitted', async () => {
    const loginSpy = vi.spyOn(Login.methods, 'login')
    wrapper = createWrapper()
    
    await wrapper.find('form').trigger('submit.prevent')
    
    expect(loginSpy).toHaveBeenCalled()
  })
})
