import request from './request'

export function getPrescriptions(params?: Record<string, unknown>) {
  return request.get('/prescriptions', { params })
}

export function getPrescription(id: number) {
  return request.get(`/prescriptions/${id}`)
}

export function createPrescription(data: Record<string, unknown>) {
  return request.post('/prescriptions', data)
}

export function updatePrescription(id: number, data: Record<string, unknown>) {
  return request.put(`/prescriptions/${id}`, data)
}
