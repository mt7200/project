export interface Patient {
  id: number
  name: string
  gender: '男' | '女'
  age: number
  phone: string
  idCard?: string
}

export interface Doctor {
  id: number
  name: string
  title: string
  department: string
  registrationCount: number
  pendingCount: number
  avatar?: string
}

export interface RegistrationRecord {
  id: number
  patient: Patient
  department: string
  doctor: Doctor
  visitType: '初诊' | '复诊'
  channel: string
  status: '已诊' | '待诊' | '已退'
  fee: number
  expectedTime: string
  registerTime: string
  remark?: string
}

export interface OutpatientRecord {
  id: number
  patient: Patient
  doctor: Doctor
  visitType: '初诊' | '复诊'
  consultationFee: number
  paymentType: string
  status: 'draft' | 'completed'
  chiefComplaint: string
  presentIllness: string
  pastHistory: string
  allergyHistory: string
  diagnosis: string
  syndrome: string
  prescription: string
  createTime: string
}

export interface BillingItem {
  id: number
  name: string
  unitPrice: number
  quantity: number
  unit: string
  amount: number
  category: string
  remark?: string
}

export interface BillingRecord {
  id: number
  patient: Patient
  doctor: Doctor
  items: BillingItem[]
  totalAmount: number
  actualAmount: number
  discount: number
  status: '待收' | '已收'
  paymentMethod?: string
  createTime: string
  completeTime?: string
  cashier: string
  invoiceStatus?: string
}

export interface SystemNotification {
  id: number
  title: string
  date: string
  read: boolean
}

export interface DailyStat {
  label: string
  value: number
  unit?: string
  type?: 'primary' | 'warning' | 'success'
}

export interface HerbTemplate {
  id: number
  name: string
  category: string
  source?: string
  function: string
  indications: string
  herbs: { name: string; dosage: string }[]
  public: boolean
}

export interface ExecutionOrder {
  id: number
  patient: Patient
  doctor: Doctor
  diagnosis: string
  createTime: string
  status: '已收费' | '执行中' | '已完成'
  chargeAmount: number
  prescriptions: ExecutionPrescription[]
  history: ExecutionHistory[]
}

export interface ExecutionPrescription {
  id: number
  type: '成药处方' | '中药处方' | '输注处方' | '外治处方'
  name: string
  usage: string
  frequency: string
  dosage: string
  days: number
  total: number
  progress: string
  items?: { name: string; dosage: string }[]
}

export interface ExecutionHistory {
  id: number
  time: string
  operator: string
  action: string
  registrar: string
}

export interface MenuItem {
  path: string
  label: string
  icon: string
}

export interface TabItem {
  label: string
  value: string
  count?: number
}
