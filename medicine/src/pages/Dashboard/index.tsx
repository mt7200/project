import { ChevronRight, Search, AlertTriangle } from 'lucide-react'
import { mockNotifications, mockDailyStats, currentDoctor } from '../../mock'

export default function DashboardPage() {
  const now = new Date()
  const dateStr = `${now.getFullYear()}-${String(now.getMonth() + 1).padStart(2, '0')}-${String(now.getDate()).padStart(2, '0')}`
  const weekDays = ['日', '一', '二', '三', '四', '五', '六']
  const weekDay = weekDays[now.getDay()]

  const tableHeaders = ['患者', '预约', '预计就诊', '登记时间', '科室', '初复诊', '医生', '就诊', '收费', '发药', '治疗', '理疗']

  return (
    <div className="p-5 space-y-5">
      <div className="card-panel">
        <div className="p-4 border-b border-[#E5E6E8]">
          <div className="flex items-center justify-between">
            <div>
              <span className="text-base text-[#86909C]">下午好，</span>
              <span className="text-lg font-medium text-[#1D2129]">{currentDoctor.name}</span>
            </div>
            <div className="text-sm text-[#86909C]">{dateStr} 星期{weekDay}</div>
          </div>
        </div>
        <div className="divide-y divide-[#E5E6E8]">
          {mockNotifications.slice(0, 3).map((n) => (
            <div key={n.id} className="flex items-center gap-3 px-4 py-2.5 hover:bg-[#F7F8FA] cursor-pointer">
              <div className={`w-2 h-2 rounded-full shrink-0 ${n.read ? 'bg-transparent' : 'bg-[#165DFF]'}`} />
              <span className="text-sm text-[#1D2129] flex-1">{n.title}</span>
              <span className="text-xs text-[#86909C]">{n.date}</span>
              <ChevronRight size={14} className="text-[#C9CDD4]" />
            </div>
          ))}
          <div className="px-4 py-2 text-right">
            <button className="text-xs text-[#165DFF] hover:underline">显示全部</button>
          </div>
        </div>
      </div>

      <div className="card-panel">
        <div className="p-4 border-b border-[#E5E6E8] flex items-center justify-between">
          <button className="btn-primary">今日工作汇总</button>
        </div>
        <div className="p-4">
          <div className="flex gap-3 mb-3">
            {mockDailyStats.map((stat) => (
              <div key={stat.label} className="flex-1 bg-[#F7F8FA] rounded p-3 text-center">
                <div className={`text-2xl font-bold ${stat.type === 'warning' ? 'text-[#FF7D00]' : 'text-[#165DFF]'}`}>
                  {stat.value}
                </div>
                <div className="text-xs text-[#86909C] mt-1">{stat.label}</div>
              </div>
            ))}
          </div>
          <div className="flex items-center gap-2 mt-3 p-3 bg-[#FFF3E8] rounded">
            <AlertTriangle size={16} className="text-[#FF7D00]" />
            <span className="text-sm text-[#FF7D00] flex-1">未贯标提醒</span>
            <span className="text-lg font-bold text-[#FF7D00]">23</span>
          </div>
        </div>
      </div>

      <div className="card-panel">
        <div className="p-4 border-b border-[#E5E6E8]">
          <div className="w-72">
            <div className="relative">
              <Search size={14} className="absolute left-2.5 top-1/2 -translate-y-1/2 text-[#86909C]" />
              <input className="input-search pl-8" placeholder="搜索患者..." />
            </div>
          </div>
        </div>
        <div className="overflow-x-auto">
          <table className="w-full">
            <thead>
              <tr>
                {tableHeaders.map((h) => (
                  <th key={h} className="table-header whitespace-nowrap">{h}</th>
                ))}
              </tr>
            </thead>
            <tbody>
              <tr>
                <td colSpan={12} className="text-center py-16 text-[#86909C]">
                  <div className="flex flex-col items-center gap-2">
                    <Search size={40} className="text-[#C9CDD4]" />
                    <span className="text-sm">今日暂无患者</span>
                  </div>
                </td>
              </tr>
            </tbody>
          </table>
        </div>
      </div>
    </div>
  )
}
