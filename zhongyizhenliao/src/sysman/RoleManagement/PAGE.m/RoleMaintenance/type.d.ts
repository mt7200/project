/**
 * 角色信息接口
 */
export interface Role {
  role_id: number
  role_name: string
  role_code: string
  sort: number
  remark: string
  enable: number
  description: string
}

/**
 * 搜索表单接口
 */
export interface SearchForm {
  roleId: string
  name: string
  sort: number | null
  remark?: string
}

/**
 * 分页信息接口
 */
export interface PageInfo {
  total: number
  pageSize: number
  currentPage: number
}

/**
 * 通用列表响应接口
 */
export interface GeneralListResponse<T> {
  data: T[]
  count: number
}

// 分页组件实例
export interface HGridPagingInstance {
  reload: (dataUrl?: string, params?: Record<string, any>) => Promise<void>;
}
