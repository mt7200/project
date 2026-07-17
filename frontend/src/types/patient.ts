export interface Patient {
  id: number
  name: string
  gender: string
  age: number
  phone: string
  idCard?: string
  birthDate?: string
  occupation?: string
  ethnicity?: string
  maritalStatus?: string
  address?: string
  diagnosis?: string
  status?: string
}

export interface PatientSummary {
  id: number
  name: string
  gender: string
  age: number
  diagnosis: string
  visitDate: string
  followUp: string
}
