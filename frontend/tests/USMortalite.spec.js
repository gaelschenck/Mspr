// @vitest-environment jsdom
import { mount, flushPromises } from '@vue/test-utils'
import { describe, it, expect, vi, beforeEach } from 'vitest'
import USMortalite from '../src/components/USMortalite.vue'
import { createI18n } from 'vue-i18n'

// Mock axios pour empêcher tout appel réseau réel
let pageCall = 0;
vi.mock('axios', () => ({
  default: {
    create: () => ({
      get: vi.fn().mockImplementation(() => {
        pageCall++;
        if (pageCall === 1) {
          // Première page : 25 éléments
          return Promise.resolve({ data: Array.from({length: 25}, (_, i) => ({ id: i+1, nom_pays: 'USA', annee: 2020, valeur: 100+i })) });
        } else {
          // Page suivante : 2 éléments
          return Promise.resolve({ data: [
            { id: 26, nom_pays: 'USA', annee: 2021, valeur: 456 },
            { id: 27, nom_pays: 'USA', annee: 2022, valeur: 789 }
          ] });
        }
      }),
      interceptors: {
        request: { use: vi.fn() }
      }
    })
  }
}))

// Mock localStorage pour l'environnement de test
if (!global.localStorage) {
  global.localStorage = {
    getItem: vi.fn(() => null),
    setItem: vi.fn(),
    removeItem: vi.fn(),
    clear: vi.fn()
  }
}

const i18n = createI18n({
  legacy: false,
  locale: 'fr',
  messages: { fr: { mortalite_title: 'Mortalité', pays: 'Pays', annee: 'Année', valeur: 'Valeur' } }
})

describe('USMortalite.vue', () => {
  beforeEach(() => {
    vi.clearAllMocks()
    pageCall = 0;
  })

  it('affiche les données de mortalité US', async () => {
    const wrapper = mount(USMortalite, {
      global: { plugins: [i18n] }
    })
    await flushPromises()
    
    // Vérifier que le tableau est présent
    expect(wrapper.find('.data-table').exists()).toBe(true)
    
    // Vérifier les données dans le tableau
    const tableRows = wrapper.findAll('.data-table tbody tr')
    expect(tableRows.length).toBe(25) // 25 éléments sur la première page
    
    // Vérifier le contenu de la première ligne
    const firstRow = tableRows[0]
    expect(firstRow.text()).toContain('USA')
    expect(firstRow.text()).toContain('2020')
    expect(firstRow.text()).toContain('100')
  })

  it('passe à la page suivante au clic sur Suivant', async () => {
    const wrapper = mount(USMortalite, {
      global: { plugins: [i18n] }
    })
    await flushPromises()
    
    // Cliquer sur le bouton Suivant
    await wrapper.find('button:last-of-type').trigger('click')
    await flushPromises()
    
    // Vérifier que la page a changé
    expect(wrapper.find('span').text()).toContain('Page 2')
    
    // Vérifier les nouvelles données dans le tableau
    const tableRows = wrapper.findAll('.data-table tbody tr')
    expect(tableRows.length).toBe(2) // 2 éléments sur la deuxième page
    
    const tableText = wrapper.find('.data-table').text()
    expect(tableText).toContain('2021')
    expect(tableText).toContain('456')
    expect(tableText).toContain('2022')
    expect(tableText).toContain('789')
  })
})
