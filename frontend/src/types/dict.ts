export interface DiagnosisResult {
  pattern: string
  confidence: number
  description: string
  symptoms: string[]
}

export interface CustomDiagnosis {
  id: string
  pattern: string
  description: string
  symptoms: string[]
}

export interface SyndromePattern {
  name: string
  code: string
  etiology: string
  pathogenesis: string
  pulse: string
  tongue: string
  differentiation: { symptom: string; weight: string }[]
}

export interface SymptomDictItem {
  id: number
  name: string
  category: string
}
