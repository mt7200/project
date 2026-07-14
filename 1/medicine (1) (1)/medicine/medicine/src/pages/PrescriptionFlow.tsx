import { useState, useMemo } from 'react'
import { useNavigate } from 'react-router-dom'
import './PrescriptionFlow.css'

interface Herb {
  id: number
  name: string
  category: string
  nature: string
  taste: string
  meridian: string
  minDosage: number
  maxDosage: number
  unit: string
  toxic: boolean
  incompatibilities: string[]
  synergies: string[]
  functions: string[]
}

interface SelectedHerb extends Herb {
  currentDosage: number
}

interface Prescription {
  id: number
  patientName: string
  patientAge: number
  patientGender: string
  diagnosis: string
  syndrome: string
  herbs: string[]
  reviewer: string
  riskLevel: 'low' | 'medium' | 'high'
  riskScore: number
  status: 'pending' | 'approved' | 'rejected'
  date: string
  compatibilityRisk: boolean
  dosageRisk: boolean
  contraindicationRisk: boolean
  risks: string[]
  suggestions: string[]
}

const mockPatients = [
  { id: 1, name: '张三', gender: '男', age: 45, diagnosis: '风寒感冒', date: '2026-05-05' },
  { id: 2, name: '李四', gender: '女', age: 38, diagnosis: '肝郁气滞', date: '2026-05-04' },
  { id: 3, name: '王五', gender: '男', age: 62, diagnosis: '肾阳虚证', date: '2026-05-03' },
]

const herbDatabase: Herb[] = [
  { id: 1, name: '柴胡', category: '解表药', nature: '微寒', taste: '辛苦', meridian: '肝、胆', minDosage: 3, maxDosage: 10, unit: 'g', toxic: false, incompatibilities: [], synergies: ['黄芩', '半夏', '党参'], functions: ['疏散退热', '疏肝解郁', '升举阳气'] },
  { id: 2, name: '黄芩', category: '清热药', nature: '寒', taste: '苦', meridian: '肺、胆、胃、大肠', minDosage: 3, maxDosage: 10, unit: 'g', toxic: false, incompatibilities: [], synergies: ['柴胡', '黄连'], functions: ['清热燥湿', '泻火解毒', '止血安胎'] },
  { id: 3, name: '党参', category: '补虚药', nature: '平', taste: '甘', meridian: '脾、肺', minDosage: 9, maxDosage: 30, unit: 'g', toxic: false, incompatibilities: ['藜芦'], synergies: ['黄芪', '白术'], functions: ['补中益气', '健脾益肺'] },
  { id: 4, name: '半夏', category: '化痰药', nature: '温', taste: '辛', meridian: '脾、胃、肺', minDosage: 3, maxDosage: 9, unit: 'g', toxic: true, incompatibilities: ['乌头', '附子'], synergies: ['陈皮', '茯苓'], functions: ['燥湿化痰', '降逆止呕', '消痞散结'] },
  { id: 5, name: '附子', category: '温里药', nature: '大热', taste: '辛甘', meridian: '心、肾、脾', minDosage: 3, maxDosage: 15, unit: 'g', toxic: true, incompatibilities: ['半夏', '瓜蒌', '川贝母', '白蔹', '白及'], synergies: ['干姜', '肉桂'], functions: ['回阳救逆', '补火助阳', '散寒止痛'] },
  { id: 6, name: '当归', category: '补虚药', nature: '温', taste: '甘辛', meridian: '肝、心、脾', minDosage: 6, maxDosage: 12, unit: 'g', toxic: false, incompatibilities: [], synergies: ['川芎', '白芍', '熟地黄'], functions: ['补血活血', '调经止痛', '润肠通便'] },
  { id: 7, name: '炙甘草', category: '补虚药', nature: '平', taste: '甘', meridian: '心、肺、脾、胃', minDosage: 1.5, maxDosage: 9, unit: 'g', toxic: false, incompatibilities: ['甘遂', '大戟', '芫花', '海藻'], synergies: [], functions: ['补脾益气', '清热解毒', '调和诸药'] },
  { id: 8, name: '黄芪', category: '补虚药', nature: '微温', taste: '甘', meridian: '肺、脾', minDosage: 9, maxDosage: 30, unit: 'g', toxic: false, incompatibilities: [], synergies: ['党参', '白术', '当归'], functions: ['补气升阳', '固表止汗', '利水消肿'] },
  { id: 9, name: '白芍', category: '补虚药', nature: '微寒', taste: '苦酸', meridian: '肝、脾', minDosage: 6, maxDosage: 15, unit: 'g', toxic: false, incompatibilities: ['藜芦'], synergies: ['当归', '川芎'], functions: ['养血调经', '敛阴止汗', '柔肝止痛'] },
  { id: 10, name: '桂枝', category: '解表药', nature: '温', taste: '辛甘', meridian: '心、肺、膀胱', minDosage: 3, maxDosage: 10, unit: 'g', toxic: false, incompatibilities: [], synergies: ['白芍', '生姜'], functions: ['发汗解肌', '温经通脉', '助阳化气'] },
  { id: 11, name: '生姜', category: '解表药', nature: '微温', taste: '辛', meridian: '肺、脾、胃', minDosage: 3, maxDosage: 10, unit: 'g', toxic: false, incompatibilities: [], synergies: ['桂枝', '大枣'], functions: ['解表散寒', '温中止呕', '化痰止咳'] },
  { id: 12, name: '大枣', category: '补虚药', nature: '温', taste: '甘', meridian: '脾、胃', minDosage: 6, maxDosage: 15, unit: 'g', toxic: false, incompatibilities: [], synergies: ['生姜', '炙甘草'], functions: ['补中益气', '养血安神'] },
  { id: 13, name: '茯苓', category: '利水渗湿药', nature: '平', taste: '甘淡', meridian: '心、脾、肾', minDosage: 9, maxDosage: 15, unit: 'g', toxic: false, incompatibilities: [], synergies: ['白术', '党参'], functions: ['利水渗湿', '健脾宁心'] },
  { id: 14, name: '川芎', category: '活血化瘀药', nature: '温', taste: '辛', meridian: '肝、胆、心包', minDosage: 3, maxDosage: 10, unit: 'g', toxic: false, incompatibilities: [], synergies: ['当归', '白芍'], functions: ['活血行气', '祛风止痛'] },
  { id: 15, name: '熟地黄', category: '补虚药', nature: '微温', taste: '甘', meridian: '肝、肾', minDosage: 9, maxDosage: 30, unit: 'g', toxic: false, incompatibilities: [], synergies: ['当归', '山茱萸'], functions: ['补血滋阴', '益精填髓'] },
]

const commonFormulas = [
  { name: '小柴胡汤', category: '和解剂', herbs: ['柴胡', '黄芩', '党参', '半夏', '炙甘草', '生姜', '大枣'] },
  { name: '四物汤', category: '补益剂', herbs: ['当归', '川芎', '白芍', '熟地黄'] },
  { name: '六味地黄丸', category: '补益剂', herbs: ['熟地黄', '山茱萸', '山药', '泽泻', '牡丹皮', '茯苓'] },
  { name: '桂枝汤', category: '解表剂', herbs: ['桂枝', '白芍', '炙甘草', '生姜', '大枣'] },
  { name: '逍遥散', category: '和解剂', herbs: ['柴胡', '当归', '白芍', '白术', '茯苓', '炙甘草'] },
]

const prescriptions: Prescription[] = [
  {
    id: 1, patientName: '张三', patientAge: 45, patientGender: '男',
    diagnosis: '风寒感冒', syndrome: '风寒束表证',
    herbs: ['麻黄', '桂枝', '杏仁', '甘草', '生姜'],
    reviewer: '系统自动', riskLevel: 'high', riskScore: 78, status: 'pending',
    date: '2026-05-05 14:30',
    compatibilityRisk: true, dosageRisk: true, contraindicationRisk: false,
    risks: ['麻黄用量超出药典上限（12g > 10g）', '麻黄与桂枝配伍辛温过强'],
    suggestions: ['建议将麻黄减量至9g', '考虑添加白芍以制约辛温太过']
  },
  {
    id: 2, patientName: '李四', patientAge: 38, patientGender: '女',
    diagnosis: '月经不调', syndrome: '肝郁血虚证',
    herbs: ['当归', '川芎', '白芍', '柴胡', '茯苓', '白术', '炙甘草', '薄荷'],
    reviewer: '系统自动', riskLevel: 'low', riskScore: 12, status: 'approved',
    date: '2026-05-04 10:15',
    compatibilityRisk: false, dosageRisk: false, contraindicationRisk: false,
    risks: [], suggestions: []
  },
  {
    id: 3, patientName: '王五', patientAge: 62, patientGender: '男',
    diagnosis: '慢性支气管炎', syndrome: '痰湿阻肺证',
    herbs: ['半夏', '陈皮', '茯苓', '甘草', '细辛', '五味子'],
    reviewer: '系统自动', riskLevel: 'medium', riskScore: 45, status: 'pending',
    date: '2026-05-04 16:20',
    compatibilityRisk: true, dosageRisk: false, contraindicationRisk: true,
    risks: ['半夏与甘草配伍需注意比例', '细辛含马兜铃酸成分需关注'],
    suggestions: ['半夏建议炮制后使用', '细辛用量建议控制在3g以内']
  },
  {
    id: 4, patientName: '赵六', patientAge: 55, patientGender: '女',
    diagnosis: '高血压', syndrome: '肝阳上亢证',
    herbs: ['天麻', '钩藤', '石决明', '栀子', '黄芩', '川牛膝', '杜仲'],
    reviewer: '系统自动', riskLevel: 'low', riskScore: 18, status: 'approved',
    date: '2026-05-03 09:00',
    compatibilityRisk: false, dosageRisk: false, contraindicationRisk: false,
    risks: [], suggestions: []
  },
]

export default function PrescriptionFlow() {
  const navigate = useNavigate()
  // Prescription state
  const [selectedPatient, setSelectedPatient] = useState<number | null>(null)
  const [selectedFormula, setSelectedFormula] = useState('')
  const [searchHerb, setSearchHerb] = useState('')
  const [selectedHerbs, setSelectedHerbs] = useState<SelectedHerb[]>([])
  const [notes, setNotes] = useState('')
  const [compatibilityWarnings, setCompatibilityWarnings] = useState<string[]>([])

  // Review state
  const [expandedId, setExpandedId] = useState<number | null>(null)
  const [selectedRx, setSelectedRx] = useState<Prescription | null>(null)

  const checkCompatibilities = (herbs: SelectedHerb[]) => {
    const warnings: string[] = []
    for (let i = 0; i < herbs.length; i++) {
      for (let j = i + 1; j < herbs.length; j++) {
        if (herbs[i].incompatibilities.includes(herbs[j].name)) {
          warnings.push(`${herbs[i].name} 与 ${herbs[j].name} 存在配伍禁忌，请谨慎使用！`)
        }
        if (herbs[j].incompatibilities.includes(herbs[i].name)) {
          warnings.push(`${herbs[j].name} 与 ${herbs[i].name} 存在配伍禁忌，请谨慎使用！`)
        }
      }
      if (herbs[i].currentDosage > herbs[i].maxDosage) {
        warnings.push(`${herbs[i].name} 超出药典规定最大剂量（${herbs[i].maxDosage}${herbs[i].unit}）`)
      }
      if (herbs[i].currentDosage < herbs[i].minDosage && herbs[i].currentDosage > 0) {
        warnings.push(`${herbs[i].name} 低于药典规定最小剂量（${herbs[i].minDosage}${herbs[i].unit}）`)
      }
    }
    setCompatibilityWarnings(warnings)
  }

  const addHerb = (herb: Herb) => {
    if (selectedHerbs.some((h) => h.id === herb.id)) return
    const newHerb: SelectedHerb = { ...herb, currentDosage: Math.round((herb.minDosage + herb.maxDosage) / 2 * 10) / 10 }
    const updated = [...selectedHerbs, newHerb]
    setSelectedHerbs(updated)
    checkCompatibilities(updated)
  }

  const removeHerb = (id: number) => {
    const updated = selectedHerbs.filter((h) => h.id !== id)
    setSelectedHerbs(updated)
    checkCompatibilities(updated)
  }

  const updateDosage = (id: number, value: number) => {
    const updated = selectedHerbs.map((h) => h.id === id ? { ...h, currentDosage: value } : h)
    setSelectedHerbs(updated)
    checkCompatibilities(updated)
  }

  const applyFormula = (formulaName: string) => {
    setSelectedFormula(formulaName)
    const formula = commonFormulas.find((f) => f.name === formulaName)
    if (formula) {
      const defaultDosages: Record<string, number> = {
        '柴胡': 12, '黄芩': 9, '党参': 9, '半夏': 9, '炙甘草': 6, '生姜': 9, '大枣': 12,
        '当归': 12, '川芎': 9, '白芍': 12, '熟地黄': 15, '桂枝': 9,
        '山茱萸': 12, '山药': 12, '泽泻': 9, '牡丹皮': 9, '茯苓': 15, '白术': 12,
      }
      const herbs = formula.herbs
        .map((herbName) => {
          const herb = herbDatabase.find((h) => h.name === herbName)
          if (!herb) return null
          return { ...herb, currentDosage: defaultDosages[herbName] || 9 }
        })
        .filter((h): h is SelectedHerb => h !== null)
      setSelectedHerbs(herbs)
      checkCompatibilities(herbs)
    }
  }

  const filteredHerbs = useMemo(() => {
    const term = searchHerb.toLowerCase()
    return herbDatabase.filter((h) =>
      h.name.includes(term) || h.category.includes(term) || h.taste.includes(term) || h.meridian.includes(term) || h.functions.some((f) => f.includes(term))
    )
  }, [searchHerb])

  const pendingCount = prescriptions.filter((p) => p.status === 'pending').length

  return (
    <div className="pf-page">
      <header className="pf-header">
        <h1>开方审方</h1>
        <p>智能开方与处方审核一体化工作台</p>
      </header>

      <div className="pf-body">
        {/* ===== 左侧：智能开方 ===== */}
        <div className="pf-left">
          <div className="pf-section-title">
            <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2"><path d="M9 5H7a2 2 0 0 0-2 2v12a2 2 0 0 0 2 2h10a2 2 0 0 0 2-2V7a2 2 0 0 0-2-2h-2" /><rect x="9" y="3" width="6" height="4" rx="1" /><path d="M12 11v3" /><path d="M9 12.5h6" /></svg>
            智能开方
          </div>

          {compatibilityWarnings.length > 0 && (
            <div className="pf-warning-banner">
              <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2"><path d="M10.29 3.86L1.82 18a2 2 0 0 0 1.71 3h16.94a2 2 0 0 0 1.71-3L13.71 3.86a2 2 0 0 0-3.42 0z" /><line x1="12" y1="9" x2="12" y2="13" /><line x1="12" y1="17" x2="12.01" y2="17" /></svg>
              <span>配伍风险 {compatibilityWarnings.length} 项</span>
            </div>
          )}

          <div className="card pf-compact">
            <div className="card-header"><h3>选择患者</h3></div>
            <div className="card-body">
              <div className="pf-patient-list">
                {mockPatients.map((p) => (
                  <div key={p.id} className={`pf-patient-card ${selectedPatient === p.id ? 'selected' : ''}`} onClick={() => setSelectedPatient(p.id)}>
                    <div className="pf-patient-avatar">{p.name[0]}</div>
                    <div className="pf-patient-info">
                      <span className="pf-patient-name">{p.name}</span>
                      <span className="pf-patient-meta">{p.gender} · {p.age}岁</span>
                    </div>
                    <span className="tag tag-blue">{p.diagnosis}</span>
                  </div>
                ))}
              </div>
            </div>
          </div>

          <div className="card pf-compact">
            <div className="card-header"><h3>推荐方剂</h3></div>
            <div className="card-body">
              <div className="pf-formula-grid">
                {commonFormulas.map((f) => (
                  <button key={f.name} className={`pf-formula-card ${selectedFormula === f.name ? 'active' : ''}`} onClick={() => applyFormula(f.name)}>
                    <span className="pf-formula-name">{f.name}</span>
                    <span className="tag tag-blue">{f.category}</span>
                    <span className="pf-formula-herbs">{f.herbs.join('、')}</span>
                  </button>
                ))}
              </div>
            </div>
          </div>

          <div className="card pf-compact">
            <div className="card-header">
              <h3>处方明细</h3>
              <span className="pf-herb-count">{selectedHerbs.length} 味</span>
            </div>
            <div className="card-body">
              {selectedHerbs.length === 0 ? (
                <div className="empty-state" style={{ padding: '30px 10px' }}><p>请选择方剂或从药库添加</p></div>
              ) : (
                <div className="pf-herbs-list">
                  {selectedHerbs.map((herb) => {
                    const isOver = herb.currentDosage > herb.maxDosage
                    const isUnder = herb.currentDosage < herb.minDosage && herb.currentDosage > 0
                    return (
                      <div key={herb.id} className={`pf-herb-item ${isOver || isUnder ? 'warning' : ''}`}>
                        <div className="pf-herb-main">
                          <span className="pf-herb-name">{herb.name}{herb.toxic && <span className="tag tag-red" style={{ marginLeft: 4, fontSize: 10 }}>毒</span>}</span>
                          <span className="pf-herb-info">{herb.nature}·{herb.taste}·归{herb.meridian}</span>
                        </div>
                        <div className="pf-herb-dosage">
                          <span className="pf-dosage-range">{herb.minDosage}-{herb.maxDosage}{herb.unit}</span>
                          <div className="pf-dosage-input-group">
                            <button className="pf-dosage-btn" onClick={() => updateDosage(herb.id, Math.max(herb.currentDosage - 1, 0))}>−</button>
                            <input type="number" className={`pf-dosage-input ${isOver ? 'over' : ''} ${isUnder ? 'under' : ''}`} value={herb.currentDosage} step={1} onChange={(e) => updateDosage(herb.id, parseFloat(e.target.value) || 0)} />
                            <button className="pf-dosage-btn" onClick={() => updateDosage(herb.id, herb.currentDosage + 1)}>+</button>
                            <span className="pf-dosage-unit">{herb.unit}</span>
                          </div>
                        </div>
                        <button className="pf-herb-remove" onClick={() => removeHerb(herb.id)}>
                          <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2"><line x1="18" y1="6" x2="6" y2="18" /><line x1="6" y1="6" x2="18" y2="18" /></svg>
                        </button>
                      </div>
                    )
                  })}
                </div>
              )}
            </div>
          </div>

          <div className="card pf-compact">
            <div className="card-header"><h3>药库检索</h3></div>
            <div className="card-body">
              <input className="form-input" placeholder="搜索药名、类别、功效..." value={searchHerb} onChange={(e) => setSearchHerb(e.target.value)} />
              <div className="pf-herb-library scrollbar">
                {filteredHerbs.map((h) => (
                  <div key={h.id} className={`pf-herb-lib-item ${selectedHerbs.some(sh => sh.id === h.id) ? 'selected' : ''}`} onClick={() => addHerb(h)}>
                    <div className="pf-herb-lib-info">
                      <span className="pf-herb-lib-name">{h.name}</span>
                      <span className="pf-herb-lib-nature">{h.nature}，{h.taste} · 归 {h.meridian}</span>
                    </div>
                    <span className="pf-herb-lib-dosage">{h.minDosage}-{h.maxDosage}{h.unit}</span>
                  </div>
                ))}
              </div>
            </div>
          </div>

          <div className="card pf-compact">
            <div className="card-header"><h3>医嘱备注</h3></div>
            <div className="card-body">
              <textarea className="form-textarea" style={{ minHeight: 60 }} placeholder="用法用量、煎服方法、忌口等..." value={notes} onChange={(e) => setNotes(e.target.value)} />
            </div>
          </div>

          <div className="pf-actions">
            <button className="btn btn-outline">暂存草稿</button>
            <button className="btn btn-primary">提交审方</button>
          </div>
        </div>

        {/* ===== 右侧：处方审核 ===== */}
        <div className="pf-right">
          <div className="pf-section-title">
            <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2"><path d="M9 11l3 3L22 4" /><path d="M21 12v7a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2h11" /></svg>
            处方审核
            {pendingCount > 0 && <span className="pf-badge">{pendingCount}</span>}
          </div>

          <div className="pf-review-list">
            {prescriptions.map((rx) => (
              <div key={rx.id} className="card pf-review-card" onClick={() => setSelectedRx(selectedRx?.id === rx.id ? null : rx)}>
                <div className="pf-review-card-header" onClick={() => setExpandedId(expandedId === rx.id ? null : rx.id)}>
                  <div className="pf-review-left">
                    <span className={`pf-review-priority ${rx.riskLevel}`} />
                    <div>
                      <div className="pf-review-patient">{rx.patientName} · {rx.patientGender} {rx.patientAge}岁</div>
                      <div className="pf-review-diagnosis">{rx.diagnosis} / {rx.syndrome}</div>
                    </div>
                  </div>
                  <div className="pf-review-right">
                    <span className={`tag ${rx.riskLevel === 'high' ? 'tag-red' : rx.riskLevel === 'medium' ? 'tag-yellow' : 'tag-green'}`}>
                      {rx.riskLevel === 'high' ? '高' : rx.riskLevel === 'medium' ? '中' : '低'} {rx.riskScore}
                    </span>
                    <span className={`pf-review-status ${rx.status}`}>
                      {rx.status === 'pending' ? '待审' : rx.status === 'approved' ? '通过' : '驳回'}
                    </span>
                  </div>
                </div>
                {expandedId === rx.id && (
                  <div className="pf-review-body">
                    <div className="pf-herbs-tags">{rx.herbs.map((h) => <span key={h} className="pf-herb-tag">{h}</span>)}</div>
                    {rx.risks.length > 0 && (
                      <div className="pf-review-section">
                        <h4>风险项</h4>
                        <ul className="pf-risk-list">{rx.risks.map((r, i) => <li key={i} className="danger">{r}</li>)}</ul>
                      </div>
                    )}
                    {rx.suggestions.length > 0 && (
                      <div className="pf-review-section">
                        <h4>建议</h4>
                        <ul className="pf-risk-list">{rx.suggestions.map((s, i) => <li key={i} className="success">{s}</li>)}</ul>
                      </div>
                    )}
                    {rx.status === 'pending' && (
                      <div className="pf-review-actions">
                        <button className="btn btn-ghost btn-sm">退回</button>
                        <button className="btn btn-danger btn-sm">驳回</button>
                        <button className="btn btn-primary btn-sm" onClick={() => navigate('/emr')}>通过</button>
                      </div>
                    )}
                  </div>
                )}
              </div>
            ))}
          </div>

          {selectedRx && (
            <div className="card pf-detail-card">
              <div className="card-header"><h3>处方详情</h3></div>
              <div className="card-body">
                <div className="detail-section">
                  <div className="detail-label">患者信息</div>
                  <div className="detail-row"><label>姓名</label><span>{selectedRx.patientName}</span></div>
                  <div className="detail-row"><label>性别/年龄</label><span>{selectedRx.patientGender} / {selectedRx.patientAge}岁</span></div>
                  <div className="detail-row"><label>诊断</label><span>{selectedRx.diagnosis}</span></div>
                  <div className="detail-row"><label>证型</label><span>{selectedRx.syndrome}</span></div>
                </div>
                <div className="detail-section">
                  <div className="detail-label">风险评估</div>
                  <div className="detail-row">
                    <label>风险等级</label>
                    <span className={`tag ${selectedRx.riskLevel === 'high' ? 'tag-red' : selectedRx.riskLevel === 'medium' ? 'tag-yellow' : 'tag-green'}`}>
                      {selectedRx.riskLevel === 'high' ? '高风险' : selectedRx.riskLevel === 'medium' ? '中风险' : '低风险'}
                    </span>
                  </div>
                  <div className="detail-row"><label>风险评分</label><span>{selectedRx.riskScore}/100</span></div>
                  <div className="risk-bar"><div className={`risk-bar-fill ${selectedRx.riskLevel}`} style={{ width: `${selectedRx.riskScore}%` }} /></div>
                </div>
                <div className="detail-section">
                  <div className="detail-label">审查项</div>
                  <div className="detail-row"><label>配伍禁忌</label><span className={`tag ${selectedRx.compatibilityRisk ? 'tag-red' : 'tag-green'}`}>{selectedRx.compatibilityRisk ? '异常' : '通过'}</span></div>
                  <div className="detail-row"><label>剂量合理性</label><span className={`tag ${selectedRx.dosageRisk ? 'tag-red' : 'tag-green'}`}>{selectedRx.dosageRisk ? '异常' : '通过'}</span></div>
                  <div className="detail-row"><label>禁忌症审查</label><span className={`tag ${selectedRx.contraindicationRisk ? 'tag-yellow' : 'tag-green'}`}>{selectedRx.contraindicationRisk ? '注意' : '通过'}</span></div>
                </div>
              </div>
            </div>
          )}
        </div>
      </div>
    </div>
  )
}
