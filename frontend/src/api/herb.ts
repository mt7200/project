import request from './request'
import type { Herb } from '@/types/herb'

export function getHerbs(params?: Record<string, unknown>) {
  return request.get('/herbs', { params })
}

export function getHerb(id: number) {
  return request.get(`/herbs/${id}`)
}

export function searchHerbs(keyword: string) {
  return request.get('/herbs/search', { params: { keyword } })
}
