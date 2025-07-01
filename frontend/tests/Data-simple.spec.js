import { describe, it, expect, beforeEach, vi } from 'vitest'
import { mount } from '@vue/test-utils'
import { createI18n } from 'vue-i18n'
import Data from '../src/components/Data.vue'

// Configuration i18n simplifiée
const i18n = createI18n({
  legacy: false,
  locale: 'fr',
  messages: {
    fr: {
      data_title: 'Données',
      data_sources: 'Sources de données',
      unified_data: 'Données unifiées',
      unified_description: 'Vue globale des données de santé',
      explore_health_data: 'Explorer les données de santé',
      specialized_views: 'Vues spécialisées',
      data_mortalite_us: 'Mortalité US',
      data_population_hiv: 'Population VIH',
      data_traitement: 'Traitement',
      data_transmission_mere_enfant: 'Transmission mère-enfant'
    }
  }
})

describe('Data (Simple)', () => {
  let wrapper

  beforeEach(() => {
    vi.clearAllMocks()
  })

  const createWrapper = () => {
    return mount(Data, {
      global: {
        plugins: [i18n],
        stubs: {
          'router-link': {
            template: '<a :href="to"><slot /></a>',
            props: ['to']
          }
        }
      }
    })
  }

  it('renders main title', () => {
    wrapper = createWrapper()
    
    expect(wrapper.find('h1').text()).toBe('Données')
  })

  it('renders data sources section', () => {
    wrapper = createWrapper()
    
    expect(wrapper.find('h2').text()).toBe('Sources de données')
  })

  it('renders unified data section', () => {
    wrapper = createWrapper()
    
    const unifiedSection = wrapper.find('.nav-section.modern')
    expect(unifiedSection.exists()).toBe(true)
    expect(unifiedSection.find('h3').text()).toBe('Données unifiées')
  })

  it('renders specialized views section', () => {
    wrapper = createWrapper()
    
    const specializedSection = wrapper.find('.nav-section.legacy')
    expect(specializedSection.exists()).toBe(true)
    expect(specializedSection.find('h3').text()).toBe('Vues spécialisées')
  })

  it('renders all specialized links', () => {
    wrapper = createWrapper()
    
    const specializedLinks = wrapper.findAll('.specialized-links a')
    expect(specializedLinks).toHaveLength(4)
    
    const linkTexts = specializedLinks.map(link => link.text())
    expect(linkTexts).toEqual([
      'Mortalité US',
      'Population VIH',
      'Traitement',
      'Transmission mère-enfant'
    ])
  })

  it('has proper navigation structure', () => {
    wrapper = createWrapper()
    
    expect(wrapper.find('.data-navigation').exists()).toBe(true)
    
    const sections = wrapper.findAll('.nav-section')
    expect(sections).toHaveLength(2)
    
    expect(sections[0].classes()).toContain('modern')
    expect(sections[1].classes()).toContain('legacy')
  })

  it('has proper heading hierarchy', () => {
    wrapper = createWrapper()
    
    const headings = wrapper.findAll('h1, h2, h3')
    expect(headings).toHaveLength(4) // h1, h2, 2x h3
    
    expect(headings[0].element.tagName).toBe('H1')
    expect(headings[1].element.tagName).toBe('H2')
    expect(headings[2].element.tagName).toBe('H3')
    expect(headings[3].element.tagName).toBe('H3')
  })
})
