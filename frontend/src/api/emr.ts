import request from './request'

export function getEMRs(params?: Record<string, unknown>) {
  return request.get('/emrs', { params })
}

export function getEMR(id: number) {
  return request.get(`/emrs/${id}`)
}

export function updateEMR(id: number, data: Record<string, unknown>) {
  return request.put(`/emrs/${id}`, data)
}

export function getHistoryRecords(params?: Record<string, unknown>) {
  return request.get('/emrs/history', { params })
}
