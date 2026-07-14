import { useState } from 'react'
import { useNavigate } from 'react-router-dom'
import './PrescriptionReview.css'

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

export default function PrescriptionReview() {
  const navigate = useNavigate()
  const [expandedId, setExpandedId] = useState<number | null>(null)
  const [selectedRx, setSelectedRx] = useState<Prescription | null>(null)
  const [filter, setFilter] = useState<string>('all')

  const toggleExpand = (id: number) => {
    setExpandedId(expandedId === id ? null : id)
  }

  const filteredPrescriptions = filter === 'all'
    ? prescriptions
    : prescriptions.filter((p) => p.status === filter)

  const stats = {
    total: prescriptions.length,
    pending: prescriptions.filter((p) => p.status === 'pending').length,
    approved: prescriptions.filter((p) => p.status === 'approved').length,
    highRisk: prescriptions.filter((p) => p.riskLevel === 'high').length,
  }

  return (
    <div className="page-container">
      <div className="page-header">
        <h1>处方审核与风险提示</h1>
        <p>智能审查处方合理性、药物配伍、剂量安全</p>
      </div>

      <div className="review-summary">
        <div className="card summary-stat">
          <div className="stat-icon blue">
            <svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2"><path d="M14 2H6a2 2 0 0 0-2 2v16a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V8z" /><polyline points="14 2 14 8 20 8" /></svg>
          </div>
          <div>
            <div className="stat-value">{stats.total}</div>
            <div className="stat-label">待审处方总数</div>
          </div>
        </div>
        <div className="card summary-stat">
          <div className="stat-icon orange">
            <svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2"><circle cx="12" cy="12" r="10" /><polyline points="12 6 12 12 16 14" /></svg>
          </div>
          <div>
            <div className="stat-value">{stats.pending}</div>
            <div className="stat-label">等待审核</div>
          </div>
        </div>
        <div className="card summary-stat">
          <div className="stat-icon green">
            <svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2"><path d="M9 11l3 3L22 4" /><path d="M21 12v7a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2h11" /></svg>
          </div>
          <div>
            <div className="stat-value">{stats.approved}</div>
            <div className="stat-label">已通过</div>
          </div>
        </div>
        <div className="card summary-stat">
          <div className="stat-icon red">
            <svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2"><path d="M10.29 3.86L1.82 18a2 2 0 0 0 1.71 3h16.94a2 2 0 0 0 1.71-3L13.71 3.86a2 2 0 0 0-3.42 0z" /><line x1="12" y1="9" x2="12" y2="13" /><line x1="12" y1="17" x2="12.01" y2="17" /></svg>
          </div>
          <div>
            <div className="stat-value">{stats.highRisk}</div>
            <div className="stat-label">高风险处方</div>
          </div>
        </div>
      </div>

      <div className="tabs">
        <button className={`tab ${filter === 'all' ? 'active' : ''}`} onClick={() => setFilter('all')}>全部</button>
        <button className={`tab ${filter === 'pending' ? 'active' : ''}`} onClick={() => setFilter('pending')}>待审核</button>
        <button className={`tab ${filter === 'approved' ? 'active' : ''}`} onClick={() => setFilter('approved')}>已通过</button>
        <button className={`tab ${filter === 'rejected' ? 'active' : ''}`} onClick={() => setFilter('rejected')}>已驳回</button>
      </div>

      <div className="review-layout">
        <div className="review-main">
          <div className="review-list-card">
            {filteredPrescriptions.map((rx) => (
              <div key={rx.id} className="card review-item" onClick={() => setSelectedRx(rx)}>
                <div className="review-item-header" onClick={() => toggleExpand(rx.id)}>
                  <div className="left">
                    <span className={`review-priority ${rx.riskLevel}`} />
                    <div>
                      <div className="review-patient">{rx.patientName} · {rx.patientGender} {rx.patientAge}岁</div>
                      <div className="review-prescription">{rx.diagnosis} / {rx.syndrome}</div>
                    </div>
                  </div>
                  <div className="right">
                    <span className={`tag ${rx.riskLevel === 'high' ? 'tag-red' : rx.riskLevel === 'medium' ? 'tag-yellow' : 'tag-green'}`}>
                      {rx.riskLevel === 'high' ? '高风险' : rx.riskLevel === 'medium' ? '中风险' : '低风险'} {rx.riskScore}
                    </span>
                    <span className={`review-status ${rx.status}`}>
                      {rx.status === 'pending' ? '待审核' : rx.status === 'approved' ? '已通过' : '已驳回'}
                    </span>
                    <span className={`review-chevron ${expandedId === rx.id ? 'open' : ''}`}>
                      <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2"><polyline points="6 9 12 15 18 9" /></svg>
                    </span>
                  </div>
                </div>
                {expandedId === rx.id && (
                  <div className="review-item-body">
                    <div className="review-body-section">
                      <h4>处方组成</h4>
                      <div className="review-herbs-tags">
                        {rx.herbs.map((h) => (
                          <span key={h} className="review-herb-tag">{h}</span>
                        ))}
                      </div>
                    </div>
                    {rx.risks.length > 0 && (
                      <div className="review-body-section">
                        <h4>风险项</h4>
                        <ul className="review-risk-list">
                          {rx.risks.map((r, i) => (
                            <li key={i} className="danger">{r}</li>
                          ))}
                        </ul>
                      </div>
                    )}
                    {rx.suggestions.length > 0 && (
                      <div className="review-body-section">
                        <h4>建议</h4>
                        <ul className="review-risk-list">
                          {rx.suggestions.map((s, i) => (
                            <li key={i} className="success">{s}</li>
                          ))}
                        </ul>
                      </div>
                    )}
                    <div className="review-actions">
                      {rx.status === 'pending' && (
                        <>
                          <button className="btn btn-ghost btn-sm">退回修改</button>
                          <button className="btn btn-danger btn-sm">驳回</button>
                          <button className="btn btn-primary btn-sm" onClick={() => navigate('/emr')}>审核通过</button>
                        </>
                      )}
                    </div>
                  </div>
                )}
              </div>
            ))}
          </div>
        </div>

        <div className="review-detail-sidebar">
          <div className="card">
            <div className="card-header">
              <h2>处方详情</h2>
            </div>
            <div className="card-body">
              {selectedRx ? (
                <>
                  <div className="detail-section">
                    <div className="detail-label">患者信息</div>
                    <div className="detail-row"><label>姓名</label><span>{selectedRx.patientName}</span></div>
                    <div className="detail-row"><label>性别 / 年龄</label><span>{selectedRx.patientGender} / {selectedRx.patientAge}岁</span></div>
                    <div className="detail-row"><label>诊断</label><span>{selectedRx.diagnosis}</span></div>
                    <div className="detail-row"><label>证型</label><span>{selectedRx.syndrome}</span></div>
                    <div className="detail-row"><label>提交时间</label><span>{selectedRx.date}</span></div>
                  </div>
                  <div className="detail-section">
                    <div className="detail-label">风险评估</div>
                    <div className="detail-row">
                      <label>总体风险等级</label>
                      <span className={`review-status ${selectedRx.riskLevel === 'high' ? 'rejected' : selectedRx.riskLevel === 'medium' ? 'pending' : 'approved'}`}>
                        {selectedRx.riskLevel === 'high' ? '高风险' : selectedRx.riskLevel === 'medium' ? '中风险' : '低风险'}
                      </span>
                    </div>
                    <div className="detail-row">
                      <label>风险评分</label>
                      <span>{selectedRx.riskScore} / 100</span>
                    </div>
                    <div className="risk-bar">
                      <div className={`risk-bar-fill ${selectedRx.riskLevel}`} style={{ width: `${selectedRx.riskScore}%` }} />
                    </div>
                  </div>
                  <div className="detail-section">
                    <div className="detail-label">审查项</div>
                    <div className="detail-row">
                      <label>配伍禁忌</label>
                      <span className={`tag ${selectedRx.compatibilityRisk ? 'tag-red' : 'tag-green'}`}>
                        {selectedRx.compatibilityRisk ? '异常' : '通过'}
                      </span>
                    </div>
                    <div className="detail-row">
                      <label>剂量合理性</label>
                      <span className={`tag ${selectedRx.dosageRisk ? 'tag-red' : 'tag-green'}`}>
                        {selectedRx.dosageRisk ? '异常' : '通过'}
                      </span>
                    </div>
                    <div className="detail-row">
                      <label>禁忌症审查</label>
                      <span className={`tag ${selectedRx.contraindicationRisk ? 'tag-yellow' : 'tag-green'}`}>
                        {selectedRx.contraindicationRisk ? '注意' : '通过'}
                      </span>
                    </div>
                  </div>
                </>
              ) : (
                <div className="empty-state" style={{ padding: '50px 20px' }}>
                  <p>点击左侧处方查看详情</p>
                </div>
              )}
            </div>
          </div>
        </div>
      </div>
    </div>
  )
}
