import { defineStore } from 'pinia'
import { ref } from 'vue'
import type { Patient } from '@/types/patient'
import type { SymptomForm } from '@/types/visit'

export const useVisitStore = defineStore('visit', () => {
  const currentPatient = ref<Patient | null>(null)
  const symptoms = ref<SymptomForm>({
    pulseLeft: '', pulseRight: '', pulseDescription: '', tongueColor: '',
    tongueShape: '', tongueCoating: '', tongueTexture: '', tongueRemark: '',
    facialColor: '', expression: '', mentalState: '', breathSound: '',
    speechSound: '', sweating: '', limbsTemperature: '', sleepQuality: '',
    appetite: '', thirst: '', taste: '', bowelMovement: '', urineColor: '',
    menstrualCycle: '',
  })
  const selectedHerbs = ref<{ name: string; dosage: string }[]>([])
  const selectedPattern = ref('')

  function setPatient(patient: Patient) {
    currentPatient.value = patient
  }

  function clearVisit() {
    currentPatient.value = null
    selectedHerbs.value = []
    selectedPattern.value = ''
  }

  return { currentPatient, symptoms, selectedHerbs, selectedPattern, setPatient, clearVisit }
})
