export interface Visit {
  id: number
  patientId: number
  patientName: string
  visitDate: string
  chiefComplaint: string
  presentIllness: string
  pastHistory: string
  familyHistory: string
  allergyHistory: string
  personalHistory: string
}

export interface SymptomForm {
  pulseLeft: string
  pulseRight: string
  pulseDescription: string
  tongueColor: string
  tongueShape: string
  tongueCoating: string
  tongueTexture: string
  tongueRemark: string
  facialColor: string
  expression: string
  mentalState: string
  breathSound: string
  speechSound: string
  sweating: string
  limbsTemperature: string
  sleepQuality: string
  appetite: string
  thirst: string
  taste: string
  bowelMovement: string
  urineColor: string
  menstrualCycle: string
}
