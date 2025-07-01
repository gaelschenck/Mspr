import { describe, it, expect } from 'vitest'
import { mount } from '@vue/test-utils'
import Confidentialite from '../src/components/Confidentialite.vue'

describe('Confidentialite', () => {
  let wrapper

  const createWrapper = () => {
    return mount(Confidentialite)
  }

  it('renders component correctly', () => {
    wrapper = createWrapper()
    
    expect(wrapper.find('.confidentialite').exists()).toBe(true)
    expect(wrapper.find('h1').text()).toBe('Politique de confidentialité')
  })

  it('displays all required sections', () => {
    wrapper = createWrapper()
    
    const headings = wrapper.findAll('h2')
    const sectionTitles = headings.map(h => h.text())
    
    expect(sectionTitles).toContain('Données collectées')
    expect(sectionTitles).toContain('Consentement')
    expect(sectionTitles).toContain('Utilisation des données')
    expect(sectionTitles).toContain('Partage des données')
    expect(sectionTitles).toContain('Vos droits')
    expect(sectionTitles).toContain('Contact')
  })

  it('contains email links', () => {
    wrapper = createWrapper()
    
    const emailLinks = wrapper.findAll('a[href^="mailto:"]')
    expect(emailLinks.length).toBeGreaterThan(0)
    expect(emailLinks[0].attributes('href')).toBe('mailto:votre-email@domaine.fr')
  })

  it('displays last update date', () => {
    wrapper = createWrapper()
    
    expect(wrapper.text()).toContain('Dernière mise à jour : 10 juin 2025')
  })

  it('contains information about cookies', () => {
    wrapper = createWrapper()
    
    expect(wrapper.text()).toContain('cookies')
    expect(wrapper.text()).toContain('Google Analytics')
  })

  it('mentions RGPD rights', () => {
    wrapper = createWrapper()
    
    expect(wrapper.text()).toContain('RGPD')
    expect(wrapper.text()).toContain('droit d')
  })

  it('has proper styling class', () => {
    wrapper = createWrapper()
    
    expect(wrapper.classes()).toContain('confidentialite')
  })
})
