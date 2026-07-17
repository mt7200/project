export interface User {
  id: number
  username: string
  realName: string
  role: string
  /** 后端/me 接口不返回，由前端本地补充 */
  title?: string
  token?: string
}

export interface LoginParams {
  username: string
  password: string
  rememberMe?: boolean
}

export interface LoginResult {
  token: string
  user: User
}