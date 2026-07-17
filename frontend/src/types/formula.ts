export interface Formula {
  name: string
  category: string
  herbs: string[]
}

export interface FormulaDetail {
  name: string
  herbs: { name: string; dosage: string }[]
  effects: string[]
  reason: string
}
