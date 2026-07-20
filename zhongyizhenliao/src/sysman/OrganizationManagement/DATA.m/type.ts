
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
  [key: string]: any
}

export interface QueryParams {
  user_name?: string
  account?: string
  departmentIds?: number[]
}

export interface GridData<T> {
  count?: number
  data?: T[]
}



export interface User extends UserItem {
  id?: number
  user_id?: number
  name?: string
  department?: string
  department_id?: number
  userStatus?: boolean
  remark?: string
  createTime?: string
}

export interface DepartmentNode {
  id: number
  name: string
  children?: DepartmentNode[]
}


