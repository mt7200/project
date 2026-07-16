import { useState, useMemo } from 'react'
import './IntelligentPrescription.css'

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

interface SelectedHerb extends Herb {
  currentDosage: number
}

export default function IntelligentPrescription() {
  const [selectedPatient, setSelectedPatient] = useState<number | null>(null)
  const [selectedFormula, setSelectedFormula] = useState('')
  const [searchHerb, setSearchHerb] = useState('')
  const [selectedHerbs, setSelectedHerbs] = useState<SelectedHerb[]>([])
  const [notes, setNotes] = useState('')
  const [compatibilityWarnings, setCompatibilityWarnings] = useState<string[]>([])

  const checkCompatibilities = (herbs: SelectedHerb[]) => {
    const warnings: string[] = []
    for (let i = 0; i < herbs.length; i++) {
      for (let j = i + 1; j < herbs.length; j++) {
        if (herbs[i].incompatibilities.includes(herbs[j].name)) {
          warnings.push(`${herbs[i].name} 与 ${herbs[j].name} 存在配伍禁忌（十八反/十九畏），请谨慎使用！`)
        }
        if (herbs[j].incompatibilities.includes(herbs[i].name)) {
          warnings.push(`${herbs[j].name} 与 ${herbs[i].name} 存在配伍禁忌（十八反/十九畏），请谨慎使用！`)
        }
      }
      if (herbs[i].currentDosage > herbs[i].maxDosage) {
        warnings.push(`${herbs[i].name} 超出药典规定最大剂量（${herbs[i].maxDosage}${herbs[i].unit}），当前剂量 ${herbs[i].currentDosage}${herbs[i].unit}`)
      }
      if (herbs[i].currentDosage < herbs[i].minDosage && herbs[i].currentDosage > 0) {
        warnings.push(`${herbs[i].name} 低于药典规定最小剂量（${herbs[i].minDosage}${herbs[i].unit}），当前剂量 ${herbs[i].currentDosage}${herbs[i].unit}`)
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
    const updated = selectedHerbs.map((h) =>
      h.id === id ? { ...h, currentDosage: value } : h
    )
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
        '山茱萸': 12, '山药': 12, '泽泻': 9, '牡丹皮': 9, '茯苓': 15,
        '白术': 12,
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
    return herbDatabase.filter(
      (h) =>
        h.name.includes(term) ||
        h.category.includes(term) ||
        h.taste.includes(term) ||
        h.meridian.includes(term) ||
        h.functions.some((f) => f.includes(term))
    )
  }, [searchHerb])

  return (
    <div className="page-container prescription-page">
      <div className="page-header">
        <h1>智能开方</h1>
        <p>基于辨证结果，智能推荐方剂并辅助处方开具</p>
      </div>

      {compatibilityWarnings.length > 0 && (
        <div className="warning-banner">
          <div className="warning-banner-header">
            <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2"><path d="M10.29 3.86L1.82 18a2 2 0 0 0 1.71 3h16.94a2 2 0 0 0 1.71-3L13.71 3.86a2 2 0 0 0-3.42 0z" /><line x1="12" y1="9" x2="12" y2="13" /><line x1="12" y1="17" x2="12.01" y2="17" /></svg>
            <strong>配伍风险提示（{compatibilityWarnings.length}）</strong>
          </div>
          <ul className="warning-list">
            {compatibilityWarnings.map((w, i) => (
              <li key={i}>{w}</li>
            ))}
          </ul>
        </div>
      )}

      <div className="prescription-layout">
        <div className="prescription-main">
          <div className="card">
            <div className="card-header">
              <h2>
                <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round">
                  <path d="M17 21v-2a4 4 0 0 0-4-4H5a4 4 0 0 0-4 4v2" />
                  <circle cx="9" cy="7" r="4" />
                  <path d="M23 21v-2a4 4 0 0 0-3-3.87" />
                  <path d="M16 3.13a4 4 0 0 1 0 7.75" />
                </svg>
                选择患者
              </h2>
            </div>
            <div className="card-body">
              <div className="patient-select-list">
                {mockPatients.map((p) => (
                  <div
                    key={p.id}
                    className={`patient-card ${selectedPatient === p.id ? 'selected' : ''}`}
                    onClick={() => setSelectedPatient(p.id)}
                  >
                    <div className="patient-avatar">{p.name[0]}</div>
                    <div className="patient-info">
                      <span className="patient-name">{p.name}</span>
                      <span className="patient-meta">{p.gender} · {p.age}岁</span>
                    </div>
                    <span className="tag tag-blue">{p.diagnosis}</span>
                  </div>
                ))}
              </div>
            </div>
          </div>

          <div className="card">
            <div className="card-header">
              <h2>
                <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round">
                  <path d="M12 2v4" /><path d="M12 18v4" /><path d="M4.93 4.93l2.83 2.83" /><path d="M16.24 16.24l2.83 2.83" />
                  <path d="M2 12h4" /><path d="M18 12h4" /><path d="M4.93 19.07l2.83-2.83" /><path d="M16.24 7.76l2.83-2.83" />
                  <circle cx="12" cy="12" r="3" />
                </svg>
                推荐方剂
              </h2>
            </div>
            <div className="card-body">
              <div className="formula-grid">
                {commonFormulas.map((f) => (
                  <button
                    key={f.name}
                    className={`formula-card ${selectedFormula === f.name ? 'active' : ''}`}
                    onClick={() => applyFormula(f.name)}
                  >
                    <span className="formula-name">{f.name}</span>
                    <span className="tag tag-blue">{f.category}</span>
                    <span className="formula-herbs">{f.herbs.join('、')}</span>
                  </button>
                ))}
              </div>
            </div>
          </div>

          <div className="card">
            <div className="card-header">
              <h2>
                <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round">
                  <rect x="9" y="9" width="13" height="13" rx="2" /><path d="M5 15H4a2 2 0 0 1-2-2V4a2 2 0 0 1 2-2h9a2 2 0 0 1 2 2v1" />
                </svg>
                处方明细
              </h2>
              <span className="herb-count">{selectedHerbs.length} 味</span>
            </div>
            <div className="card-body">
              {selectedHerbs.length === 0 ? (
                <div className="empty-state">
                  <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="1.5"><rect x="9" y="9" width="13" height="13" rx="2" /><path d="M5 15H4a2 2 0 0 1-2-2V4a2 2 0 0 1 2-2h9a2 2 0 0 1 2 2v1" /></svg>
                  <p>请从推荐方剂中选择，或从右侧药库添加中药</p>
                </div>
              ) : (
                <div className="prescription-herbs-list">
                  {selectedHerbs.map((herb) => {
                    const isOver = herb.currentDosage > herb.maxDosage
                    const isUnder = herb.currentDosage < herb.minDosage && herb.currentDosage > 0
                    return (
                      <div key={herb.id} className={`prescription-herb-item ${isOver || isUnder ? 'warning' : ''}`}>
                        <div className="herb-item-main">
                          <div className="herb-item-header">
                            <span className="herb-item-name">
                              {herb.name}
                              {herb.toxic && <span className="tag tag-red" style={{ marginLeft: 6 }}>毒</span>}
                            </span>
                            <span className="tag tag-blue">{herb.category}</span>
                          </div>
                          <div className="herb-item-info">
                            <span>{herb.nature}，{herb.taste}</span>
                            <span>归 {herb.meridian}</span>
                          </div>
                          <div className="herb-item-functions">{herb.functions.join('、')}</div>
                        </div>
                        <div className="herb-item-dosage">
                          <div className="dosage-range">药典：{herb.minDosage}-{herb.maxDosage}{herb.unit}</div>
                          <div className="dosage-input-group">
                            <button
                              className="dosage-btn"
                              onClick={() => updateDosage(herb.id, Math.max(herb.currentDosage - 1, 0))}
                            >−</button>
                            <input
                              type="number"
                              className={`dosage-number-input ${isOver ? 'over' : ''} ${isUnder ? 'under' : ''}`}
                              value={herb.currentDosage}
                              step={1}
                              onChange={(e) => updateDosage(herb.id, parseFloat(e.target.value) || 0)}
                            />
                            <button
                              className="dosage-btn"
                              onClick={() => updateDosage(herb.id, herb.currentDosage + 1)}
                            >+</button>
                            <span className="dosage-unit">{herb.unit}</span>
                          </div>
                          {(isOver || isUnder) && (
                            <div className="dosage-warning-text">
                              {isOver && '⚠ 超出最大剂量'}
                              {isUnder && '⚠ 低于最小剂量'}
                            </div>
                          )}
                        </div>
                        <button className="herb-remove-btn" onClick={() => removeHerb(herb.id)}>
                          <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2"><line x1="18" y1="6" x2="6" y2="18" /><line x1="6" y1="6" x2="18" y2="18" /></svg>
                        </button>
                      </div>
                    )
                  })}
                </div>
              )}
            </div>
          </div>

          {selectedHerbs.length >= 2 && (
            <div className="card">
              <div className="card-header">
                <h2>配伍关系</h2>
              </div>
              <div className="card-body">
                <div className="compatibility-matrix">
                  {selectedHerbs.map((h1, i) =>
                    selectedHerbs.slice(i + 1).map((h2, j) => {
                      const isSynergy = h1.synergies.includes(h2.name) || h2.synergies.includes(h1.name)
                      const isIncompat = h1.incompatibilities.includes(h2.name) || h2.incompatibilities.includes(h1.name)
                      return (
                        <div key={`${i}-${j}`} className={`compatibility-pair ${isIncompat ? 'incompat' : isSynergy ? 'synergy' : ''}`}>
                          <span className="pair-name">{h1.name}</span>
                          <span className={`pair-relation ${isIncompat ? 'danger' : isSynergy ? 'success' : 'muted'}`}>
                            {isIncompat ? '✕ 禁忌' : isSynergy ? '✓ 相须' : '— 无特殊'}
                          </span>
                          <span className="pair-name">{h2.name}</span>
                        </div>
                      )
                    })
                  )}
                </div>
              </div>
            </div>
          )}

          <div className="card">
            <div className="card-header">
              <h2>
                <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2"><path d="M11 4H4a2 2 0 0 0-2 2v14a2 2 0 0 0 2 2h14a2 2 0 0 0 2-2v-7" /><path d="M18.5 2.5a2.121 2.121 0 0 1 3 3L12 15l-4 1 1-4 9.5-9.5z" /></svg>
                医嘱备注
              </h2>
            </div>
            <div className="card-body">
              <textarea
                className="form-textarea"
                style={{ minHeight: 100 }}
                placeholder="输入用法用量、煎服方法、忌口等医嘱说明..."
                value={notes}
                onChange={(e) => setNotes(e.target.value)}
              />
            </div>
          </div>

          <div className="prescription-actions">
            <button className="btn btn-outline">暂存草稿</button>
            <button className="btn btn-outline">预览处方</button>
            <button className="btn btn-primary btn-lg">提交审方</button>
          </div>
        </div>

        <div className="prescription-sidebar">
          <div className="card">
            <div className="card-header">
              <h2>药库检索</h2>
            </div>
            <div className="card-body">
              <input
                className="form-input"
                placeholder="搜索药名、类别、功效..."
                value={searchHerb}
                onChange={(e) => setSearchHerb(e.target.value)}
              />
              <div className="herb-library scrollbar">
                {filteredHerbs.map((h) => (
                  <div
                    key={h.id}
                    className={`herb-item ${selectedHerbs.some(sh => sh.id === h.id) ? 'selected' : ''}`}
                    onClick={() => addHerb(h)}
                  >
                    <div className="herb-item-info">
                      <span className="herb-item-name">
                        {h.name}
                        {h.toxic && <span className="tag tag-red" style={{ marginLeft: 4, fontSize: 10 }}>毒</span>}
                      </span>
                      <span className="herb-item-nature">{h.nature}，{h.taste} | 归 {h.meridian}</span>
                      <span className="herb-item-dosage-range">{h.minDosage}-{h.maxDosage}{h.unit}</span>
                    </div>
                    <span className={`tag ${h.toxic ? 'tag-red' : 'tag-blue'}`}>
                      {h.category}
                    </span>
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
