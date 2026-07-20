import request from './request'

export function getStatistics(params?: Record<string, unknown>) {
  return request.get('/statistics/summary', { params })
}

export function getMonthlyTrend() {
  return request.get('/statistics/visit-count')
}

export function getSyndromeDistribution() {
  return request.get('/statistics/syndrome-distribution')
}

export function getHerbUsageRanking() {
  return request.get('/statistics/herb-ranking')
}
