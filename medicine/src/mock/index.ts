import type {
  Patient, Doctor, RegistrationRecord, OutpatientRecord,
  BillingRecord, BillingItem, SystemNotification, DailyStat, HerbTemplate,
  ExecutionOrder
} from '../types'

export const currentDoctor: Doctor = {
  id: 1,
  name: '张仲景',
  title: '主治医师',
  department: '中医内科',
  registrationCount: 28,
  pendingCount: 5,
}

export const mockPatients: Patient[] = [
  { id: 1, name: '王建国', gender: '男', age: 52, phone: '138****5678' },
  { id: 2, name: '李秀英', gender: '女', age: 45, phone: '139****9012' },
  { id: 3, name: '赵德明', gender: '男', age: 38, phone: '137****3456' },
  { id: 4, name: '陈桂兰', gender: '女', age: 62, phone: '136****7890' },
  { id: 5, name: '刘伟', gender: '男', age: 28, phone: '135****1234' },
  { id: 6, name: '张丽华', gender: '女', age: 35, phone: '158****5678' },
  { id: 7, name: '孙志强', gender: '男', age: 55, phone: '159****9012' },
  { id: 8, name: '周美玲', gender: '女', age: 48, phone: '157****3456' },
]

export const mockDoctors: Doctor[] = [
  { id: 1, name: '张仲景', title: '主治医师', department: '中医内科', registrationCount: 28, pendingCount: 5 },
  { id: 2, name: '华佗', title: '副主任医师', department: '中医外科', registrationCount: 22, pendingCount: 3 },
  { id: 3, name: '李时珍', title: '主任医师', department: '中医内科', registrationCount: 35, pendingCount: 8 },
  { id: 4, name: '孙思邈', title: '主治医师', department: '针灸科', registrationCount: 18, pendingCount: 2 },
  { id: 5, name: '王清任', title: '主治医师', department: '中医内科', registrationCount: 15, pendingCount: 4 },
]

export const mockRegistrations: RegistrationRecord[] = Array.from({ length: 25 }, (_, i) => ({
  id: 2024001 + i,
  patient: mockPatients[i % mockPatients.length],
  department: ['中医内科', '中医外科', '针灸科', '中医妇科'][i % 4],
  doctor: mockDoctors[i % mockDoctors.length],
  visitType: i % 3 === 0 ? '复诊' : '初诊',
  channel: ['线上预约', '现场挂号', '微信预约'][i % 3],
  status: (i % 5 === 0 ? '已退' : i % 3 === 0 ? '已诊' : '待诊') as '已诊' | '待诊' | '已退',
  fee: 20 + (i % 5) * 5,
  expectedTime: `2026-06-0${1 + (i % 3)} ${8 + (i % 8)}:${(i * 3) % 60}`,
  registerTime: `2026-06-0${1 + (i % 3)} ${7 + (i % 2)}:${(i * 7) % 60}`,
}))

export const mockOutpatientRecords: OutpatientRecord[] = [
  {
    id: 1, patient: mockPatients[0], doctor: mockDoctors[0],
    visitType: '复诊', consultationFee: 20, paymentType: '医保',
    status: 'draft', chiefComplaint: '头痛眩晕3年，加重1周',
    presentIllness: '患者3年来反复出现头痛眩晕，劳累后加重，伴失眠多梦，口苦咽干。近1周症状加重。',
    pastHistory: '高血压病史5年，规律服药', allergyHistory: '无',
    diagnosis: '肝阳上亢证', syndrome: '肝阳偏亢，上扰头目',
    prescription: '天麻钩藤饮加减', createTime: '2026-06-01 09:00',
  },
  {
    id: 2, patient: mockPatients[1], doctor: mockDoctors[0],
    visitType: '初诊', consultationFee: 20, paymentType: '自费',
    status: 'draft', chiefComplaint: '月经不调半年',
    presentIllness: '患者近半年来月经周期紊乱，经量时多时少，经前乳房胀痛。',
    pastHistory: '乳腺增生病史', allergyHistory: '青霉素过敏',
    diagnosis: '肝郁血虚证', syndrome: '肝郁气滞，血虚失养',
    prescription: '逍遥散加减', createTime: '2026-06-01 10:00',
  },
  {
    id: 3, patient: mockPatients[2], doctor: mockDoctors[0],
    visitType: '初诊', consultationFee: 20, paymentType: '医保',
    status: 'draft', chiefComplaint: '反复腰痛3年，加重1周',
    presentIllness: '患者3年来反复腰痛，劳累后加重，伴下肢酸软。',
    pastHistory: '高血压病史', allergyHistory: '无',
    diagnosis: '肾阳虚证', syndrome: '肾阳不足，腰府失养',
    prescription: '金匮肾气丸加减', createTime: '2026-06-01 11:00',
  },
]

export const mockBillingRecords: BillingRecord[] = [
  {
    id: 1, patient: mockPatients[0], doctor: mockDoctors[0],
    items: [
      { id: 1, name: '挂号费', unitPrice: 20, quantity: 1, unit: '次', amount: 20, category: '诊察费' },
      { id: 2, name: '中药饮片', unitPrice: 85.5, quantity: 7, unit: '剂', amount: 598.5, category: '中药' },
      { id: 3, name: '血常规检查', unitPrice: 35, quantity: 1, unit: '次', amount: 35, category: '检验' },
    ],
    totalAmount: 653.5, actualAmount: 620, discount: 33.5,
    status: '已收', paymentMethod: '医保卡', createTime: '2026-06-01 09:00',
    completeTime: '2026-06-01 09:15', cashier: '收款员A', invoiceStatus: '已开票',
  },
  {
    id: 2, patient: mockPatients[1], doctor: mockDoctors[0],
    items: [
      { id: 1, name: '挂号费', unitPrice: 20, quantity: 1, unit: '次', amount: 20, category: '诊察费' },
      { id: 2, name: '中药饮片', unitPrice: 65.0, quantity: 7, unit: '剂', amount: 455.0, category: '中药' },
    ],
    totalAmount: 475.0, actualAmount: 475.0, discount: 0,
    status: '待收', createTime: '2026-06-01 10:00', cashier: '收款员A',
  },
  {
    id: 3, patient: mockPatients[2], doctor: mockDoctors[0],
    items: [
      { id: 1, name: '挂号费', unitPrice: 20, quantity: 1, unit: '次', amount: 20, category: '诊察费' },
      { id: 2, name: '中药饮片', unitPrice: 92.0, quantity: 7, unit: '剂', amount: 644.0, category: '中药' },
      { id: 3, name: '针灸治疗', unitPrice: 60, quantity: 5, unit: '次', amount: 300, category: '治疗' },
    ],
    totalAmount: 964.0, actualAmount: 950.0, discount: 14.0,
    status: '已收', paymentMethod: '微信支付', createTime: '2026-06-01 11:00',
    completeTime: '2026-06-01 11:10', cashier: '收款员B', invoiceStatus: '未开票',
  },
]

export const mockNotifications: SystemNotification[] = [
  { id: 1, title: '系统已升级至 V3.2.1，新增AI辅助辨证功能', date: '2026-06-01', read: false },
  { id: 2, title: '医保接口已更新，请重新同步药品目录', date: '2026-05-30', read: false },
  { id: 3, title: '药品库存预警：当归库存不足50剂', date: '2026-05-28', read: true },
  { id: 4, title: '本月处方点评工作将于6月5日截止', date: '2026-05-25', read: true },
]

export const mockDailyStats: DailyStat[] = [
  { label: '门诊量', value: 128, type: 'primary' },
  { label: '待接诊', value: 12, type: 'warning' },
  { label: '待收费', value: 8, type: 'warning' },
  { label: '待发药', value: 15, type: 'primary' },
  { label: '待检查', value: 5, type: 'primary' },
]

export const mockExecutionOrders: ExecutionOrder[] = [
  {
    id: 1001,
    patient: mockPatients[0],
    doctor: mockDoctors[0],
    diagnosis: '肝阳上亢证',
    createTime: '2026-06-01 09:00',
    status: '已收费',
    chargeAmount: 653.5,
    prescriptions: [
      {
        id: 1, type: '成药处方', name: '天麻钩藤颗粒',
        usage: '口服', frequency: '每日2次', dosage: '1袋',
        days: 7, total: 14, progress: '0/14',
      },
      {
        id: 2, type: '中药处方', name: '天麻钩藤饮加减',
        usage: '水煎服', frequency: '每日1剂', dosage: '200ml',
        days: 7, total: 7, progress: '0/7',
        items: [
          { name: '天麻', dosage: '12g' }, { name: '钩藤', dosage: '15g' },
          { name: '石决明', dosage: '30g' }, { name: '栀子', dosage: '9g' },
          { name: '黄芩', dosage: '9g' }, { name: '川牛膝', dosage: '12g' },
        ],
      },
    ],
    history: [
      { id: 1, time: '2026-06-01 09:15', operator: '收款员A', action: '收费确认', registrar: '收款员A' },
      { id: 2, time: '2026-06-01 09:30', operator: '药房A', action: '处方审核通过', registrar: '药房A' },
    ],
  },
  {
    id: 1002,
    patient: mockPatients[1],
    doctor: mockDoctors[0],
    diagnosis: '肝郁血虚证',
    createTime: '2026-06-01 10:00',
    status: '已收费',
    chargeAmount: 475.0,
    prescriptions: [
      {
        id: 1, type: '中药处方', name: '逍遥散加减',
        usage: '水煎服', frequency: '每日1剂', dosage: '200ml',
        days: 7, total: 7, progress: '0/7',
        items: [
          { name: '柴胡', dosage: '12g' }, { name: '当归', dosage: '12g' },
          { name: '白芍', dosage: '15g' }, { name: '茯苓', dosage: '15g' },
          { name: '白术', dosage: '12g' }, { name: '炙甘草', dosage: '6g' },
        ],
      },
    ],
    history: [
      { id: 1, time: '2026-06-01 10:15', operator: '收款员A', action: '收费确认', registrar: '收款员A' },
    ],
  },
  {
    id: 1003,
    patient: mockPatients[2],
    doctor: mockDoctors[1],
    diagnosis: '腰痛病（肾阳虚证）',
    createTime: '2026-06-01 11:00',
    status: '已收费',
    chargeAmount: 964.0,
    prescriptions: [
      {
        id: 1, type: '中药处方', name: '金匮肾气丸加减',
        usage: '水煎服', frequency: '每日1剂', dosage: '200ml',
        days: 7, total: 7, progress: '2/7',
        items: [
          { name: '熟地黄', dosage: '24g' }, { name: '山茱萸', dosage: '12g' },
          { name: '山药', dosage: '12g' }, { name: '茯苓', dosage: '9g' },
          { name: '牡丹皮', dosage: '9g' }, { name: '泽泻', dosage: '9g' },
          { name: '桂枝', dosage: '6g' }, { name: '附子', dosage: '6g' },
        ],
      },
      {
        id: 2, type: '输注处方', name: '丹参注射液',
        usage: '静脉滴注', frequency: '每日1次', dosage: '250ml',
        days: 5, total: 5, progress: '2/5',
      },
      {
        id: 3, type: '外治处方', name: '针灸治疗',
        usage: '穴位针刺', frequency: '每日1次', dosage: '30min',
        days: 5, total: 5, progress: '1/5',
      },
    ],
    history: [
      { id: 1, time: '2026-06-01 11:10', operator: '收款员B', action: '收费确认', registrar: '收款员B' },
      { id: 2, time: '2026-06-01 14:00', operator: '治疗室A', action: '针灸治疗开始', registrar: '治疗室A' },
      { id: 3, time: '2026-06-02 09:00', operator: '药房A', action: '中药发药', registrar: '药房A' },
      { id: 4, time: '2026-06-02 14:30', operator: '治疗室A', action: '第二次针灸治疗', registrar: '治疗室A' },
    ],
  },
]

export const herbTemplates: HerbTemplate[] = [
  {
    id: 1, name: '小柴胡汤', category: '解表剂', source: '《伤寒论》',
    function: '和解少阳', indications: '伤寒少阳证，症见往来寒热、胸胁苦满、心烦喜呕',
    herbs: [{ name: '柴胡', dosage: '12g' }, { name: '黄芩', dosage: '9g' }, { name: '党参', dosage: '9g' }, { name: '半夏', dosage: '9g' }, { name: '炙甘草', dosage: '6g' }, { name: '生姜', dosage: '9g' }, { name: '大枣', dosage: '12g' }],
    public: true,
  },
  {
    id: 2, name: '四物汤', category: '补益剂', source: '《太平惠民和剂局方》',
    function: '补血活血', indications: '营血虚滞证，症见心悸失眠、头晕目眩',
    herbs: [{ name: '当归', dosage: '12g' }, { name: '川芎', dosage: '9g' }, { name: '白芍', dosage: '12g' }, { name: '熟地黄', dosage: '15g' }],
    public: true,
  },
  {
    id: 3, name: '桂枝汤', category: '解表剂', source: '《伤寒论》',
    function: '解肌发表，调和营卫', indications: '外感风寒表虚证',
    herbs: [{ name: '桂枝', dosage: '9g' }, { name: '白芍', dosage: '9g' }, { name: '炙甘草', dosage: '6g' }, { name: '生姜', dosage: '9g' }, { name: '大枣', dosage: '12g' }],
    public: true,
  },
  {
    id: 4, name: '逍遥散', category: '和解剂', source: '《太平惠民和剂局方》',
    function: '疏肝解郁，养血健脾', indications: '肝郁血虚脾弱证',
    herbs: [{ name: '柴胡', dosage: '12g' }, { name: '当归', dosage: '12g' }, { name: '白芍', dosage: '12g' }, { name: '白术', dosage: '12g' }, { name: '茯苓', dosage: '15g' }, { name: '炙甘草', dosage: '6g' }],
    public: true,
  },
]
