import { useState } from 'react'
import { Search, Mic, FileText, Plus, RotateCcw, Brain } from 'lucide-react'
import { mockOutpatientRecords, mockDoctors } from '../../mock'
import type { OutpatientRecord } from '../../types'

const scriptTabs = ['检查', '检验', '治疗', '耗材', '商品', '套餐', '其他']
const prescriptionTabs = ['成药处方', '输注处方', '中药处方', '外治处方', 'AI识方', '模板']
const rightTabs = ['历史', '报告', '影像', 'AI诊疗']

export default function OutpatientPage() {
  const [selectedId, setSelectedId] = useState<number | null>(1)
  const [scriptTab, setScriptTab] = useState('检查')
  const [prescriptionTab, setPrescriptionTab] = useState('中药处方')
  const [rightTab, setRightTab] = useState('历史')

  const selected = mockOutpatientRecords.find((r) => r.id === selectedId)

  return (
    <div className="flex h-full">
      {/* Left Panel - Patient List */}
      <div className="w-72 bg-white border-r border-[#E5E6E8] shrink-0 flex flex-col">
        <div className="p-3 border-b border-[#E5E6E8]">
          <div className="flex items-center gap-2">
            <div className="flex-1 relative">
              <Search size={14} className="absolute left-2.5 top-1/2 -translate-y-1/2 text-[#86909C]" />
              <input className="input-search pl-8" placeholder="搜索门诊单" />
            </div>
            <button className="btn-primary whitespace-nowrap">+ 接诊</button>
          </div>
        </div>
        <div className="px-3 py-2 border-b border-[#E5E6E8] flex items-center gap-2">
          <button className="text-sm px-3 py-1 rounded bg-[#165DFF] text-white">门诊</button>
          <button className="text-sm px-3 py-1 rounded text-[#4E5969] hover:bg-[#F2F3F5]">网诊</button>
          <div className="ml-auto">
            <select className="text-xs border border-[#E5E6E8] rounded px-2 py-1">
              <option>今天</option>
              <option>本周</option>
              <option>本月</option>
            </select>
          </div>
        </div>
        <div className="flex-1 overflow-y-auto scrollbar-thin">
          {mockOutpatientRecords.map((record) => (
            <div
              key={record.id}
              className={`px-3 py-3 border-b border-[#E5E6E8] cursor-pointer hover:bg-[#F7F8FA] ${
                selectedId === record.id ? 'bg-[#E8F3FF]' : ''
              }`}
              onClick={() => setSelectedId(record.id)}
            >
              <div className="flex items-center justify-between mb-1">
                <span className="text-sm font-medium text-[#1D2129]">{record.patient.name}</span>
                {record.status === 'draft' && (
                  <span className="tag-green text-[10px] px-1.5">草稿</span>
                )}
              </div>
              <div className="text-xs text-[#86909C]">{record.patient.gender} · {record.patient.age}岁</div>
            </div>
          ))}
        </div>
        <div className="p-3 border-t border-[#E5E6E8] grid grid-cols-2 gap-1">
          <button className="btn-ghost text-xs justify-center py-1.5">门诊看板</button>
          <button className="btn-ghost text-xs justify-center py-1.5">医生工作汇总</button>
          <button className="btn-ghost text-xs justify-center py-1.5">预约看板</button>
          <button className="btn-ghost text-xs justify-center py-1.5">挂号预约情况</button>
          <button className="btn-ghost text-xs justify-center py-1.5">用药助手</button>
          <button className="btn-ghost text-xs justify-center py-1.5">安全合理用药</button>
        </div>
      </div>

      {/* Main - Edit Area */}
      <div className="flex-1 flex flex-col overflow-hidden">
        {selected && (
          <>
            {/* Patient Info Bar */}
            <div className="bg-white border-b border-[#E5E6E8] px-4 py-2.5">
              <div className="flex items-center gap-4">
                <div className="flex items-center gap-2">
                  <div className="w-8 h-8 rounded-full bg-[#E8F3FF] flex items-center justify-center text-sm text-[#165DFF] font-bold">
                    {selected.patient.name[0]}
                  </div>
                  <div>
                    <span className="text-sm font-medium">{selected.patient.name}</span>
                    <span className="text-xs text-[#86909C] ml-2">{selected.patient.gender} · {selected.patient.age}岁</span>
                    <span className="text-xs text-[#86909C] ml-2">{selected.patient.phone}</span>
                  </div>
                </div>
                <select className="text-xs border border-[#E5E6E8] rounded px-2 py-1" defaultValue={selected.doctor.name}>
                  {mockDoctors.map((d) => (
                    <option key={d.id} value={d.name}>{d.name}</option>
                  ))}
                </select>
                <select className="text-xs border border-[#E5E6E8] rounded px-2 py-1" defaultValue="复诊">
                  <option value="初诊">初诊</option>
                  <option value="复诊">复诊</option>
                </select>
                <span className="text-xs text-[#86909C]">挂号费：¥20.00</span>
                <select className="text-xs border border-[#E5E6E8] rounded px-2 py-1">
                  <option>医保</option>
                  <option>自费</option>
                </select>
                <div className="ml-auto flex gap-2">
                  <button className="btn-secondary text-xs">费用预览</button>
                  <button className="btn-primary text-xs">完成接诊</button>
                  <button className="btn-danger text-xs">删除</button>
                </div>
              </div>
            </div>

            <div className="flex-1 overflow-y-auto scrollbar-thin">
              {/* Medical Record */}
              <div className="m-3 card-panel">
                <div className="card-header">
                  <span className="text-sm font-medium">病历编辑</span>
                  <div className="flex items-center gap-2">
                    <button className="btn-ghost p-1"><Mic size={14} /></button>
                    <button className="btn-ghost p-1"><RotateCcw size={14} /></button>
                    <button className="btn-ghost p-1"><FileText size={14} /></button>
                    <button className="btn-ghost text-xs">添加文书</button>
                    <button className="btn-ghost text-xs">附件</button>
                    <button className="btn-ghost text-xs">模板</button>
                  </div>
                </div>
                <div className="p-4 space-y-4">
                  <div className="grid grid-cols-2 gap-4">
                    <div>
                      <label className="text-xs text-[#86909C] block mb-1">主诉</label>
                      <textarea className="w-full border border-[#E5E6E8] rounded p-2 text-sm h-20 focus:border-[#165DFF] outline-none resize-none" defaultValue={selected.chiefComplaint} />
                    </div>
                    <div>
                      <label className="text-xs text-[#86909C] block mb-1">现病史</label>
                      <textarea className="w-full border border-[#E5E6E8] rounded p-2 text-sm h-20 focus:border-[#165DFF] outline-none resize-none" defaultValue={selected.presentIllness} />
                    </div>
                  </div>
                  <div className="grid grid-cols-3 gap-4">
                    <div>
                      <label className="text-xs text-[#86909C] block mb-1">既往史</label>
                      <textarea className="w-full border border-[#E5E6E8] rounded p-2 text-sm h-16 focus:border-[#165DFF] outline-none resize-none" defaultValue={selected.pastHistory} />
                    </div>
                    <div>
                      <label className="text-xs text-[#86909C] block mb-1">过敏史</label>
                      <textarea className="w-full border border-[#E5E6E8] rounded p-2 text-sm h-16 focus:border-[#165DFF] outline-none resize-none" defaultValue={selected.allergyHistory} />
                    </div>
                    <div>
                      <label className="text-xs text-[#86909C] block mb-1">个人史</label>
                      <textarea className="w-full border border-[#E5E6E8] rounded p-2 text-sm h-16 focus:border-[#165DFF] outline-none resize-none" />
                    </div>
                  </div>
                  <div className="grid grid-cols-2 gap-4">
                    <div>
                      <label className="text-xs text-[#86909C] block mb-1">望闻切诊</label>
                      <textarea className="w-full border border-[#E5E6E8] rounded p-2 text-sm h-16 focus:border-[#165DFF] outline-none resize-none" placeholder="舌象、脉象等" />
                    </div>
                    <div>
                      <label className="text-xs text-[#86909C] block mb-1">诊断</label>
                      <textarea className="w-full border border-[#E5E6E8] rounded p-2 text-sm h-16 focus:border-[#165DFF] outline-none resize-none" defaultValue={selected.diagnosis} />
                    </div>
                  </div>
                </div>
              </div>

              {/* Script Items */}
              <div className="mx-3 mb-3 card-panel">
                <div className="card-header">
                  <div className="flex items-center gap-1">
                    {scriptTabs.map((t) => (
                      <button
                        key={t}
                        className={`text-xs px-3 py-1 rounded ${scriptTab === t ? 'bg-[#165DFF] text-white' : 'text-[#4E5969] hover:bg-[#F2F3F5]'}`}
                        onClick={() => setScriptTab(t)}
                      >
                        {t}
                      </button>
                    ))}
                  </div>
                </div>
                <div className="p-3 flex items-center gap-2">
                  <div className="flex-1 relative">
                    <Search size={14} className="absolute left-2.5 top-1/2 -translate-y-1/2 text-[#86909C]" />
                    <input className="input-search pl-8" placeholder={`搜索${scriptTab}项目...`} />
                  </div>
                  <button className="btn-primary text-xs py-1.5"><Plus size={14} /> 添加</button>
                </div>
                <div className="p-3 text-center text-xs text-[#86909C]">暂无项目</div>
              </div>

              {/* Prescription Area */}
              <div className="mx-3 mb-3 card-panel">
                <div className="card-header">
                  <div className="flex items-center gap-1">
                    {prescriptionTabs.map((t) => (
                      <button
                        key={t}
                        className={`text-xs px-3 py-1 rounded ${prescriptionTab === t ? 'bg-[#165DFF] text-white' : 'text-[#4E5969] hover:bg-[#F2F3F5]'}`}
                        onClick={() => setPrescriptionTab(t)}
                      >
                        {t}
                      </button>
                    ))}
                  </div>
                </div>
                {prescriptionTab === '中药处方' && (
                  <div className="p-3">
                    <div className="flex items-center gap-3 mb-3">
                      <select className="text-xs border border-[#E5E6E8] rounded px-2 py-1">
                        <option>饮片</option>
                        <option>颗粒</option>
                      </select>
                      <select className="text-xs border border-[#E5E6E8] rounded px-2 py-1">
                        <option>中药房一</option>
                        <option>中药房二</option>
                      </select>
                      <select className="text-xs border border-[#E5E6E8] rounded px-2 py-1">
                        <option>自煎</option>
                        <option>代煎</option>
                        <option>代加工</option>
                      </select>
                    </div>
                    <table className="w-full">
                      <thead>
                        <tr>
                          <th className="table-header w-16">序号</th>
                          <th className="table-header">药名</th>
                          <th className="table-header w-24">用量</th>
                          <th className="table-header w-16">单位</th>
                          <th className="table-header w-20">操作</th>
                        </tr>
                      </thead>
                      <tbody>
                        {['当归', '川芎', '白芍', '熟地黄'].map((herb, i) => (
                          <tr key={herb} className="table-row">
                            <td className="table-cell text-center text-[#86909C]">{i + 1}</td>
                            <td className="table-cell font-medium">{herb}</td>
                            <td className="table-cell">
                              <input className="w-16 border border-[#E5E6E8] rounded px-2 py-1 text-sm text-center" defaultValue="12" />
                            </td>
                            <td className="table-cell text-center">g</td>
                            <td className="table-cell text-center">
                              <button className="text-[#F53F3F] text-xs hover:underline">删除</button>
                            </td>
                          </tr>
                        ))}
                      </tbody>
                    </table>
                    <div className="mt-3">
                      <label className="text-xs text-[#86909C] block mb-1">煎服说明</label>
                      <textarea className="w-full border border-[#E5E6E8] rounded p-2 text-sm h-16 focus:border-[#165DFF] outline-none resize-none" placeholder="每日1剂，水煎400ml，分早晚两次温服" />
                    </div>
                  </div>
                )}
              </div>
            </div>
          </>
        )}
      </div>

      {/* Right Panel */}
      <div className="w-72 bg-white border-l border-[#E5E6E8] shrink-0 flex flex-col">
        <div className="flex border-b border-[#E5E6E8]">
          {rightTabs.map((t) => (
            <button
              key={t}
              className={`flex-1 text-xs py-2.5 text-center transition-colors ${
                rightTab === t ? 'text-[#165DFF] border-b-2 border-[#165DFF] font-medium' : 'text-[#86909C] hover:text-[#4E5969]'
              }`}
              onClick={() => setRightTab(t)}
            >
              {t}
            </button>
          ))}
        </div>
        {rightTab === '历史' && (
          <div className="flex-1 flex items-center justify-center text-xs text-[#86909C]">
            暂无历史记录
          </div>
        )}
        {rightTab === 'AI诊疗' && (
          <div className="flex-1 p-4">
            <div className="text-center py-10">
              <Brain size={32} className="text-[#C9CDD4] mx-auto mb-2" />
              <div className="text-xs text-[#86909C]">AI 诊疗辅助</div>
              <div className="text-[10px] text-[#C9CDD4] mt-1">输入病情获取智能建议</div>
            </div>
            <div className="mt-auto">
              <textarea className="w-full border border-[#E5E6E8] rounded p-2 text-sm h-20 focus:border-[#165DFF] outline-none resize-none" placeholder="请描述病情..." />
              <button className="btn-primary w-full text-xs mt-2 justify-center">向 AI 提问</button>
            </div>
          </div>
        )}
      </div>
    </div>
  )
}
