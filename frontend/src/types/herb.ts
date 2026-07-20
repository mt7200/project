export interface Herb {
  id: number
  name: string
  category: string
  nature: string
  taste: string
  meridian: string
  minDosage: number
  maxDosage: number
  unit: string
  toxic: boolean
  functions: string[]
}

export interface SelectedHerb extends Herb {
  currentDosage: number
}
