import { useState, useMemo } from 'react'
import './HistoryRecords.css'

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

export default function HistoryRecords() {
  const [searchText, setSearchText] = useState('')
  const [filterDate, setFilterDate] = useState('')
  const [filterResult, setFilterResult] = useState('')
  const [selectedRecord, setSelectedRecord] = useState<HistoryRecord | null>(null)

  const filteredRecords = useMemo(() => {
    return historyRecords.filter((r) => {
      if (searchText && !r.patientName.includes(searchText) && !r.diagnosis.includes(searchText)) return false
      if (filterDate && !r.visitDate.includes(filterDate)) return false
      if (filterResult && r.treatmentResult !== filterResult) return false
      return true
    })
  }, [searchText, filterDate, filterResult])

  const statSummary = useMemo(() => {
    const results = historyRecords.map((r) => r.treatmentResult)
    return {
      total: results.length,
      cured: results.filter((r) => r === '痊愈').length,
      improved: results.filter((r) => r === '显效' || r === '好转').length,
    }
  }, [])

  return (
    <div className="page-container">
      <div className="page-header">
        <h1>历史诊疗记录</h1>
        <p>查看所有患者的历史诊疗记录，支持筛选和详情查看</p>
      </div>

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
                value={searchText}
                onChange={(e) => setSearchText(e.target.value)}
              />
            </div>
            <div className="filter-item">
              <input
                className="form-input"
                type="month"
                value={filterDate}
                onChange={(e) => setFilterDate(e.target.value)}
              />
            </div>
            <div className="filter-item">
              <select
                className="form-select"
                value={filterResult}
                onChange={(e) => setFilterResult(e.target.value)}
              >
                <option value="">全部疗效</option>
                <option value="痊愈">痊愈</option>
                <option value="显效">显效</option>
                <option value="好转">好转</option>
              </select>
            </div>
            {(searchText || filterDate || filterResult) && (
              <button className="btn btn-ghost btn-sm" onClick={() => { setSearchText(''); setFilterDate(''); setFilterResult('') }}>
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
                  {filteredRecords.map((r) => (
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
    </div>
  )
}
