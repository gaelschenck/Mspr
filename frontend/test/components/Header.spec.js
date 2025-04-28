import { describe, it, expect } from 'vitest'
import { mount } from '@vue/test-utils'
import Header from '@/components/Header.vue'

describe('ce test fait une verification si le  composant  header.vue est monté correctement dans le dom', () => {
  it('le composant header est monté correctement dans le dom', () => {
    const wrapper = mount(Header)
    expect(wrapper.exists()).toBe(true)
  })
})