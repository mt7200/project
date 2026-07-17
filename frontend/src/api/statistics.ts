import request from './request'

export function getStatistics(params?: Record<string, unknown>) {
  return request.get('/statistics', { params })
}

export function getMonthlyTrend() {
  return request.get('/statistics/monthly')
}

export function getSyndromeDistribution() {
  return request.get('/statistics/syndrome')
}

export function getHerbUsageRanking() {
  return request.get('/statistics/herb-usage')
}
