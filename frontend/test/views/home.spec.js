import { describe, it, expect } from 'vitest'
import { mount } from '@vue/test-utils'
import Home from '@/views/home.vue'

describe('ce test fait une verification si le  d\' aceuille \'homr.vue\'  est monté correctement dans le dom', () => {
  it('le page aceuille  se monte  correctement', () => {
    const wrapper = mount(Home)
    expect(wrapper.exists()).toBe(true)
  })
})