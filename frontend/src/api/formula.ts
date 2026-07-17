import request from './request'

export function getFormulas(params?: Record<string, unknown>) {
  return request.get('/formulas', { params })
}

export function getFormula(id: number) {
  return request.get(`/formulas/${id}`)
}

export function searchFormulas(keyword: string) {
  return request.get('/formulas/search', { params: { keyword } })
}
