import { useState, useMemo } from 'react'
import './Workspace.css'

/* ============ Types ============ */
interface PatientForm {
  name: string; gender: string; age: string; phone: string; idCard: string; birthDate: string
  occupation: string; ethnicity: string; maritalStatus: string; address: string
  chiefComplaint: string; presentIllness: string; pastHistory: string; familyHistory: string; allergyHistory: string
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
  { pattern: '肝阳上亢', confidence: 92, description: '肝阳偏亢，上扰头目，导致头晕头痛；肝肾阴虚，腰膝失养，故腰膝酸软。', symptoms: ['眩晕', '头痛', '失眠多梦', '腰膝酸软', '口苦咽干'] },
  { pattern: '阴虚阳亢', confidence: 78, description: '阴液亏虚，阳气偏亢，虚热内生，上扰清窍。', symptoms: ['头晕耳鸣', '潮热盗汗', '五心烦热'] },
  { pattern: '肝郁气滞', confidence: 65, description: '肝气郁结，气机不畅，情志不舒。', symptoms: ['胁肋胀痛', '胸闷善太息', '抑郁多疑'] },
]

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

/* ============ Component ============ */
export default function Workspace() {
  // ---- Diagnosis state ----
  const [form, setForm] = useState<PatientForm>({
    name: '', gender: '', age: '', phone: '', idCard: '', birthDate: '',
    occupation: '', ethnicity: '汉族', maritalStatus: '', address: '',
    chiefComplaint: '', presentIllness: '', pastHistory: '', familyHistory: '', allergyHistory: '',
  })
  const [symptoms, setSymptoms] = useState<SymptomForm>({
    pulseLeft: '', pulseRight: '', pulseDescription: '', tongueColor: '', tongueShape: '',
    tongueCoating: '', tongueTexture: '', facialColor: '', expression: '', mentalState: '',
    sleepQuality: '', appetite: '', thirst: '', taste: '', bowelMovement: '', urineColor: '',
  })
  const [selectedPattern, setSelectedPattern] = useState('')
  const [customDiagnoses, setCustomDiagnoses] = useState<CustomDiagnosis[]>([])
  const [customPattern, setCustomPattern] = useState('')
  const [customDescription, setCustomDescription] = useState('')
  const [customSymptoms, setCustomSymptoms] = useState('')

  // ---- Prescription state ----
  const [selectedFormula, setSelectedFormula] = useState('')
  const [searchHerb, setSearchHerb] = useState('')
  const [selectedHerbs, setSelectedHerbs] = useState<SelectedHerb[]>([])
  const [notes, setNotes] = useState('')
  const [compatibilityWarnings, setCompatibilityWarnings] = useState<string[]>([])
  const [expandedRxId, setExpandedRxId] = useState<number | null>(null)
  const [selectedRx, setSelectedRx] = useState<Prescription | null>(null)

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
        {/* ========== 左栏：诊疗流程 ========== */}
        <div className="ws-col ws-left">
          <div className="ws-col-title">
            <span className="ws-col-icon blue">
              <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2.5"><circle cx="12" cy="12" r="10" /><polyline points="12 6 12 12 16 14" /></svg>
            </span>
            诊疗流程
          </div>

          {/* 患者录入 */}
          <div className="ws-card">
            <div className="ws-card-head"><h3>患者录入</h3></div>
            <div className="ws-card-body">
              <div className="ws-form-grid">
                <div className="ws-field"><label>姓名 <span className="req">*</span></label><input name="name" value={form.name} onChange={handleChange} placeholder="患者姓名" /></div>
                <div className="ws-field"><label>性别</label><select name="gender" value={form.gender} onChange={handleChange}><option value="">选择</option><option value="male">男</option><option value="female">女</option></select></div>
                <div className="ws-field"><label>年龄</label><input type="number" name="age" value={form.age} onChange={handleChange} placeholder="岁" /></div>
                <div className="ws-field"><label>电话</label><input name="phone" value={form.phone} onChange={handleChange} placeholder="手机号" /></div>
              </div>
              <div className="ws-field full"><label>主诉 <span className="req">*</span></label><textarea name="chiefComplaint" value={form.chiefComplaint} onChange={handleChange} placeholder="主要症状及持续时间" rows={2} /></div>
              <div className="ws-field full"><label>现病史</label><textarea name="presentIllness" value={form.presentIllness} onChange={handleChange} placeholder="发病经过" rows={2} /></div>
              <div className="ws-form-grid">
                <div className="ws-field"><label>既往病史</label><input name="pastHistory" value={form.pastHistory} onChange={handleChange} placeholder="慢性病、手术史" /></div>
                <div className="ws-field"><label>过敏史</label><input name="allergyHistory" value={form.allergyHistory} onChange={handleChange} placeholder="药物/食物过敏" /></div>
              </div>
            </div>
          </div>

          {/* 四诊采集 */}
          <div className="ws-card">
            <div className="ws-card-head"><h3>四诊采集</h3></div>
            <div className="ws-card-body">
              <div className="ws-sub-title">脉诊</div>
              <div className="ws-form-grid">
                <div className="ws-field"><label>左脉</label><select value={symptoms.pulseLeft} onChange={e => handleSymptomChange('pulseLeft', e.target.value)}><option value="">选择</option>{pulseOptions.map(v => <option key={v} value={v}>{v}</option>)}</select></div>
                <div className="ws-field"><label>右脉</label><select value={symptoms.pulseRight} onChange={e => handleSymptomChange('pulseRight', e.target.value)}><option value="">选择</option>{pulseOptions.map(v => <option key={v} value={v}>{v}</option>)}</select></div>
              </div>
              <div className="ws-field full"><label>脉象描述</label><input value={symptoms.pulseDescription} onChange={e => handleSymptomChange('pulseDescription', e.target.value)} placeholder="补充描述" /></div>

              <div className="ws-sub-title">舌诊</div>
              <div className="ws-form-grid">
                <div className="ws-field"><label>舌质</label><select value={symptoms.tongueColor} onChange={e => handleSymptomChange('tongueColor', e.target.value)}><option value="">选择</option><option value="pale">淡</option><option value="red">红</option><option value="crimson">绛</option><option value="purple">紫</option></select></div>
                <div className="ws-field"><label>舌苔</label><select value={symptoms.tongueCoating} onChange={e => handleSymptomChange('tongueCoating', e.target.value)}><option value="">选择</option><option value="thin-white">薄白</option><option value="thin-yellow">薄黄</option><option value="white-greasy">白腻</option><option value="yellow-greasy">黄腻</option><option value="less">少苔</option></select></div>
                <div className="ws-field"><label>舌形</label><select value={symptoms.tongueShape} onChange={e => handleSymptomChange('tongueShape', e.target.value)}><option value="">选择</option><option value="swollen">胖大</option><option value="cracked">裂纹</option><option value="tooth-marked">齿痕</option></select></div>
                <div className="ws-field"><label>纹理</label><select value={symptoms.tongueTexture} onChange={e => handleSymptomChange('tongueTexture', e.target.value)}><option value="">选择</option><option value="tender">嫩</option><option value="old">老</option><option value="moist">润</option><option value="dry">燥</option></select></div>
              </div>

              <div className="ws-sub-title">望诊</div>
              <div className="ws-form-grid">
                <div className="ws-field"><label>面色</label><select value={symptoms.facialColor} onChange={e => handleSymptomChange('facialColor', e.target.value)}><option value="">选择</option><option value="pale">苍白</option><option value="flushed">潮红</option><option value="sallow">萎黄</option><option value="dark">暗黑</option></select></div>
                <div className="ws-field"><label>神态</label><select value={symptoms.expression} onChange={e => handleSymptomChange('expression', e.target.value)}><option value="">选择</option><option value="alert">有神</option><option value="tired">少神</option><option value="apathetic">失神</option></select></div>
              </div>

              <div className="ws-sub-title">问诊</div>
              <div className="ws-form-grid">
                <div className="ws-field"><label>睡眠</label><select value={symptoms.sleepQuality} onChange={e => handleSymptomChange('sleepQuality', e.target.value)}><option value="">选择</option><option value="good">正常</option><option value="insomnia">失眠</option><option value="dreamy">多梦</option></select></div>
                <div className="ws-field"><label>食欲</label><select value={symptoms.appetite} onChange={e => handleSymptomChange('appetite', e.target.value)}><option value="">选择</option><option value="good">正常</option><option value="poor">纳差</option></select></div>
                <div className="ws-field"><label>口渴</label><select value={symptoms.thirst} onChange={e => handleSymptomChange('thirst', e.target.value)}><option value="">选择</option><option value="none">不渴</option><option value="thirsty">口渴</option><option value="bitter">口苦</option></select></div>
                <div className="ws-field"><label>二便</label><select value={symptoms.bowelMovement} onChange={e => handleSymptomChange('bowelMovement', e.target.value)}><option value="">选择</option><option value="normal">正常</option><option value="constipation">便秘</option><option value="diarrhea">便溏</option></select></div>
              </div>
            </div>
          </div>

          {/* 辨证诊断 */}
          <div className="ws-card">
            <div className="ws-card-head"><h3>辨证诊断</h3><span className="ws-ai-badge">AI</span></div>
            <div className="ws-card-body">
              <div className="ws-diag-results">
                {diagnosisResults.map(r => (
                  <div key={r.pattern} className={`ws-diag-card ${selectedPattern === r.pattern ? 'selected' : ''}`} onClick={() => handleSelectPattern(r)}>
                    <div className="ws-diag-head"><span className="ws-diag-name">{r.pattern}</span><span className="ws-diag-conf">{r.confidence}%</span></div>
                    <p className="ws-diag-desc">{r.description}</p>
                    <div className="ws-tags">{r.symptoms.map((s, i) => <span key={i} className="ws-tag">{s}</span>)}</div>
                  </div>
                ))}
              </div>

              {customDiagnoses.length > 0 && <div className="ws-sub-title">已选证型</div>}
              {customDiagnoses.map(d => (
                <div key={d.id} className="ws-chosen-diag">
                  <div className="ws-chosen-head"><strong>{d.pattern}</strong><button className="ws-btn-x" onClick={() => handleRemoveCustom(d.id)}>×</button></div>
                  <p>{d.description}</p>
                  <div className="ws-tags">{d.symptoms.map((s, i) => <span key={i} className="ws-tag">{s}</span>)}</div>
                </div>
              ))}

              <div className="ws-sub-title">添加辨证</div>
              <div className="ws-field"><label>证型</label><input value={customPattern} onChange={e => setCustomPattern(e.target.value)} placeholder="输入或点击AI建议" /></div>
              <div className="ws-field"><label>描述</label><textarea value={customDescription} onChange={e => setCustomDescription(e.target.value)} placeholder="证型描述" rows={2} /></div>
              <div className="ws-field"><label>关键症状</label><input value={customSymptoms} onChange={e => setCustomSymptoms(e.target.value)} placeholder="顿号分隔" /></div>
              {selectedResult && (
                <div className="ws-ai-suggest">
                  <span>AI建议：</span>
                  <div className="ws-tags">{selectedResult.symptoms.map((s, i) => (
                    <button key={i} className={`ws-tag clickable ${customSymptoms.includes(s) ? 'selected' : ''}`} onClick={() => {
                      const cur = customSymptoms.split(/[,，、]/).map(x => x.trim()).filter(x => x)
                      if (!cur.includes(s)) setCustomSymptoms([...cur, s].join('、'))
                    }}>{s}</button>
                  ))}</div>
                </div>
              )}
              <div className="ws-btn-row">
                <button className="btn btn-ghost btn-sm" onClick={() => { setCustomPattern(''); setCustomDescription(''); setCustomSymptoms(''); setSelectedPattern('') }}>清空</button>
                <button className="btn btn-primary btn-sm" onClick={handleAddCustomDiagnosis}>添加</button>
              </div>
            </div>
          </div>
        </div>

        {/* ========== 中栏：智能开方 ========== */}
        <div className="ws-col ws-center">
          <div className="ws-col-title">
            <span className="ws-col-icon purple">
              <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2.5"><path d="M9 5H7a2 2 0 0 0-2 2v12a2 2 0 0 0 2 2h10a2 2 0 0 0 2-2V7a2 2 0 0 0-2-2h-2" /><rect x="9" y="3" width="6" height="4" rx="1" /><path d="M12 11v3" /><path d="M9 12.5h6" /></svg>
            </span>
            智能开方
          </div>

          {compatibilityWarnings.length > 0 && (
            <div className="ws-warning">
              <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2"><path d="M10.29 3.86L1.82 18a2 2 0 0 0 1.71 3h16.94a2 2 0 0 0 1.71-3L13.71 3.86a2 2 0 0 0-3.42 0z" /><line x1="12" y1="9" x2="12" y2="13" /><line x1="12" y1="17" x2="12.01" y2="17" /></svg>
              配伍风险 {compatibilityWarnings.length} 项
            </div>
          )}

          {/* 推荐方剂 */}
          <div className="ws-card">
            <div className="ws-card-head"><h3>推荐方剂</h3></div>
            <div className="ws-card-body">
              <div className="ws-formula-grid">
                {commonFormulas.map(f => (
                  <button key={f.name} className={`ws-formula-card ${selectedFormula === f.name ? 'active' : ''}`} onClick={() => applyFormula(f.name)}>
                    <span className="ws-formula-name">{f.name}</span>
                    <span className="ws-formula-cat">{f.category}</span>
                    <span className="ws-formula-herbs">{f.herbs.join('、')}</span>
                  </button>
                ))}
              </div>
            </div>
          </div>

          {/* 处方明细 */}
          <div className="ws-card">
            <div className="ws-card-head"><h3>处方明细</h3><span className="ws-count">{selectedHerbs.length}味</span></div>
            <div className="ws-card-body">
              {selectedHerbs.length === 0 ? (
                <div className="ws-empty">请选择方剂或从药库添加</div>
              ) : (
                <div className="ws-herbs-list">
                  {selectedHerbs.map(herb => {
                    const over = herb.currentDosage > herb.maxDosage
                    const under = herb.currentDosage < herb.minDosage && herb.currentDosage > 0
                    return (
                      <div key={herb.id} className={`ws-herb ${over || under ? 'warn' : ''}`}>
                        <div className="ws-herb-info">
                          <span className="ws-herb-name">{herb.name}{herb.toxic && <span className="ws-toxic">毒</span>}</span>
                          <span className="ws-herb-meta">{herb.nature}·{herb.taste}·归{herb.meridian}</span>
                        </div>
                        <div className="ws-herb-dosage">
                          <span className="ws-range">{herb.minDosage}-{herb.maxDosage}{herb.unit}</span>
                          <div className="ws-dosage-ctrl">
                            <button onClick={() => updateDosage(herb.id, Math.max(0, herb.currentDosage - 1))}>−</button>
                            <input type="number" className={over ? 'over' : under ? 'under' : ''} value={herb.currentDosage} onChange={e => updateDosage(herb.id, parseFloat(e.target.value) || 0)} />
                            <button onClick={() => updateDosage(herb.id, herb.currentDosage + 1)}>+</button>
                            <span>{herb.unit}</span>
                          </div>
                        </div>
                        <button className="ws-herb-x" onClick={() => removeHerb(herb.id)}>×</button>
                      </div>
                    )
                  })}
                </div>
              )}
            </div>
          </div>

          {/* 药库检索 */}
          <div className="ws-card">
            <div className="ws-card-head"><h3>药库检索</h3></div>
            <div className="ws-card-body">
              <input className="ws-search" placeholder="搜索药名、类别、功效..." value={searchHerb} onChange={e => setSearchHerb(e.target.value)} />
              <div className="ws-lib-list">
                {filteredHerbs.map(h => (
                  <div key={h.id} className={`ws-lib-item ${selectedHerbs.some(sh => sh.id === h.id) ? 'selected' : ''}`} onClick={() => addHerb(h)}>
                    <div><span className="ws-lib-name">{h.name}</span><span className="ws-lib-meta">{h.nature}，{h.taste}</span></div>
                    <span className="ws-lib-dose">{h.minDosage}-{h.maxDosage}{h.unit}</span>
                  </div>
                ))}
              </div>
            </div>
          </div>

          {/* 医嘱备注 */}
          <div className="ws-card">
            <div className="ws-card-head"><h3>医嘱备注</h3></div>
            <div className="ws-card-body">
              <textarea className="ws-notes" placeholder="用法用量、煎服方法、忌口等..." value={notes} onChange={e => setNotes(e.target.value)} rows={2} />
            </div>
          </div>

          <div className="ws-btn-row" style={{ justifyContent: 'flex-end' }}>
            <button className="btn btn-outline btn-sm">暂存草稿</button>
            <button className="btn btn-primary btn-sm">提交审方</button>
          </div>
        </div>

        {/* ========== 右栏：处方审核 ========== */}
        <div className="ws-col ws-right">
          <div className="ws-col-title">
            <span className="ws-col-icon green">
              <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2.5"><path d="M9 11l3 3L22 4" /><path d="M21 12v7a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2h11" /></svg>
            </span>
            处方审核
            {pendingCount > 0 && <span className="ws-badge">{pendingCount}</span>}
          </div>

          <div className="ws-card">
            <div className="ws-card-body" style={{ padding: 0, overflowY: 'auto' }}>
              <div className="ws-rx-list">
                {prescriptions.map(rx => (
                  <div key={rx.id} className={`ws-rx-card ${selectedRx?.id === rx.id ? 'selected' : ''}`} onClick={() => { setSelectedRx(selectedRx?.id === rx.id ? null : rx); setExpandedRxId(expandedRxId === rx.id ? null : rx.id) }}>
                    <div className="ws-rx-head">
                      <div className="ws-rx-left">
                        <span className={`ws-rx-dot ${rx.riskLevel}`} />
                        <div>
                          <div className="ws-rx-patient">{rx.patientName} · {rx.patientGender} {rx.patientAge}岁</div>
                          <div className="ws-rx-diag">{rx.diagnosis} / {rx.syndrome}</div>
                        </div>
                      </div>
                      <div className="ws-rx-right">
                        <span className={`ws-risk-tag ${rx.riskLevel}`}>{rx.riskLevel === 'high' ? '高' : rx.riskLevel === 'medium' ? '中' : '低'} {rx.riskScore}</span>
                        <span className={`ws-status ${rx.status}`}>{rx.status === 'pending' ? '待审' : rx.status === 'approved' ? '通过' : '驳回'}</span>
                      </div>
                    </div>
                    {expandedRxId === rx.id && (
                      <div className="ws-rx-body">
                        <div className="ws-tags">{rx.herbs.map(h => <span key={h} className="ws-tag">{h}</span>)}</div>
                        {rx.risks.length > 0 && <div className="ws-rx-section"><div className="ws-sub-title">风险项</div><ul className="ws-risk-list">{rx.risks.map((r, i) => <li key={i} className="danger">{r}</li>)}</ul></div>}
                        {rx.suggestions.length > 0 && <div className="ws-rx-section"><div className="ws-sub-title">建议</div><ul className="ws-risk-list">{rx.suggestions.map((s, i) => <li key={i} className="success">{s}</li>)}</ul></div>}
                        {rx.status === 'pending' && (
                          <div className="ws-btn-row" style={{ marginTop: 8 }}>
                            <button className="btn btn-ghost btn-sm">退回</button>
                            <button className="btn btn-danger btn-sm">驳回</button>
                            <button className="btn btn-primary btn-sm">通过</button>
                          </div>
                        )}
                      </div>
                    )}
                  </div>
                ))}
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  )
}
