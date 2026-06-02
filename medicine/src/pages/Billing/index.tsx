import { useState, useMemo } from 'react'
import { Search, ChevronLeft, ChevronRight, Printer, Settings, Download, FileText, Plus, CheckCircle } from 'lucide-react'
import { mockBillingRecords } from '../../mock'
import type { BillingRecord } from '../../types'

const statusTabs = ['待收', '挂单']

export default function BillingPage() {
  const [searchText, setSearchText] = useState('')
  const [statusFilter, setStatusFilter] = useState('待收')
  const [selectedId, setSelectedId] = useState<number | null>(1)
  const [page, setPage] = useState(1)
  const [pageSize] = useState(10)

  const filtered = useMemo(() => {
    return mockBillingRecords.filter((r) => {
      if (searchText && !r.patient.name.includes(searchText)) return false
      if (statusFilter === '待收' && r.status !== '待收') return false
      if (statusFilter === '挂单' && r.status !== '已收') return false
      return true
    })
  }, [searchText, statusFilter])

  const selected = mockBillingRecords.find((r) => r.id === selectedId)

  return (
    <div className="flex h-full">
      {/* Left Panel */}
      <div className="w-72 bg-white border-r border-[#E5E6E8] shrink-0 flex flex-col">
        <div className="p-3 border-b border-[#E5E6E8]">
          <div className="flex items-center gap-2">
            <div className="flex-1 relative">
              <Search size={14} className="absolute left-2.5 top-1/2 -translate-y-1/2 text-[#86909C]" />
              <input className="input-search pl-8" placeholder="搜索收费单" value={searchText} onChange={(e) => setSearchText(e.target.value)} />
            </div>
            <button className="btn-primary whitespace-nowrap"><Plus size={14} /> 收费</button>
          </div>
        </div>
        <div className="px-3 py-2 border-b border-[#E5E6E8] flex items-center gap-2">
          {statusTabs.map((t) => (
            <button
              key={t}
              className={`text-sm px-3 py-1 rounded ${statusFilter === t ? 'bg-[#165DFF] text-white' : 'text-[#4E5969] hover:bg-[#F2F3F5]'}`}
              onClick={() => setStatusFilter(t)}
            >
              {t}
            </button>
          ))}
          <button className="ml-auto btn-ghost p-1"><Settings size={14} /></button>
        </div>
        <div className="flex-1 overflow-y-auto scrollbar-thin">
          {filtered.map((record) => (
            <div
              key={record.id}
              className={`px-3 py-3 border-b border-[#E5E6E8] cursor-pointer hover:bg-[#F7F8FA] ${
                selectedId === record.id ? 'bg-[#E8F3FF]' : ''
              }`}
              onClick={() => setSelectedId(record.id)}
            >
              <div className="flex items-center justify-between mb-1">
                <span className="text-sm font-medium text-[#1D2129]">{record.patient.name}</span>
                <span className={`tag-${record.status === '已收' ? 'blue' : 'gray'}`}>{record.status}</span>
              </div>
              <div className="text-xs text-[#86909C]">¥{record.totalAmount} · {record.createTime}</div>
            </div>
          ))}
        </div>
        <div className="p-3 border-t border-[#E5E6E8] space-y-1">
          <button className="btn-ghost text-xs w-full justify-start">空中药房</button>
          <button className="btn-ghost text-xs w-full justify-start">收费看板</button>
          <button className="btn-ghost text-xs w-full justify-start">导出快递名单</button>
          <button className="btn-ghost text-xs w-full justify-start">开票记录</button>
        </div>
      </div>

      {/* Main Content */}
      <div className="flex-1 flex flex-col overflow-hidden">
        {selected ? (
          <>
            <div className="bg-yellow-50 border-b border-yellow-100 px-4 py-2 flex items-center gap-2">
              <CheckCircle size={16} className="text-[#00B42A]" />
              <span className="text-sm font-medium text-[#00B42A]">已收费</span>
              <span className="text-lg font-bold text-[#1D2129] ml-4">¥{selected.actualAmount}</span>
              <div className="ml-auto flex gap-2">
                <button className="btn-secondary text-xs">退费</button>
                <button className="btn-secondary text-xs">追溯码</button>
                <button className="btn-secondary text-xs">开票</button>
                <button className="btn-secondary text-xs"><Printer size={14} /> 打印</button>
                <button className="btn-secondary text-xs"><Settings size={14} /></button>
              </div>
            </div>

            <div className="bg-white border-b border-[#E5E6E8] px-4 py-2 flex items-center gap-4 text-xs">
              <div className="flex items-center gap-2">
                <span className="text-[#86909C]">患者：</span>
                <span className="font-medium">{selected.patient.name}</span>
                <span className="text-[#86909C]">{selected.patient.gender} · {selected.patient.age}岁</span>
                <span className="text-[#86909C]">{selected.patient.phone}</span>
              </div>
              <span className="text-[#86909C]">|</span>
              <span className="text-[#86909C]">医生：{selected.doctor.name}</span>
              <span className="text-[#86909C]">|</span>
              <span className="text-[#86909C]">挂号费：¥20.00</span>
              <span className="text-[#86909C]">|</span>
              <span className="text-[#86909C]">付费类型：{selected.paymentMethod || '医保'}</span>
            </div>

            <div className="flex-1 overflow-y-auto p-4">
              <table className="w-full">
                <thead>
                  <tr>
                    <th className="table-header w-10"><input type="checkbox" /></th>
                    <th className="table-header">收费项目</th>
                    <th className="table-header w-20">单价</th>
                    <th className="table-header w-16">数量</th>
                    <th className="table-header w-16">单位</th>
                    <th className="table-header w-20">金额</th>
                    <th className="table-header w-24">备注</th>
                  </tr>
                </thead>
                <tbody>
                  {selected.items.map((item, i) => (
                    <tr key={i} className="table-row">
                      <td className="table-cell text-center"><input type="checkbox" /></td>
                      <td className="table-cell">{item.name}</td>
                      <td className="table-cell">¥{item.unitPrice}</td>
                      <td className="table-cell text-center">{item.quantity}</td>
                      <td className="table-cell text-center">{item.unit}</td>
                      <td className="table-cell font-medium">¥{item.amount}</td>
                      <td className="table-cell text-[#86909C]">{item.remark || '—'}</td>
                    </tr>
                  ))}
                </tbody>
              </table>

              <div className="mt-4 flex items-center gap-4 text-sm">
                <div className="flex items-center gap-2">
                  <span className="text-[#86909C]">议价：</span>
                  <input className="w-20 border border-[#E5E6E8] rounded px-2 py-1 text-sm text-center" defaultValue={selected.discount > 0 ? `-${selected.discount}` : '0'} />
                </div>
                <div className="flex items-center gap-2">
                  <span className="text-[#86909C]">抹零：</span>
                  <input className="w-20 border border-[#E5E6E8] rounded px-2 py-1 text-sm text-center" defaultValue="0" />
                </div>
                <span className="text-[#86909C]">就诊时间：{selected.createTime}</span>
              </div>
            </div>
          </>
        ) : (
          <div className="flex-1 flex items-center justify-center text-sm text-[#86909C]">请选择收费单</div>
        )}
      </div>

      {/* Right - Payment Details */}
      <div className="w-80 bg-white border-l border-[#E5E6E8] shrink-0">
        {selected ? (
          <div className="p-4">
            <div className="text-sm font-medium text-[#1D2129] mb-4">收费详情</div>
            <div className="space-y-2.5 text-sm">
              <div className="flex justify-between">
                <span className="text-[#86909C]">开单时间</span>
                <span>{selected.createTime}</span>
              </div>
              <div className="flex justify-between">
                <span className="text-[#86909C]">完成时间</span>
                <span>{selected.completeTime || '—'}</span>
              </div>
              <div className="flex justify-between">
                <span className="text-[#86909C]">收费员</span>
                <span>{selected.cashier}</span>
              </div>
              <div className="border-t border-[#E5E6E8] pt-2 mt-2">
                <div className="flex justify-between">
                  <span className="text-[#86909C]">原价</span>
                  <span>¥{selected.totalAmount}</span>
                </div>
                <div className="flex justify-between">
                  <span className="text-[#86909C]">单项议价</span>
                  <span className="text-[#00B42A]">-¥{selected.discount > 0 ? selected.discount : 0}</span>
                </div>
                <div className="flex justify-between">
                  <span className="text-[#86909C]">优惠</span>
                  <span>¥0.00</span>
                </div>
                <div className="flex justify-between">
                  <span className="text-[#86909C]">议价 (加价)</span>
                  <span>¥0.00</span>
                </div>
                <div className="flex justify-between text-base font-bold mt-2 pt-2 border-t border-[#E5E6E8]">
                  <span>应收</span>
                  <span className="text-[#F53F3F]">¥{selected.actualAmount}</span>
                </div>
                <div className="flex justify-between">
                  <span className="text-[#86909C]">实收</span>
                  <span>¥{selected.actualAmount}</span>
                </div>
                <div className="flex justify-between">
                  <span className="text-[#86909C]">支付方式</span>
                  <span className="font-medium">{selected.paymentMethod || '—'}</span>
                </div>
              </div>
              <div className="border-t border-[#E5E6E8] pt-2 mt-2">
                <div className="flex justify-between">
                  <span className="text-[#86909C]">发票状态</span>
                  <span className={`tag-${selected.invoiceStatus === '已开票' ? 'blue' : 'gray'}`}>
                    {selected.invoiceStatus || '未开票'}
                  </span>
                </div>
                <button className="text-xs text-[#165DFF] mt-2 hover:underline flex items-center gap-1">
                  <ChevronRight size={12} /> 展开交易明细
                </button>
              </div>
            </div>
          </div>
        ) : (
          <div className="p-4 text-center text-xs text-[#86909C]">选择收费单查看详情</div>
        )}
      </div>
    </div>
  )
}
