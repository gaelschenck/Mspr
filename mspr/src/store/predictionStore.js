import { defineStore } from 'pinia';

export const usePredictionStore = defineStore('prediction', {
  state: () => ({
    realData: [],
    predictedData: [],
    labels: []
  }),
  actions: {
    setPredictionData(realData, predictedData, labels) {
      this.realData = realData;
      this.predictedData = predictedData;
      this.labels = labels;
    }
  }
});