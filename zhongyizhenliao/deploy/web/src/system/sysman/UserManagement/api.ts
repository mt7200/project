import api from '@/utils/http'
import { buildTree } from './utils'
import { type UserItem, type QueryParams, type DepartmentItem, type SaveUserParams, type RoleItem, type GridData } from './type'


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
          : {}),
          ...(params?.start && params?.limit
            ? { start: params.start, limit: params.limit }
            : {})
      }
    })

    return res || []
  } catch (error) {
    console.error('查询用户入网列表失败:', error)
    return {}
  }
}




/**
 * 重置用户密码
 */
export const resetUserPassword = async (user_id: any) => {
  try {
    const res = await api.post({
      url: '/json/ResetPassword.json',
      data: {
          user_id: user_id
      },
    })

    return res
  } catch (error) {
    console.error("重置密码失败:", error)
    return null
  }
}


/**
 * 禁用启用入网权限
 */
export const toggleNetWorkStatus = async (user_id: string,is_network: number) => {
  try {
    const res = await api.post({
      url: '/json/GetNetWork.json',
      data: {
          user_id: user_id,
          is_network: is_network
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



/**
 * 删除用户
 */
export const deleteUser = async (user_id: any) => {
  try {
    const res = await api.post({
      url: '/json/DeleteUser.json',
      data: {
          user_id: user_id
      }
    })

    return res
  } catch (error) {
    console.error('删除用户失败:', error)
    return null
  }
}


/**
 * 新增用户
 */
export const insertUser = async (data: SaveUserParams) => {
  try {
    const res = await api.post({
      url: '/json/InsertUser.json',
      data: {
        ...data
      },
    })
    return res
  } catch (error) {
    console.error('新增用户失败:', error)
    return null
  }
}

/**
 * 用户信息更新
 */
export const updateUser = async (data: SaveUserParams) => {
  try {
    const res = await api.post({
      url: '/json/UpdateUser.json',
      data: {
        ...data
      },
    })
    return res
  } catch (error) {
    console.error('新增用户失败:', error)
    return null
  }
}


/**
 * 角色列表查询
 *  */
export const queryRoleList = async (): Promise<RoleItem[]> => {
  const res: RoleItem[] = await api.get({
    url: '/data/SystemRoleOptions.json'
  })
  return res || []
}


/**
 * 禁用启用用户
 */
export const toggleUserStatus = async (user_id: any,user_status: number) => {
  try {
    const res = await api.post({
      url: '/data/UpdateUserEnable.json',
      data: {
          user_id: user_id,
          user_status:user_status
      },
    })

    return res
  } catch (error) {
    console.error("重置密码失败:", error)
    return null
  }
}
