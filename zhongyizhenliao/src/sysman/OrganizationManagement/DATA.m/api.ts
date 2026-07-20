import api from '@/utils/http'
import { buildTree } from './utils'
import { type UserItem, type QueryParams, type DepartmentItem, type GridData } from './type'


/**
 * 查询用户入网列表
 */
export const queryUserList = async (
  params?: QueryParams
): Promise<GridData<UserItem>> => {
  try {
    const res: GridData<UserItem> = await api.get({
      url: '/data/SystemUserPage.json',
      params: {
        user_name: params?.user_name || '',
        account: params?.account || '',
        ...(params?.departmentIds?.length
          ? { departmentIds: params.departmentIds.join(',') }
          : {})
      }
    })

    return res || {}
  } catch (error) {
    console.error('查询用户入网列表失败:', error)
    return {}
  }
}




/**
 * 重置用户密码
 */
export const resetUserPassword = async (userId: number, updateBy: number) => {
  try {
    const res = await api.post({
      url: '/json/ResetPassword.json',
      data: {
        user_id: userId,
        update_by: updateBy
      },
    })

    return res
  } catch (error) {
    console.error("重置密码失败:", error)
    return null
  }
}

/**
 * 查询部门树
 */
export const queryDepartmentTree = async (): Promise<DepartmentItem[]> => {
  const res: DepartmentItem[] = await api.get({
    url: '/data/SystemDepartmentOptions.json'
  })

  return buildTree(res || [])
}
