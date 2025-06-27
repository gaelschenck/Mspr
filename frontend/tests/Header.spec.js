import { describe, it, expect, beforeEach, vi } from 'vitest'
import { mount, flushPromises } from '@vue/test-utils'
import { createTestingPinia } from '@pinia/testing'
import { createI18n } from 'vue-i18n'
import Header from '../src/components/Header.vue'
import { useUserStore } from '../src/stores/userStore'

// Mock du router
const mockRouter = {
  push: vi.fn()
}

// Mock de window.location.reload
const mockReload = vi.fn()
Object.defineProperty(window, 'location', {
  value: {
    reload: mockReload
  },
  writable: true
})

// Configuration i18n pour les tests
const i18n = createI18n({
  locale: 'fr',
  messages: {
    fr: {
      nav_home: 'Accueil',
      nav_data: 'Données',
      nav_charts: 'Graphiques',
      nav_prediction: 'Prédiction'
    },
    en: {
      nav_home: 'Home',
      nav_data: 'Data',
      nav_charts: 'Charts',
      nav_prediction: 'Prediction'
    },
    de: {
      nav_home: 'Startseite',
      nav_data: 'Daten',
      nav_charts: 'Diagramme',
      nav_prediction: 'Vorhersage'
    },
    it: {
      nav_home: 'Casa',
      nav_data: 'Dati',
      nav_charts: 'Grafici',
      nav_prediction: 'Predizione'
    }
  }
})

describe('Header.vue', () => {
  let wrapper
  let pinia
  let userStore

  beforeEach(() => {
    // Clear localStorage before each test
    localStorage.clear()
    
    // Clear all mocks including localStorage mocks
    vi.clearAllMocks()
    
    // Create testing pinia
    pinia = createTestingPinia({
      createSpy: vi.fn
    })
    
    // Mount component with required plugins
    wrapper = mount(Header, {
      global: {
        plugins: [pinia, i18n],
        mocks: {
          $router: mockRouter
        },
        stubs: {
          'router-link': true
        }
      }
    })
    
    userStore = useUserStore()
  })

  describe('Rendu initial', () => {
    it('affiche tous les éléments de navigation', () => {
      expect(wrapper.find('nav ul').exists()).toBe(true)
      expect(wrapper.findAll('nav li')).toHaveLength(4)
      
      const links = wrapper.findAll('router-link-stub')
      expect(links[0].attributes('to')).toBe('/')
      expect(links[1].attributes('to')).toBe('/data')
      expect(links[2].attributes('to')).toBe('/graphiques')
      expect(links[3].attributes('to')).toBe('/prediction')
    })

    it('affiche les boutons de sélection de pays', () => {
      const langButtons = wrapper.findAll('.lang-select button')
      expect(langButtons).toHaveLength(3)
      expect(langButtons[0].text()).toBe('FR')
      expect(langButtons[1].text()).toBe('US')
      expect(langButtons[2].text()).toBe('CH')
    })

    it('affiche le bouton de déconnexion', () => {
      const allButtons = wrapper.findAll('button')
      const logoutButton = allButtons.find(button => button.text() === 'Déconnexion')
      expect(logoutButton).toBeDefined()
      expect(logoutButton.text()).toBe('Déconnexion')
    })

    it('n\'affiche pas les langues suisses par défaut', () => {
      expect(wrapper.find('.swiss-lang').exists()).toBe(false)
    })

    it('affiche les langues suisses quand utilisateur connecté sur cluster suisse', async () => {
      // Simuler un utilisateur connecté sur cluster suisse
      userStore.username = 'testuser'
      await wrapper.setData({ currentCountry: 'ch_fr' })
      await wrapper.vm.$nextTick()
      
      expect(wrapper.find('.swiss-lang').exists()).toBe(true)
      const swissButtons = wrapper.findAll('.swiss-lang button')
      expect(swissButtons).toHaveLength(4)
      expect(swissButtons[0].text()).toBe('FR-CH')
      expect(swissButtons[1].text()).toBe('EN-CH')
      expect(swissButtons[2].text()).toBe('DE-CH')
      expect(swissButtons[3].text()).toBe('IT-CH')
    })

    it('n\'affiche pas les langues suisses si pas d\'utilisateur connecté', async () => {
      // Simuler cluster suisse sans utilisateur connecté
      userStore.username = null
      await wrapper.setData({ currentCountry: 'ch_fr' })
      await wrapper.vm.$nextTick()
      
      expect(wrapper.find('.swiss-lang').exists()).toBe(false)
    })
  })

  describe('Sélection de pays', () => {
    it('définit le pays France et recharge la page', async () => {
      const frButton = wrapper.findAll('.lang-select button')[0]
      
      await frButton.trigger('click')
      
      expect(localStorage.setItem).toHaveBeenCalledWith('selectedCountry', 'fr')
      expect(mockReload).toHaveBeenCalled()
    })

    it('définit le pays USA et recharge la page', async () => {
      const usButton = wrapper.findAll('.lang-select button')[1]
      
      await usButton.trigger('click')
      
      expect(localStorage.setItem).toHaveBeenCalledWith('selectedCountry', 'us')
      expect(mockReload).toHaveBeenCalled()
    })

    it('définit le cluster Suisse (ch_fr) quand CH est cliqué', async () => {
      const chButton = wrapper.findAll('.lang-select button')[2]
      
      await chButton.trigger('click')
      
      expect(localStorage.setItem).toHaveBeenCalledWith('selectedCountry', 'ch_fr')
      expect(mockReload).toHaveBeenCalled()
    })

    it('redirige vers la page d\'avertissement quand on change de cluster avec utilisateur connecté', async () => {
      // Simuler un utilisateur connecté
      userStore.username = 'testuser'
      localStorage.setItem('selectedCountry', 'fr')
      
      // Recréer le wrapper pour prendre en compte le changement d'état
      await wrapper.vm.$nextTick()
      
      const usButton = wrapper.findAll('.lang-select button')[1]
      await usButton.trigger('click')
      
      expect(mockRouter.push).toHaveBeenCalledWith('/cluster-switch-not-allowed')
    })
  })

  describe('Langues suisses', () => {
    beforeEach(async () => {
      // Simuler un utilisateur connecté sur cluster suisse pour afficher les options
      userStore.username = 'testuser'
      await wrapper.setData({ currentCountry: 'ch_fr' })
      await wrapper.vm.$nextTick()
    })

    it('permet le changement de langue suisse quand déjà sur cluster suisse', async () => {
      localStorage.setItem('selectedCountry', 'ch_fr')
      
      const deButton = wrapper.findAll('.swiss-lang button')[2]
      await deButton.trigger('click')
      
      expect(localStorage.setItem).toHaveBeenCalledWith('selectedCountry', 'ch_de')
      expect(mockReload).toHaveBeenCalled()
    })

    it('redirige vers page d\'avertissement quand pas sur cluster suisse', async () => {
      localStorage.setItem('selectedCountry', 'fr')
      
      const frChButton = wrapper.findAll('.swiss-lang button')[0]
      await frChButton.trigger('click')
      
      expect(mockRouter.push).toHaveBeenCalledWith('/cluster-switch-not-allowed')
    })

    it('définit les bonnes langues suisses', async () => {
      localStorage.setItem('selectedCountry', 'ch_fr')
      
      const buttons = wrapper.findAll('.swiss-lang button')
      
      await buttons[1].trigger('click') // EN-CH
      expect(localStorage.setItem).toHaveBeenCalledWith('selectedCountry', 'ch_en')
      
      localStorage.setItem('selectedCountry', 'ch_fr')
      await buttons[3].trigger('click') // IT-CH
      expect(localStorage.setItem).toHaveBeenCalledWith('selectedCountry', 'ch_it')
    })
  })

  describe('Affichage des informations utilisateur', () => {
    it('affiche le nom d\'utilisateur quand connecté', async () => {
      userStore.username = 'johndoe'
      await wrapper.vm.$nextTick()
      
      expect(wrapper.text()).toContain('Connecté en tant que : johndoe')
    })

    it('n\'affiche pas les informations utilisateur quand déconnecté', async () => {
      userStore.username = null
      await wrapper.vm.$nextTick()
      
      expect(wrapper.text()).not.toContain('Connecté en tant que')
    })
  })

  describe('Affichage du cluster', () => {
    it('affiche le cluster France', async () => {
      localStorage.setItem('selectedCountry', 'fr')
      await wrapper.setData({ currentCountry: 'fr' })
      
      expect(wrapper.text()).toContain('Cluster : France')
    })

    it('affiche le cluster USA', async () => {
      localStorage.setItem('selectedCountry', 'us')
      await wrapper.setData({ currentCountry: 'us' })
      
      expect(wrapper.text()).toContain('Cluster : USA')
    })

    it('affiche le cluster Suisse pour toutes les langues suisses', async () => {
      const swissCountries = ['ch_fr', 'ch_en', 'ch_de', 'ch_it']
      
      for (const country of swissCountries) {
        localStorage.setItem('selectedCountry', country)
        await wrapper.setData({ currentCountry: country })
        
        expect(wrapper.text()).toContain('Cluster : Suisse')
      }
    })

    it('n\'affiche pas le cluster quand aucun pays sélectionné', async () => {
      await wrapper.setData({ currentCountry: null })
      
      expect(wrapper.text()).not.toContain('Cluster :')
    })
  })

  describe('Déconnexion', () => {
    it('déconnecte l\'utilisateur et redirige vers login', async () => {
      localStorage.setItem('selectedCountry', 'fr')
      userStore.username = 'testuser'
      
      const allButtons = wrapper.findAll('button')
      const logoutButton = allButtons.find(button => button.text() === 'Déconnexion')
      expect(logoutButton).toBeDefined()
      
      await logoutButton.trigger('click')
      
      expect(userStore.clearUser).toHaveBeenCalled()
      expect(localStorage.removeItem).toHaveBeenCalledWith('selectedCountry')
      expect(mockRouter.push).toHaveBeenCalledWith('/login')
    })
  })

  describe('Propriétés calculées', () => {
    it('calcule correctement displayCountry', () => {
      wrapper.vm.currentCountry = 'fr'
      expect(wrapper.vm.displayCountry).toBe('France')
      
      wrapper.vm.currentCountry = 'us'
      expect(wrapper.vm.displayCountry).toBe('USA')
      
      wrapper.vm.currentCountry = 'ch_fr'
      expect(wrapper.vm.displayCountry).toBe('Suisse')
      
      wrapper.vm.currentCountry = 'ch_de'
      expect(wrapper.vm.displayCountry).toBe('Suisse')
      
      wrapper.vm.currentCountry = null
      expect(wrapper.vm.displayCountry).toBe('')
    })

    it('retourne le nom d\'utilisateur depuis le store', () => {
      userStore.username = 'testuser'
      expect(wrapper.vm.currentUser).toBe('testuser')
      
      userStore.username = null
      expect(wrapper.vm.currentUser).toBe(null)
    })
  })

  describe('Classes CSS', () => {
    it('applique les bonnes classes CSS', () => {
      expect(wrapper.find('.header').exists()).toBe(true)
      expect(wrapper.find('.header-content').exists()).toBe(true)
      expect(wrapper.find('.lang-select').exists()).toBe(true)
    })

    it('affiche les informations de cluster avec la bonne classe', async () => {
      localStorage.setItem('selectedCountry', 'fr')
      await wrapper.setData({ currentCountry: 'fr' })
      
      expect(wrapper.find('.cluster-info').exists()).toBe(true)
    })

    it('affiche les informations utilisateur avec la bonne classe', async () => {
      userStore.username = 'testuser'
      await wrapper.vm.$nextTick()
      
      expect(wrapper.find('.user-info').exists()).toBe(true)
    })
  })

  describe('Gestion des erreurs localStorage', () => {
    it('gère le cas où localStorage est vide', () => {
      localStorage.clear()
      
      const newWrapper = mount(Header, {
        global: {
          plugins: [pinia, i18n],
          mocks: {
            $router: mockRouter
          },
          stubs: {
            'router-link': true
          }
        }
      })
      
      expect(newWrapper.vm.currentCountry).toBe(null)
    })
  })
})