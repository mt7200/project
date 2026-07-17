export interface EMR {
  id: number
  name: string
  gender: string
  age: number
  visitDate: string
  chiefComplaint: string
  presentIllness: string
  pastHistory: string
  tongueImage: string
  pulseImage: string
  complexion: string
  voice: string
  syndrome: string
  diagnosis: string
  treatmentPrinciple: string
  prescription: string
  notes: string
}

export interface HistoryRecord {
  id: number
  patientName: string
  gender: string
  age: number
  visitDate: string
  chiefComplaint: string
  diagnosis: string
  syndrome: string
  prescription: string
  treatmentResult: string
  followUp: string
  docName: string
}
