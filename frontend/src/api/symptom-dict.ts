import request from './request'

export interface SymptomDictItem {
  id: number
  category: string
  subCategory?: string
  label: string
  sortOrder?: number
  isCommon?: number
  weight?: number
}

export function getSymptomList(params?: {
  category?: string
  isCommon?: number
  skip?: number
  limit?: number
}) {
  return request.get<any, SymptomDictItem[]>('/symptom-dict', { params })
}

export function getSymptomCategories() {
  return request.get<any, string[]>('/symptom-dict/categories')
}