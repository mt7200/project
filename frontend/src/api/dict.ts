import request from './request'

export function getSymptomDict(params?: Record<string, unknown>) {
  return request.get('/symptom-dict', { params })
}

export function getSyndromePatterns(params?: Record<string, unknown>) {
  return request.get('/syndrome-patterns', { params })
}

export function getDiagnoses(params?: Record<string, unknown>) {
  return request.get('/diagnoses', { params })
}

export function createDiagnosis(data: Record<string, unknown>) {
  return request.post('/diagnoses', data)
}
