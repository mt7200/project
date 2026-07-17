import request from './request'

export interface SyndromePattern {
  id: number
  patternName: string
  patternCode?: string
  category?: string
  etiology?: string
  pathogenesis?: string
  keySymptoms?: string
  pulsePattern?: string
  tonguePattern?: string
  differentiation?: string
  treatmentMethod?: string
  recommendedFormula?: string
  relatedDiagnosis?: string
  sortOrder?: number
}

export function getSyndromePatterns(params?: {
  category?: string
  keyword?: string
  skip?: number
  limit?: number
}) {
  return request.get<any, SyndromePattern[]>('/syndrome-patterns', { params })
}

export function getSyndromePattern(id: number) {
  return request.get<any, SyndromePattern>(`/syndrome-patterns/${id}`)
}

export function searchSyndromePatterns(keyword: string) {
  return request.get<any, SyndromePattern[]>('/syndrome-patterns', { params: { keyword, limit: 50 } })
}