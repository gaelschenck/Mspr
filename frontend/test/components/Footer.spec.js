import { describe, it, expect } from 'vitest'
import { mount } from '@vue/test-utils'
import Footer from '@/components/Footer.vue'

describe('ce test fait une verification si le  composant  footer.vue est monté correctement dans le dom', () => {
  it('le composant footer est monté correctement dans le dom', () => {
    const wrapper = mount(Footer)
    expect(wrapper.exists()).toBe(true)
  })
})