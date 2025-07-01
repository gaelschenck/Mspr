
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


});
