/**
 * 日志信息接口
 */
export interface Log {
  id?: number
  content: string
  user_name: string
  account: string
  create_time: string
  ip: string
  unit: string
  log_type: string
}

/**
 * 搜索表单接口
 */
export interface SearchForm {
  unit: string
  operator: string
  account: string
  logType: string
  startTime: string
  endTime: string
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

// 分页组件实例
export interface HGridPagingInstance {
  reload: (dataUrl?: string, params?: Record<string, any>) => Promise<void>;
}
