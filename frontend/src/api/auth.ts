import request from './request'
import type { LoginParams, LoginResult } from '@/types/user'

export function login(data: LoginParams) {
  return request.post<any, LoginResult>('/auth/login', data)
}

export function logout() {
  return request.post('/auth/logout')
}

export function getUserInfo() {
  return request.get('/auth/me')
}
