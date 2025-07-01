
import { mount } from '@vue/test-utils';
import { describe, it, expect, vi, beforeEach, afterEach } from 'vitest';
import PredictionGraphs from '../src/components/predictionGraphs.vue'; 
import { useRoute } from 'vue-router'; 

vi.mock('vue-i18n', () => ({
  useI18n: () => ({
    t: (key) => key, 
  }),
}));

vi.mock('chart.js/auto', () => ({
  default: vi.fn().mockImplementation(() => ({
    destroy: vi.fn(), 
  })),
}));


vi.mock('vue-router', () => ({
  useRoute: vi.fn(),
}));

describe('PredictionGraphs.vue', () => {
  const mockPredictionResult = {
    rmse: 10.123,
    r2: 0.9876,
   
    prediction: [
      { year: 2010, value: 100, lower: 90, upper: 110 },
      { year: 2011, value: 105, lower: 95, upper: 115 },
    ],
    future_prediction: 120.456,
    future_year: 2025,
    message: 'Test prediction message',
    metadata: {
      region: 'Europe',
      indicator: 'HIV Prevalence',
      year_range: '2010-2011',
    },
  };

  beforeEach(() => {
    vi.useFakeTimers();
    vi.clearAllMocks()
    useRoute.mockReturnValue({
      query: {
        result: JSON.stringify(mockPredictionResult),
      },
    });
  });

  afterEach(() => {
    vi.runOnlyPendingTimers(); 
    vi.useRealTimers(); 
  });

 
  const mountAndInitComponent = async (mockResultOverride = null) => {

    const currentMockResult = mockResultOverride || mockPredictionResult;
    useRoute.mockReturnValue({
      query: {
        result: JSON.stringify(currentMockResult),
      },
    });

    const wrapper = mount(PredictionGraphs, {
      global: {
        mocks: {
          $t: (key) => key,
        },
      }
    });

  
    vi.runAllTimers();
 
    await wrapper.vm.$nextTick();

    await wrapper.vm.$nextTick(); 
    
    return wrapper;
  };

  it('renders title and performance metrics when result is present', async () => {
    const wrapper = await mountAndInitComponent();

    expect(wrapper.find('h2').text()).toContain('prediction_results_title');
    expect(wrapper.find('.metrics').exists()).toBe(true);
    expect(wrapper.html()).toContain('rmse');
    expect(wrapper.html()).toContain('r2');
    expect(wrapper.html()).toContain('data_points');
    expect(wrapper.html()).toContain('period');
    expect(wrapper.findAll('.metric-value')[2].text()).toBe(mockPredictionResult.prediction.length.toString()); 
    expect(wrapper.find('.metric-value').text()).toContain('10.12');
    expect(wrapper.findAll('.metric-value')[1].text()).toContain('0.988'); 
    expect(wrapper.findAll('.metric-value')[3].text()).toContain('2010-2011'); 
  });

  it('renders future prediction section when future_prediction is available', async () => {
    const wrapper = await mountAndInitComponent();

    expect(wrapper.find('.future-prediction').exists()).toBe(true);
    expect(wrapper.find('.future-year').text()).toBe('2025');
    expect(wrapper.find('.future-value').text()).toBe('120.46'); 
    expect(wrapper.find('.future-label').text()).toContain('prediction_future_desc');
  });


  it('displays success message if result has a message', async () => {
    const wrapper = await mountAndInitComponent();

    expect(wrapper.find('.success-message').exists()).toBe(true);
    expect(wrapper.find('.success-message p').text()).toBe('Test prediction message');
  });

  it('renders chart canvas if hasValidPredictionData returns true', async () => {
    const wrapper = await mountAndInitComponent();

    expect(wrapper.find('#myChart').exists()).toBe(true); 
  });

  it('displays no data message if hasValidPredictionData returns false', async () => {

    const wrapper = await mountAndInitComponent({ ...mockPredictionResult, prediction: [] });

    expect(wrapper.find('#myChart').exists()).toBe(false);
    expect(wrapper.find('.no-data').exists()).toBe(true);
    expect(wrapper.find('.no-data p').text()).toContain('prediction_no_data');
  });

  // Tests simples pour couvrir les fonctions utilitaires
  it('should handle getDataLength function correctly', async () => {
    const wrapper = await mountAndInitComponent();
    // Accéder à la fonction via l'instance du composant
    expect(wrapper.vm.getDataLength()).toBe(2);
  });

  it('should handle getDataLength with empty prediction', async () => {
    const wrapper = await mountAndInitComponent({ ...mockPredictionResult, prediction: [] });
    expect(wrapper.vm.getDataLength()).toBe(0);
  });

  it('should handle getDataLength with null result', async () => {
    // Vraiment passer null et vérifier que result.value est null
    useRoute.mockReturnValue({
      query: {}
    });
    const wrapper = mount(PredictionGraphs, {
      global: {
        mocks: {
          $t: (key) => key,
        },
      }
    });
    vi.runAllTimers();
    await wrapper.vm.$nextTick();
    expect(wrapper.vm.getDataLength()).toBe('N/A');
  });

  it('should handle hasValidPredictionData function correctly', async () => {
    const wrapper = await mountAndInitComponent();
    expect(wrapper.vm.hasValidPredictionData()).toBe(true);
  });

  it('should handle hasValidPredictionData with empty prediction', async () => {
    const wrapper = await mountAndInitComponent({ ...mockPredictionResult, prediction: [] });
    expect(wrapper.vm.hasValidPredictionData()).toBe(false);
  });

  it('should handle hasValidPredictionData with null result', async () => {
    // Vraiment passer null et vérifier que result.value est null
    useRoute.mockReturnValue({
      query: {}
    });
    const wrapper = mount(PredictionGraphs, {
      global: {
        mocks: {
          $t: (key) => key,
        },
      }
    });
    vi.runAllTimers();
    await wrapper.vm.$nextTick();
    expect(wrapper.vm.hasValidPredictionData()).toBe(false);
  });

  it('should handle getChartTitle with filters', async () => {
    const mockWithFilters = {
      ...mockPredictionResult,
      filters: {
        pays: 'France',
        indicator_types: ['HIV Prevalence']
      }
    };
    const wrapper = await mountAndInitComponent(mockWithFilters);
    const title = wrapper.vm.getChartTitle();
    expect(title).toContain('France');
  });

  it('should handle getChartTitle with region filter only', async () => {
    const mockWithRegionFilter = {
      ...mockPredictionResult,
      filters: {
        who_region: 'Europe',
        indicator_types: ['Mortality Rate']
      }
    };
    const wrapper = await mountAndInitComponent(mockWithRegionFilter);
    const title = wrapper.vm.getChartTitle();
    expect(title).toBeTruthy();
  });

  it('should handle getChartTitle without filters', async () => {
    const wrapper = await mountAndInitComponent();
    const title = wrapper.vm.getChartTitle();
    expect(title).toBe('prediction_chart_title');
  });

  it('should handle getXAxisLabel with year labels', async () => {
    const mockWithYearLabels = {
      ...mockPredictionResult,
      labels: [2020, 2021, 2022]
    };
    const wrapper = await mountAndInitComponent(mockWithYearLabels);
    const label = wrapper.vm.getXAxisLabel();
    expect(label).toBe('prediction_years');
  });

  it('should handle getXAxisLabel without year labels', async () => {
    const mockWithoutYearLabels = {
      ...mockPredictionResult,
      labels: ['label1', 'label2']
    };
    const wrapper = await mountAndInitComponent(mockWithoutYearLabels);
    const label = wrapper.vm.getXAxisLabel();
    expect(label).toBe('prediction_period_points');
  });

  it('should handle getXAxisLabel without labels', async () => {
    const wrapper = await mountAndInitComponent();
    const label = wrapper.vm.getXAxisLabel();
    expect(label).toBe('prediction_period_points');
  });

  it('should handle getYAxisLabel with value_types', async () => {
    const mockWithValueTypes = {
      ...mockPredictionResult,
      filters: {
        value_types: ['percentage']
      }
    };
    const wrapper = await mountAndInitComponent(mockWithValueTypes);
    const label = wrapper.vm.getYAxisLabel();
    expect(label).toContain('percentage');
  });

  it('should handle getYAxisLabel with indicator_types', async () => {
    const mockWithIndicatorTypes = {
      ...mockPredictionResult,
      filters: {
        indicator_types: ['HIV Prevalence']
      }
    };
    const wrapper = await mountAndInitComponent(mockWithIndicatorTypes);
    const label = wrapper.vm.getYAxisLabel();
    expect(label).toContain('HIV Prevalence');
  });

  it('should handle getYAxisLabel without filters', async () => {
    const wrapper = await mountAndInitComponent();
    const label = wrapper.vm.getYAxisLabel();
    expect(label).toBe('prediction_predicted_values');
  });

  it('should handle error in result parsing', async () => {
    useRoute.mockReturnValue({
      query: {
        result: 'invalid-json'
      },
    });

    const wrapper = mount(PredictionGraphs, {
      global: {
        mocks: {
          $t: (key) => key,
        },
      }
    });

    vi.runAllTimers();
    await wrapper.vm.$nextTick();
    
    expect(wrapper.vm.result).toBe(null);
  });

  it('should handle missing route query', async () => {
    useRoute.mockReturnValue({
      query: {}
    });

    const wrapper = mount(PredictionGraphs, {
      global: {
        mocks: {
          $t: (key) => key,
        },
      }
    });

    vi.runAllTimers();
    await wrapper.vm.$nextTick();
    
    expect(wrapper.vm.result).toBe(null);
  });

  it('should handle alternative predictions format', async () => {
    const mockWithPredictions = {
      ...mockPredictionResult,
      predictions: [
        { year: 2020, value: 50 },
        { year: 2021, value: 55 }
      ]
    };
    delete mockWithPredictions.prediction;
    
    const wrapper = await mountAndInitComponent(mockWithPredictions);
    expect(wrapper.vm.hasValidPredictionData()).toBe(true);
    expect(wrapper.vm.getDataLength()).toBe(2);
  });

  it('should handle chart creation with missing canvas', async () => {
    const wrapper = await mountAndInitComponent();
    
    // Mock getElementById to return null et créer un spy
    const mockGetElementById = vi.spyOn(document, 'getElementById').mockReturnValue(null);
    
    // Call createChart directly
    wrapper.vm.createChart();
    
    // Check that getElementById was called
    expect(mockGetElementById).toHaveBeenCalledWith('myChart');
    
    // Restore original function
    mockGetElementById.mockRestore();
  });

  it('should destroy existing chart instance before creating new one', async () => {
    const wrapper = await mountAndInitComponent();
    
    // Mock chart instance with destroy method
    const mockDestroy = vi.fn();
    wrapper.vm.chartInstance = { destroy: mockDestroy };
    
    // Mock canvas and context
    const mockCanvas = { getContext: vi.fn().mockReturnValue({}) };
    document.getElementById = vi.fn().mockReturnValue(mockCanvas);
    
    wrapper.vm.createChart();
    
    expect(mockDestroy).toHaveBeenCalled();
  });


});
