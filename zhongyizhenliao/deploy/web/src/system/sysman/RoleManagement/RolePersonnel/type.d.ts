/**
 * 角色信息接口
 */
export interface Role {
  role_name: string
  role_code: string
  role_id: number
  description: string
  enable: number
  remark: string
  sort: number
}

/**
 * 用户信息接口
 */
export interface User {
  user_id: string
  user_name: string
  account: string
  phone: string
  user_status: number
}

/**
 * 搜索表单接口
 */
export interface SearchForm {
  userId: string
  userName: string
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
 * 一般列表接口返回值接口
 * @template T - 列表数据类型
 */
export interface GeneralListResponse<T> {
  pageSize: number;
  data: T[];
  count: number;
}
