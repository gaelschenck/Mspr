import { setActivePinia, createPinia } from 'pinia'
import { usePredictionStore } from '@/store/predictionStore'
import { describe, it, expect,beforeEach } from 'vitest'

const realData = [18000, 22000, 19000];
const predictedData = [18666.359664214782, 20613.517480325256, 19260.000000001975];
const labels = [2018, 2010, 2000]

describe('ce teste verifie le changement  d\' etat des variable dans le fichier predictionStore.js',()=> {
    beforeEach(() => {
        setActivePinia(createPinia()) // Chaque test a son propre Pinia
      })
    it("tester l'etat initiale du store",()=> {
        const usePrediction = usePredictionStore()
        expect(usePrediction.realData).toEqual([])
        expect(usePrediction.predictedData).toEqual([])
        expect(usePrediction.labels).toEqual([])
    })
    it("tester le fonction setPredictionData ",() => {
        const usePrediction = usePredictionStore()
        usePrediction.setPredictionData(realData,predictedData,labels)
        expect(usePrediction.realData).toEqual(realData)
        expect(usePrediction.predictedData).toEqual(predictedData)
        expect(usePrediction.labels).toEqual(labels)
    })
})