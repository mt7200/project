
export interface UpdateUserParams {
  user_id: number
  update_by: number
}

export interface DepartmentItem {
  id: number
  belongto: number | null
  text: string
  children?: DepartmentItem[]
}


export interface UserItem {
  user_name?: string
  account?: string
  create_time?: string
  user_status?: string
  id?: number
  memo?: string
  [key: string]: any
}

export interface GridData<T> {
  count?: number
  data?: UserItem[]
}

export interface QueryParams {
  user_name?: string
  account?: string
  departmentIds?: number[]
  start?: number
  limit?: number
}



export interface User extends UserItem {
  id?: number
  user_id?: number
  user_name?: string
  department?: string
  department_id?: number
  userStatus?: boolean
  memo?: string
  phone?: string
  createTime?: string
  remark?: string
}

export interface DepartmentNode {
  id: number
  user_name: string
  children?: DepartmentNode[]
}


export interface SaveUserParams {
  user_id?: number
  user_name: string
  account: string
  department_id: number
  phone?: string
  remark?: string
  password?: string
}

export interface RoleItem {
  role_id: number
  role_name: string
}

/**
 * 分页信息接口
 */
export interface PageInfo {
  total: number
  pageSize: number
  currentPage: number
}
