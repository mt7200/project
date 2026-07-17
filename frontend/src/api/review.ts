import request from './request'

export function getReviewList(params?: Record<string, unknown>) {
  return request.get('/review', { params })
}

export function reviewPrescription(id: number, data: { status: string; comment?: string }) {
  return request.post(`/review/${id}`, data)
}
