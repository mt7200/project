import request from './request'

export function getVisits(params?: Record<string, unknown>) {
  return request.get('/visits', { params })
}

export function getVisit(id: number) {
  return request.get(`/visits/${id}`)
}

export function createVisit(data: Record<string, unknown>) {
  return request.post('/visits', data)
}

export function updateVisit(id: number, data: Record<string, unknown>) {
  return request.put(`/visits/${id}`, data)
}

export function deleteVisit(id: number) {
  return request.delete(`/visits/${id}`)
}
