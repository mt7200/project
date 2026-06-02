import { useState, useMemo } from 'react'
import { Search, Plus, Printer } from 'lucide-react'
import { mockExecutionOrders } from '../../mock'
import type { ExecutionOrder } from '../../types'

const filterTabs = ['全部', '我的开单', '我的执行']

export default function ExecutionPage() {
  const [searchText, setSearchText] = useState('')
  const [filterTab, setFilterTab] = useState('全部')
  const [selectedId, setSelectedId] = useState<number | null>(1001)

  const filtered = useMemo(() => {
    return mockExecutionOrders.filter((r) => {
      if (searchText && !r.patient.name.includes(searchText)) return false
      return true
    })
  }, [searchText])

  const selected = mockExecutionOrders.find((r) => r.id === selectedId)

  return (
    <div className="flex h-full">
      {/* Left Panel - Execution Orders List */}
      <div className="w-72 bg-white border-r border-[#E5E6E8] shrink-0 flex flex-col">
        <div className="p-3 border-b border-[#E5E6E8]">
          <div className="flex items-center gap-2">
            <div className="flex-1 relative">
              <Search size={14} className="absolute left-2.5 top-1/2 -translate-y-1/2 text-[#86909C]" />
              <input className="input-search pl-8" placeholder="搜索执行单" value={searchText} onChange={(e) => setSearchText(e.target.value)} />
            </div>
            <button className="btn-primary whitespace-nowrap"><Plus size={14} /> 开单</button>
          </div>
        </div>
        <div className="px-3 py-2 border-b border-[#E5E6E8] flex items-center gap-2">
          {filterTabs.map((t) => (
            <button
              key={t}
              className={`text-sm px-3 py-1 rounded ${filterTab === t ? 'bg-[#165DFF] text-white' : 'text-[#4E5969] hover:bg-[#F2F3F5]'}`}
              onClick={() => setFilterTab(t)}
            >
              {t}
            </button>
          ))}
          <button className="ml-auto btn-ghost p-1">
            <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2"><line x1="4" y1="21" x2="4" y2="14"/><line x1="4" y1="10" x2="4" y2="3"/><line x1="12" y1="21" x2="12" y2="12"/><line x1="12" y1="8" x2="12" y2="3"/><line x1="20" y1="21" x2="20" y2="16"/><line x1="20" y1="12" x2="20" y2="3"/><line x1="1" y1="14" x2="7" y2="14"/><line x1="9" y1="8" x2="15" y2="8"/><line x1="17" y1="16" x2="23" y2="16"/></svg>
          </button>
        </div>
        <div className="flex-1 overflow-y-auto scrollbar-thin">
          {filtered.map((order) => (
            <div
              key={order.id}
              className={`px-3 py-3 border-b border-[#E5E6E8] cursor-pointer hover:bg-[#F7F8FA] ${
                selectedId === order.id ? 'bg-[#E8F3FF]' : ''
              }`}
              onClick={() => setSelectedId(order.id)}
            >
              <div className="flex items-center justify-between mb-1">
                <span className="text-sm font-medium text-[#1D2129]">{order.patient.name}</span>
                <span className="text-xs text-[#00B42A] border border-[#00B42A] rounded px-1.5 py-0.5">{order.status}</span>
              </div>
              <div className="text-xs text-[#86909C] mb-0.5">{order.diagnosis}</div>
              <div className="text-xs text-[#86909C]">{order.createTime}</div>
            </div>
          ))}
        </div>
        <div className="p-3 border-t border-[#E5E6E8] space-y-1">
          <button className="btn-ghost text-xs w-full justify-start">执行看板</button>
          <button className="btn-ghost text-xs w-full justify-start">执行情况一览</button>
        </div>
      </div>

      {/* Main Content */}
      <div className="flex-1 flex flex-col overflow-hidden">
        {selected ? (
          <>
            {/* Top Bar */}
            <div className="bg-white border-b border-[#E5E6E8] px-4 py-2.5 flex items-center justify-between">
              <span className="text-sm font-medium text-[#1D2129]">医嘱执行</span>
              <button className="btn-secondary text-xs"><Printer size={14} /> 打印</button>
            </div>

            {/* Patient Info Bar */}
            <div className="bg-white border-b border-[#E5E6E8] px-4 py-2.5 flex items-center gap-4 text-xs">
              <div className="flex items-center gap-2">
                <div className="w-7 h-7 rounded-full bg-[#E8F3FF] flex items-center justify-center text-sm text-[#165DFF] font-bold">
                  {selected.patient.name[0]}
                </div>
                <div>
                  <span className="text-sm font-medium">{selected.patient.name}</span>
                  <span className="text-[#86909C] ml-2">{selected.patient.gender} · {selected.patient.age}岁</span>
                  <span className="text-[#86909C] ml-2">{selected.patient.phone}</span>
                </div>
              </div>
            </div>

            {/* Content Area */}
            <div className="flex-1 overflow-y-auto p-4 space-y-4">
              {/* Diagnosis Info Table */}
              <div className="card-panel">
                <table className="w-full">
                  <thead>
                    <tr>
                      <th className="table-header">诊断</th>
                      <th className="table-header w-24">医生</th>
                      <th className="table-header w-28">时间</th>
                      <th className="table-header w-20">金额</th>
                      <th className="table-header w-20">实收</th>
                      <th className="table-header w-20">状态</th>
                    </tr>
                  </thead>
                  <tbody>
                    <tr className="table-row">
                      <td className="table-cell font-medium">{selected.diagnosis}</td>
                      <td className="table-cell text-[#86909C]">{selected.doctor.name}</td>
                      <td className="table-cell text-[#86909C]">{selected.createTime}</td>
                      <td className="table-cell">¥{selected.chargeAmount}</td>
                      <td className="table-cell">¥{selected.chargeAmount}</td>
                      <td className="table-cell">
                        <span className="text-xs text-[#00B42A] border border-[#00B42A] rounded px-1.5 py-0.5">
                          {selected.status}
                        </span>
                      </td>
                    </tr>
                  </tbody>
                </table>
              </div>

              {/* Prescription Tables */}
              {selected.prescriptions.map((rx) => (
                <div key={rx.id} className="card-panel">
                  <div className="card-header">
                    <span className="text-xs font-medium text-[#00B42A] border border-[#00B42A] rounded px-1.5 py-0.5">
                      {rx.type === '成药处方' ? '已收费' : rx.type === '中药处方' ? '已收费' : '已收费'}
                    </span>
                    <span className="text-sm font-medium">{rx.type} · {rx.name}</span>
                    <span className="text-xs text-[#86909C] ml-auto">执行进度：{rx.progress}</span>
                  </div>
                  {rx.type === '中药处方' && rx.items ? (
                    <div>
                      <table className="w-full">
                        <thead>
                          <tr>
                            <th className="table-header w-16">序号</th>
                            <th className="table-header">药名</th>
                            <th className="table-header w-24">用量</th>
                          </tr>
                        </thead>
                        <tbody>
                          {rx.items.map((item, i) => (
                            <tr key={i} className="table-row">
                              <td className="table-cell text-center text-[#86909C]">{i + 1}</td>
                              <td className="table-cell font-medium">{item.name}</td>
                              <td className="table-cell">{item.dosage}</td>
                            </tr>
                          ))}
                        </tbody>
                      </table>
                      <div className="px-3 py-2 text-xs text-[#86909C] border-t border-[#E5E6E8]">
                        每剂用量 · {rx.dosage} · {rx.frequency}
                      </div>
                    </div>
                  ) : (
                    <table className="w-full">
                      <thead>
                        <tr>
                          <th className="table-header">处方</th>
                          <th className="table-header w-20">用法</th>
                          <th className="table-header w-20">频率</th>
                          <th className="table-header w-20">剂量</th>
                          <th className="table-header w-16">天数</th>
                          <th className="table-header w-16">总量</th>
                          <th className="table-header w-20">执行进度</th>
                        </tr>
                      </thead>
                      <tbody>
                        <tr className="table-row">
                          <td className="table-cell font-medium">{rx.name}</td>
                          <td className="table-cell text-[#86909C]">{rx.usage}</td>
                          <td className="table-cell text-[#86909C]">{rx.frequency}</td>
                          <td className="table-cell">{rx.dosage}</td>
                          <td className="table-cell text-center">{rx.days}天</td>
                          <td className="table-cell text-center">{rx.total}</td>
                          <td className="table-cell">{rx.progress}</td>
                        </tr>
                      </tbody>
                    </table>
                  )}
                </div>
              ))}
            </div>
          </>
        ) : (
          <div className="flex-1 flex items-center justify-center text-sm text-[#86909C]">请选择执行单</div>
        )}
      </div>

      {/* Right Panel - Execution History Timeline */}
      <div className="w-72 bg-white border-l border-[#E5E6E8] shrink-0 flex flex-col">
        <div className="px-4 py-3 border-b border-[#E5E6E8]">
          <span className="text-sm font-medium text-[#1D2129]">执行历史</span>
        </div>
        {selected ? (
          <div className="flex-1 overflow-y-auto scrollbar-thin p-4">
            <div className="relative">
              <div className="absolute left-[5px] top-2 bottom-2 w-0.5 bg-[#E5E6E8]" />
              <div className="space-y-5">
                {selected.history.map((h) => (
                  <div key={h.id} className="relative pl-6">
                    <div className="absolute left-0 top-1 w-[11px] h-[11px] rounded-full bg-[#FF7D00] border-2 border-white shadow" />
                    <div className="text-xs text-[#1D2129] font-medium">{h.time}</div>
                    <div className="text-xs text-[#86909C] mt-0.5">{h.action}</div>
                    <div className="text-[10px] text-[#C9CDD4] mt-0.5">
                      开单人：{h.operator} · 登记人：{h.registrar}
                    </div>
                  </div>
                ))}
              </div>
            </div>
          </div>
        ) : (
          <div className="flex-1 flex items-center justify-center text-xs text-[#86909C]">请选择执行单</div>
        )}
      </div>
    </div>
  )
}
