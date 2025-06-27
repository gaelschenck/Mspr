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
    expect(wrapper.text()).toContain('USA')
    expect(wrapper.text()).toContain('2020')
    expect(wrapper.text()).toContain('100')
    // On ne teste plus la présence de 2021 ici, car elle n'est pas sur la première page
  })

  it('passe à la page suivante au clic sur Suivant', async () => {
    const wrapper = mount(USMortalite, {
      global: { plugins: [i18n] }
    })
    await flushPromises()
    await wrapper.find('button:last-of-type').trigger('click')
    await flushPromises()
    expect(wrapper.find('span').text()).toContain('Page 2')
    expect(wrapper.text()).toContain('2021')
    expect(wrapper.text()).toContain('456')
    expect(wrapper.text()).toContain('2022')
    expect(wrapper.text()).toContain('789')
  })
})
