/**
 * 用户信息接口
 */
export interface User {
  user_id: string
  user_name: string
  account: string
  department_name: string
  [key: string]: any
}

/**
 * 模块信息接口
 */
export interface ModuleInfo {
  belongto: string
  id: string
  resource_code: string
  resource_name: string
  resource_id: string
  text: string
  iconCls: string
}

/**
 * 模块节点接口
 */
export interface ModuleNode {
  id: string
  belongto: string
  leaf: boolean
  iconCls: string
  text: string
  children?: ModuleNode[]
}

/**
 * 搜索表单接口
 */
export interface SearchForm {
  name: string
  unit: string
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
