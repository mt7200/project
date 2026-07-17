import request from './request'
import type { LoginParams, LoginResult } from '@/types/user'

// ===== 控制开关：后端未就绪时可切回 Mock =====
// 后端完成后设为 false 即可，无需改动其他代码
const USE_MOCK = false

// ===== Mock 数据（后端未完成时使用） =====
const MOCK_DELAY = 800

const mockUsers = [
  { id: 1, username: 'admin', password: '123456', realName: '管理员', role: 'admin', title: '系统管理员' },
  { id: 2, username: 'doctor', password: '123456', realName: '李医生', role: 'doctor', title: '主治医师' },
]

function mockLogin(data: LoginParams): Promise<LoginResult> {
  return new Promise((resolve, reject) => {
    setTimeout(() => {
      const user = mockUsers.find((u) => u.username === data.username && u.password === data.password)
      if (user) {
        resolve({
          token: 'mock-token-' + Date.now(),
          user,
        })
      } else {
        reject(new Error('用户名或密码错误'))
      }
    }, MOCK_DELAY)
  })
}

// ===== 导出接口 =====

export function login(data: LoginParams): Promise<LoginResult> {
  if (USE_MOCK) {
    return mockLogin(data)
  }
  return request.post<any, LoginResult>('/auth/login', data)
}

export function logout() {
  if (USE_MOCK) {
    return Promise.resolve({ message: '已退出登录' })
  }
  return request.post('/auth/logout')
}

export function getUserInfo(): Promise<{ id: number; username: string; realName: string; role: string }> {
  return request.get('/auth/me')
}