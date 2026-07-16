import { useState, useMemo, useEffect, useRef } from 'react'
import { useNavigate, useLocation } from 'react-router-dom'
import './Workspace.css'

/* ============ Types ============ */
interface PatientForm {
  name: string; gender: string; age: string; phone: string; idCard: string; birthDate: string
  occupation: string; ethnicity: string; maritalStatus: string; address: string
  chiefComplaint: string; presentIllness: string; pastHistory: string; familyHistory: string; allergyHistory: string; personalHistory: string
  diagnosis: string; differentiation: string; treatmentMethod: string; prescription: string
}
interface SymptomForm {
  pulseLeft: string; pulseRight: string; pulseDescription: string
  tongueColor: string; tongueShape: string; tongueCoating: string; tongueTexture: string
  facialColor: string; expression: string; mentalState: string
  sleepQuality: string; appetite: string; thirst: string; taste: string; bowelMovement: string; urineColor: string
}
interface DiagnosisResult { pattern: string; confidence: number; description: string; symptoms: string[] }
interface CustomDiagnosis { id: string; pattern: string; description: string; symptoms: string[] }
interface Herb {
  id: number; name: string; category: string; nature: string; taste: string; meridian: string
  minDosage: number; maxDosage: number; unit: string; toxic: boolean
  incompatibilities: string[]; synergies: string[]; functions: string[]
}
interface SelectedHerb extends Herb { currentDosage: number }
interface Prescription {
  id: number; patientName: string; patientAge: number; patientGender: string
  diagnosis: string; syndrome: string; herbs: string[]
  riskLevel: 'low' | 'medium' | 'high'; riskScore: number; status: 'pending' | 'approved' | 'rejected'
  date: string; compatibilityRisk: boolean; dosageRisk: boolean; contraindicationRisk: boolean
  risks: string[]; suggestions: string[]
}

/* ============ Data ============ */
const diagnosisResults: DiagnosisResult[] = [
  { pattern: '肝阳上亢证', confidence: 92, description: '肝阳偏亢，上扰头目，导致头晕头痛；肝肾阴虚，腰膝失养，故腰膝酸软。', symptoms: ['眩晕', '头痛', '失眠多梦', '腰膝酸软', '口苦咽干'] },
  { pattern: '阴虚阳亢证', confidence: 78, description: '阴液亏虚，阳气偏亢，虚热内生，上扰清窍。', symptoms: ['头晕耳鸣', '潮热盗汗', '五心烦热'] },
  { pattern: '肝郁气滞证', confidence: 65, description: '肝气郁结，气机不畅，情志不舒。', symptoms: ['胁肋胀痛', '胸闷善太息', '抑郁多疑'] },
]

// Mock diagnosis mapping: pattern -> { diagnosis, differentiation, treatmentMethod, prescription }
const patternToDiagnosis: Record<string, { diagnosis: string; differentiation: string; treatmentMethod: string; prescription: string }> = {
  '肝阳上亢证': { diagnosis: '高血压病', differentiation: '肝阳上亢证', treatmentMethod: '平肝潜阳，滋养肝肾', prescription: '天麻钩藤饮加减' },
  '阴虚阳亢证': { diagnosis: '高血压病', differentiation: '阴虚阳亢证', treatmentMethod: '滋阴潜阳', prescription: '镇肝熄风汤加减' },
  '肝郁气滞证': { diagnosis: '郁证', differentiation: '肝郁气滞证', treatmentMethod: '疏肝解郁，理气畅中', prescription: '柴胡疏肝散加减' },
}

const herbDatabase: Herb[] = [
  { id: 1, name: '柴胡', category: '解表药', nature: '微寒', taste: '辛苦', meridian: '肝、胆', minDosage: 3, maxDosage: 10, unit: 'g', toxic: false, incompatibilities: [], synergies: ['黄芩', '半夏'], functions: ['疏散退热', '疏肝解郁'] },
  { id: 2, name: '黄芩', category: '清热药', nature: '寒', taste: '苦', meridian: '肺、胆、胃', minDosage: 3, maxDosage: 10, unit: 'g', toxic: false, incompatibilities: [], synergies: ['柴胡', '黄连'], functions: ['清热燥湿', '泻火解毒'] },
  { id: 3, name: '党参', category: '补虚药', nature: '平', taste: '甘', meridian: '脾、肺', minDosage: 9, maxDosage: 30, unit: 'g', toxic: false, incompatibilities: ['藜芦'], synergies: ['黄芪', '白术'], functions: ['补中益气', '健脾益肺'] },
  { id: 4, name: '半夏', category: '化痰药', nature: '温', taste: '辛', meridian: '脾、胃、肺', minDosage: 3, maxDosage: 9, unit: 'g', toxic: true, incompatibilities: ['乌头', '附子'], synergies: ['陈皮', '茯苓'], functions: ['燥湿化痰', '降逆止呕'] },
  { id: 5, name: '附子', category: '温里药', nature: '大热', taste: '辛甘', meridian: '心、肾、脾', minDosage: 3, maxDosage: 15, unit: 'g', toxic: true, incompatibilities: ['半夏', '瓜蒌', '川贝母'], synergies: ['干姜', '肉桂'], functions: ['回阳救逆', '补火助阳'] },
  { id: 6, name: '当归', category: '补虚药', nature: '温', taste: '甘辛', meridian: '肝、心、脾', minDosage: 6, maxDosage: 12, unit: 'g', toxic: false, incompatibilities: [], synergies: ['川芎', '白芍'], functions: ['补血活血', '调经止痛'] },
  { id: 7, name: '炙甘草', category: '补虚药', nature: '平', taste: '甘', meridian: '心、肺、脾', minDosage: 1.5, maxDosage: 9, unit: 'g', toxic: false, incompatibilities: ['甘遂', '大戟', '芫花'], synergies: [], functions: ['补脾益气', '调和诸药'] },
  { id: 8, name: '黄芪', category: '补虚药', nature: '微温', taste: '甘', meridian: '肺、脾', minDosage: 9, maxDosage: 30, unit: 'g', toxic: false, incompatibilities: [], synergies: ['党参', '白术'], functions: ['补气升阳', '固表止汗'] },
  { id: 9, name: '白芍', category: '补虚药', nature: '微寒', taste: '苦酸', meridian: '肝、脾', minDosage: 6, maxDosage: 15, unit: 'g', toxic: false, incompatibilities: ['藜芦'], synergies: ['当归', '川芎'], functions: ['养血调经', '柔肝止痛'] },
  { id: 10, name: '桂枝', category: '解表药', nature: '温', taste: '辛甘', meridian: '心、肺、膀胱', minDosage: 3, maxDosage: 10, unit: 'g', toxic: false, incompatibilities: [], synergies: ['白芍', '生姜'], functions: ['发汗解肌', '温经通脉'] },
  { id: 11, name: '生姜', category: '解表药', nature: '微温', taste: '辛', meridian: '肺、脾、胃', minDosage: 3, maxDosage: 10, unit: 'g', toxic: false, incompatibilities: [], synergies: ['桂枝', '大枣'], functions: ['解表散寒', '温中止呕'] },
  { id: 12, name: '大枣', category: '补虚药', nature: '温', taste: '甘', meridian: '脾、胃', minDosage: 6, maxDosage: 15, unit: 'g', toxic: false, incompatibilities: [], synergies: ['生姜', '炙甘草'], functions: ['补中益气', '养血安神'] },
  { id: 13, name: '茯苓', category: '利水渗湿药', nature: '平', taste: '甘淡', meridian: '心、脾、肾', minDosage: 9, maxDosage: 15, unit: 'g', toxic: false, incompatibilities: [], synergies: ['白术', '党参'], functions: ['利水渗湿', '健脾宁心'] },
  { id: 14, name: '川芎', category: '活血化瘀药', nature: '温', taste: '辛', meridian: '肝、胆', minDosage: 3, maxDosage: 10, unit: 'g', toxic: false, incompatibilities: [], synergies: ['当归', '白芍'], functions: ['活血行气', '祛风止痛'] },
  { id: 15, name: '熟地黄', category: '补虚药', nature: '微温', taste: '甘', meridian: '肝、肾', minDosage: 9, maxDosage: 30, unit: 'g', toxic: false, incompatibilities: [], synergies: ['当归', '山茱萸'], functions: ['补血滋阴', '益精填髓'] },
]

const commonFormulas = [
  { name: '小柴胡汤', category: '和解剂', herbs: ['柴胡', '黄芩', '党参', '半夏', '炙甘草', '生姜', '大枣'] },
  { name: '四物汤', category: '补益剂', herbs: ['当归', '川芎', '白芍', '熟地黄'] },
  { name: '桂枝汤', category: '解表剂', herbs: ['桂枝', '白芍', '炙甘草', '生姜', '大枣'] },
  { name: '逍遥散', category: '和解剂', herbs: ['柴胡', '当归', '白芍', '白术', '茯苓', '炙甘草'] },
]

const prescriptions: Prescription[] = [
  { id: 1, patientName: '张三', patientAge: 45, patientGender: '男', diagnosis: '风寒感冒', syndrome: '风寒束表证', herbs: ['麻黄', '桂枝', '杏仁', '甘草', '生姜'], riskLevel: 'high', riskScore: 78, status: 'pending', date: '2026-05-05 14:30', compatibilityRisk: true, dosageRisk: true, contraindicationRisk: false, risks: ['麻黄用量超出药典上限（12g > 10g）', '麻黄与桂枝配伍辛温过强'], suggestions: ['建议将麻黄减量至9g', '考虑添加白芍以制约辛温太过'] },
  { id: 2, patientName: '李四', patientAge: 38, patientGender: '女', diagnosis: '月经不调', syndrome: '肝郁血虚证', herbs: ['当归', '川芎', '白芍', '柴胡', '茯苓', '白术', '炙甘草'], riskLevel: 'low', riskScore: 12, status: 'approved', date: '2026-05-04 10:15', compatibilityRisk: false, dosageRisk: false, contraindicationRisk: false, risks: [], suggestions: [] },
  { id: 3, patientName: '王五', patientAge: 62, patientGender: '男', diagnosis: '慢性支气管炎', syndrome: '痰湿阻肺证', herbs: ['半夏', '陈皮', '茯苓', '甘草', '细辛', '五味子'], riskLevel: 'medium', riskScore: 45, status: 'pending', date: '2026-05-04 16:20', compatibilityRisk: true, dosageRisk: false, contraindicationRisk: true, risks: ['半夏与甘草配伍需注意比例', '细辛含马兜铃酸成分需关注'], suggestions: ['半夏建议炮制后使用', '细辛用量建议控制在3g以内'] },
  { id: 4, patientName: '赵六', patientAge: 55, patientGender: '女', diagnosis: '高血压', syndrome: '肝阳上亢证', herbs: ['天麻', '钩藤', '石决明', '栀子', '黄芩', '川牛膝', '杜仲'], riskLevel: 'low', riskScore: 18, status: 'approved', date: '2026-05-03 09:00', compatibilityRisk: false, dosageRisk: false, contraindicationRisk: false, risks: [], suggestions: [] },
]

const pulseOptions = ['浮', '沉', '迟', '数', '弱', '弦', '滑', '涩', '紧', '缓', '细', '虚', '实']

const emrPatientList = [
  { id: 1, name: '张三', gender: '男', age: 45, diagnosis: '风寒感冒', status: '待诊断' },
  { id: 2, name: '李四', gender: '女', age: 38, diagnosis: '月经不调', status: '已诊断' },
  { id: 3, name: '王五', gender: '男', age: 62, diagnosis: '腰痛病', status: '已诊断' },
  { id: 4, name: '赵六', gender: '女', age: 55, diagnosis: '高血压', status: '可复诊' },
  { id: 5, name: '钱九', gender: '男', age: 35, diagnosis: '待查', status: '未诊断完成' },
  { id: 6, name: '孙七', gender: '男', age: 28, diagnosis: '咽喉炎', status: '已诊断' },
]

// ---- AI 辅助开方 Mock 数据 ----
const prescriptionMock = {
  complaint: "咳嗽反复2周，夜间加重",
  symptoms: ["咽干", "痰少", "口渴"],
  tongue: "舌红少苔",
  pulse: "细数",
  syndrome: "肺阴虚证",
  keywords: ["咳嗽", "咽干", "痰少", "口渴", "舌红少苔", "细数", "肺阴虚"],
  treatment: "养阴润肺",
  formulas: [
    {
      name: "沙参麦冬汤",
      herbs: [
        { name: "北沙参", dosage: "15g" },
        { name: "麦冬", dosage: "12g" },
        { name: "玉竹", dosage: "10g" },
        { name: "桑叶", dosage: "10g" },
        { name: "天花粉", dosage: "10g" },
      ],
      effects: ["养阴清肺", "生津润燥", "止咳化痰"],
      reason: "根据患者肺阴亏虚、津液不足、干咳少痰等表现，以沙参麦冬汤养阴清肺、生津润燥，为经典首选方案。",
    },
    {
      name: "百合固金汤",
      herbs: [
        { name: "百合", dosage: "12g" },
        { name: "生地黄", dosage: "15g" },
        { name: "熟地黄", dosage: "12g" },
        { name: "麦冬", dosage: "10g" },
        { name: "川贝母", dosage: "6g" },
        { name: "桔梗", dosage: "6g" },
      ],
      effects: ["滋肾保肺", "止咳化痰", "清热凉血"],
      reason: "患者肺阴虚兼阴虚内热明显，百合固金汤可滋肾保肺、清热润燥，适合阴虚咳嗽较甚者。",
    },
    {
      name: "养阴清肺汤",
      herbs: [
        { name: "生地黄", dosage: "12g" },
        { name: "麦冬", dosage: "12g" },
        { name: "白芍", dosage: "10g" },
        { name: "牡丹皮", dosage: "10g" },
        { name: "贝母", dosage: "6g" },
        { name: "玄参", dosage: "12g" },
        { name: "薄荷", dosage: "6g" },
      ],
      effects: ["养阴清肺", "解毒利咽", "润燥止咳"],
      reason: "患者咽干口渴症状突出，养阴清肺汤原方善治阴虚肺燥，兼可利咽生津，为对本证之良方。",
    },
  ],
}

/* ============ Component ============ */
export default function Workspace() {
  const navigate = useNavigate()
  const location = useLocation()

  // ---- Receive patient from EMR page (auto-select and auto-fill) ----
  useEffect(() => {
    const state = location.state as Record<string, unknown> | null
    const patient = state?.patient as { id: number; name: string; gender: string; age: number; diagnosis: string } | undefined
    if (patient) {
      setSelectedPatientFromBar(patient.id)
      setForm(prev => ({
        ...prev,
        name: patient.name,
        gender: patient.gender === '男' ? 'male' : 'female',
        age: String(patient.age),
      }))
      window.history.replaceState({}, '')
    }
  }, [location.state])
  // ---- Diagnosis state ----
  const [form, setForm] = useState<PatientForm>({
    name: '', gender: '', age: '', phone: '', idCard: '', birthDate: '',
    occupation: '', ethnicity: '汉族', maritalStatus: '', address: '',
    chiefComplaint: '', presentIllness: '', pastHistory: '', familyHistory: '', allergyHistory: '', personalHistory: '',
    diagnosis: '', differentiation: '', treatmentMethod: '', prescription: '',
  })
  const [symptoms, setSymptoms] = useState<SymptomForm>({
    pulseLeft: '', pulseRight: '', pulseDescription: '', tongueColor: '', tongueShape: '',
    tongueCoating: '', tongueTexture: '', facialColor: '', expression: '', mentalState: '',
    sleepQuality: '', appetite: '', thirst: '', taste: '', bowelMovement: '', urineColor: '',
  })
  const [showPulsePicker, setShowPulsePicker] = useState(false)
  const [showTonguePicker, setShowTonguePicker] = useState(false)
  const [showInspectionPicker, setShowInspectionPicker] = useState(false)
  const [showInquiryPicker, setShowInquiryPicker] = useState(false)
  // ---- Tongue photo & Pulse data import ----
  const [tonguePhoto, setTonguePhoto] = useState<string | null>(null)
  const [pulseImportData, setPulseImportData] = useState<string>('')
  const [showChiefComplaintPicker, setShowChiefComplaintPicker] = useState(false)
  const [showPresentIllnessPicker, setShowPresentIllnessPicker] = useState(false)
  const [showPastHistoryPicker, setShowPastHistoryPicker] = useState(false)
  const [showAllergyPicker, setShowAllergyPicker] = useState(false)
  const [showPersonalHistoryPicker, setShowPersonalHistoryPicker] = useState(false)
  const chiefComplaintRef = useRef<HTMLDivElement>(null)
  const presentIllnessRef = useRef<HTMLDivElement>(null)
  const pastHistoryRef = useRef<HTMLDivElement>(null)
  const allergyRef = useRef<HTMLDivElement>(null)
  const personalHistoryRef = useRef<HTMLDivElement>(null)

  // Close pickers when clicking outside
  useEffect(() => {
    const handler = (e: MouseEvent) => {
      const target = e.target as HTMLElement
      // Close pickers when clicking outside their containers
      if (chiefComplaintRef.current && !chiefComplaintRef.current.contains(target)) {
        setShowChiefComplaintPicker(false)
      }
      if (presentIllnessRef.current && !presentIllnessRef.current.contains(target)) {
        setShowPresentIllnessPicker(false)
      }
      if (pastHistoryRef.current && !pastHistoryRef.current.contains(target)) {
        setShowPastHistoryPicker(false)
      }
      if (allergyRef.current && !allergyRef.current.contains(target)) {
        setShowAllergyPicker(false)
      }
      if (personalHistoryRef.current && !personalHistoryRef.current.contains(target)) {
        setShowPersonalHistoryPicker(false)
      }
      // Close other pickers when clicking outside
      if (!target.closest('.ws-picker-panel') && !target.closest('.ws-field input')) {
        setShowPulsePicker(false)
        setShowTonguePicker(false)
        setShowInspectionPicker(false)
        setShowInquiryPicker(false)
      }
    }
    document.addEventListener('mousedown', handler)
    return () => document.removeEventListener('mousedown', handler)
  }, [])
  const [selectedPattern, setSelectedPattern] = useState('')
  const [customDiagnoses, setCustomDiagnoses] = useState<CustomDiagnosis[]>([])
  const [customPattern, setCustomPattern] = useState('')
  const [customDescription, setCustomDescription] = useState('')
  const [customSymptoms, setCustomSymptoms] = useState('')

  // ---- Editable AI prescription herbs ----
  interface EditableHerb { name: string; dosage: string }
  const [selectedFormulaIndices, setSelectedFormulaIndices] = useState<number[]>([0])
  const [aiHerbs, setAiHerbs] = useState<EditableHerb[]>(
    () => prescriptionMock.formulas[0].herbs.map(h => ({ ...h }))
  )
  const [editingHerbIdx, setEditingHerbIdx] = useState<number | null>(null)
  const [editName, setEditName] = useState('')
  const [editDosage, setEditDosage] = useState('')
  const [deletedHerb, setDeletedHerb] = useState<{ herb: EditableHerb; index: number } | null>(null)
  const undoTimeoutRef = useRef<ReturnType<typeof setTimeout> | null>(null)

  // ---- Formula name editing ----
  const [editingFormulaName, setEditingFormulaName] = useState(false)
  const [editFormulaName, setEditFormulaName] = useState('')

  // ---- Effects editing ----
  const [formulaEffects, setFormulaEffects] = useState<string[]>(
    () => [...prescriptionMock.formulas[0].effects]
  )
  const [editingEffectIdx, setEditingEffectIdx] = useState<number | null>(null)
  const [editEffect, setEditEffect] = useState('')

  // ---- Reason editing ----
  const [editingReason, setEditingReason] = useState(false)
  const [editReason, setEditReason] = useState('')

  // ---- Custom formula (additive) ----
  const [showCustomEditor, setShowCustomEditor] = useState(false)
  const [customHerbs, setCustomHerbs] = useState<EditableHerb[]>([])
  const [customEffects, setCustomEffects] = useState<string[]>([])
  const [customReason, setCustomReason] = useState('')
  const [customFormulaName, setCustomFormulaName] = useState('自定义方剂')
  const [formulaSearchQuery, setFormulaSearchQuery] = useState('')
  const [showFormulaSearchResults, setShowFormulaSearchResults] = useState(false)
  const [selectedCommonFormulaNames, setSelectedCommonFormulaNames] = useState<string[]>([])

  // ---- Custom editing states ----
  const [editingCustomHerbIdx, setEditingCustomHerbIdx] = useState<number | null>(null)
  const [editCustomName, setEditCustomName] = useState('')
  const [editCustomDosage, setEditCustomDosage] = useState('')
  const [deletedCustomHerb, setDeletedCustomHerb] = useState<{ herb: EditableHerb; index: number } | null>(null)
  const [editingCustomEffectIdx, setEditingCustomEffectIdx] = useState<number | null>(null)
  const [editCustomEffect, setEditCustomEffect] = useState('')
  const [editingCustomReason, setEditingCustomReason] = useState(false)
  const [editCustomReason, setEditCustomReason] = useState('')

  // ---- Merge helper: compute merged herbs/effects/reason from selected indices ----
  const getMergedFromIndices = (indices: number[]) => {
    if (indices.length === 0) return { herbs: [], effects: [], reason: '' }
    const allHerbs: EditableHerb[] = []
    const seenNames = new Set<string>()
    const allEffects: string[] = []
    const seenEffects = new Set<string>()
    const allReasons: string[] = []
    indices.forEach(i => {
      const f = prescriptionMock.formulas[i]
      f.herbs.forEach(h => {
        if (!seenNames.has(h.name)) {
          seenNames.add(h.name)
          allHerbs.push({ ...h })
        }
      })
      f.effects.forEach(e => {
        if (!seenEffects.has(e)) {
          seenEffects.add(e)
          allEffects.push(e)
        }
      })
      allReasons.push(f.reason)
    })
    return { herbs: allHerbs, effects: allEffects, reason: allReasons.join('；') }
  }

  // ---- Prescription state ----
  const [selectedFormula, setSelectedFormula] = useState('')
  const [searchHerb, setSearchHerb] = useState('')
  const [selectedHerbs, setSelectedHerbs] = useState<SelectedHerb[]>([])
  const [notes, setNotes] = useState('')
  const [compatibilityWarnings, setCompatibilityWarnings] = useState<string[]>([])
  const [expandedRxId, setExpandedRxId] = useState<number | null>(null)
  const [selectedRx, setSelectedRx] = useState<Prescription | null>(null)
  const [selectedPatientFromBar, setSelectedPatientFromBar] = useState<number | null>(null)

  // ---- Step wizard state ----
  const [currentStep, setCurrentStep] = useState(0)
  const wizardSteps = ['辨证诊断', '智能开方', '处方审核']

  // ---- Handlers ----
  const handleChange = (e: React.ChangeEvent<HTMLInputElement | HTMLSelectElement | HTMLTextAreaElement>) => {
    setForm(prev => ({ ...prev, [e.target.name]: e.target.value }))
  }
  const handleSymptomChange = (field: keyof SymptomForm, value: string) => {
    setSymptoms(prev => ({ ...prev, [field]: value }))
  }
  const handleSelectPattern = (result: DiagnosisResult) => {
    setCustomPattern(result.pattern)
    setCustomDescription(result.description)
    setCustomSymptoms(result.symptoms.join('、'))
    setSelectedPattern(result.pattern)
    // Auto-fill diagnosis and differentiation fields with mock data
    const mockData = patternToDiagnosis[result.pattern]
    if (mockData) {
      setForm(prev => ({
        ...prev,
        diagnosis: mockData.diagnosis,
        differentiation: mockData.differentiation,
      }))
    }
  }
  const handleAddCustomDiagnosis = () => {
    if (!customPattern.trim()) return
    setCustomDiagnoses(prev => [...prev, {
      id: Date.now().toString(), pattern: customPattern, description: customDescription,
      symptoms: customSymptoms.split(/[,，、]/).map(s => s.trim()).filter(s => s)
    }])
    setCustomPattern(''); setCustomDescription(''); setCustomSymptoms(''); setSelectedPattern('')
  }
  const handleRemoveCustom = (id: string) => setCustomDiagnoses(prev => prev.filter(d => d.id !== id))

  const handleAutoFill = (patient: typeof emrPatientList[0]) => {
    setForm(prev => ({
      ...prev,
      name: patient.name,
      gender: patient.gender === '男' ? 'male' : 'female',
      age: String(patient.age),
    }))
  }

  const checkCompatibilities = (herbs: SelectedHerb[]) => {
    const w: string[] = []
    for (let i = 0; i < herbs.length; i++) {
      for (let j = i + 1; j < herbs.length; j++) {
        if (herbs[i].incompatibilities.includes(herbs[j].name)) w.push(`${herbs[i].name} 与 ${herbs[j].name} 存在配伍禁忌`)
        if (herbs[j].incompatibilities.includes(herbs[i].name)) w.push(`${herbs[j].name} 与 ${herbs[i].name} 存在配伍禁忌`)
      }
      if (herbs[i].currentDosage > herbs[i].maxDosage) w.push(`${herbs[i].name} 超出最大剂量（${herbs[i].maxDosage}${herbs[i].unit}）`)
    }
    setCompatibilityWarnings(w)
  }
  const addHerb = (herb: Herb) => {
    if (selectedHerbs.some(h => h.id === herb.id)) return
    const updated = [...selectedHerbs, { ...herb, currentDosage: Math.round((herb.minDosage + herb.maxDosage) / 2) }]
    setSelectedHerbs(updated); checkCompatibilities(updated)
  }
  const removeHerb = (id: number) => {
    const updated = selectedHerbs.filter(h => h.id !== id)
    setSelectedHerbs(updated); checkCompatibilities(updated)
  }
  const updateDosage = (id: number, value: number) => {
    const updated = selectedHerbs.map(h => h.id === id ? { ...h, currentDosage: value } : h)
    setSelectedHerbs(updated); checkCompatibilities(updated)
  }
  const applyFormula = (name: string) => {
    setSelectedFormula(name)
    const formula = commonFormulas.find(f => f.name === name)
    if (!formula) return
    const dosages: Record<string, number> = { '柴胡': 12, '黄芩': 9, '党参': 9, '半夏': 9, '炙甘草': 6, '生姜': 9, '大枣': 12, '当归': 12, '川芎': 9, '白芍': 12, '熟地黄': 15, '桂枝': 9, '茯苓': 15, '白术': 12 }
    const herbs = formula.herbs.map(n => { const h = herbDatabase.find(x => x.name === n); return h ? { ...h, currentDosage: dosages[n] || 9 } : null }).filter((h): h is SelectedHerb => h !== null)
    setSelectedHerbs(herbs); checkCompatibilities(herbs)
  }
  const filteredHerbs = useMemo(() => {
    const t = searchHerb.toLowerCase()
    return herbDatabase.filter(h => h.name.includes(t) || h.category.includes(t) || h.functions.some(f => f.includes(t)))
  }, [searchHerb])

  const selectedResult = diagnosisResults.find(r => r.pattern === selectedPattern)
  const pendingCount = prescriptions.filter(p => p.status === 'pending').length

  return (
    <div className="ws-page">
      <div className="ws-body">
        {/* ========== 患者栏 ========== */}
        <div className="ws-col ws-patient-bar">
          <div className="ws-col-title">
            <span className="ws-col-icon blue">
              <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2.5">
                <path d="M17 21v-2a4 4 0 0 0-4-4H5a4 4 0 0 0-4 4v2"/><circle cx="9" cy="7" r="4"/>
              </svg>
            </span>
            患者列表
          </div>
          <div className="ws-card">
            <div className="ws-card-body" style={{ padding: 0 }}>
              {emrPatientList.map(patient => {
                const isSelected = selectedPatientFromBar === patient.id
                return (
                  <div key={patient.id} className={`ws-patient-item ${isSelected ? 'selected' : ''}`} onClick={() => setSelectedPatientFromBar(patient.id)}>
                    <div className="ws-patient-item-head">
                      <span className="ws-patient-name">{patient.name}</span>
                      <span className="ws-patient-gender">{patient.gender}/{patient.age}岁</span>
                    </div>
                    <div className="ws-patient-diagnosis">{patient.diagnosis}</div>
                    <div className="ws-patient-status">{patient.status}</div>
                    {isSelected && (
                      <button className="btn btn-primary btn-sm" style={{ marginTop: 6, width: '100%' }} onClick={(e) => { e.stopPropagation(); handleAutoFill(patient) }}>
                        自动填充
                      </button>
                    )}
                  </div>
                )
              })}
            </div>
          </div>
          {selectedPatientFromBar !== null && (() => {
            const p = emrPatientList.find(x => x.id === selectedPatientFromBar)
            return p ? (
              <div className="ws-card" style={{ marginTop: 8 }}>
                <div className="ws-card-head"><h3>患者信息</h3></div>
                <div className="ws-card-body" style={{ flex: 1, minHeight: 0 }}>
                  <div className="ws-field"><label>姓名</label><span>{p.name}</span></div>
                  <div className="ws-field"><label>性别</label><span>{p.gender}</span></div>
                  <div className="ws-field"><label>年龄</label><span>{p.age}岁</span></div>
                  <div className="ws-field"><label>诊断</label><span>{p.diagnosis}</span></div>
                  <div className="ws-field"><label>状态</label><span>{p.status}</span></div>
                </div>
              </div>
            ) : null
          })()}
        </div>

        {/* ========== 左栏：诊疗流程 ========== */}
        <div className="ws-col ws-left">
          <div className="ws-col-title">
            <span className="ws-col-icon blue">
              <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2.5"><circle cx="12" cy="12" r="10" /><polyline points="12 6 12 12 16 14" /></svg>
            </span>
            诊疗流程
          </div>

          {/* 患者录入 */}
          <div className="ws-card" style={currentStep >= 1 ? { flex: 'none' } : {}}>
            <div className="ws-card-head"><h3>患者录入</h3></div>
            {currentStep >= 1 ? (
              <div className="ws-card-body" style={{ fontSize: 11, lineHeight: 1.7, padding: '6px 10px' }}>
                <div style={{ display: 'flex', flexWrap: 'wrap', gap: '2px 12px', marginBottom: 4 }}>
                  <span><strong>姓名：</strong>{form.name || '—'}</span>
                  <span><strong>性别：</strong>{form.gender === 'male' ? '男' : form.gender === 'female' ? '女' : '—'}</span>
                  <span><strong>年龄：</strong>{form.age || '—'}</span>
                  <span><strong>电话：</strong>{form.phone || '—'}</span>
                </div>
                <div style={{ marginBottom: 2 }}>
                  <strong>主诉：</strong>{form.chiefComplaint || '—'}<br />
                  <strong>现病史：</strong>{form.presentIllness || '—'}<br />
                  <strong>既往史：</strong>{form.pastHistory || '—'}<strong style={{ marginLeft: 8 }}>过敏：</strong>{form.allergyHistory || '—'}<br />
                  <strong>个人史：</strong>{form.personalHistory || '—'}<br />
                  <strong>诊断/辨证：</strong>{form.diagnosis || '—'}　{form.differentiation || '—'}<br />
                  <strong>脉诊：</strong>{symptoms.pulseDescription || '—'}<br />
                  <strong>舌诊：</strong>{[symptoms.tongueColor, symptoms.tongueCoating, symptoms.tongueShape, symptoms.tongueTexture].filter(Boolean).join(' ') || '—'}<br />
                  <strong>望诊：</strong>{[symptoms.facialColor, symptoms.expression].filter(Boolean).join(' ') || '—'}<br />
                  <strong>问诊：</strong>{[symptoms.sleepQuality, symptoms.appetite, symptoms.thirst, symptoms.bowelMovement].filter(Boolean).join(' ') || '—'}
                </div>
              </div>
            ) : (
            <div className="ws-card-body">
              <div className="ws-form-grid">
                <div className="ws-field"><label>姓名 <span className="req">*</span></label><input name="name" value={form.name} onChange={handleChange} placeholder="患者姓名" /></div>
                <div className="ws-field"><label>性别</label><select name="gender" value={form.gender} onChange={handleChange}><option value="">选择</option><option value="male">男</option><option value="female">女</option></select></div>
                <div className="ws-field"><label>年龄</label><input type="number" name="age" value={form.age} onChange={handleChange} placeholder="岁" /></div>
                <div className="ws-field"><label>电话</label><input name="phone" value={form.phone} onChange={handleChange} placeholder="手机号" /></div>
              </div>
              <div className="ws-field full ws-chief-complaint-field" style={{position:'relative'}} ref={chiefComplaintRef}>
                <label>主诉 <span className="req">*</span></label>
                <textarea
                  name="chiefComplaint"
                  value={form.chiefComplaint}
                  onChange={handleChange}
                  onFocus={() => setShowChiefComplaintPicker(true)}
                  placeholder="点击选择症状标签或手动输入"
                  rows={2}
                  style={{cursor:'pointer'}}
                />
                {showChiefComplaintPicker && (
                  <div className="ws-picker-panel ws-chief-complaint-picker">
                    <div className="ws-pulse-tags">
                      {['咳嗽','干咳','咳痰','夜咳','晨咳','咽干','咽痒','咽痛','痰中带血','声音嘶哑','咽部异物感','反复感冒','发热','喷嚏','流涕','鼻塞','头痛','头晕','耳鸣','汗多','盗汗','自汗','头汗','易汗出','胃胀','胃痛','胃不适','腹胀','腹痛','腹泻','恶心','呕吐','反酸','嗳气','烧心','纳差','便秘','便','便血','黑便','大便干','大便黏','五更泻','腹痛欲便','里急后重','排便不爽','溏结不调','胸闷','胸痛','心悸','气短','气喘','气促','眠差','眠浅','多梦','易醒','早醒','入睡困难','嗜睡','尿频','尿急','尿痛','尿不尽','尿灼热','尿分叉','夜尿多','尿浊','尿血','水肿','阳痿','遗精','早泄','肩痛','胁痛','背痛','腰痛','颈椎痛','关节痛','关节僵硬','四肢麻木','半身麻木','四肢无力','偏瘫','拘挛','眼干','口干','口苦','牙痛','齿衄','口疮','皮疹','斑疹','丘疹','风团','皮肤红斑','皮肤瘙痒','痛经','闭经','崩漏','月经量多','月经量少','月经提前','月经延后','经期错乱','带下量多','带下量少','带下异味','黄带','偶尔','1天','2天','3天','4天','5天','1周','2周','3周','1个月','2个月','3个月','半年','1年'].map(v => (
                        <span key={'cc-'+v} className="ws-pulse-tag" onClick={() => { const cur = form.chiefComplaint; setForm(prev => ({ ...prev, chiefComplaint: cur ? cur + ' ' + v : v })); }}>{v}</span>
                      ))}
                    </div>
                  </div>
                )}
              </div>
              <div className="ws-field full" style={{position:'relative'}} ref={presentIllnessRef}>
                <label>现病史</label>
                <textarea
                  name="presentIllness"
                  value={form.presentIllness}
                  onChange={handleChange}
                  onFocus={() => setShowPresentIllnessPicker(true)}
                  placeholder="点击选择标签或手动输入"
                  rows={2}
                  style={{cursor:'pointer'}}
                />
                {showPresentIllnessPicker && (
                  <div className="ws-picker-panel ws-chief-complaint-picker">
                    <div className="ws-pulse-section">
                      <span className="ws-pulse-section-label">诱因</span>
                      <div className="ws-pulse-tags">
                        {['无明显诱因','受凉','劳累','接触感冒患者','季节变化','淋雨'].map(v => (
                          <span key={'pi-'+v} className="ws-pulse-tag" onClick={() => { const cur = form.presentIllness; setForm(prev => ({ ...prev, presentIllness: cur ? cur + ' ' + v : v })); }}>{v}</span>
                        ))}
                      </div>
                    </div>
                    <div className="ws-pulse-section">
                      <span className="ws-pulse-section-label">特征</span>
                      <div className="ws-pulse-tags">
                        {['高热','低热','喷嚏频繁','喷嚏阵发性','发热反复'].map(v => (
                          <span key={'pi-'+v} className="ws-pulse-tag" onClick={() => { const cur = form.presentIllness; setForm(prev => ({ ...prev, presentIllness: cur ? cur + ' ' + v : v })); }}>{v}</span>
                        ))}
                      </div>
                    </div>
                    <div className="ws-pulse-section">
                      <span className="ws-pulse-section-label">影响</span>
                      <div className="ws-pulse-tags">
                        {['休息后缓解','受凉后加重','夜间加重','活动后加重','多饮水后缓解'].map(v => (
                          <span key={'pi-'+v} className="ws-pulse-tag" onClick={() => { const cur = form.presentIllness; setForm(prev => ({ ...prev, presentIllness: cur ? cur + ' ' + v : v })); }}>{v}</span>
                        ))}
                      </div>
                    </div>
                    <div className="ws-pulse-section">
                      <span className="ws-pulse-section-label">伴随</span>
                      <div className="ws-pulse-tags">
                        {['流涕','咽痛','咳嗽','头痛','肌肉酸痛'].map(v => (
                          <span key={'pi-'+v} className="ws-pulse-tag" onClick={() => { const cur = form.presentIllness; setForm(prev => ({ ...prev, presentIllness: cur ? cur + ' ' + v : v })); }}>{v}</span>
                        ))}
                      </div>
                    </div>
                  </div>
                )}
              </div>
              <div className="ws-form-grid">
                <div className="ws-field" style={{position:'relative'}} ref={pastHistoryRef}>
                  <label>既往病史</label>
                  <input
                    name="pastHistory"
                    value={form.pastHistory}
                    onChange={handleChange}
                    onFocus={() => setShowPastHistoryPicker(true)}
                    placeholder="点击选择或手动输入"
                    style={{cursor:'pointer'}}
                  />
                  {showPastHistoryPicker && (
                    <div className="ws-picker-panel ws-chief-complaint-picker">
                      <div className="ws-pulse-section">
                        <span className="ws-pulse-section-label">既往有</span>
                        <div className="ws-pulse-tags">
                          {['高血压','高血脂','心脏病','糖尿病','痛风','精神疾病','脑梗死','肝炎','胃炎','肺结核','哮喘','鼻炎','甲亢','血液病'].map(v => (
                            <span key={'ph-'+v} className="ws-pulse-tag" onClick={() => { const cur = form.pastHistory; setForm(prev => ({ ...prev, pastHistory: cur ? cur + ' ' + v : v })); }}>{v}</span>
                          ))}
                        </div>
                      </div>
                    </div>
                  )}
                </div>
                <div className="ws-field" style={{position:'relative'}} ref={allergyRef}>
                  <label>过敏史</label>
                  <input
                    name="allergyHistory"
                    value={form.allergyHistory}
                    onChange={handleChange}
                    onFocus={() => setShowAllergyPicker(true)}
                    placeholder="点击选择或手动输入"
                    style={{cursor:'pointer'}}
                  />
                  {showAllergyPicker && (
                    <div className="ws-picker-panel ws-chief-complaint-picker">
                      <div className="ws-pulse-tags">
                        {['青霉素','链霉素','卡那霉素','林可霉素','左氧氟沙星','溴芬酸钠','阿托品','头孢类','磺胺类','酒精','碘伏','去痛片','扑热息痛','安痛定','安定','鲁米那','阿司匹林','普鲁卡因','花粉','霉菌','尘螨','毛皮屑','牛奶','鸡蛋','大豆','小麦','花生','鱼虾','坚果'].map(v => (
                          <span key={'al-'+v} className="ws-pulse-tag" onClick={() => { const cur = form.allergyHistory; setForm(prev => ({ ...prev, allergyHistory: cur ? cur + ' ' + v : v })); }}>{v}</span>
                        ))}
                      </div>
                    </div>
                  )}
                </div>
              </div>
              <div className="ws-field full" style={{position:'relative'}} ref={personalHistoryRef}>
                <label>个人史</label>
                <textarea
                  name="personalHistory"
                  value={form.personalHistory}
                  onChange={handleChange}
                  onFocus={() => setShowPersonalHistoryPicker(true)}
                  placeholder="点击选择标签或手动输入"
                  rows={2}
                  style={{cursor:'pointer'}}
                />
                {showPersonalHistoryPicker && (
                  <div className="ws-picker-panel ws-chief-complaint-picker">
                    <div className="ws-pulse-section">
                      <span className="ws-pulse-section-label">吸烟/饮酒</span>
                      <div className="ws-pulse-tags">
                        {['吸烟','偶尔吸烟','长期吸烟','不饮酒','偶尔饮酒','长期饮酒'].map(v => (
                          <span key={'ps-'+v} className="ws-pulse-tag" onClick={() => { const cur = form.personalHistory; setForm(prev => ({ ...prev, personalHistory: cur ? cur + ' ' + v : v })); }}>{v}</span>
                        ))}
                      </div>
                    </div>
                    <div className="ws-pulse-section">
                      <span className="ws-pulse-section-label">婚育</span>
                      <div className="ws-pulse-tags">
                        {['未婚','已婚','未孕','备孕','怀孕','闭经','有早产史','有流产史','有痛经史'].map(v => (
                          <span key={'ps-'+v} className="ws-pulse-tag" onClick={() => { const cur = form.personalHistory; setForm(prev => ({ ...prev, personalHistory: cur ? cur + ' ' + v : v })); }}>{v}</span>
                        ))}
                      </div>
                    </div>
                  </div>
                )}
              </div>
              <div className="ws-form-grid">
                <div className="ws-field"><label>诊断</label><input name="diagnosis" value={form.diagnosis} onChange={handleChange} placeholder="请输入诊断" /></div>
                <div className="ws-field"><label>辩证</label><input name="differentiation" value={form.differentiation} onChange={handleChange} placeholder="请输入辩证" /></div>
                <div className="ws-field"><label>治法</label><input name="treatmentMethod" value={form.treatmentMethod} onChange={handleChange} placeholder="请输入治法" /></div>
                <div className="ws-field"><label>方药</label><input name="prescription" value={form.prescription} onChange={handleChange} placeholder="请输入方药" /></div>
              </div>
            </div>
          )}
          </div>

          {/* 四诊采集 (Step 0) / 处方管理 (Step 1,2) */}
          {currentStep >= 1 ? (
            <div className="ws-card" style={{ flex: 1, display: 'flex', flexDirection: 'column' }}>
              <div className="ws-card-head" style={{ background: 'var(--primary-bg)' }}>
                <h3 style={{ color: 'var(--primary)' }}>
                  <svg width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2">
                    <polyline points="9 11 12 14 22 4" /><path d="M21 12v7a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2h11" />
                  </svg>
                  处方管理
                </h3>
              </div>
              <div className="ws-card-body" style={{ flex: 1, minHeight: 0, overflowY: 'auto' }}>
                {/* 多推荐方剂选择（可多选）+ 自定义 */}
                <div style={{ display: 'flex', gap: 6, marginBottom: 8, flexWrap: 'wrap' }}>
                  {prescriptionMock.formulas.map((f, i) => {
                    const selected = selectedFormulaIndices.includes(i)
                    return (
                      <div
                        key={i}
                        onClick={() => {
                          let newIndices: number[]
                          if (selected) {
                            newIndices = selectedFormulaIndices.filter(idx => idx !== i)
                          } else {
                            newIndices = [...selectedFormulaIndices, i]
                          }
                          setSelectedFormulaIndices(newIndices)
                          const merged = getMergedFromIndices(newIndices)
                          setAiHerbs(merged.herbs)
                          setFormulaEffects(merged.effects)
                          setEditReason(merged.reason)
                          setEditFormulaName(newIndices.length === 1 ? prescriptionMock.formulas[newIndices[0]].name : '合方(' + newIndices.map(idx => prescriptionMock.formulas[idx].name).join('+') + ')')
                          setDeletedHerb(null)
                          setEditingFormulaName(false)
                          setEditingEffectIdx(null)
                          setEditingReason(false)
                        }}
                        style={{
                          flex: 1, padding: '6px 8px', borderRadius: 6, cursor: 'pointer', textAlign: 'center', minWidth: 60,
                          border: selected ? '1.5px solid var(--primary)' : '1px solid #E0E0E0',
                          background: selected ? 'var(--primary-bg)' : '#FAFAFA',
                          position: 'relative',
                        }}
                      >
                        {selected && (
                          <span style={{ position: 'absolute', top: -4, right: -4, width: 16, height: 16, borderRadius: '50%', background: 'var(--primary)', color: '#fff', fontSize: 9, lineHeight: '16px', textAlign: 'center', fontWeight: 600 }}>✓</span>
                        )}
                        <div className={'ws-ai-formula-name' + (selected ? ' active' : '')}>
                          {f.name}
                        </div>
                        <div style={{ fontSize: 10, color: 'var(--text-muted)', marginTop: 1 }}>{f.herbs.length}味</div>
                        <span style={{ fontSize: 8, background: '#52C41A', color: '#fff', padding: '1px 8px', borderRadius: 8, fontWeight: 600, display: 'inline-block', marginTop: 2, letterSpacing: 0.5 }}>AI推荐</span>
                      </div>
                    )
                  })}
                  <div
                    onClick={() => setShowCustomEditor(prev => !prev)}
                    style={{
                      flex: 0.7, padding: '6px 8px', borderRadius: 6, cursor: 'pointer', textAlign: 'center',
                      border: showCustomEditor ? '1.5px solid var(--primary)' : '1px dashed #B5B5B5',
                      background: showCustomEditor ? '#FFF7E6' : '#FAFAFA',
                      display: 'flex', alignItems: 'center', justifyContent: 'center', gap: 3,
                    }}
                  >
                    <span style={{ fontSize: 14, lineHeight: 1, color: showCustomEditor ? 'var(--primary)' : 'var(--text-muted)' }}>+</span>
                    <span style={{ fontSize: 11, fontWeight: showCustomEditor ? 600 : 400, color: showCustomEditor ? 'var(--primary)' : 'var(--text-muted)' }}>附加方剂</span>
                    {showCustomEditor && <span style={{ fontSize: 9, background: '#FFF7E6', color: '#D46B08', padding: '0 6px', borderRadius: 4 }}>展开</span>}
                  </div>
                </div>

                {/* 通用：方剂名编辑（仅AI方剂） */}
                {showCustomEditor && (
                  <div style={{ marginBottom: 6, position: 'relative' }}>
                    <div className="ws-sub-title" style={{ fontSize: 11, marginTop: 0, marginBottom: 4 }}>方剂名称</div>
                    <input
                      style={{ width: '100%', boxSizing: 'border-box', border: '1px solid var(--border)', borderRadius: 6, fontSize: 13, fontWeight: 600, padding: '4px 10px', outline: 'none' }}
                      value={customFormulaName}
                      onChange={e => {
                        const val = e.target.value
                        setCustomFormulaName(val)
                        setFormulaSearchQuery(val)
                        setShowFormulaSearchResults(val.length > 0)
                        if (!val.trim()) {
                          // 清空名称时同步清除对应的药材/功效/理由
                          setCustomHerbs([])
                          setCustomEffects([])
                          setCustomReason('')
                          setSelectedCommonFormulaNames([])
                        }
                      }}
                      onFocus={() => setShowFormulaSearchResults(formulaSearchQuery.length > 0)}
                      placeholder="输入方剂名称搜索自动补全"
                    />
                    {showFormulaSearchResults && (
                      <div style={{ position: 'absolute', top: '100%', left: 0, right: 0, background: '#fff', border: '1px solid var(--border)', borderRadius: 6, zIndex: 100, maxHeight: 160, overflowY: 'auto', boxShadow: '0 4px 12px rgba(0,0,0,0.1)' }}>
                        {[...prescriptionMock.formulas, ...commonFormulas.map(f => ({ name: f.name, herbs: f.herbs.map(h => ({ name: h, dosage: '9g' })), effects: [] as string[], reason: '' }))]
                          .filter(f => f.name.includes(formulaSearchQuery))
                          .map((f, i) => (
                            <div key={i} style={{ padding: '6px 10px', cursor: 'pointer', fontSize: 12, borderBottom: '1px solid #F0F0F0' }}
                              onMouseDown={() => {
                                setCustomFormulaName(f.name)
                                setCustomHerbs(f.herbs.map(h => ({ ...h })))
                                setCustomEffects(f.effects ? [...f.effects] : [])
                                setCustomReason(f.reason || '')
                                setShowFormulaSearchResults(false)
                                setFormulaSearchQuery('')
                              }}
                            >
                              <strong>{f.name}</strong>
                              <span style={{ color: 'var(--text-muted)', marginLeft: 8 }}>{f.herbs.length}味</span>
                            </div>
                          ))}
                        {[...prescriptionMock.formulas, ...commonFormulas.map(f => ({ name: f.name, herbs: f.herbs.map(h => ({ name: h, dosage: '9g' })), effects: [] as string[], reason: '' }))]
                          .filter(f => f.name.includes(formulaSearchQuery)).length === 0 && (
                          <div style={{ padding: '6px 10px', fontSize: 11, color: 'var(--text-muted)' }}>无匹配方剂</div>
                        )}
                      </div>
                    )}
                  </div>
                )}

                {/* 通用：方剂名编辑（仅AI方剂） */}
                {!showCustomEditor && selectedFormulaIndices.length > 0 && (
                  <div style={{ fontSize: 13, fontWeight: 600, color: 'var(--primary)', marginBottom: 6, textAlign: 'center', padding: '4px', background: 'var(--primary-bg)', borderRadius: 6, cursor: 'pointer' }} onClick={() => { setEditingFormulaName(true); setEditFormulaName(selectedFormulaIndices.length === 1 ? prescriptionMock.formulas[selectedFormulaIndices[0]].name : '合方(' + selectedFormulaIndices.map(idx => prescriptionMock.formulas[idx].name).join('+') + ')') }}>
                    {editFormulaName || (selectedFormulaIndices.length === 1 ? prescriptionMock.formulas[selectedFormulaIndices[0]].name : '合方(' + selectedFormulaIndices.map(idx => prescriptionMock.formulas[idx].name).join('+') + ')')}
                    <span style={{ fontWeight: 400, fontSize: 10, color: 'var(--text-muted)', marginLeft: 6 }}>点击编辑</span>
                  </div>
                )}

                {/* ===== 统一药材显示（AI + 自定义合并） ===== */}
                <div className="ws-sub-title" style={{ fontSize: 11, marginTop: 0 }}>组成
                  <span style={{ fontWeight: 400, color: 'var(--text-muted)', marginLeft: 6, fontSize: 10 }}>点击药材可修改</span>
                  {showCustomEditor && customHerbs.length > 0 && (
                    <span style={{ marginLeft: 8, fontSize: 10, color: '#D46B08', background: '#FFF7E6', padding: '0 6px', borderRadius: 4 }}>
                      +{customHerbs.length}味自定义
                    </span>
                  )}
                </div>
                <div style={{ display: 'flex', flexDirection: 'column', gap: 4, marginBottom: 8 }}>
                  {(() => {
                    const displayHerbs = showCustomEditor ? [...aiHerbs, ...customHerbs] : aiHerbs
                    const aiCount = aiHerbs.length
                    // Build source map: herbName → [formula names]
                    const sourceMap = new Map<string, Set<string>>()
                    for (const idx of selectedFormulaIndices) {
                      const f = prescriptionMock.formulas[idx]
                      for (const h of f.herbs) {
                        if (!sourceMap.has(h.name)) sourceMap.set(h.name, new Set())
                        sourceMap.get(h.name)!.add(f.name)
                      }
                    }
                    for (const name of selectedCommonFormulaNames) {
                      const cf = commonFormulas.find(c => c.name === name)
                      if (cf) {
                        for (const h of cf.herbs) {
                          if (!sourceMap.has(h)) sourceMap.set(h, new Set())
                          sourceMap.get(h)!.add(name)
                        }
                      }
                    }
                    // Merge display herbs by name
                    const seenNames = new Set<string>()
                    const mergedHerbs: { name: string; dosage: string; sources: string[]; isAI: boolean; origIdx: number; isCustom: boolean; customIdx: number }[] = []
                    for (let idx = 0; idx < displayHerbs.length; idx++) {
                      const h = displayHerbs[idx]
                      if (seenNames.has(h.name)) continue
                      seenNames.add(h.name)
                      const rawSources = sourceMap.get(h.name)
                      const sources = rawSources ? Array.from(rawSources) : ['手动']
                      mergedHerbs.push({
                        name: h.name,
                        dosage: h.dosage,
                        sources,
                        isAI: idx < aiCount,
                        origIdx: idx,
                        isCustom: idx >= aiCount,
                        customIdx: idx - aiCount,
                      })
                    }
                    if (displayHerbs.length === 0) {
                      return <div style={{ fontSize: 11, color: 'var(--text-muted)', padding: '4px 0' }}>暂未添加药材</div>
                    }
                    return mergedHerbs.map((mh) => {
                      const isEditing = mh.isAI ? editingHerbIdx === mh.origIdx : editingCustomHerbIdx === mh.customIdx
                      if (isEditing) {
                        return (
                          <div key={`merged-${mh.name}`} style={{ display: 'flex', gap: 4, alignItems: 'center', padding: '2px 6px', background: '#fff', border: '1px solid var(--primary)', borderRadius: 6 }}>
                            <input style={{ width: 70, border: 'none', outline: 'none', fontSize: 12, padding: '2px 0' }} value={mh.isAI ? editName : editCustomName} onChange={e => mh.isAI ? setEditName(e.target.value) : setEditCustomName(e.target.value)} placeholder="药名" />
                            <input style={{ width: 50, border: 'none', outline: 'none', fontSize: 12, padding: '2px 0', textAlign: 'right' }} value={mh.isAI ? editDosage : editCustomDosage} onChange={e => mh.isAI ? setEditDosage(e.target.value) : setEditCustomDosage(e.target.value)} placeholder="剂量" />
                            <button style={{ border: 'none', background: 'var(--primary)', color: '#fff', borderRadius: 4, fontSize: 10, padding: '1px 6px', cursor: 'pointer' }} onClick={() => {
                              const name = (mh.isAI ? editName : editCustomName).trim()
                              if (!name) return
                              if (mh.isAI) {
                                const updated = [...aiHerbs]; updated[mh.origIdx] = { name, dosage: editDosage.trim() }; setAiHerbs(updated)
                              } else {
                                const updated = [...customHerbs]; updated[mh.customIdx] = { name, dosage: editCustomDosage.trim() }; setCustomHerbs(updated)
                              }
                              mh.isAI ? setEditingHerbIdx(null) : setEditingCustomHerbIdx(null)
                            }}>✓</button>
                            <button style={{ border: 'none', background: 'transparent', color: '#999', cursor: 'pointer', fontSize: 12 }} onClick={() => mh.isAI ? setEditingHerbIdx(null) : setEditingCustomHerbIdx(null)}>×</button>
                            <button style={{ border: 'none', background: '#FF4D4F', color: '#fff', borderRadius: 4, fontSize: 10, padding: '1px 6px', cursor: 'pointer' }} onClick={() => {
                              if (mh.isAI) {
                                setDeletedHerb({ herb: aiHerbs[mh.origIdx], index: mh.origIdx })
                                setAiHerbs(prev => prev.filter((_, idx) => idx !== mh.origIdx))
                                setEditingHerbIdx(null)
                              } else {
                                setDeletedCustomHerb({ herb: customHerbs[mh.customIdx], index: mh.customIdx })
                                setCustomHerbs(prev => prev.filter((_, idx) => idx !== mh.customIdx))
                                setEditingCustomHerbIdx(null)
                              }
                              if (undoTimeoutRef.current) clearTimeout(undoTimeoutRef.current)
                              undoTimeoutRef.current = setTimeout(() => { setDeletedHerb(null); setDeletedCustomHerb(null) }, 6000)
                            }}>删</button>
                          </div>
                        )
                      }
                      return (
                        <div key={`merged-${mh.name}`}
                          className="ws-tag"
                          style={{
                            fontSize: 12,
                            background: mh.isAI ? '#F0FFF4' : '#FFF7E6',
                            borderColor: mh.isAI ? '#95DE64' : '#FFD591',
                            padding: '3px 10px', cursor: 'pointer',
                            display: 'flex', alignItems: 'center', gap: 6,
                          }}
                          onClick={() => {
                            // Find first editable occurrence
                            let found = false
                            for (let j = 0; j < aiHerbs.length; j++) {
                              if (aiHerbs[j].name === mh.name) {
                                setEditingHerbIdx(j); setEditName(aiHerbs[j].name); setEditDosage(aiHerbs[j].dosage); found = true; break
                              }
                            }
                            if (!found) {
                              for (let j = 0; j < customHerbs.length; j++) {
                                if (customHerbs[j].name === mh.name) {
                                  setEditingCustomHerbIdx(j); setEditCustomName(customHerbs[j].name); setEditCustomDosage(customHerbs[j].dosage); break
                                }
                              }
                            }
                          }}
                        >
                          <span>{mh.name} <strong>{mh.dosage}</strong></span>
                          <span style={{ display: 'flex', gap: 2, flexWrap: 'wrap' }}>
                            {mh.sources.map((s, si) => (
                              <span key={si} style={{
                                fontSize: 8, padding: '0 4px', borderRadius: 3,
                                background: s === '手动' ? '#E6E6E6' : mh.isAI ? '#D9F7BE' : '#FFE58F',
                                color: s === '手动' ? '#666' : mh.isAI ? '#389E0D' : '#D46B08',
                                whiteSpace: 'nowrap',
                              }}>{s}</span>
                            ))}
                          </span>
                        </div>
                      )
                    })
                  })()}
                  <span className="ws-tag" style={{ fontSize: 12, background: '#FAFAFA', borderColor: '#D9D9D9', padding: '3px 10px', cursor: 'pointer', color: 'var(--text-muted)' }} onClick={() => {
                    if (showCustomEditor) {
                      setCustomHerbs(prev => [...prev, { name: '', dosage: '' }])
                      setEditingCustomHerbIdx(customHerbs.length)
                      setEditCustomName(''); setEditCustomDosage('')
                    } else {
                      setAiHerbs(prev => [...prev, { name: '', dosage: '' }])
                      setEditingHerbIdx(aiHerbs.length)
                      setEditName(''); setEditDosage('')
                    }
                  }}>
                    + 添加药材
                  </span>
                </div>

                {deletedHerb && !deletedCustomHerb && (
                  <div style={{ display: 'flex', alignItems: 'center', gap: 8, marginBottom: 6, padding: '4px 10px', background: '#FFF7E6', border: '1px solid #FFD591', borderRadius: 6, fontSize: 11 }}>
                    <span style={{ color: 'var(--text-secondary)' }}>已删除 {deletedHerb.herb.name} {deletedHerb.herb.dosage}</span>
                    <button style={{ border: '1px solid var(--primary)', background: '#fff', color: 'var(--primary)', borderRadius: 4, fontSize: 11, padding: '1px 10px', cursor: 'pointer' }} onClick={() => { const restored = [...aiHerbs]; restored.splice(deletedHerb.index, 0, deletedHerb.herb); setAiHerbs(restored); setDeletedHerb(null); if (undoTimeoutRef.current) clearTimeout(undoTimeoutRef.current) }}>撤销</button>
                  </div>
                )}
                {deletedCustomHerb && (
                  <div style={{ display: 'flex', alignItems: 'center', gap: 8, marginBottom: 6, padding: '4px 10px', background: '#FFF7E6', border: '1px solid #FFD591', borderRadius: 6, fontSize: 11 }}>
                    <span style={{ color: 'var(--text-secondary)' }}>已删除 {deletedCustomHerb.herb.name} {deletedCustomHerb.herb.dosage}</span>
                    <button style={{ border: '1px solid var(--primary)', background: '#fff', color: 'var(--primary)', borderRadius: 4, fontSize: 11, padding: '1px 10px', cursor: 'pointer' }} onClick={() => { const restored = [...customHerbs]; restored.splice(deletedCustomHerb.index, 0, deletedCustomHerb.herb); setCustomHerbs(restored); setDeletedCustomHerb(null); if (undoTimeoutRef.current) clearTimeout(undoTimeoutRef.current) }}>撤销</button>
                  </div>
                )}

                {/* ===== 统一功效显示（AI + 自定义合并） ===== */}
                <div className="ws-sub-title" style={{ fontSize: 11 }}>功效 <span style={{ fontWeight: 400, color: 'var(--text-muted)', fontSize: 10 }}>点击编辑</span></div>
                <div style={{ display: 'flex', flexWrap: 'wrap', gap: 4, marginBottom: 8, fontSize: 12, color: 'var(--text-secondary)' }}>
                  {(() => {
                    const displayEffects = showCustomEditor ? [...formulaEffects, ...customEffects] : formulaEffects
                    const aiEffectCount = formulaEffects.length
                    if (displayEffects.length === 0) {
                      return <span style={{ fontSize: 11, color: 'var(--text-muted)' }}>暂未添加功效</span>
                    }
                    return displayEffects.map((e, i) => {
                      const isAI = i < aiEffectCount
                      const cIdx = i - aiEffectCount
                      const isEditing = isAI ? editingEffectIdx === i : editingCustomEffectIdx === cIdx
                      if (isEditing) {
                        return (
                          <div key={`eff-${isAI ? 'ai' : 'cus'}-${i}`} style={{ display: 'flex', gap: 2, alignItems: 'center' }}>
                            <input style={{ width: 70, border: '1px solid var(--primary)', borderRadius: 4, fontSize: 11, padding: '1px 4px', outline: 'none' }} value={isAI ? editEffect : editCustomEffect} onChange={e2 => isAI ? setEditEffect(e2.target.value) : setEditCustomEffect(e2.target.value)} autoFocus />
                            <button style={{ border: 'none', background: 'var(--primary)', color: '#fff', borderRadius: 4, fontSize: 9, padding: '1px 5px', cursor: 'pointer' }} onClick={() => {
                              const val = (isAI ? editEffect : editCustomEffect).trim()
                              if (!val) return
                              if (isAI) { const u = [...formulaEffects]; u[i] = val; setFormulaEffects(u) }
                              else { const u = [...customEffects]; u[cIdx] = val; setCustomEffects(u) }
                              isAI ? setEditingEffectIdx(null) : setEditingCustomEffectIdx(null)
                            }}>✓</button>
                            <button style={{ border: 'none', background: '#FF4D4F', color: '#fff', borderRadius: 4, fontSize: 9, padding: '1px 5px', cursor: 'pointer' }} onClick={() => {
                              if (isAI) { setFormulaEffects(prev => prev.filter((_, idx) => idx !== i)); setEditingEffectIdx(null) }
                              else { setCustomEffects(prev => prev.filter((_, idx) => idx !== cIdx)); setEditingCustomEffectIdx(null) }
                            }}>×</button>
                          </div>
                        )
                      }
                      return (
                        <span key={`eff-${isAI ? 'ai' : 'cus'}-${i}`} style={{
                          padding: '2px 8px', borderRadius: 4, border: '1px solid', cursor: 'pointer', fontSize: 11,
                          background: isAI ? '#FFF7E6' : '#FFFBE6',
                          borderColor: isAI ? '#FFD591' : '#FFE58F',
                        }} onClick={() => {
                          if (isAI) { setEditingEffectIdx(i); setEditEffect(e) }
                          else { setEditingCustomEffectIdx(cIdx); setEditCustomEffect(e) }
                        }}>
                          {e}
                        </span>
                      )
                    })
                  })()}
                  <span style={{ padding: '2px 8px', background: '#FAFAFA', borderRadius: 4, border: '1px dashed #D9D9D9', cursor: 'pointer', fontSize: 11, color: 'var(--text-muted)' }} onClick={() => {
                    if (showCustomEditor) {
                      setCustomEffects(prev => [...prev, ''])
                      setEditingCustomEffectIdx(customEffects.length)
                      setEditCustomEffect('')
                    } else {
                      setFormulaEffects(prev => [...prev, ''])
                      setEditingEffectIdx(formulaEffects.length)
                      setEditEffect('')
                    }
                  }}>
                    + 添加功效
                  </span>
                </div>

                {/* ===== 统一推荐理由显示 ===== */}
                <div className="ws-sub-title" style={{ fontSize: 11 }}>推荐理由
                  <span style={{ fontWeight: 400, color: 'var(--text-muted)', marginLeft: 6, fontSize: 10 }}>点击可编辑</span>
                </div>
                {(() => {
                  const aiReason = getMergedFromIndices(selectedFormulaIndices).reason
                  const displayReason = showCustomEditor && customReason ? (aiReason ? aiReason + '；' + customReason : customReason) : aiReason
                  if (editingReason) {
                    return (
                      <div style={{ display: 'flex', flexDirection: 'column', gap: 4, marginBottom: 8 }}>
                        <textarea style={{ fontSize: 11, lineHeight: 1.6, padding: '6px 10px', background: '#fff', border: '1px solid var(--primary)', borderRadius: 6, resize: 'vertical', outline: 'none', width: '100%', boxSizing: 'border-box' }} value={editReason} onChange={e => setEditReason(e.target.value)} rows={3} autoFocus />
                        <div style={{ display: 'flex', gap: 4 }}>
                          <button style={{ border: '1px solid var(--primary)', background: 'var(--primary)', color: '#fff', borderRadius: 4, fontSize: 10, padding: '2px 12px', cursor: 'pointer' }} onClick={() => setEditingReason(false)}>✓ 确认</button>
                          <button style={{ border: '1px solid #999', background: '#fff', color: '#999', borderRadius: 4, fontSize: 10, padding: '2px 12px', cursor: 'pointer' }} onClick={() => { setEditingReason(false); setEditReason(aiReason) }}>× 取消</button>
                        </div>
                      </div>
                    )
                  }
                  return (
                    <div style={{ fontSize: 11, color: 'var(--text-secondary)', lineHeight: 1.6, padding: '6px 10px', background: 'var(--bg-page)', borderRadius: 6, cursor: 'pointer', marginBottom: showCustomEditor ? 8 : 0 }} onClick={() => { setEditingReason(true); setEditReason(displayReason) }}>
                      {displayReason || '点击此处输入推荐理由...'}
                    </div>
                  )
                })()}

                {/* ===== 附加方剂编辑器（精简） ===== */}
                {showCustomEditor && (
                  <>
                    <div style={{ borderTop: '1px dashed var(--border)', margin: '8px 0 6px' }} />
                    <div style={{ display: 'flex', gap: 4, flexWrap: 'wrap', alignItems: 'center' }}>
                      <span style={{ fontSize: 10, color: '#D46B08', background: '#FFF7E6', padding: '2px 6px', borderRadius: 4 }}>
                        附加方剂已合并到上方，可直接编辑
                      </span>
                    </div>
                  </>
                )}
              </div>
            </div>
          ) : (
            <div className="ws-card">
              <div className="ws-card-head"><h3>四诊采集</h3></div>
              <div className="ws-card-body">
                <div className="ws-sub-title">脉诊</div>
                <div className="ws-field full" style={{position:'relative'}}>
                  <input value={symptoms.pulseDescription} onChange={e => handleSymptomChange('pulseDescription', e.target.value)} onFocus={() => setShowPulsePicker(true)} placeholder="点击选择或输入脉象" style={{cursor:'pointer'}} />
                  {showPulsePicker && (
                    <div className="ws-picker-panel">
                      <div className="ws-pulse-section"><span className="ws-pulse-section-label">左脉</span><div className="ws-pulse-tags">{pulseOptions.map(v => (<span key={'l-'+v} className="ws-pulse-tag" onClick={() => { const cur = symptoms.pulseDescription; handleSymptomChange('pulseDescription', cur ? cur + ' ' + v : v) }}>{v}</span>))}</div></div>
                      <div className="ws-pulse-section"><span className="ws-pulse-section-label">右脉</span><div className="ws-pulse-tags">{pulseOptions.map(v => (<span key={'r-'+v} className="ws-pulse-tag" onClick={() => { const cur = symptoms.pulseDescription; handleSymptomChange('pulseDescription', cur ? cur + ' ' + v : v) }}>{v}</span>))}</div></div>
                      <div className="ws-pulse-section"><span className="ws-pulse-section-label">脉象描述</span><div className="ws-pulse-tags">{['弦细','滑数','沉迟','浮紧','细弱','洪大','濡缓','涩滞','虚浮','实有力'].map(v => (<span key={'d-'+v} className="ws-pulse-tag" onClick={() => { const cur = symptoms.pulseDescription; handleSymptomChange('pulseDescription', cur ? cur + ' ' + v : v) }}>{v}</span>))}</div></div>
                    </div>
                  )}
                </div>
                <div className="ws-field full" style={{ display: 'flex', alignItems: 'center', gap: 8, marginTop: -4, marginBottom: 6 }}>
                  <span style={{ fontSize: 10, color: 'var(--text-muted)', display: 'flex', alignItems: 'center', gap: 4, cursor: 'pointer', padding: '3px 10px', background: '#F5F5F5', borderRadius: 4, border: '1px dashed #D9D9D9' }}
                    onClick={() => setPulseImportData('脉诊仪数据已导入（2026-07-16 14:32）')}
                  >
                    <svg width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2"><path d="M21 15v4a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2v-4"/><polyline points="7 10 12 15 17 10"/><line x1="12" y1="15" x2="12" y2="3"/></svg>
                    脉诊数据导入
                  </span>
                  {pulseImportData && <span style={{ fontSize: 10, color: '#52C41A' }}>✓ {pulseImportData}</span>}
                </div>
                <div className="ws-sub-title">舌诊</div>
                <div className="ws-field full" style={{position:'relative'}}>
                  <input value={symptoms.tongueColor + (symptoms.tongueCoating ? ' ' + symptoms.tongueCoating : '') + (symptoms.tongueShape ? ' ' + symptoms.tongueShape : '') + (symptoms.tongueTexture ? ' ' + symptoms.tongueTexture : '')} onChange={e => { const val = e.target.value; handleSymptomChange('tongueColor', val); handleSymptomChange('tongueCoating', ''); handleSymptomChange('tongueShape', ''); handleSymptomChange('tongueTexture', '') }} onFocus={() => setShowTonguePicker(true)} placeholder="点击选择或输入舌象" style={{cursor:'pointer'}} />
                  {showTonguePicker && (
                    <div className="ws-picker-panel">
                      <div className="ws-pulse-section"><span className="ws-pulse-section-label">舌质</span><div className="ws-pulse-tags">{['淡','红','绛','紫','青'].map(v => (<span key={'tc-'+v} className="ws-pulse-tag" onClick={() => handleSymptomChange('tongueColor', v)}>{v}</span>))}</div></div>
                      <div className="ws-pulse-section"><span className="ws-pulse-section-label">舌苔</span><div className="ws-pulse-tags">{['薄白','薄黄','白腻','黄腻','少苔','剥苔','厚苔'].map(v => (<span key={'tco-'+v} className="ws-pulse-tag" onClick={() => handleSymptomChange('tongueCoating', v)}>{v}</span>))}</div></div>
                      <div className="ws-pulse-section"><span className="ws-pulse-section-label">舌形</span><div className="ws-pulse-tags">{['胖大','肿胀','瘦薄','裂纹','齿痕'].map(v => (<span key={'ts-'+v} className="ws-pulse-tag" onClick={() => handleSymptomChange('tongueShape', v)}>{v}</span>))}</div></div>
                      <div className="ws-pulse-section"><span className="ws-pulse-section-label">纹理</span><div className="ws-pulse-tags">{['嫩','老','润','燥'].map(v => (<span key={'tt-'+v} className="ws-pulse-tag" onClick={() => handleSymptomChange('tongueTexture', v)}>{v}</span>))}</div></div>
                    </div>
                  )}
                </div>
                <div className="ws-field full" style={{ display: 'flex', alignItems: 'center', gap: 8, marginTop: -4, marginBottom: 6 }}>
                  <span style={{ fontSize: 10, color: 'var(--text-muted)', display: 'flex', alignItems: 'center', gap: 4, cursor: 'pointer', padding: '3px 10px', background: '#F5F5F5', borderRadius: 4, border: '1px dashed #D9D9D9' }}
                    onClick={() => {
                      const input = document.createElement('input')
                      input.type = 'file'
                      input.accept = 'image/*'
                      input.onchange = (e: any) => {
                        const file = e.target.files?.[0]
                        if (file) {
                          const reader = new FileReader()
                          reader.onload = (ev) => setTonguePhoto(ev.target?.result as string)
                          reader.readAsDataURL(file)
                        }
                      }
                      input.click()
                    }}
                  >
                    <svg width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2"><path d="M23 19a2 2 0 0 1-2 2H3a2 2 0 0 1-2-2V8a2 2 0 0 1 2-2h4l2-3h6l2 3h4a2 2 0 0 1 2 2z"/><circle cx="12" cy="13" r="4"/></svg>
                    舌诊拍照
                  </span>
                  {tonguePhoto && (
                    <span style={{ position: 'relative', display: 'inline-block' }}>
                      <img src={tonguePhoto} alt="舌诊照片" style={{ height: 28, width: 28, borderRadius: 4, objectFit: 'cover', border: '1px solid var(--border)', cursor: 'pointer' }}
                        onClick={() => window.open(tonguePhoto)}
                      />
                      <span style={{ position: 'absolute', top: -5, right: -5, width: 12, height: 12, borderRadius: '50%', background: '#FF4D4F', color: '#fff', fontSize: 8, lineHeight: '12px', textAlign: 'center', cursor: 'pointer' }}
                        onClick={() => setTonguePhoto(null)}
                      >×</span>
                    </span>
                  )}
                </div>
                <div className="ws-sub-title">望诊</div>
                <div className="ws-field full" style={{position:'relative'}}>
                  <input value={symptoms.facialColor + (symptoms.expression ? ' ' + symptoms.expression : '')} onChange={e => { const val = e.target.value; handleSymptomChange('facialColor', val); handleSymptomChange('expression', '') }} onFocus={() => setShowInspectionPicker(true)} placeholder="点击选择或输入望诊信息" style={{cursor:'pointer'}} />
                  {showInspectionPicker && (
                    <div className="ws-picker-panel">
                      <div className="ws-pulse-section"><span className="ws-pulse-section-label">面色</span><div className="ws-pulse-tags">{['苍白','潮红','萎黄','暗黑','正常'].map(v => (<span key={'fc-'+v} className="ws-pulse-tag" onClick={() => handleSymptomChange('facialColor', v)}>{v}</span>))}</div></div>
                      <div className="ws-pulse-section"><span className="ws-pulse-section-label">神态</span><div className="ws-pulse-tags">{['有神','少神','失神','烦躁','抑郁'].map(v => (<span key={'ex-'+v} className="ws-pulse-tag" onClick={() => handleSymptomChange('expression', v)}>{v}</span>))}</div></div>
                    </div>
                  )}
                </div>
                <div className="ws-sub-title">问诊</div>
                <div className="ws-field full" style={{position:'relative'}}>
                  <input value={symptoms.sleepQuality + (symptoms.appetite ? ' ' + symptoms.appetite : '') + (symptoms.thirst ? ' ' + symptoms.thirst : '') + (symptoms.bowelMovement ? ' ' + symptoms.bowelMovement : '')} onChange={e => { const val = e.target.value; handleSymptomChange('sleepQuality', val); handleSymptomChange('appetite', ''); handleSymptomChange('thirst', ''); handleSymptomChange('bowelMovement', '') }} onFocus={() => setShowInquiryPicker(true)} placeholder="点击选择或输入问诊信息" style={{cursor:'pointer'}} />
                  {showInquiryPicker && (
                    <div className="ws-picker-panel ws-chief-complaint-picker">
                      <div className="ws-pulse-section"><span className="ws-pulse-section-label">寒热</span><div className="ws-pulse-tags">{['恶风','恶寒','怕冷','怕热','潮热','手足心热'].map(v => (<span key={'iq-'+v} className="ws-pulse-tag" onClick={() => { const cur = symptoms.sleepQuality; handleSymptomChange('sleepQuality', cur ? cur + ' ' + v : v) }}>{v}</span>))}</div></div>
                      <div className="ws-pulse-section"><span className="ws-pulse-section-label">汗出</span><div className="ws-pulse-tags">{['自汗','盗汗','汗多','冷汗','头汗','手足心汗'].map(v => (<span key={'iq-'+v} className="ws-pulse-tag" onClick={() => { const cur = symptoms.sleepQuality; handleSymptomChange('sleepQuality', cur ? cur + ' ' + v : v) }}>{v}</span>))}</div></div>
                      <div className="ws-pulse-section"><span className="ws-pulse-section-label">饮食</span><div className="ws-pulse-tags">{['纳可','纳差','口干','口苦','喜冷饮','喜热饮'].map(v => (<span key={'iq-'+v} className="ws-pulse-tag" onClick={() => { const cur = symptoms.appetite; handleSymptomChange('appetite', cur ? cur + ' ' + v : v) }}>{v}</span>))}</div></div>
                      <div className="ws-pulse-section"><span className="ws-pulse-section-label">二便</span><div className="ws-pulse-tags">{['小便正常','尿黄','多尿','少尿','大便正常','便溏','大便干','大便黏'].map(v => (<span key={'iq-'+v} className="ws-pulse-tag" onClick={() => { const cur = symptoms.bowelMovement; handleSymptomChange('bowelMovement', cur ? cur + ' ' + v : v) }}>{v}</span>))}</div></div>
                    </div>
                  )}
                </div>
              </div>
            </div>
          )}


        </div>

        {/* ========== 中栏：步骤向导 ========== */}
        <div className="ws-col ws-center">
          <div className="ws-col-title">
            <span className="ws-col-icon purple">
              <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2.5"><path d="M9 5H7a2 2 0 0 0-2 2v12a2 2 0 0 0 2 2h10a2 2 0 0 0 2-2V7a2 2 0 0 0-2-2h-2" /><rect x="9" y="3" width="6" height="4" rx="1" /><path d="M12 11v3" /><path d="M9 12.5h6" /></svg>
            </span>
            {wizardSteps[currentStep]}
          </div>

          {/* 步骤指示器 */}
          <div style={{ display: 'flex', alignItems: 'center', justifyContent: 'center', gap: 0, marginBottom: 8, flexShrink: 0 }}>
            {wizardSteps.map((step, index) => (
              <div key={step} style={{ display: 'flex', alignItems: 'center' }}>
                <div style={{
                  display: 'flex', alignItems: 'center', justifyContent: 'center',
                  width: 24, height: 24, borderRadius: '50%',
                  background: index < currentStep ? 'var(--success)' : index === currentStep ? 'var(--primary)' : 'var(--border)',
                  color: '#fff', fontSize: 11, fontWeight: 600, flexShrink: 0
                }}>
                  {index < currentStep ? '✓' : index + 1}
                </div>
                <span style={{
                  fontSize: 11, marginLeft: 5, fontWeight: index === currentStep ? 600 : 400,
                  color: index === currentStep ? 'var(--text-primary)' : 'var(--text-muted)'
                }}>
                  {step}
                </span>
                {index < wizardSteps.length - 1 && (
                  <div style={{
                    width: 40, height: 2, margin: '0 8px',
                    background: index < currentStep ? 'var(--success)' : 'var(--border)',
                    borderRadius: 1
                  }} />
                )}
              </div>
            ))}
          </div>

          {/* ===== 步骤0：辨证诊断 ===== */}
          {currentStep === 0 && (
            <div className="ws-card">
              <div className="ws-card-head"><h3>AI 推荐辨证</h3></div>
              <div className="ws-card-body">
                <div className="ws-diag-results">
                  {diagnosisResults.map(result => (
                    <div key={result.pattern} className={`ws-diag-card ${selectedPattern === result.pattern ? 'selected' : ''}`} onClick={() => handleSelectPattern(result)}>
                      <div className="ws-diag-head">
                        <span className="ws-diag-name">{result.pattern}</span>
                        <span className="ws-diag-conf">{result.confidence}%</span>
                      </div>
                      <div className="ws-diag-desc">{result.description}</div>
                      <div className="ws-tags">{result.symptoms.map(s => <span key={s} className="ws-tag">{s}</span>)}</div>
                    </div>
                  ))}
                </div>
                {selectedResult && (
                  <div className="ws-ai-suggest">
                    已选择：<strong>{selectedResult.pattern}</strong>（匹配度 {selectedResult.confidence}%）— 已自动填充诊断、辨证
                  </div>
                )}
              </div>
            </div>
          )}

          {/* ===== 步骤1：智能开方 ===== */}
          {currentStep === 1 && (
            <div style={{ display: 'flex', flexDirection: 'column', flex: 1, minHeight: 0 }}>
              {/* ===== Agent辅助诊疗分析（放大撑满） ===== */}
              <div className="ws-card" style={{ flex: 1, display: 'flex', flexDirection: 'column' }}>
                <div className="ws-card-head">
                  <h3>
                    <svg width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2">
                      <circle cx="12" cy="12" r="10"/><path d="M12 16v-4"/><path d="M12 8h.01"/>
                    </svg>
                    Agent辅助诊疗分析
                  </h3>
                </div>
                <div className="ws-card-body" style={{ flex: 1, fontSize: 12, padding: '10px 14px' }}>
                  {/* 诊疗信息 */}
                  <div className="ws-sub-title" style={{ fontSize: 11, marginTop: 0, marginBottom: 6 }}>① 当前诊疗信息</div>
                  <div style={{ color: 'var(--text-secondary)', lineHeight: 1.8, marginBottom: 10, padding: '6px 10px', background: 'var(--bg-page)', borderRadius: 6 }}>
                    <strong style={{ color: 'var(--text-primary)' }}>主诉：</strong>{prescriptionMock.complaint}<br />
                    <strong style={{ color: 'var(--text-primary)' }}>现病史：</strong>{prescriptionMock.symptoms.join('、')}<br />
                    <strong style={{ color: 'var(--text-primary)' }}>舌象：</strong>{prescriptionMock.tongue}　
                    <strong style={{ color: 'var(--text-primary)' }}>脉象：</strong>{prescriptionMock.pulse}<br />
                    <strong style={{ color: 'var(--text-primary)' }}>辨证：</strong><span style={{ color: 'var(--primary)', fontWeight: 500 }}>{prescriptionMock.syndrome}</span>
                  </div>

                  {/* 关键词 */}
                  <div className="ws-sub-title" style={{ fontSize: 11, marginBottom: 6 }}>② Agent预处理 → 关键词提取</div>
                  <div className="ws-tags" style={{ marginBottom: 10 }}>
                    {prescriptionMock.keywords.map((kw, i) => (
                      <span key={i} className="ws-tag" style={{ 
                        background: ['#E8F4FD','#F0EBFF','#FFF7E6','#FFF0F0','#F0FFF4','#E6FFFB','#FFF0F6'][i % 7],
                        borderColor: ['#91CAFF','#B89EFF','#FFD591','#FFA39E','#95DE64','#87E8DE','#FF85C0'][i % 7],
                        fontSize: 11
                      }}>
                        {kw}
                      </span>
                    ))}
                  </div>

                  {/* Agent分析 */}
                  <div className="ws-sub-title" style={{ fontSize: 11, marginBottom: 6 }}>③ Agent分析结果</div>
                  <div style={{ display: 'flex', gap: 16, flexWrap: 'wrap', marginBottom: 6 }}>
                    <span style={{ fontSize: 12 }}><strong>证型识别：</strong>{prescriptionMock.syndrome}</span>
                    <span style={{ fontSize: 12 }}><strong>治法建议：</strong>{prescriptionMock.treatment}、生津止咳</span>
                    <span style={{ fontSize: 12 }}><strong>推荐方向：</strong>润肺养阴类方剂</span>
                  </div>
                  {/* 推荐方向下全部方剂（AI推荐 + 常用方剂库） */}
                  {(() => {
                    const allDirectionFormulas = prescriptionMock.formulas.map((f, i) => ({ ...f, idx: i, source: 'ai' as const }))
                    const allFormulas = [
                      ...allDirectionFormulas,
                      ...commonFormulas
                        .filter(cf => !prescriptionMock.formulas.some(af => af.name === cf.name))
                        .map((cf, i) => ({
                          name: cf.name,
                          herbs: cf.herbs.map(h => ({ name: h, dosage: '9g' as string })),
                          effects: [] as string[],
                          reason: '',
                          idx: i + prescriptionMock.formulas.length,
                          source: 'common' as const
                        }))
                    ]
                    return (
                      <div style={{ marginBottom: 2 }}>
                        <span style={{ fontSize: 11, color: 'var(--text-muted)' }}>推荐方剂列表（润肺养阴类）：</span>
                        <div style={{ display: 'flex', gap: 4, flexWrap: 'wrap', marginTop: 2 }}>
                          {allFormulas.map((f, i) => {
                            const realIdx = f.source === 'ai' ? (f as any).idx : -1
                            const selected = realIdx >= 0 ? selectedFormulaIndices.includes(realIdx) : selectedCommonFormulaNames.includes(f.name)
                            const isCommon = f.source === 'common'
                            return (
                              <span key={i} style={{
                                fontSize: 11, padding: '2px 8px', borderRadius: 4,
                                background: selected ? 'var(--primary-bg)' : isCommon && showCustomEditor && customFormulaName === f.name ? '#FFF7E6' : '#FAFAFA',
                                border: selected ? '1px solid var(--primary)' : isCommon && showCustomEditor && customFormulaName === f.name ? '1px solid #FFD591' : '1px solid #E0E0E0',
                                color: selected ? 'var(--primary)' : isCommon && showCustomEditor && customFormulaName === f.name ? '#D46B08' : 'var(--text-secondary)',
                                cursor: 'pointer',
                                fontWeight: (selected || (isCommon && showCustomEditor && customFormulaName === f.name)) ? 600 : 400,
                              }}
                              onClick={() => {
                                if (realIdx >= 0) {
                                  // AI formula: toggle selection
                                  let newIndices: number[]
                                  if (selectedFormulaIndices.includes(realIdx)) {
                                    newIndices = selectedFormulaIndices.filter(idx => idx !== realIdx)
                                  } else {
                                    newIndices = [...selectedFormulaIndices, realIdx]
                                  }
                                  setSelectedFormulaIndices(newIndices)
                                  const merged = getMergedFromIndices(newIndices)
                                  setAiHerbs(merged.herbs)
                                  setFormulaEffects(merged.effects)
                                  setEditReason(merged.reason)
                                  setEditFormulaName(newIndices.length === 1 ? prescriptionMock.formulas[newIndices[0]].name : '合方(' + newIndices.map(idx => prescriptionMock.formulas[idx].name).join('+') + ')')
                                  setDeletedHerb(null)
                                  setEditingFormulaName(false)
                                  setEditingEffectIdx(null)
                                  setEditingReason(false)
                                } else if (isCommon) {
                                   // Common formula: toggle selection (multi-select)
                                   const isSelected = selectedCommonFormulaNames.includes(f.name)
                                   let newNames: string[]
                                   if (isSelected) {
                                     newNames = selectedCommonFormulaNames.filter(n => n !== f.name)
                                   } else {
                                     newNames = [...selectedCommonFormulaNames, f.name]
                                   }
                                   setSelectedCommonFormulaNames(newNames)
                                   // Rebuild custom herbs/effects from all selected common formulas
                                   const allHerbs: EditableHerb[] = []
                                   const allEffects: string[] = []
                                   const allReasons: string[] = []
                                   newNames.forEach(name => {
                                     const cf = commonFormulas.find(c => c.name === name)
                                     if (cf) {
                                       cf.herbs.forEach(h => allHerbs.push({ name: h, dosage: '9g' }))
                                     }
                                   })
                                   setCustomHerbs(allHerbs)
                                   setCustomEffects(allEffects)
                                   setCustomReason(allReasons.join('；'))
                                   if (newNames.length > 0) {
                                     setCustomFormulaName(newNames.join(' + '))
                                     setShowCustomEditor(true)
                                   } else {
                                     setCustomFormulaName('自定义方剂')
                                     setShowCustomEditor(false)
                                   }
                                   setFormulaSearchQuery('')
                                   setShowFormulaSearchResults(false)
                                 }
                              }}
                              >{f.name} ({f.herbs.length}味)
                              {isCommon && <span style={{ fontSize: 8, color: '#D46B08', marginLeft: 4 }}>常用</span>}
                              </span>
                            )
                          })}
                        </div>
                      </div>
                    )
                  })()}
                </div>
              </div>
            </div>
          )}

          {/* ===== 步骤2：处方审核 ===== */}
          {currentStep === 2 && (
            <>
              {/* Agent 工作流 */}
              <div className="ws-card" style={{ flex: 'none' }}>
                <div className="ws-card-head">
                  <h3>
                    <svg width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2">
                      <circle cx="12" cy="12" r="10"/><path d="M12 16v-4"/><path d="M12 8h.01"/>
                    </svg>
                    Agent 智能审方
                  </h3>
                </div>
                <div className="ws-card-body" style={{ padding: '6px 10px' }}>
                  <div className="ws-sub-title" style={{ fontSize: 10, marginTop: 0 }}>① 诊疗信息输入</div>
                  <div style={{ fontSize: 10, color: 'var(--text-secondary)', lineHeight: 1.5, marginBottom: 2, padding: '3px 6px', background: 'var(--bg-page)', borderRadius: 4 }}>
                    <strong style={{ color: 'var(--text-primary)' }}>李某</strong> · 男 58岁 · 2026-07-14<br />
                    主诉：反复头晕头痛3年，加重1周 · 血压 158/96 mmHg<br />
                    既往史：高血压病史5年 · 过敏史：无
                  </div>

                  <div className="ws-sub-title" style={{ fontSize: 10 }}>② 关键词提取</div>
                  <div className="ws-tags" style={{ marginBottom: 2 }}>
                    <span className="ws-tag" style={{ background: '#E8F4FD', borderColor: '#91CAFF' }}>高血压</span>
                    <span className="ws-tag" style={{ background: '#F0EBFF', borderColor: '#B89EFF' }}>肝阳上亢</span>
                    <span className="ws-tag" style={{ background: '#FFF7E6', borderColor: '#FFD591' }}>头晕</span>
                    <span className="ws-tag" style={{ background: '#FFF0F0', borderColor: '#FFA39E' }}>头痛</span>
                    <span className="ws-tag" style={{ background: '#F0FFF4', borderColor: '#95DE64' }}>失眠</span>
                    <span className="ws-tag" style={{ background: '#E6FFFB', borderColor: '#87E8DE' }}>口苦咽干</span>
                  </div>

                  <div className="ws-sub-title" style={{ fontSize: 10 }}>③ Agent 审方分析</div>
                  <div style={{ fontSize: 10, color: 'var(--text-secondary)', marginBottom: 2 }}>
                    {[
                      { label: '证型匹配', status: 'done', detail: '肝阳上亢证（匹配度 92%）' },
                      { label: '方剂推荐', status: 'done', detail: '天麻钩藤饮加减' },
                      { label: '配伍检查', status: 'done', detail: '未发现配伍禁忌' },
                      { label: '剂量校验', status: 'done', detail: '所有药材在安全范围' },
                      { label: '禁忌审查', status: 'done', detail: '无禁忌证冲突' },
                    ].map((step, i) => (
                      <div key={i} style={{ display: 'flex', alignItems: 'center', gap: 5, padding: '2px 0' }}>
                        <svg width="10" height="10" viewBox="0 0 24 24" fill="none" stroke="#52C41A" strokeWidth="3">
                          <polyline points="20 6 9 17 4 12" />
                        </svg>
                        <span style={{ color: 'var(--text-primary)', fontWeight: 500 }}>{step.label}</span>
                        <span style={{ color: 'var(--text-muted)' }}>— {step.detail}</span>
                      </div>
                    ))}
                  </div>

                  <div className="ws-sub-title" style={{ fontSize: 10 }}>④ 审方结果输出</div>
                  <div style={{ fontSize: 10, lineHeight: 1.5, padding: '4px 6px', background: '#F0FFF4', border: '1px solid #95DE64', borderRadius: 4, color: 'var(--text-primary)' }}>
                    <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: 2 }}>
                      <strong style={{ fontSize: 11, color: '#389E0D' }}>✓ 审方通过</strong>
                      <span style={{ fontSize: 9, color: '#389E0D', background: '#D9F7BE', padding: '0 5px', borderRadius: 3 }}>低风险 12</span>
                    </div>
                    <div style={{ color: 'var(--text-secondary)' }}>
                      推荐处方：天麻 12g · 钩藤 15g · 石决明 30g · 黄芩 9g · 牛膝 12g · 杜仲 12g · 栀子 9g · 茯神 15g
                    </div>
                    <div style={{ color: 'var(--text-secondary)', marginTop: 1 }}>
                      煎服：每日1剂，水煎400ml，分早晚两次温服
                    </div>
                  </div>
                </div>
              </div>

              {/* 当前患者处方审核 */}
              <div className="ws-card" style={{ flex: 1, display: 'flex', flexDirection: 'column' }}>
                <div className="ws-card-head"><h3>当前处方</h3></div>
                <div className="ws-card-body" style={{ overflowY: 'auto', flex: 1 }}>
                  <div className="ws-rx-list">
                    <div className="ws-rx-card selected" style={{ cursor: 'default' }}>
                      <div className="ws-rx-head">
                        <div className="ws-rx-left">
                          <span className="ws-rx-dot low" />
                          <div>
                            <div className="ws-rx-patient">{form.name || '李某'} · {form.gender || '男'} {form.age || '58'}岁</div>
                            <div className="ws-rx-diag">{form.diagnosis || '高血压病'} / {selectedPattern || form.differentiation || '肝阳上亢证'}</div>
                          </div>
                        </div>
                        <div className="ws-rx-right">
                          <span className="ws-risk-tag low">低 12</span>
                          <span className="ws-status pending">待审</span>
                        </div>
                      </div>
                      <div className="ws-rx-body">
                        <div className="ws-sub-title">处方药材</div>
                        <div className="ws-tags" style={{ marginBottom: 6 }}>
                          {(() => {
                            const rxHerbs = [...getMergedFromIndices(selectedFormulaIndices).herbs, ...customHerbs]
                            const rxSourceMap = new Map<string, Set<string>>()
                            for (const idx of selectedFormulaIndices) {
                              const f = prescriptionMock.formulas[idx]
                              for (const h of f.herbs) {
                                if (!rxSourceMap.has(h.name)) rxSourceMap.set(h.name, new Set())
                                rxSourceMap.get(h.name)!.add(f.name)
                              }
                            }
                            for (const name of selectedCommonFormulaNames) {
                              const cf = commonFormulas.find(c => c.name === name)
                              if (cf) {
                                for (const h of cf.herbs) {
                                  if (!rxSourceMap.has(h)) rxSourceMap.set(h, new Set())
                                  rxSourceMap.get(h)!.add(name)
                                }
                              }
                            }
                            const rxSeen = new Set<string>()
                            return rxHerbs.map((h, i) => {
                              if (rxSeen.has(h.name)) return null
                              rxSeen.add(h.name)
                              const s = rxSourceMap.get(h.name)
                              const sources = s ? Array.from(s) : ['手动']
                              return <span key={i} className="ws-tag" style={{ display: 'inline-flex', alignItems: 'center', gap: 4 }}>{h.name} {h.dosage}<span style={{ fontSize: 7, padding: '0 3px', borderRadius: 2, background: '#F0F0F0', color: '#666' }}>{sources.join('/')}</span></span>
                            })
                          })()}
                        </div>
                        <div className="ws-rx-section">
                          <div className="ws-sub-title">风险项</div>
                          <ul className="ws-risk-list">
                            <li className="danger">未发现配伍禁忌</li>
                            <li className="danger">所有药材剂量在安全范围</li>
                          </ul>
                        </div>
                        <div className="ws-rx-section">
                          <div className="ws-sub-title">建议</div>
                          <ul className="ws-risk-list">
                            <li className="success">建议饭后温服</li>
                            <li className="success">忌食生冷辛辣</li>
                          </ul>
                        </div>
                        <div className="ws-btn-row" style={{ marginTop: 8 }}>
                          <button className="btn btn-ghost btn-sm">退回</button>
                          <button className="btn btn-danger btn-sm">驳回</button>
                          <button className="btn btn-primary btn-sm" onClick={() => navigate('/emr')}>通过</button>
                        </div>
                      </div>
                    </div>
                  </div>
                </div>
              </div>
            </>
          )}

          {/* 导航按钮 */}
          <div className="ws-btn-row" style={{ justifyContent: 'space-between', marginTop: 8 }}>
            <div>
              {currentStep > 0 && (
                <button className="btn btn-outline btn-sm" onClick={() => setCurrentStep(prev => prev - 1)}>← 上一步</button>
              )}
            </div>
            <div>
              {currentStep < wizardSteps.length - 1 ? (
                <button className="btn btn-primary btn-sm" onClick={() => setCurrentStep(prev => prev + 1)}>下一步 →</button>
              ) : (
                <button className="btn btn-primary btn-sm" onClick={() => navigate('/emr')}>提交审方</button>
              )}
            </div>
          </div>
        </div>
      </div>
      {/* 底部操作栏 - 位于三栏布局外部 */}
      <div style={{ display: 'flex', justifyContent: 'flex-end', gap: '8px', padding: '8px 4px 0', borderTop: '1px solid var(--border)', marginTop: 8, flexShrink: 0 }}>
        <button className="btn btn-outline btn-sm">暂存草稿</button>
      </div>
    </div>
  )
}
