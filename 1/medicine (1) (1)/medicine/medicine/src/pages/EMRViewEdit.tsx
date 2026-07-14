import { useState, useMemo, useEffect } from 'react'
import { useNavigate, useSearchParams } from 'react-router-dom'
import './EMRViewEdit.css'

interface EMR {
  id: number
  name: string
  gender: string
  age: number
  visitDate: string
  chiefComplaint: string
  presentIllness: string
  pastHistory: string
  tongueImage: string
  pulseImage: string
  complexion: string
  voice: string
  syndrome: string
  diagnosis: string
  treatmentPrinciple: string
  prescription: string
  notes: string
}

const mockEMRs: EMR[] = [
  {
    id: 10001, name: '张三', gender: '男', age: 45,
    visitDate: '2026-05-05', chiefComplaint: '恶寒发热2天，伴头痛鼻塞',
    presentIllness: '患者2天前因受凉后出现恶寒、发热、头痛、鼻塞流清涕、咳嗽、痰白清稀。自服感冒药效果不佳。',
    pastHistory: '既往体健，无药物过敏史，无慢性病史。',
    tongueImage: '舌质淡红，苔薄白', pulseImage: '脉浮紧',
    complexion: '面色微白', voice: '语声重浊',
    syndrome: '风寒束表证', diagnosis: '风寒感冒',
    treatmentPrinciple: '辛温解表，宣肺散寒',
    prescription: '麻黄9g、桂枝6g、杏仁9g、炙甘草3g',
    notes: '嘱服药后盖被取微汗，避风寒，忌食生冷。3剂，每日1剂，水煎服。',
  },
  {
    id: 10002, name: '李四', gender: '女', age: 38,
    visitDate: '2026-05-04', chiefComplaint: '月经不调半年，伴胸胁胀痛',
    presentIllness: '患者近半年来月经周期紊乱，经量时多时少，经前乳房胀痛，胸胁胀满，情绪易怒，失眠多梦。',
    pastHistory: '有轻度乳腺增生病史，无手术史。',
    tongueImage: '舌质淡红，苔薄白', pulseImage: '脉弦细',
    complexion: '面色微暗', voice: '语声正常',
    syndrome: '肝郁血虚证', diagnosis: '月经不调',
    treatmentPrinciple: '疏肝解郁，养血调经',
    prescription: '柴胡12g、当归12g、白芍15g、茯苓15g、白术12g、薄荷6g、生姜9g、炙甘草6g',
    notes: '嘱保持心情舒畅，避免劳累。7剂，每日1剂，水煎服。',
  },
  {
    id: 10003, name: '王五', gender: '男', age: 62,
    visitDate: '2026-05-03', chiefComplaint: '反复腰痛3年，加重1周',
    presentIllness: '患者3年来反复出现腰痛，劳累后加重，伴下肢酸软无力，夜尿频多，畏寒肢冷。近1周症状加重。',
    pastHistory: '有高血压病史5年，规律服用降压药，血压控制可。',
    tongueImage: '舌质淡胖，苔白滑', pulseImage: '脉沉弱',
    complexion: '面色㿠白', voice: '语声低微',
    syndrome: '肾阳虚证', diagnosis: '腰痛病',
    treatmentPrinciple: '温补肾阳，强腰壮骨',
    prescription: '熟地黄24g、山茱萸12g、山药12g、茯苓9g、牡丹皮9g、泽泻9g、桂枝3g、附子3g',
    notes: '嘱注意腰部保暖，避免重体力劳动。7剂，每日1剂，水煎服。',
  },
]

interface PatientSummary {
  id: number
  name: string
  gender: string
  age: number
  diagnosis: string
  visitDate: string
  followUp: string
}

const mockPatientsByStatus: Record<string, PatientSummary[]> = {
  '可复诊': [
    { id: 1, name: '张三', gender: '男', age: 45, diagnosis: '风寒感冒', visitDate: '2026-05-05', followUp: '7日后复诊' },
    { id: 2, name: '王五', gender: '男', age: 62, diagnosis: '腰痛病', visitDate: '2026-05-03', followUp: '7日后复诊' },
  ],
  '未诊断完成': [
    { id: 3, name: '钱九', gender: '男', age: 35, diagnosis: '待查', visitDate: '2026-05-06', followUp: '' },
    { id: 4, name: '吴十', gender: '女', age: 28, diagnosis: '待查', visitDate: '2026-05-06', followUp: '' },
  ],
  '已完成': [
    { id: 5, name: '李四', gender: '女', age: 38, diagnosis: '月经不调', visitDate: '2026-05-04', followUp: '已痊愈' },
    { id: 6, name: '赵六', gender: '女', age: 55, diagnosis: '高血压', visitDate: '2026-05-03', followUp: '已痊愈' },
  ],
  '待诊断': [
    { id: 7, name: '郑十一', gender: '男', age: 50, diagnosis: '-', visitDate: '2026-05-07', followUp: '' },
    { id: 8, name: '陈十二', gender: '女', age: 42, diagnosis: '-', visitDate: '2026-05-07', followUp: '' },
  ],
}

interface HistoryRecord {
  id: number
  patientName: string
  gender: string
  age: number
  visitDate: string
  chiefComplaint: string
  diagnosis: string
  syndrome: string
  prescription: string
  treatmentResult: string
  followUp: string
  docName: string
}

const historyRecords: HistoryRecord[] = [
  {
    id: 20001, patientName: '张三', gender: '男', age: 45,
    visitDate: '2026-05-05', chiefComplaint: '恶寒发热2天', diagnosis: '风寒感冒',
    syndrome: '风寒束表证', prescription: '麻黄汤加减',
    treatmentResult: '好转', followUp: '7日后复诊',
    docName: '张仲景',
  },
  {
    id: 20002, patientName: '张三', gender: '男', age: 45,
    visitDate: '2026-04-20', chiefComplaint: '咳嗽3天', diagnosis: '咳嗽病',
    syndrome: '风热犯肺证', prescription: '桑菊饮加减',
    treatmentResult: '痊愈', followUp: '无需复诊',
    docName: '张仲景',
  },
  {
    id: 20003, patientName: '李四', gender: '女', age: 38,
    visitDate: '2026-05-04', chiefComplaint: '月经不调半年', diagnosis: '月经不调',
    syndrome: '肝郁血虚证', prescription: '逍遥散加减',
    treatmentResult: '显效', followUp: '14日后复诊',
    docName: '华佗',
  },
  {
    id: 20004, patientName: '李四', gender: '女', age: 38,
    visitDate: '2026-03-15', chiefComplaint: '头痛乏力', diagnosis: '头痛病',
    syndrome: '气血两虚证', prescription: '八珍汤加减',
    treatmentResult: '好转', followUp: '30日后复诊',
    docName: '张仲景',
  },
  {
    id: 20005, patientName: '王五', gender: '男', age: 62,
    visitDate: '2026-05-03', chiefComplaint: '腰痛加重1周', diagnosis: '腰痛病',
    syndrome: '肾阳虚证', prescription: '金匮肾气丸加减',
    treatmentResult: '好转', followUp: '7日后复诊',
    docName: '张仲景',
  },
  {
    id: 20006, patientName: '王五', gender: '男', age: 62,
    visitDate: '2026-03-10', chiefComplaint: '头晕1月', diagnosis: '眩晕病',
    syndrome: '肝阳上亢证', prescription: '天麻钩藤饮加减',
    treatmentResult: '好转', followUp: '14日后复诊',
    docName: '华佗',
  },
  {
    id: 20007, patientName: '赵六', gender: '女', age: 55,
    visitDate: '2026-05-03', chiefComplaint: '失眠心悸', diagnosis: '不寐',
    syndrome: '心脾两虚证', prescription: '归脾汤加减',
    treatmentResult: '显效', followUp: '14日后复诊',
    docName: '张仲景',
  },
  {
    id: 20008, patientName: '赵六', gender: '女', age: 55,
    visitDate: '2026-02-20', chiefComplaint: '胃脘痛', diagnosis: '胃痛病',
    syndrome: '脾胃虚寒证', prescription: '理中汤加减',
    treatmentResult: '痊愈', followUp: '无需复诊',
    docName: '张仲景',
  },
  {
    id: 20009, patientName: '孙七', gender: '男', age: 28,
    visitDate: '2026-05-01', chiefComplaint: '咽喉痛3天', diagnosis: '咽喉炎',
    syndrome: '风热侵袭证', prescription: '银翘散加减',
    treatmentResult: '好转', followUp: '5日后复诊',
    docName: '华佗',
  },
  {
    id: 20010, patientName: '周八', gender: '女', age: 70,
    visitDate: '2026-04-28', chiefComplaint: '关节疼痛', diagnosis: '痹证',
    syndrome: '风寒湿痹证', prescription: '独活寄生汤加减',
    treatmentResult: '好转', followUp: '14日后复诊',
    docName: '张仲景',
  },
]

const syndromeOptions = [
  '风寒束表证', '风热犯肺证', '肝郁气滞证', '肝郁血虚证',
  '肾阳虚证', '肾阴虚证', '脾虚湿盛证', '痰湿阻肺证',
  '肝阳上亢证', '气血两虚证', '瘀血阻络证',
]

const TABS = ['可复诊', '未诊断完成', '已完成', '待诊断', '历史诊疗']

function exportToCSV<T extends Record<string, unknown>>(data: T[], filename: string, headers: Record<string, string>) {
  const headerRow = Object.values(headers).join(',')
  const rows = data.map((item) =>
    Object.keys(headers).map((key) => {
      const val = item[key]
      const str = val == null ? '' : String(val)
      return str.includes(',') ? `"${str}"` : str
    }).join(',')
  )
  const csv = [headerRow, ...rows].join('\n')
  const blob = new Blob(['\uFEFF' + csv], { type: 'text/csv;charset=utf-8' })
  const url = URL.createObjectURL(blob)
  const a = document.createElement('a')
  a.href = url
  a.download = `${filename}.csv`
  a.click()
  URL.revokeObjectURL(url)
}

export default function EMRViewEdit() {
  const [activeTab, setActiveTab] = useState('可复诊')
  const [selectedId, setSelectedId] = useState<number | null>(null)
  const [isEditing, setIsEditing] = useState(false)
  const [editingData, setEditingData] = useState<EMR | null>(null)
  const [searchTerm, setSearchTerm] = useState('')
  const [searchParams] = useSearchParams()
  const navigate = useNavigate()
  const [filterMonth, setFilterMonth] = useState<string>('')
  const [filterSyndrome, setFilterSyndrome] = useState<string>('')

  useEffect(() => {
    const month = searchParams.get('month')
    const syndrome = searchParams.get('syndrome')
    if (month) {
      setActiveTab('已完成')
      setFilterMonth(month)
    }
    if (syndrome) {
      setActiveTab('已完成')
      setFilterSyndrome(syndrome)
    }
  }, [searchParams])

  // History tab state
  const [historySearchText, setHistorySearchText] = useState('')
  const [historyFilterDate, setHistoryFilterDate] = useState('')
  const [historyFilterResult, setHistoryFilterResult] = useState('')
  const [selectedRecord, setSelectedRecord] = useState<HistoryRecord | null>(null)

  const isHistoryTab = activeTab === '历史诊疗'
  const currentPatients = !isHistoryTab ? (mockPatientsByStatus[activeTab] || []) : []

  const monthMap: Record<string, string> = {
    '1月': '01', '2月': '02', '3月': '03', '4月': '04', '5月': '05',
    '6月': '06', '7月': '07', '8月': '08', '9月': '09', '10月': '10',
    '11月': '11', '12月': '12',
  }

  const filteredPatients = currentPatients.filter((p) => {
    // Text search filter
    if (searchTerm && !p.name.includes(searchTerm) && !p.diagnosis.includes(searchTerm)) return false
    // Month filter
    if (filterMonth) {
      const monthNum = monthMap[filterMonth]
      if (monthNum && !p.visitDate.includes(`-${monthNum}-`)) return false
    }
    // Syndrome filter: only show patients whose EMR matches the syndrome
    if (filterSyndrome) {
      const matchedNames = mockEMRs.filter((e) => e.syndrome === filterSyndrome).map((e) => e.name)
      if (!matchedNames.includes(p.name)) return false
    }
    return true
  })

  const selectedPatient = currentPatients.find((p) => p.id === selectedId) || null

  // For 已完成 tab, look up full EMR by name
  const selectedEMR = selectedPatient
    ? mockEMRs.find((e) => e.name === selectedPatient.name) || null
    : null

  const filteredHistoryRecords = useMemo(() => {
    return historyRecords.filter((r) => {
      if (historySearchText && !r.patientName.includes(historySearchText) && !r.diagnosis.includes(historySearchText)) return false
      if (historyFilterDate && !r.visitDate.includes(historyFilterDate)) return false
      if (historyFilterResult && r.treatmentResult !== historyFilterResult) return false
      return true
    })
  }, [historySearchText, historyFilterDate, historyFilterResult])

  const statSummary = useMemo(() => {
    const results = historyRecords.map((r) => r.treatmentResult)
    return {
      total: results.length,
      cured: results.filter((r) => r === '痊愈').length,
      improved: results.filter((r) => r === '显效' || r === '好转').length,
    }
  }, [])

  const handleSelect = (patient: PatientSummary) => {
    setSelectedId(patient.id)
    setIsEditing(false)
    setEditingData(null)
  }

  const handleTabChange = (tab: string) => {
    setActiveTab(tab)
    setSelectedId(null)
    setIsEditing(false)
    setEditingData(null)
    setSearchTerm('')
    setSelectedRecord(null)
    setFilterMonth('')
    setFilterSyndrome('')
  }

  const handleEdit = () => {
    if (selectedEMR) {
      setEditingData({ ...selectedEMR })
      setIsEditing(true)
    }
  }

  const handleSave = () => {
    setIsEditing(false)
    setEditingData(null)
  }

  const handleCancel = () => {
    setIsEditing(false)
    setEditingData(null)
  }

  const data = editingData || selectedEMR

  // Render patient info card for non-completed tabs (simplified view)
  const renderPatientInfoCard = () => {
    if (!selectedPatient) return null
    return (
      <div className="card patient-info-card">
        <div className="info-header">
          <h3>{selectedPatient.name} 的信息</h3>
        </div>
        <div className="info-row">
          <label>性别</label>
          <span>{selectedPatient.gender}</span>
        </div>
        <div className="info-row">
          <label>年龄</label>
          <span>{selectedPatient.age}岁</span>
        </div>
        <div className="info-row">
          <label>诊断</label>
          <span>{selectedPatient.diagnosis}</span>
        </div>
        <div className="info-row">
          <label>就诊日期</label>
          <span>{selectedPatient.visitDate}</span>
        </div>
        {selectedPatient.followUp && (
          <div className="info-row">
            <label>随访建议</label>
            <span>{selectedPatient.followUp}</span>
          </div>
        )}
      </div>
    )
  }

  return (
    <div className="page-container">
      <div className="page-header">
        <div>
          <h1>电子病历查看 / 编辑</h1>
          <p>查看和编辑患者的四诊信息、辨证诊断及处方记录</p>
        </div>
        <div style={{ display: 'flex', gap: 8 }}>
          {isHistoryTab ? (
            <button
              className="btn btn-outline btn-sm"
              onClick={() => {
                const headers = { patientName: '患者姓名', gender: '性别', age: '年龄', visitDate: '就诊日期', chiefComplaint: '主诉', diagnosis: '诊断', syndrome: '证型', prescription: '处方', treatmentResult: '疗效', docName: '医师' }
                exportToCSV(historyRecords, '历史诊疗记录', headers)
              }}
            >
              <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2"><path d="M21 15v4a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2v-4"/><polyline points="7 10 12 15 17 10"/><line x1="12" y1="15" x2="12" y2="3"/></svg>
              导出历史记录
            </button>
          ) : (
            <button
              className="btn btn-outline btn-sm"
              onClick={() => {
                const headers = { name: '姓名', gender: '性别', age: '年龄', visitDate: '就诊日期', diagnosis: '诊断' }
                exportToCSV(filteredPatients, `电子病历_${activeTab}`, headers)
              }}
            >
              <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2"><path d="M21 15v4a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2v-4"/><polyline points="7 10 12 15 17 10"/><line x1="12" y1="15" x2="12" y2="3"/></svg>
              导出列表
            </button>
          )}
        </div>
      </div>

      {/* Tabs */}
      <div className="emr-tabs">
        {TABS.map((tab) => (
          <button
            key={tab}
            className={`emr-tab ${activeTab === tab ? 'active' : ''}`}
            onClick={() => handleTabChange(tab)}
          >
            {tab}
          </button>
        ))}
      </div>

      {/* Filter indicators */}
      {(filterMonth || filterSyndrome) && (
        <div style={{ display: 'flex', alignItems: 'center', gap: 8, marginBottom: 16, flexWrap: 'wrap' }}>
          {filterMonth && (
            <span style={{
              display: 'inline-flex', alignItems: 'center', gap: 4,
              padding: '4px 10px', borderRadius: 16, fontSize: 13,
              background: '#e8f4fd', color: '#1976d2', border: '1px solid #bbdefb',
            }}>
              月份：{filterMonth}
              <button
                onClick={() => setFilterMonth('')}
                style={{ background: 'none', border: 'none', cursor: 'pointer', color: '#1976d2', fontSize: 16, lineHeight: 1, padding: 0 }}
                title="清除月份筛选"
              >×</button>
            </span>
          )}
          {filterSyndrome && (
            <span style={{
              display: 'inline-flex', alignItems: 'center', gap: 4,
              padding: '4px 10px', borderRadius: 16, fontSize: 13,
              background: '#fce4ec', color: '#c62828', border: '1px solid #f8bbd0',
            }}>
              证型：{filterSyndrome}
              <button
                onClick={() => setFilterSyndrome('')}
                style={{ background: 'none', border: 'none', cursor: 'pointer', color: '#c62828', fontSize: 16, lineHeight: 1, padding: 0 }}
                title="清除证型筛选"
              >×</button>
            </span>
          )}
          <button
            className="btn btn-ghost btn-sm"
            onClick={() => { setFilterMonth(''); setFilterSyndrome('') }}
          >
            清除全部
          </button>
        </div>
      )}

      {isHistoryTab ? (
        /* ===== 历史诊疗 Tab ===== */
        <>
          <div className="history-summary">
            <div className="summary-stat">
              <div className="stat-icon blue">
                <svg width="22" height="22" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2"><path d="M14 2H6a2 2 0 0 0-2 2v16a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V8z" /><polyline points="14 2 14 8 20 8" /></svg>
              </div>
              <div>
                <div className="stat-value">{statSummary.total}</div>
                <div className="stat-label">总诊疗次数</div>
              </div>
            </div>
            <div className="summary-stat">
              <div className="stat-icon green">
                <svg width="22" height="22" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2"><path d="M22 11.08V12a10 10 0 1 1-5.93-9.14" /><polyline points="22 4 12 14.01 9 11.01" /></svg>
              </div>
              <div>
                <div className="stat-value">{statSummary.cured}</div>
                <div className="stat-label">痊愈</div>
              </div>
            </div>
            <div className="summary-stat">
              <div className="stat-icon orange">
                <svg width="22" height="22" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2"><polyline points="23 6 13.5 15.5 8.5 10.5 1 18" /><polyline points="17 6 23 6 23 12" /></svg>
              </div>
              <div>
                <div className="stat-value">{statSummary.improved}</div>
                <div className="stat-label">好转/显效</div>
              </div>
            </div>
          </div>

          <div className="card" style={{ marginBottom: 20 }}>
            <div className="card-body">
              <div className="history-filters">
                <div className="filter-item">
                  <input
                    className="form-input"
                    placeholder="搜索患者姓名或诊断..."
                    value={historySearchText}
                    onChange={(e) => setHistorySearchText(e.target.value)}
                  />
                </div>
                <div className="filter-item">
                  <input
                    className="form-input"
                    type="month"
                    value={historyFilterDate}
                    onChange={(e) => setHistoryFilterDate(e.target.value)}
                  />
                </div>
                <div className="filter-item">
                  <select
                    className="form-select"
                    value={historyFilterResult}
                    onChange={(e) => setHistoryFilterResult(e.target.value)}
                  >
                    <option value="">全部疗效</option>
                    <option value="痊愈">痊愈</option>
                    <option value="显效">显效</option>
                    <option value="好转">好转</option>
                  </select>
                </div>
                {(historySearchText || historyFilterDate || historyFilterResult) && (
                  <button className="btn btn-ghost btn-sm" onClick={() => { setHistorySearchText(''); setHistoryFilterDate(''); setHistoryFilterResult('') }}>
                    清除筛选
                  </button>
                )}
              </div>
            </div>
          </div>

          <div className="history-layout">
            <div className="history-table-wrapper">
              <div className="card">
                <div className="herb-table-wrapper scrollbar" style={{ maxHeight: 600 }}>
                  <table className="table">
                    <thead>
                      <tr>
                        <th>患者姓名</th>
                        <th>性别/年龄</th>
                        <th>就诊日期</th>
                        <th>主诉</th>
                        <th>诊断</th>
                        <th>证型</th>
                        <th>处方</th>
                        <th>疗效</th>
                        <th>医师</th>
                      </tr>
                    </thead>
                    <tbody>
                      {filteredHistoryRecords.map((r) => (
                        <tr key={r.id} onClick={() => setSelectedRecord(r)} style={{ cursor: 'pointer' }}>
                          <td><span style={{ fontWeight: 500 }}>{r.patientName}</span></td>
                          <td className="text-muted">{r.gender} / {r.age}</td>
                          <td className="text-muted">{r.visitDate}</td>
                          <td className="text-muted" style={{ maxWidth: 160, overflow: 'hidden', textOverflow: 'ellipsis', whiteSpace: 'nowrap' }}>{r.chiefComplaint}</td>
                          <td>{r.diagnosis}</td>
                          <td className="text-muted">{r.syndrome}</td>
                          <td className="text-muted" style={{ maxWidth: 140, overflow: 'hidden', textOverflow: 'ellipsis', whiteSpace: 'nowrap' }}>{r.prescription}</td>
                          <td>
                            <span className={`tag ${
                              r.treatmentResult === '痊愈' ? 'tag-green' :
                              r.treatmentResult === '显效' ? 'tag-blue' :
                              'tag-yellow'
                            }`}>{r.treatmentResult}</span>
                          </td>
                          <td className="text-muted">{r.docName}</td>
                        </tr>
                      ))}
                    </tbody>
                  </table>
                </div>
              </div>
            </div>

            {selectedRecord && (
              <div className="history-detail-sidebar">
                <div className="card">
                  <div className="card-header">
                    <h2>诊疗详情</h2>
                    <button className="btn btn-ghost btn-sm" onClick={() => setSelectedRecord(null)}>
                      <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2"><line x1="18" y1="6" x2="6" y2="18" /><line x1="6" y1="6" x2="18" y2="18" /></svg>
                    </button>
                  </div>
                  <div className="card-body">
                    <div className="detail-section">
                      <div className="detail-label">基本信息</div>
                      <div className="detail-row"><label>患者</label><span>{selectedRecord.patientName}</span></div>
                      <div className="detail-row"><label>性别/年龄</label><span>{selectedRecord.gender} / {selectedRecord.age}岁</span></div>
                      <div className="detail-row"><label>就诊日期</label><span>{selectedRecord.visitDate}</span></div>
                      <div className="detail-row"><label>就诊医师</label><span>{selectedRecord.docName}</span></div>
                    </div>
                    <div className="detail-section">
                      <div className="detail-label">诊疗信息</div>
                      <div className="detail-row"><label>主诉</label><span>{selectedRecord.chiefComplaint}</span></div>
                      <div className="detail-row"><label>诊断</label><span><span className="tag tag-blue">{selectedRecord.diagnosis}</span></span></div>
                      <div className="detail-row"><label>证型</label><span>{selectedRecord.syndrome}</span></div>
                      <div className="detail-row"><label>处方</label><span>{selectedRecord.prescription}</span></div>
                    </div>
                    <div className="detail-section">
                      <div className="detail-label">结果</div>
                      <div className="detail-row"><label>疗效</label>
                        <span className={`tag ${
                          selectedRecord.treatmentResult === '痊愈' ? 'tag-green' :
                          selectedRecord.treatmentResult === '显效' ? 'tag-blue' : 'tag-yellow'
                        }`}>{selectedRecord.treatmentResult}</span>
                      </div>
                      <div className="detail-row"><label>随访建议</label><span>{selectedRecord.followUp}</span></div>
                    </div>
                  </div>
                </div>
              </div>
            )}
          </div>
        </>
      ) : (
        /* ===== 患者列表 Tab (可复诊/未诊断完成/已完成/待诊断) ===== */
        <div className="emr-layout">
          <div className="emr-list-panel">
            <div className="emr-search-box">
              <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2"><circle cx="11" cy="11" r="8" /><line x1="21" y1="21" x2="16.65" y2="16.65" /></svg>
              <input
                className="form-input"
                placeholder="搜索姓名或诊断..."
                value={searchTerm}
                onChange={(e) => setSearchTerm(e.target.value)}
              />
            </div>
            <div className="emr-list scrollbar">
              {filteredPatients.map((patient) => (
                <div
                  key={patient.id}
                  className={`emr-list-item card ${selectedId === patient.id ? 'active' : ''}`}
                >
                  <div style={{ cursor: 'pointer' }} onClick={() => handleSelect(patient)}>
                    <div className="emr-list-header">
                      <span className="emr-list-name">{patient.name}</span>
                      <span className="emr-list-date">{patient.visitDate}</span>
                    </div>
                    <div className="emr-list-meta">
                      {patient.gender} · {patient.age}岁 · {patient.diagnosis}
                    </div>
                  </div>
                  <div style={{ marginTop: 6, display: 'flex', gap: 4 }}>
                    <button
                      className="btn btn-primary btn-sm"
                      style={{ fontSize: 11, padding: '2px 8px' }}
                      onClick={(e) => {
                         e.stopPropagation()
                         navigate('/workspace', { state: { patient } })
                       }}
                    >
                      接诊
                    </button>
                  </div>
                </div>
              ))}
              {filteredPatients.length === 0 && (
                <div style={{ padding: '20px', textAlign: 'center', color: 'var(--text-muted)' }}>
                  暂无患者数据
                </div>
              )}
            </div>
          </div>

          <div className="emr-editor-panel">
            {activeTab === '已完成' && data ? (
              /* Full EMR details for 已完成 tab */
              <div className="card" style={{ padding: '20px 24px' }}>
                <div className="emr-record-header">
                  <div>
                    <h3>{data.name} 的病历</h3>
                    <span className="emr-record-id">病历号：{data.id}</span>
                  </div>
                  <div className="emr-actions">
                    {!isEditing ? (
                      <button className="btn btn-outline" onClick={handleEdit}>
                        <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2"><path d="M11 4H4a2 2 0 0 0-2 2v14a2 2 0 0 0 2 2h14a2 2 0 0 0 2-2v-7" /><path d="M18.5 2.5a2.121 2.121 0 0 1 3 3L12 15l-4 1 1-4 9.5-9.5z" /></svg>
                        编辑
                      </button>
                    ) : (
                      <>
                        <button className="btn btn-outline" onClick={handleCancel}>取消</button>
                        <button className="btn btn-primary" onClick={handleSave}>保存</button>
                      </>
                    )}
                  </div>
                </div>

                <div className="emr-section">
                  <div className="emr-section-title">基本信息</div>
                  <div className="emr-field-row">
                    <div className="emr-field">
                      <label>姓名</label>
                      {isEditing ? (
                        <input className="editing-value" value={editingData!.name} onChange={(e) => setEditingData({ ...editingData!, name: e.target.value })} />
                      ) : (
                        <span className="value">{data.name}</span>
                      )}
                    </div>
                    <div className="emr-field">
                      <label>性别</label>
                      {isEditing ? (
                        <select className="editing-value" value={editingData!.gender} onChange={(e) => setEditingData({ ...editingData!, gender: e.target.value })}>
                          <option>男</option><option>女</option>
                        </select>
                      ) : (
                        <span className="value">{data.gender}</span>
                      )}
                    </div>
                    <div className="emr-field">
                      <label>年龄</label>
                      {isEditing ? (
                        <input className="editing-value" type="number" value={editingData!.age} onChange={(e) => setEditingData({ ...editingData!, age: Number(e.target.value) })} />
                      ) : (
                        <span className="value">{data.age}岁</span>
                      )}
                    </div>
                    <div className="emr-field">
                      <label>就诊日期</label>
                      {isEditing ? (
                        <input className="editing-value" type="date" value={editingData!.visitDate} onChange={(e) => setEditingData({ ...editingData!, visitDate: e.target.value })} />
                      ) : (
                        <span className="value">{data.visitDate}</span>
                      )}
                    </div>
                  </div>
                </div>

                <div className="emr-section">
                  <div className="emr-section-title">主诉与现病史</div>
                  <div className="emr-field" style={{ marginBottom: 10 }}>
                    <label>主诉</label>
                    {isEditing ? (
                      <input className="editing-value" value={editingData!.chiefComplaint} onChange={(e) => setEditingData({ ...editingData!, chiefComplaint: e.target.value })} />
                    ) : (
                      <span className="value">{data.chiefComplaint}</span>
                    )}
                  </div>
                  <div className="emr-field">
                    <label>现病史</label>
                    {isEditing ? (
                      <textarea className="editing-value" rows={3} value={editingData!.presentIllness} onChange={(e) => setEditingData({ ...editingData!, presentIllness: e.target.value })} />
                    ) : (
                      <span className="value">{data.presentIllness}</span>
                    )}
                  </div>
                </div>

                <div className="emr-section">
                  <div className="emr-section-title">既往史</div>
                  <div className="emr-field">
                    {isEditing ? (
                      <textarea className="editing-value" rows={2} value={editingData!.pastHistory} onChange={(e) => setEditingData({ ...editingData!, pastHistory: e.target.value })} />
                    ) : (
                      <span className="value">{data.pastHistory}</span>
                    )}
                  </div>
                </div>

                <div className="emr-section">
                  <div className="emr-section-title">四诊信息</div>
                  <div className="emr-field-row">
                    <div className="emr-field">
                      <label>舌象</label>
                      {isEditing ? (
                        <input className="editing-value" value={editingData!.tongueImage} onChange={(e) => setEditingData({ ...editingData!, tongueImage: e.target.value })} />
                      ) : (
                        <span className="value">{data.tongueImage}</span>
                      )}
                    </div>
                    <div className="emr-field">
                      <label>脉象</label>
                      {isEditing ? (
                        <input className="editing-value" value={editingData!.pulseImage} onChange={(e) => setEditingData({ ...editingData!, pulseImage: e.target.value })} />
                      ) : (
                        <span className="value">{data.pulseImage}</span>
                      )}
                    </div>
                    <div className="emr-field">
                      <label>面色</label>
                      {isEditing ? (
                        <input className="editing-value" value={editingData!.complexion} onChange={(e) => setEditingData({ ...editingData!, complexion: e.target.value })} />
                      ) : (
                        <span className="value">{data.complexion}</span>
                      )}
                    </div>
                    <div className="emr-field">
                      <label>语声</label>
                      {isEditing ? (
                        <input className="editing-value" value={editingData!.voice} onChange={(e) => setEditingData({ ...editingData!, voice: e.target.value })} />
                      ) : (
                        <span className="value">{data.voice}</span>
                      )}
                    </div>
                  </div>
                </div>

                <div className="emr-section">
                  <div className="emr-section-title">辨证诊断</div>
                  {isEditing && (
                    <div className="syndrome-select-hint">
                      <label className="form-label">选择证型</label>
                      <div className="syndrome-options">
                        {syndromeOptions.map((s) => (
                          <button
                            key={s}
                            className={`syndrome-option ${editingData!.syndrome === s ? 'selected' : ''}`}
                            onClick={() => setEditingData({ ...editingData!, syndrome: s })}
                          >
                            {s}
                          </button>
                        ))}
                      </div>
                    </div>
                  )}
                  <div className="emr-field-row">
                    <div className="emr-field">
                      <label>证型</label>
                      {isEditing ? (
                        <input className="editing-value" value={editingData!.syndrome} onChange={(e) => setEditingData({ ...editingData!, syndrome: e.target.value })} />
                      ) : (
                        <span className="value">{data.syndrome}</span>
                      )}
                    </div>
                    <div className="emr-field">
                      <label>诊断</label>
                      {isEditing ? (
                        <input className="editing-value" value={editingData!.diagnosis} onChange={(e) => setEditingData({ ...editingData!, diagnosis: e.target.value })} />
                      ) : (
                        <span className="value">{data.diagnosis}</span>
                      )}
                    </div>
                    <div className="emr-field">
                      <label>治法</label>
                      {isEditing ? (
                        <input className="editing-value" value={editingData!.treatmentPrinciple} onChange={(e) => setEditingData({ ...editingData!, treatmentPrinciple: e.target.value })} />
                      ) : (
                        <span className="value">{data.treatmentPrinciple}</span>
                      )}
                    </div>
                  </div>
                </div>

                <div className="emr-section">
                  <div className="emr-section-title">处方</div>
                  <div className="emr-field">
                    {isEditing ? (
                      <textarea className="editing-value" rows={2} value={editingData!.prescription} onChange={(e) => setEditingData({ ...editingData!, prescription: e.target.value })} />
                    ) : (
                      <span className="value" style={{ fontFamily: 'var(--font-family)', fontSize: 14, fontWeight: 500 }}>{data.prescription}</span>
                    )}
                  </div>
                </div>

                <div className="emr-section">
                  <div className="emr-section-title">医嘱</div>
                  <div className="emr-field">
                    {isEditing ? (
                      <textarea className="editing-value" rows={2} value={editingData!.notes} onChange={(e) => setEditingData({ ...editingData!, notes: e.target.value })} />
                    ) : (
                      <span className="value">{data.notes}</span>
                    )}
                  </div>
                </div>
              </div>
            ) : selectedPatient ? (
              /* Simplified patient info for other tabs */
              renderPatientInfoCard()
            ) : (
              <div className="card">
                <div className="empty-state" style={{ padding: '80px 20px' }}>
                  <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="1.5"><path d="M14 2H6a2 2 0 0 0-2 2v16a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V8z" /><polyline points="14 2 14 8 20 8" /><line x1="16" y1="13" x2="8" y2="13" /><line x1="16" y1="17" x2="8" y2="17" /></svg>
                  <p>请从左侧选择患者查看信息</p>
                </div>
              </div>
            )}
          </div>
        </div>
      )}
    </div>
  )
}
