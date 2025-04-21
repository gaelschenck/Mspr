import { describe, it, expect, beforeEach } from 'vitest';
import { mount } from '@vue/test-utils';
import TestPrediction from '../src/components/TestPrediction.vue';

describe('TestPrediction.vue', () => {
  let wrapper;

  beforeEach(() => {
    wrapper = mount(TestPrediction, {
      data() {
        return {
          selectedRegion: '', // vide au départ
          selectedPays: '',
          selectedTable: null,
          selectedColumn: null,
          paysList: [
            { id: 1, nom: 'France', region: 'europe' },
            { id: 2, nom: 'Canada', region: 'ameriques' },
            { id: 3, nom: 'Bulgarie', region: 'europe' },
          ],
          tables: [],
          columns: [],
          regions: ['europe', 'ameriques'],
          showChart: false,
          chartData: null,
          chartOptions: {
            responsive: true,
            plugins: {
              legend: { position: 'top' },
              title: {
                display: true,
                text: 'Prédiction vs Réel',
              },
            },
          },
        };
      },
    });
  });

  it('affiche uniquement les pays de la région sélectionnée', async () => {
    await wrapper.setData({ selectedRegion: 'europe' });

    const paysOptions = wrapper.findAll('select#pays option');
    const optionsText = paysOptions.map(o => o.text());

    expect(optionsText).toContain('France');
    expect(optionsText).toContain('Bulgarie');
    expect(optionsText).not.toContain('Canada');
  });

  it('n’affiche aucun pays si aucune région n’est sélectionnée', () => {
    expect(wrapper.vm.filteredPaysList.length).toBe(0);
    const paysOptions = wrapper.findAll('select#pays option');
    expect(paysOptions.length).toBe(1); // juste l’option "Sélectionner un pays"
  });

  it('met à jour les pays affichés quand on change de région', async () => {
    await wrapper.setData({ selectedRegion: 'ameriques' });
    const paysOptions = wrapper.findAll('select#pays option');
    const optionsText = paysOptions.map(o => o.text());
    expect(optionsText).toContain('Canada');
    expect(optionsText).not.toContain('France');
    expect(optionsText).not.toContain('Bulgarie');
  });
});
