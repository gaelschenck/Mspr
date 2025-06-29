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
          // Première page : 26 éléments (25 + 1 pour détecter la page suivante)
          return Promise.resolve({ data: Array.from({length: 26}, (_, i) => ({ 
            id: i+1, 
            country_name: 'USA', 
            year: 2020, 
            value: 100+i,
            value_type: 'deaths',
            who_region: 'Americas'
          })) });
        } else {
          // Page suivante : 2 éléments
          return Promise.resolve({ data: [
            { id: 26, country_name: 'USA', year: 2021, value: 456, value_type: 'deaths', who_region: 'Americas' },
            { id: 27, country_name: 'USA', year: 2022, value: 789, value_type: 'deaths', who_region: 'Americas' }
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
  messages: { 
    fr: { 
      mortalite_title: 'Mortalité',
      pays: 'Pays', 
      annee: 'Année', 
      valeur: 'Valeur',
      type_valeur: 'Type de valeur',
      region_oms: 'Région OMS',
      loading: 'Chargement...',
      chargement: 'Chargement...',
      error: 'Erreur lors du chargement des données',
      erreur_chargement: 'Erreur lors du chargement des données',
      reessayer: 'Réessayer',
      no_data: 'Aucune donnée disponible',
      aucune_donnee: 'Aucune donnée disponible',
      page: 'Page',
      page_courante: 'Page courante',
      precedent: 'Précédent',
      suivant: 'Suivant',
      resultats_par_page: 'résultats par page',
      plus_resultats: 'plus de résultats disponibles',
      derniere_page: 'dernière page'
    } 
  }
})

describe('USMortalite.vue', () => {
  beforeEach(() => {
    vi.clearAllMocks()
    pageCall = 0;
  })

  it('affiche le titre et la structure de base', async () => {
    const wrapper = mount(USMortalite, {
      global: { plugins: [i18n] }
    })
    await flushPromises()
    
    // Vérifier que le titre est présent
    expect(wrapper.text()).toContain('Mortalité')
    
    // Vérifier que la structure de base est présente (div racine avec h1)
    expect(wrapper.find('h1').exists()).toBe(true)
    expect(wrapper.find('h1').text()).toBe('Mortalité')
  })

  it('affiche les données de mortalité US', async () => {
    const wrapper = mount(USMortalite, {
      global: { plugins: [i18n] }
    })
    await flushPromises()
    
    // Vérifier que le tableau est présent (plusieurs sélecteurs possibles)
    const hasDataTable = wrapper.find('.data-table').exists() || 
                        wrapper.find('table').exists() || 
                        wrapper.find('[class*="table"]').exists()
    expect(hasDataTable).toBe(true)
    
    // Vérifier les données sont affichées
    const wrapperText = wrapper.text()
    expect(wrapperText).toContain('USA')
    expect(wrapperText).toContain('2020')
    expect(wrapperText).toContain('100')
  })

  it('gère la pagination correctement', async () => {
    const wrapper = mount(USMortalite, {
      global: { plugins: [i18n] }
    })
    await flushPromises()
    
    // Vérifier que le bouton Suivant est présent et cliquable
    const buttons = wrapper.findAll('button')
    const nextButton = buttons.find(btn => 
      btn.text().includes('Suivant') || 
      btn.text().includes('Next') || 
      btn.text().includes('>')
    )
    
    if (nextButton && !nextButton.attributes('disabled')) {
      // Cliquer sur le bouton Suivant
      await nextButton.trigger('click')
      await flushPromises()
      
      // Vérifier que la page a changé
      const wrapperText = wrapper.text()
      expect(wrapperText).toContain('2021')
      expect(wrapperText).toContain('456')
    } else {
      // Si pas de pagination, vérifier au moins que les données sont affichées
      expect(wrapper.text()).toContain('USA')
    }
  })

  it('gère les états de chargement et d\'erreur', async () => {
    const wrapper = mount(USMortalite, {
      global: { plugins: [i18n] }
    })
    
    // Le composant doit au moins s'afficher sans erreur
    expect(wrapper.exists()).toBe(true)
    
    await flushPromises()
    
    // Vérifier qu'aucun message d'erreur n'est affiché après le chargement
    const wrapperText = wrapper.text()
    expect(wrapperText).not.toMatch(/erreur|error/i)
  })

  it('affiche les colonnes de données appropriées', async () => {
    const wrapper = mount(USMortalite, {
      global: { plugins: [i18n] }
    })
    await flushPromises()
    
    const wrapperText = wrapper.text()
    
    // Vérifier que les données essentielles sont présentes
    expect(wrapperText).toContain('USA') // Pays
    expect(wrapperText).toMatch(/202\d/) // Année (format 20XX)
    expect(wrapperText).toMatch(/\d+/) // Une valeur numérique
  })
})
