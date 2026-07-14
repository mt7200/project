export interface MenuItem {
  path: string
  label: string
  icon: React.ReactNode
  category?: string
}

export const workspaceMenus: MenuItem[] = [
  {
    path: '/workspace',
    label: '诊疗工作台',
    icon: (
      <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round">
        <rect x="3" y="3" width="7" height="7" rx="1" />
        <rect x="14" y="3" width="7" height="7" rx="1" />
        <rect x="3" y="14" width="7" height="7" rx="1" />
        <rect x="14" y="14" width="7" height="7" rx="1" />
      </svg>
    ),
    category: '诊疗工作台'
  }
]

export const recordMenus: MenuItem[] = [
  {
    path: '/emr',
    label: '电子病历',
    icon: (
      <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round">
        <path d="M14 2H6a2 2 0 0 0-2 2v16a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V8z" />
        <polyline points="14 2 14 8 20 8" />
        <line x1="16" y1="13" x2="8" y2="13" />
        <line x1="16" y1="17" x2="8" y2="17" />
        <line x1="10" y1="9" x2="8" y2="9" />
      </svg>
    ),
    category: '病历管理'
  },
  {
    path: '/statistics',
    label: '数据统计',
    icon: (
      <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round">
        <line x1="18" y1="20" x2="18" y2="4" />
        <line x1="12" y1="20" x2="12" y2="10" />
        <line x1="6" y1="20" x2="6" y2="14" />
      </svg>
    ),
    category: '病历管理'
  }
]

export const allMenus = [
  ...workspaceMenus,
  ...recordMenus
]
