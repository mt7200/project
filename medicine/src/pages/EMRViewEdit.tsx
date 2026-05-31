import { useState } from 'react'
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

const syndromeOptions = [
  '风寒束表证', '风热犯肺证', '肝郁气滞证', '肝郁血虚证',
  '肾阳虚证', '肾阴虚证', '脾虚湿盛证', '痰湿阻肺证',
  '肝阳上亢证', '气血两虚证', '瘀血阻络证',
]

export default function EMRViewEdit() {
  const [selectedId, setSelectedId] = useState<number | null>(null)
  const [isEditing, setIsEditing] = useState(false)
  const [editingData, setEditingData] = useState<EMR | null>(null)
  const [searchTerm, setSearchTerm] = useState('')

  const selectedEMR = mockEMRs.find((e) => e.id === selectedId) || null

  const filteredEMRs = mockEMRs.filter(
    (e) => e.name.includes(searchTerm) || e.diagnosis.includes(searchTerm)
  )

  const handleSelect = (emr: EMR) => {
    setSelectedId(emr.id)
    setIsEditing(false)
    setEditingData(null)
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

  return (
    <div className="page-container">
      <div className="page-header">
        <h1>电子病历查看 / 编辑</h1>
        <p>查看和编辑患者的四诊信息、辨证诊断及处方记录</p>
      </div>

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
            {filteredEMRs.map((emr) => (
              <div
                key={emr.id}
                className={`emr-list-item card ${selectedId === emr.id ? 'active' : ''}`}
                onClick={() => handleSelect(emr)}
              >
                <div className="emr-list-header">
                  <span className="emr-list-name">{emr.name}</span>
                  <span className="emr-list-date">{emr.visitDate}</span>
                </div>
                <div className="emr-list-meta">
                  {emr.gender} · {emr.age}岁 · {emr.diagnosis}
                </div>
              </div>
            ))}
          </div>
        </div>

        <div className="emr-editor-panel">
          {data ? (
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
          ) : (
            <div className="card">
              <div className="empty-state" style={{ padding: '80px 20px' }}>
                <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="1.5"><path d="M14 2H6a2 2 0 0 0-2 2v16a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V8z" /><polyline points="14 2 14 8 20 8" /><line x1="16" y1="13" x2="8" y2="13" /><line x1="16" y1="17" x2="8" y2="17" /></svg>
                <p>请从左侧选择患者病历查看或编辑</p>
              </div>
            </div>
          )}
        </div>
      </div>
    </div>
  )
}
