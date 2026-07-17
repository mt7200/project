export interface User {
  id: number
  username: string
  realName: string
  role: string
  title: string
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
