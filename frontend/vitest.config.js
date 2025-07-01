/// <reference types="vitest" />
import { defineConfig } from 'vite'
import vue from '@vitejs/plugin-vue'
import { fileURLToPath, URL } from 'node:url'

export default defineConfig({
  plugins: [vue()],
  resolve: {
    alias: {
      '@': fileURLToPath(new URL('./src', import.meta.url))
    }
  },
  test: {
    globals: true,
    environment: 'jsdom',
    setupFiles: ['./vitest.setup.js'],
    include: ['tests/**/*.spec.js', 'tests/**/*.test.js'],
    coverage: {
      provider: 'v8',
      reporter: ['text', 'json', 'html', 'lcov'],
      reportsDirectory: './coverage',
      include: ['src/**/*.{js,vue}'], // Spécifier explicitement les fichiers à inclure
      exclude: [
        'node_modules/',
        'tests/',
        'src/**/*.spec.js',
        'src/**/*.test.js',
        'vitest.config.js',
        'vitest.setup.js',
        'src/main.js', // Exclude main.js si pas testé
        '**/dist/**',
        '**/build/**'
      ],
      all: true, // Inclure tous les fichiers même non importés
      clean: true // Nettoyer les rapports précédents
    }
  }
})
