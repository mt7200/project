import api from '@/utils/http'
import { type DepartmentItem } from './type'

/**
 * 查询部门树
 */
export const queryDepartmentTree = async (params?: any): Promise<DepartmentItem[]> => {
  const res: DepartmentItem[] = await api.get({
    url: '/data/TreeDerpartment.json',
    params: { ...params }
  })

  return res || []
}


/**
 * 启用/禁用部门
 * 
 *  **/
export const toggleDepartmentStatus = async (id: number, enable: number) => {
  try {
    const res = await api.post({
      url: '/json/UpdateDepartmentEnable.json',
      params: {
        data: {
          id: id,
          enable: enable
        }
      }

    })

    return res
  } catch (error) {
    console.error("操作失败:", error)
    return null
  }
}

/**
 * 删除部门
 */
export const deleteDepartment = async (data: any) => {
  try {
    const res = await api.post({
      url: '/json/DeleteDerpartment.json',
      data: {
        ...data
      }
    })
    return res
  } catch (error) {
    console.error('删除部门失败:', error)
    return null
  }
}


/**
 * 新增部门
 */
export const insertDepartment = async (data: DepartmentItem) => {
  try {
    const res = await api.post({
      url: '/data/InsertDepartment.json',
      data: {
        data: {
          ...data
        }
      },
    })
    return res
  } catch (error) {
    console.error('新增部门失败:', error)
    return null
  }
}

/**
 * 部门信息更新
 */
export const updateDepartment = async (data: DepartmentItem) => {
  try {
    const res = await api.post({
      url: '/json/UpdateDepartment.json',
      data: {
        data: {
          ...data
        }
      }
    })
    return res
  } catch (error) {
    console.error('更新部门失败:', error)
    return null
  }
}


/**
 * 层级调整
 */
export const adjustDepartmentLevel = async (data: any) => {
  try {
    const res = await api.post({
      url: '/json/HierarchyAdjustment.json',
      params: {
        data: {
          ...data
        }
      }
    })
    return res
  } catch (error) {
    console.error('层级调整失败:', error)
    return null
  }
}
