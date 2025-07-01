import { describe, it, expect } from 'vitest'
import { mount } from '@vue/test-utils'
import { createI18n } from 'vue-i18n'
import App from '../src/App.vue'

// Mock des composants
const MockHeader = { template: '<div>Header</div>' }
const MockFooter = { template: '<div>Footer</div>' }
const MockRGPDConsent = { template: '<div>RGPD</div>' }

// Configuration i18n
const i18n = createI18n({
  legacy: false,
  locale: 'fr',
  messages: {
    fr: {}
  }
})

// Mock router
const mockRouter = {
  currentRoute: { value: { path: '/' } },
  push: () => {},
  replace: () => {}
}

describe('App', () => {
  let wrapper

  const createWrapper = () => {
    return mount(App, {
      global: {
        plugins: [i18n],
        mocks: {
          $router: mockRouter,
          $route: { path: '/' }
        },
        stubs: {
          Header: MockHeader,
          Footer: MockFooter,
          RGPDConsent: MockRGPDConsent,
          'router-view': { template: '<div>Router View</div>' }
        }
      }
    })
  }

  it('renders the main app structure', () => {
    wrapper = createWrapper()
    
    expect(wrapper.find('.min-h-screen').exists()).toBe(true)
    expect(wrapper.find('.bg-gray-100').exists()).toBe(true)
    expect(wrapper.find('.container').exists()).toBe(true)
  })

  it('includes all required components', () => {
    wrapper = createWrapper()
    
    expect(wrapper.findComponent(MockHeader).exists()).toBe(true)
    expect(wrapper.findComponent(MockFooter).exists()).toBe(true)
    expect(wrapper.findComponent(MockRGPDConsent).exists()).toBe(true)
  })

  it('includes router-view for page content', () => {
    wrapper = createWrapper()
    
    expect(wrapper.find('[data-v-app] > div').text()).toContain('Router View')
  })

  it('has correct CSS classes for layout', () => {
    wrapper = createWrapper()
    
    const mainDiv = wrapper.find('.min-h-screen')
    expect(mainDiv.classes()).toContain('bg-gray-100')
    
    const container = wrapper.find('.container')
    expect(container.classes()).toContain('mx-auto')
    expect(container.classes()).toContain('px-4')
    expect(container.classes()).toContain('py-8')
  })

  it('renders components in correct order', () => {
    wrapper = createWrapper()
    
    const components = wrapper.text()
    const headerIndex = components.indexOf('Header')
    const rgpdIndex = components.indexOf('RGPD')
    const routerIndex = components.indexOf('Router View')
    const footerIndex = components.indexOf('Footer')
    
    expect(headerIndex).toBeLessThan(rgpdIndex)
    expect(rgpdIndex).toBeLessThan(routerIndex)
    expect(routerIndex).toBeLessThan(footerIndex)
  })
})
