import request from './request'
import type { Patient } from '@/types/patient'

export function getPatients(params?: Record<string, unknown>) {
  return request.get('/patients', { params })
}

export function getPatient(id: number) {
  return request.get(`/patients/${id}`)
}

export function createPatient(data: Partial<Patient>) {
  return request.post('/patients', data)
}

export function updatePatient(id: number, data: Partial<Patient>) {
  return request.put(`/patients/${id}`, data)
}

export function deletePatient(id: number) {
  return request.delete(`/patients/${id}`)
}
