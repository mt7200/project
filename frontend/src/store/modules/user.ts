import { defineStore } from 'pinia'
import { ref, computed } from 'vue'
import type { User, LoginParams } from '@/types/user'
import { login as loginApi, getUserInfo as getCurrentUserInfo } from '@/api/auth'

export const useUserStore = defineStore('user', () => {
  const token = ref<string>(localStorage.getItem('token') || '')
  const userInfo = ref<User | null>(null)

  const isLoggedIn = computed(() => !!token.value)

  function setToken(t: string) {
    token.value = t
    localStorage.setItem('token', t)
  }

  function setUserInfo(info: User) {
    userInfo.value = info
  }

  async function login(params: LoginParams) {
    const res = await loginApi(params)
    setToken(res.token)
    setUserInfo(res.user)
    return res
  }

  /**
   * 刷新页面时恢复用户信息
   * 有 token 时从后端获取 /auth/me
   */
  async function restoreUserInfo() {
    if (!token.value) return
    try {
      const info = await getCurrentUserInfo()
      setUserInfo(info as User)
    } catch {
      // token 无效或后端未就绪，清除登录状态
      logout()
    }
  }

  function logout() {
    token.value = ''
    userInfo.value = null
    localStorage.removeItem('token')
  }

  return { token, userInfo, isLoggedIn, setToken, setUserInfo, login, restoreUserInfo, logout }
})