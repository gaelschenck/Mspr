import { describe, it, expect, beforeEach, vi } from 'vitest'

// Mock localStorage
const localStorageMock = {
  getItem: vi.fn()
}
Object.defineProperty(global, 'localStorage', {
  value: localStorageMock
})

describe('i18n configuration', () => {
  beforeEach(() => {
    vi.clearAllMocks()
    // Clear module cache to test different localStorage values
    vi.resetModules()
  })

  it('sets French locale by default', async () => {
    localStorageMock.getItem.mockReturnValue(null)
    
    const { default: i18n } = await import('../src/i18n.js')
    
    expect(i18n.global.locale).toBe('fr')
  })

  it('sets French locale for fr country', async () => {
    localStorageMock.getItem.mockReturnValue('fr')
    
    const { default: i18n } = await import('../src/i18n.js')
    
    expect(i18n.global.locale).toBe('fr')
  })

  it('sets English locale for us country', async () => {
    localStorageMock.getItem.mockReturnValue('us')
    
    const { default: i18n } = await import('../src/i18n.js')
    
    expect(i18n.global.locale).toBe('en')
  })

  it('sets correct locale for Swiss French', async () => {
    localStorageMock.getItem.mockReturnValue('ch_fr')
    
    const { default: i18n } = await import('../src/i18n.js')
    
    expect(i18n.global.locale).toBe('fr')
  })

  it('sets correct locale for Swiss English', async () => {
    localStorageMock.getItem.mockReturnValue('ch_en')
    
    const { default: i18n } = await import('../src/i18n.js')
    
    expect(i18n.global.locale).toBe('en')
  })

  it('sets correct locale for Swiss German', async () => {
    localStorageMock.getItem.mockReturnValue('ch_de')
    
    const { default: i18n } = await import('../src/i18n.js')
    
    expect(i18n.global.locale).toBe('de')
  })

  it('sets correct locale for Swiss Italian', async () => {
    localStorageMock.getItem.mockReturnValue('ch_it')
    
    const { default: i18n } = await import('../src/i18n.js')
    
    expect(i18n.global.locale).toBe('it')
  })

  it('fallbacks to French for unknown country', async () => {
    localStorageMock.getItem.mockReturnValue('unknown')
    
    const { default: i18n } = await import('../src/i18n.js')
    
    expect(i18n.global.locale).toBe('fr')
  })

  it('contains French messages', async () => {
    localStorageMock.getItem.mockReturnValue('fr')
    
    const { default: i18n } = await import('../src/i18n.js')
    
    expect(i18n.global.messages.fr).toBeDefined()
    expect(i18n.global.messages.fr.welcome).toBe("Bienvenue sur l'application MSPR")
    expect(i18n.global.messages.fr.nav_home).toBe("Accueil")
    expect(i18n.global.messages.fr.nav_data).toBe("Données")
  })

  it('contains English messages', async () => {
    localStorageMock.getItem.mockReturnValue('us')
    
    const { default: i18n } = await import('../src/i18n.js')
    
    expect(i18n.global.messages.en).toBeDefined()
    expect(i18n.global.messages.en.welcome).toContain("Welcome")
    expect(i18n.global.messages.en.nav_home).toBe("Home")
    expect(i18n.global.messages.en.nav_data).toBe("Data")
  })

  it('contains German messages', async () => {
    localStorageMock.getItem.mockReturnValue('ch_de')
    
    const { default: i18n } = await import('../src/i18n.js')
    
    expect(i18n.global.messages.de).toBeDefined()
    expect(i18n.global.messages.de.welcome).toContain("Willkommen")
    expect(i18n.global.messages.de.nav_home).toBe("Startseite")
  })

  it('contains Italian messages', async () => {
    localStorageMock.getItem.mockReturnValue('ch_it')
    
    const { default: i18n } = await import('../src/i18n.js')
    
    expect(i18n.global.messages.it).toBeDefined()
    expect(i18n.global.messages.it.welcome).toContain("Benvenuto")
    expect(i18n.global.messages.it.nav_home).toBe("Home")
  })

  it('has consistent navigation keys across all locales', async () => {
    localStorageMock.getItem.mockReturnValue('fr')
    
    const { default: i18n } = await import('../src/i18n.js')
    
    const requiredNavKeys = [
      'nav_home',
      'nav_data', 
      'nav_charts',
      'nav_prediction',
      'nav_etl'
    ]
    
    const locales = ['fr', 'en', 'de', 'it']
    
    locales.forEach(locale => {
      const messages = i18n.global.messages[locale]
      expect(messages).toBeDefined()
      
      requiredNavKeys.forEach(key => {
        expect(messages[key]).toBeDefined()
        expect(typeof messages[key]).toBe('string')
        expect(messages[key].length).toBeGreaterThan(0)
      })
    })
  })

  it('has welcome message in all locales', async () => {
    localStorageMock.getItem.mockReturnValue('fr')
    
    const { default: i18n } = await import('../src/i18n.js')
    
    const locales = ['fr', 'en', 'de', 'it']
    
    locales.forEach(locale => {
      const messages = i18n.global.messages[locale]
      expect(messages.welcome).toBeDefined()
      expect(typeof messages.welcome).toBe('string')
      expect(messages.welcome.length).toBeGreaterThan(0)
    })
  })

  it('has consistent test prediction keys', async () => {
    localStorageMock.getItem.mockReturnValue('fr')
    
    const { default: i18n } = await import('../src/i18n.js')
    
    const testPredictionKeys = [
      'testprediction_title',
      'testprediction_choose_region',
      'testprediction_choose_country',
      'testprediction_submit'
    ]
    
    const locales = ['fr', 'en', 'de', 'it']
    
    locales.forEach(locale => {
      const messages = i18n.global.messages[locale]
      
      testPredictionKeys.forEach(key => {
        expect(messages[key]).toBeDefined()
        expect(typeof messages[key]).toBe('string')
      })
    })
  })

  it('has footer content in all locales', async () => {
    localStorageMock.getItem.mockReturnValue('fr')
    
    const { default: i18n } = await import('../src/i18n.js')
    
    const footerKeys = ['footer_title', 'footer_rights']
    const locales = ['fr', 'en', 'de', 'it']
    
    locales.forEach(locale => {
      const messages = i18n.global.messages[locale]
      
      footerKeys.forEach(key => {
        expect(messages[key]).toBeDefined()
        expect(typeof messages[key]).toBe('string')
      })
    })
  })

  it('creates i18n instance with correct configuration', async () => {
    localStorageMock.getItem.mockReturnValue('fr')
    
    const { default: i18n } = await import('../src/i18n.js')
    
    expect(i18n).toBeDefined()
    expect(i18n.global).toBeDefined()
    expect(i18n.global.locale).toBe('fr')
    expect(i18n.global.messages).toBeDefined()
    expect(Object.keys(i18n.global.messages)).toEqual(['fr', 'en', 'de', 'it'])
  })

  it('supports dynamic locale switching', async () => {
    localStorageMock.getItem.mockReturnValue('fr')
    
    const { default: i18n } = await import('../src/i18n.js')
    
    expect(i18n.global.locale).toBe('fr')
    
    // Test switching locale
    i18n.global.locale = 'en'
    expect(i18n.global.locale).toBe('en')
    
    i18n.global.locale = 'de'
    expect(i18n.global.locale).toBe('de')
  })

  it('handles translation function correctly', async () => {
    localStorageMock.getItem.mockReturnValue('fr')
    
    const { default: i18n } = await import('../src/i18n.js')
    
    // Test translation
    expect(i18n.global.t('welcome')).toBe("Bienvenue sur l'application MSPR")
    expect(i18n.global.t('nav_home')).toBe("Accueil")
    
    // Switch locale and test
    i18n.global.locale = 'en'
    expect(i18n.global.t('nav_home')).toBe("Home")
  })
})
