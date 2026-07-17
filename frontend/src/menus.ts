export interface MenuItem {
  path: string
  name: string
  icon?: string
  children?: MenuItem[]
}

const menus: MenuItem[] = [
  { path: '/workspace', name: '工作台', icon: 'Monitor' },
  { path: '/diagnosis-flow', name: '辨证诊断', icon: 'Document' },
  { path: '/prescription-flow', name: '智能开方', icon: 'Edit' },
  { path: '/prescription-review', name: '处方审核', icon: 'Checked' },
  { path: '/emr', name: '电子病历', icon: 'Files' },
  { path: '/statistics', name: '数据统计', icon: 'DataAnalysis' },
]

export default menus