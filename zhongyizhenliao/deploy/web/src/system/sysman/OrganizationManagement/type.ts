
export interface DepartmentItem {
  id?: number | null
  belongto?: number | null 
  text?: string
  tel?: string
  email?: string
  sequence?: number
  address?: string
  memo?: string
  enable?: number
  children?: DepartmentItem[]
}