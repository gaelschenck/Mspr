import { describe, it, expect, beforeEach, vi } from 'vitest'
import { mount } from '@vue/test-utils'
import { createI18n } from 'vue-i18n'
import Home from '../src/views/home.vue'

// Configuration i18n
const i18n = createI18n({
  legacy: false,
  locale: 'fr',
  messages: {
    fr: {
      welcome: 'Bienvenue sur notre plateforme de données de santé',
      home_description: 'Explorez les données de santé mondiale et obtenez des prédictions basées sur l\'intelligence artificielle.'
    },
    en: {
      welcome: 'Welcome to our health data platform',
      home_description: 'Explore global health data and get AI-based predictions.'
    }
  }
})

describe('Home.vue', () => {
  let wrapper

  beforeEach(() => {
    vi.clearAllMocks()
  })

  const createWrapper = () => {
    return mount(Home, {
      global: {
        plugins: [i18n]
      }
    })
  }

  it('renders home component', () => {
    wrapper = createWrapper()
    
    expect(wrapper.exists()).toBe(true)
    expect(wrapper.find('.home').exists()).toBe(true)
  })

  it('displays welcome title', () => {
    wrapper = createWrapper()
    
    const title = wrapper.find('h1')
    expect(title.exists()).toBe(true)
    expect(title.text()).toBe('Bienvenue sur notre plateforme de données de santé')
  })

  it('displays description paragraph', () => {
    wrapper = createWrapper()
    
    const description = wrapper.find('p')
    expect(description.exists()).toBe(true)
    expect(description.text()).toBe('Explorez les données de santé mondiale et obtenez des prédictions basées sur l\'intelligence artificielle.')
  })

  it('has proper CSS classes', () => {
    wrapper = createWrapper()
    
    expect(wrapper.find('.home').exists()).toBe(true)
    expect(wrapper.find('.home h1').exists()).toBe(true)
    expect(wrapper.find('.home p').exists()).toBe(true)
  })

  it('has correct component name', () => {
    expect(Home.name).toBe('Home')
  })

  it('has no data or methods', () => {
    expect(Home.data).toBeUndefined()
    expect(Home.methods).toBeUndefined()
    expect(Home.computed).toBeUndefined()
  })

  it('uses i18n for internationalization', () => {
    wrapper = createWrapper()
    
    // Vérifie que les clés i18n sont utilisées
    expect(wrapper.html()).toContain('Bienvenue sur notre plateforme')
    expect(wrapper.html()).toContain('Explorez les données de santé')
  })

  it('maintains semantic HTML structure', () => {
    wrapper = createWrapper()
    
    // Vérifie la structure sémantique
    const h1 = wrapper.find('h1')
    const p = wrapper.find('p')
    
    expect(h1.exists()).toBe(true)
    expect(p.exists()).toBe(true)
    
    // H1 devrait venir avant le paragraphe
    const h1Index = Array.from(wrapper.element.children).indexOf(h1.element)
    const pIndex = Array.from(wrapper.element.children).indexOf(p.element)
    expect(h1Index).toBeLessThan(pIndex)
  })

  it('renders with centered text layout', () => {
    wrapper = createWrapper()
    
    const homeDiv = wrapper.find('.home')
    expect(homeDiv.exists()).toBe(true)
    
    // Les styles de centrage sont appliqués via CSS
    expect(homeDiv.element.className).toBe('home')
  })

  it('is responsive by default', () => {
    wrapper = createWrapper()
    
    // Vérifie que la structure est appropriée pour le responsive
    const homeDiv = wrapper.find('.home')
    expect(homeDiv.exists()).toBe(true)
    
    // Les éléments de base sont présents pour le responsive design
    expect(wrapper.find('h1').exists()).toBe(true)
    expect(wrapper.find('p').exists()).toBe(true)
  })

  it('has accessible heading hierarchy', () => {
    wrapper = createWrapper()
    
    const headings = wrapper.findAll('h1, h2, h3, h4, h5, h6')
    expect(headings).toHaveLength(1)
    expect(headings[0].element.tagName).toBe('H1')
  })

  it('has proper content structure', () => {
    wrapper = createWrapper()
    
    // Vérifie que le contenu est structuré logiquement
    const elements = wrapper.findAll('h1, p')
    expect(elements).toHaveLength(2)
    expect(elements[0].element.tagName).toBe('H1')
    expect(elements[1].element.tagName).toBe('P')
  })

  it('handles missing translations gracefully', () => {
    const i18nWithMissingKeys = createI18n({
      locale: 'fr',
      messages: {
        fr: {
          welcome: 'Bienvenue'
          // home_description is missing
        }
      }
    })
    
    wrapper = mount(Home, {
      global: {
        plugins: [i18nWithMissingKeys]
      }
    })
    
    expect(wrapper.find('h1').text()).toBe('Bienvenue')
    // Missing key should show the key itself
    expect(wrapper.find('p').text()).toBe('home_description')
  })
})
