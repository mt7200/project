import request from '@/utils/http'
import { AppRouteRecord } from '@/types/router'

// 获取用户列表
export function fetchGetUserList(params: Api.SystemManage.UserSearchParams) {
  return request.get<Api.SystemManage.UserList>({
    url: '/api/user/list',
    params
  })
}

// 获取角色列表
export function fetchGetRoleList(params: Api.SystemManage.RoleSearchParams) {
  return request.get<Api.SystemManage.RoleList>({
    url: '/api/role/list',
    params
  })
}

// 获取菜单列表
export function fetchGetMenuList() {
  return request.get<AppRouteRecord[]>({
    url: '/api/auth/getUserMenu'
  })
}

// 获取菜单详情
export function fetchGetMenuById(id: number) {
  return request.get<AppRouteRecord>({
    url: `/api/resource/resources/${id}`
  })
}

// 创建菜单
export function fetchCreateMenu(data: any) {
  return request.post({
    url: '/api/resource/resources',
    data
  })
}

// 更新菜单
export function fetchUpdateMenu(id: number, data: any) {
  return request.put({
    url: `/api/resource/resources/${id}`,
    data
  })
}

// 删除菜单
export function fetchDeleteMenu(id: number) {
  return request.del({
    url: `/api/resource/resources/${id}`
  })
}
