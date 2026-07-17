import axios from 'axios'
import type { AxiosInstance } from 'axios'
import { snakeToCamel } from '@/utils/common'

const request: AxiosInstance = axios.create({
  baseURL: import.meta.env.VITE_API_BASE_URL || '/api',
  timeout: 15000,
})

request.interceptors.request.use(
  (config) => {
    const token = localStorage.getItem('token')
    if (token) {
      config.headers.Authorization = `Bearer ${token}`
    }
    return config
  },
  (error) => Promise.reject(error)
)

request.interceptors.response.use(
  (response) => snakeToCamel(response.data),
  (error) => {
    if (error.response?.status === 401) {
      localStorage.removeItem('token')
      // 使用 location.href 而不是 router.push，避免循环依赖
      window.location.href = '/login'
    }
    return Promise.reject(error)
  }
)

export default request