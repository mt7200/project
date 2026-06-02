import { useState, useMemo } from 'react'
import { ChevronLeft, ChevronRight, Search, Settings, Download, LayoutGrid, List } from 'lucide-react'
import { mockRegistrations, mockDoctors } from '../../mock'
import type { RegistrationRecord } from '../../types'

const statusTabs = ['全部', '已诊', '待诊', '已退']

export default function RegistrationPage() {
  const [currentDate, setCurrentDate] = useState(new Date(2026, 5, 1))
  const [searchText, setSearchText] = useState('')
  const [statusFilter, setStatusFilter] = useState('全部')
  const [departmentFilter, setDepartmentFilter] = useState('')
  const [viewMode, setViewMode] = useState<'list' | 'board'>('list')
  const [page, setPage] = useState(1)
  const [pageSize, setPageSize] = useState(10)

  const year = currentDate.getFullYear()
  const month = currentDate.getMonth() + 1

  const filtered = useMemo(() => {
    return mockRegistrations.filter((r) => {
      if (searchText && !r.patient.name.includes(searchText) && !r.patient.phone.includes(searchText)) return false
      if (statusFilter !== '全部' && r.status !== statusFilter) return false
      if (departmentFilter && r.department !== departmentFilter) return false
      return true
    })
  }, [searchText, statusFilter, departmentFilter])

  const paginated = filtered.slice((page - 1) * pageSize, page * pageSize)
  const totalPages = Math.ceil(filtered.length / pageSize)

  const totalFee = filtered.reduce((sum, r) => sum + r.fee, 0)

  const calendarDays = useMemo(() => {
    const firstDay = new Date(year, month - 1, 1)
    const lastDay = new Date(year, month, 0)
    const days: { date: number; isToday: boolean }[] = []
    for (let d = 1; d <= lastDay.getDate(); d++) {
      days.push({ date: d, isToday: d === 1 })
    }
    return days
  }, [year, month])

  const weekHeaders = ['一', '二', '三', '四', '五', '六', '日']

  return (
    <div className="flex h-full">
      <div className="w-[340px] bg-white border-r border-[#E5E6E8] shrink-0 flex flex-col">
        <div className="p-4">
          <div className="flex items-center justify-between mb-4">
            <button className="btn-ghost p-1" onClick={() => setCurrentDate(new Date(year, month - 2, 1))}>
              <ChevronLeft size={16} />
            </button>
            <span className="text-sm font-medium">{year}-{String(month).padStart(2, '0')}</span>
            <button className="btn-ghost p-1" onClick={() => setCurrentDate(new Date(year, month, 1))}>
              <ChevronRight size={16} />
            </button>
          </div>
          <div className="grid grid-cols-7 gap-0 mb-2">
            {weekHeaders.map((w) => (
              <div key={w} className="text-center text-xs text-[#86909C] py-1">{w}</div>
            ))}
          </div>
          <div className="grid grid-cols-7 gap-0">
            {calendarDays.map((d) => (
              <div
                key={d.date}
                className={`text-center py-1.5 text-sm cursor-pointer rounded hover:bg-[#F2F3F5] ${
                  d.isToday ? 'bg-[#165DFF] text-white hover:bg-[#165DFF]' : ''
                }`}
              >
                {d.date}
              </div>
            ))}
          </div>
        </div>
        <div className="flex-1 border-t border-[#E5E6E8] overflow-y-auto scrollbar-thin">
          {mockDoctors.map((doc) => (
            <div key={doc.id} className="flex items-center gap-3 px-4 py-3 hover:bg-[#F7F8FA] cursor-pointer border-b border-[#E5E6E8]">
              <div className="w-10 h-10 rounded-full bg-[#E8F3FF] flex items-center justify-center text-sm text-[#165DFF] font-bold">
                {doc.name[0]}
              </div>
              <div className="flex-1 min-w-0">
                <div className="text-sm font-medium text-[#1D2129]">{doc.name}</div>
                <div className="text-xs text-[#86909C]">{doc.title}</div>
              </div>
              <div className="text-right text-xs text-[#86909C]">
                <div>挂号 {doc.registrationCount}</div>
                <div className="text-[#FF7D00]">待诊 {doc.pendingCount}</div>
              </div>
              <button className="btn-primary text-xs px-3 py-1">挂号</button>
            </div>
          ))}
        </div>
        <div className="p-3 border-t border-[#E5E6E8] flex gap-2">
          <button className="btn-ghost text-xs flex-1 justify-center py-2">挂号看板</button>
          <button className="btn-ghost text-xs flex-1 justify-center py-2">挂号工作汇总</button>
        </div>
      </div>

      <div className="flex-1 flex flex-col overflow-hidden">
        <div className="p-4 bg-white border-b border-[#E5E6E8]">
          <div className="flex items-center justify-between mb-3">
            <div className="flex items-center gap-3">
              <div className="flex items-center gap-1">
                <button className="btn-ghost p-1"><ChevronLeft size={14} /></button>
                <span className="text-sm font-medium">{year}年{String(month).padStart(2, '0')}月01日</span>
                <button className="btn-ghost p-1"><ChevronRight size={14} /></button>
              </div>
              <div className="w-48">
                <div className="relative">
                  <Search size={14} className="absolute left-2.5 top-1/2 -translate-y-1/2 text-[#86909C]" />
                  <input
                    className="input-search pl-8"
                    placeholder="姓名 / 手机号"
                    value={searchText}
                    onChange={(e) => setSearchText(e.target.value)}
                  />
                </div>
              </div>
              <div className="flex bg-[#F2F3F5] rounded p-0.5">
                <button
                  className={`p-1.5 rounded ${viewMode === 'list' ? 'bg-white shadow-sm' : ''}`}
                  onClick={() => setViewMode('list')}
                >
                  <List size={14} />
                </button>
                <button
                  className={`p-1.5 rounded ${viewMode === 'board' ? 'bg-white shadow-sm' : ''}`}
                  onClick={() => setViewMode('board')}
                >
                  <LayoutGrid size={14} />
                </button>
              </div>
            </div>
            <div className="flex items-center gap-2">
              <button className="btn-ghost p-1.5"><Settings size={14} /></button>
              <button className="btn-ghost p-1.5"><Download size={14} /></button>
            </div>
          </div>
          <div className="flex items-center gap-3">
            {statusTabs.map((tab) => (
              <button
                key={tab}
                className={`text-sm px-3 py-1 rounded transition-colors ${
                  statusFilter === tab ? 'bg-[#165DFF] text-white' : 'text-[#4E5969] hover:bg-[#F2F3F5]'
                }`}
                onClick={() => { setStatusFilter(tab); setPage(1) }}
              >
                {tab}
              </button>
            ))}
            <div className="ml-auto w-32">
              <select
                className="input-search text-xs"
                value={departmentFilter}
                onChange={(e) => { setDepartmentFilter(e.target.value); setPage(1) }}
              >
                <option value="">全部科室</option>
                <option value="中医内科">中医内科</option>
                <option value="中医外科">中医外科</option>
                <option value="针灸科">针灸科</option>
                <option value="中医妇科">中医妇科</option>
              </select>
            </div>
          </div>
        </div>
        <div className="flex-1 overflow-auto bg-white">
          <table className="w-full">
            <thead>
              <tr>
                {['患者', '性别', '手机', '标签', '渠道', '状态', '挂号费', '科室', '医生', '初复诊', '预计就诊时间', '就诊备注'].map((h) => (
                  <th key={h} className="table-header whitespace-nowrap">{h}</th>
                ))}
              </tr>
            </thead>
            <tbody>
              {paginated.map((r: RegistrationRecord) => (
                <tr key={r.id} className="table-row">
                  <td className="table-cell font-medium">{r.patient.name}</td>
                  <td className="table-cell">{r.patient.gender}</td>
                  <td className="table-cell text-[#86909C]">{r.patient.phone}</td>
                  <td className="table-cell">—</td>
                  <td className="table-cell text-[#86909C]">{r.channel}</td>
                  <td className="table-cell">
                    <span className={`tag-${r.status === '已诊' ? 'gray' : r.status === '待诊' ? 'blue' : 'red'}`}>
                      {r.status}
                    </span>
                  </td>
                  <td className="table-cell">¥{r.fee}</td>
                  <td className="table-cell text-[#86909C]">{r.department}</td>
                  <td className="table-cell">{r.doctor.name}</td>
                  <td className="table-cell">
                    <span className={`tag-${r.visitType === '初诊' ? 'green' : 'blue'}`}>{r.visitType}</span>
                  </td>
                  <td className="table-cell text-[#86909C]">{r.expectedTime}</td>
                  <td className="table-cell text-[#86909C]">{r.remark || '—'}</td>
                </tr>
              ))}
            </tbody>
          </table>
          {paginated.length === 0 && (
            <div className="text-center py-16 text-[#86909C] text-sm">暂无数据</div>
          )}
        </div>
        <div className="px-4 py-2.5 bg-white border-t border-[#E5E6E8] flex items-center justify-between text-xs text-[#86909C]">
          <div className="flex items-center gap-4">
            <span>全部 {filtered.length} 条</span>
            <span>挂号费实收：¥{totalFee}.00</span>
          </div>
          <div className="flex items-center gap-3">
            <span>每页</span>
            <select className="border border-[#E5E6E8] rounded px-2 py-1 text-xs" value={pageSize} onChange={(e) => { setPageSize(Number(e.target.value)); setPage(1) }}>
              <option value={10}>10</option>
              <option value={20}>20</option>
              <option value={50}>50</option>
            </select>
            <span>条</span>
            <div className="flex items-center gap-1">
              <button className="btn-ghost p-1" disabled={page <= 1} onClick={() => setPage(page - 1)}><ChevronLeft size={14} /></button>
              <span className="px-2">{page}/{totalPages}</span>
              <button className="btn-ghost p-1" disabled={page >= totalPages} onClick={() => setPage(page + 1)}><ChevronRight size={14} /></button>
            </div>
          </div>
        </div>
      </div>
    </div>
  )
}
