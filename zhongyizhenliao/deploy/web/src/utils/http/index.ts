/**
 * HTTP 请求封装模块
 * 基于 Axios 封装的 HTTP 请求工具，提供统一的请求/响应处理
 *
 * ## 主要功能
 *
 * - 请求/响应拦截器（自动添加 Token、统一错误处理）
 * - 401 未授权自动登出（带防抖机制）
 * - 请求失败自动重试（可配置）
 * - 统一的成功/错误消息提示
 * - 支持 GET/POST/PUT/DELETE 等常用方法
 *
 * @module utils/http
 * @author Art Design Pro Team
 */

import axios, {AxiosError, AxiosRequestConfig, AxiosResponse, InternalAxiosRequestConfig } from 'axios'
import { useUserStore } from '@/store/modules/user'
import { ApiStatus } from './status'
import { HttpError, handleError, showError, showSuccess } from './error'
import { $t } from '@/locales'
import { BaseResponse } from '@/types'
import { setAxiosInstance, getAxiosInstance, setAxiosDefaults } from 'hearken-web-jfui'
const jfuiAxios = getAxiosInstance()

/** 请求配置常量 */
const REQUEST_TIMEOUT = 15000
const MAX_RETRIES = 0
const RETRY_DELAY = 1000
const UNAUTHORIZED_DEBOUNCE_TIME = 3000

/** 401防抖状态 */
let isUnauthorizedErrorShown = false
let unauthorizedTimer: ReturnType<typeof setTimeout> | null = null

/** 扩展 AxiosRequestConfig */
interface ExtendedAxiosRequestConfig extends AxiosRequestConfig {
  showErrorMessage?: boolean
  showSuccessMessage?: boolean
}

const { VITE_API_URL, VITE_WITH_CREDENTIALS } = import.meta.env
jfuiAxios.defaults.baseURL = VITE_API_URL
/** Axios实例 */
const axiosInstance = axios.create({
  timeout: REQUEST_TIMEOUT,
  baseURL: VITE_API_URL,
  withCredentials: VITE_WITH_CREDENTIALS === 'true',
  validateStatus: (status) => status >= 200 && status < 300,
  transformResponse: [
    (data, headers) => {
      const contentType = headers['content-type']
      if ((typeof contentType === 'string' || Array.isArray(contentType)) && contentType?.includes('application/json')) {
        try {
          return JSON.parse(data)
        } catch {
          return data
        }
      }
      return data
    }
  ]
})

/** 请求拦截器 */
axiosInstance.interceptors.request.use(
  (request: InternalAxiosRequestConfig) => {
    const { accessToken } = useUserStore()
    if (accessToken) request.headers.set('Authorization',`Bearer ${accessToken}`)
    const loginMode = import.meta.env.VITE_LOGIN_MODE
    // 设置请求路径
    if (loginMode) {
      request.headers.set('authType', loginMode)
    }

    if (request.data && !(request.data instanceof FormData) && !request.headers['Content-Type']) {
      request.headers.set('Content-Type', 'application/json')
      request.data = JSON.stringify(request.data)
    }

    return request
  },
  (error) => {
    showError(createHttpError($t('httpMsg.requestConfigError'), ApiStatus.error))
    return Promise.reject(error)
  }
)

jfuiAxios.interceptors.request.use(
  (request: InternalAxiosRequestConfig) => {
    const { accessToken } = useUserStore()
    if (accessToken) request.headers.set('Authorization', `Bearer ${accessToken}`)
    return request
  },
  (error: AxiosError | any) => {
    showError(createHttpError($t('httpMsg.requestConfigError'), ApiStatus.error))
    return Promise.reject(error)
  }
)
/** CAS 重定向防抖状态 */
let isCasRedirecting = false

/**
 * 处理 CAS 重定向：让浏览器进行顶层导航以触发 CAS 登录流程
 * axios（XHR）无法阻止自动跟随 302，故由后端返回 JSON，前端检测 440 后由浏览器重新发起顶层导航
 */
function handleCasRedirect(): Promise<never> {
  if (!isCasRedirecting) {
    isCasRedirecting = true
    // 保存当前路由路径（hash 模式下等同于 Vue Router 的 to.fullPath），登录回调后由路由守卫恢复
    const hash = window.location.hash || '#/'
    const currentPath = hash.startsWith('#') ? hash.slice(1) : hash
    sessionStorage.setItem('cas_redirect', currentPath || '/')
    const casServiceUrl =
      window.location.origin +
      import.meta.env.VITE_API_URL +
      '/data/Login.json?authType=authCasStrategy'
    window.location.href = `${import.meta.env.VITE_CAS_BASE_URL}/cas/login?service=${encodeURIComponent(casServiceUrl)}`
  }
  // 返回一个永不 resolve 的 Promise，阻止后续业务逻辑执行（页面即将跳转）
  return new Promise<never>(() => {})
}

/** 响应拦截器 */
axiosInstance.interceptors.response.use(
  (response: AxiosResponse<BaseResponse>) => {
    const data = response.data
    const loginMode = import.meta.env.VITE_LOGIN_MODE
    if (data?.code === 440 && loginMode === 'authCasStrategy') {
      return handleCasRedirect()
    }
    // 如果响应是纯文本字符串
    if (typeof data === 'string') {
      // 检查是否是 token 无效消息
      if (isTokenInvalidMessage(data)) {
        handleUnauthorizedError(data)
      }
      // 抛出错误，包含原始文本
      throw createHttpError(data || $t('httpMsg.requestFailed'), ApiStatus.error)
    }

    const { code, msg } = data
    if (code === ApiStatus.success || code === 1) return response
    if (code === ApiStatus.unauthorized || isTokenInvalidMessage(msg)) handleUnauthorizedError(msg)
    throw createHttpError(msg || $t('httpMsg.requestFailed'), code)
  },
  (error) => {
    if (error.response?.status === ApiStatus.unauthorized) handleUnauthorizedError()
    return Promise.reject(handleError(error))
  }
)

/** 判断是否为 token 无效消息 */
function isTokenInvalidMessage(msg: string | undefined): boolean {
  if (!msg) return false
  // 检查 token 相关错误
  if (msg.includes('token') && (msg.includes('无效') || msg.includes('失效') || msg.includes('过期') || msg.includes('顶下线'))) {
    return true
  }
  // 检查用户未分配菜单
  if (msg.includes('未分配菜单')) {
    return true
  }
  return false
}

/** 统一创建HttpError */
function createHttpError(message: string, code: number) {
  return new HttpError(message, code)
}

/** 处理401错误（带防抖） */
function handleUnauthorizedError(message?: string): never {
  const error = createHttpError(message || $t('httpMsg.unauthorized'), ApiStatus.unauthorized)

  if (!isUnauthorizedErrorShown) {
    isUnauthorizedErrorShown = true
    logOut()

    unauthorizedTimer = setTimeout(resetUnauthorizedError, UNAUTHORIZED_DEBOUNCE_TIME)

    showError(error, true)
    throw error
  }

  throw error
}

/** 重置401防抖状态 */
function resetUnauthorizedError() {
  isUnauthorizedErrorShown = false
  if (unauthorizedTimer) clearTimeout(unauthorizedTimer)
  unauthorizedTimer = null
}

/** 退出登录函数 - 同步执行跳转 */
function logOut() {
  useUserStore().logOut()
}

/** 是否需要重试 */
function shouldRetry(statusCode: number) {
  return [
    ApiStatus.requestTimeout,
    ApiStatus.internalServerError,
    ApiStatus.badGateway,
    ApiStatus.serviceUnavailable,
    ApiStatus.gatewayTimeout
  ].includes(statusCode)
}

/** 请求重试逻辑 */
async function retryRequest<T>(
  config: ExtendedAxiosRequestConfig,
  retries: number = MAX_RETRIES
): Promise<T> {
  try {
    return await request<T>(config)
  } catch (error) {
    if (retries > 0 && error instanceof HttpError && shouldRetry(error.code)) {
      await delay(RETRY_DELAY)
      return retryRequest<T>(config, retries - 1)
    }
    throw error
  }
}

/** 延迟函数 */
function delay(ms: number) {
  return new Promise((resolve) => setTimeout(resolve, ms))
}

/** 请求函数 */
async function request<T = any>(config: ExtendedAxiosRequestConfig): Promise<T> {
  // POST | PUT 参数自动填充
  if (
    ['POST', 'PUT'].includes(config.method?.toUpperCase() || '') &&
    config.params &&
    !config.data
  ) {
    config.data = config.params
    config.params = undefined
  }

  try {
    const res = await axiosInstance.request<BaseResponse<T>>(config)

    // 显示成功消息
    if (config.showSuccessMessage && res.data.msg) {
      showSuccess(res.data.msg)
    }

    return res.data.data as T
  } catch (error) {
    if (error instanceof HttpError && error.code !== ApiStatus.unauthorized) {
      const showMsg = config.showErrorMessage !== false
      showError(error, showMsg)
    }
    return Promise.reject(error)
  }
}

/** API方法集合 */
const api = {
  get<T>(config: ExtendedAxiosRequestConfig) {
    return retryRequest<T>({ ...config, method: 'GET' })
  },
  post<T>(config: ExtendedAxiosRequestConfig) {
    return retryRequest<T>({ ...config, method: 'POST' })
  },
  put<T>(config: ExtendedAxiosRequestConfig) {
    return retryRequest<T>({ ...config, method: 'PUT' })
  },
  del<T>(config: ExtendedAxiosRequestConfig) {
    return retryRequest<T>({ ...config, method: 'DELETE' })
  },
  request<T>(config: ExtendedAxiosRequestConfig) {
    return retryRequest<T>(config)
  }
}

export default api
