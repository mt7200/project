import { useState } from 'react'
import { Search, ChevronRight, ChevronDown, Lock } from 'lucide-react'
import { herbTemplates } from '../../mock'

const templateTypes = ['处方模板', '病历模板', '诊疗模板', '执行记录模板', '儿保看护模板', '文书模板']
const templateCategories = ['个人专用', '诊所公用', '经典方剂', '临床验方']

const formulaCategories = [
  { name: '解表剂', formulas: ['麻黄汤', '桂枝汤', '小青龙汤', '银翘散'] },
  { name: '清热剂', formulas: ['白虎汤', '黄连解毒汤', '清营汤', '龙胆泻肝汤'] },
  { name: '泻下剂', formulas: ['大承气汤', '小承气汤', '麻子仁丸'] },
  { name: '和解剂', formulas: ['小柴胡汤', '逍遥散', '半夏泻心汤'] },
  { name: '补益剂', formulas: ['四君子汤', '四物汤', '八珍汤', '六味地黄丸'] },
  { name: '温里剂', formulas: ['理中丸', '小建中汤', '四逆汤'] },
]

export default function AdminPage() {
  const [templateType, setTemplateType] = useState('处方模板')
  const [templateCategory, setTemplateCategory] = useState('经典方剂')
  const [expandedCategory, setExpandedCategory] = useState<string | null>('解表剂')
  const [selectedFormula, setSelectedFormula] = useState('小柴胡汤')

  const currentTemplate = herbTemplates.find((t) => t.name === selectedFormula)

  return (
    <div className="flex h-full">
      {/* Left Sidebar */}
      <div className="w-56 bg-white border-r border-[#E5E6E8] shrink-0">
        <div className="p-3 border-b border-[#E5E6E8]">
          <div className="text-sm font-medium text-[#1D2129] mb-2">模板设置</div>
          <div className="text-xs text-[#86909C] py-1 px-2 rounded bg-[#F2F3F5] cursor-pointer hover:bg-[#E5E6E8]">打印设置</div>
        </div>
      </div>

      {/* Main Content */}
      <div className="flex-1 flex flex-col overflow-hidden">
        <div className="bg-white border-b border-[#E5E6E8] p-3">
          <div className="flex items-center gap-2 mb-3">
            {templateTypes.map((t) => (
              <button
                key={t}
                className={`text-xs px-3 py-1.5 rounded ${templateType === t ? 'bg-[#165DFF] text-white' : 'text-[#4E5969] hover:bg-[#F2F3F5]'}`}
                onClick={() => setTemplateType(t)}
              >
                {t}
              </button>
            ))}
          </div>
          <div className="flex items-center gap-3">
            <div className="w-56 relative">
              <Search size={14} className="absolute left-2.5 top-1/2 -translate-y-1/2 text-[#86909C]" />
              <input className="input-search pl-8" placeholder="搜索处方模板..." />
            </div>
            <div className="flex items-center gap-1">
              {templateCategories.map((c) => (
                <button
                  key={c}
                  className={`text-xs px-3 py-1 rounded ${templateCategory === c ? 'bg-[#165DFF] text-white' : 'text-[#4E5969] hover:bg-[#F2F3F5]'}`}
                  onClick={() => setTemplateCategory(c)}
                >
                  {c}
                </button>
              ))}
            </div>
          </div>
        </div>

        <div className="flex-1 flex overflow-hidden">
          <div className="w-56 bg-white border-r border-[#E5E6E8] overflow-y-auto scrollbar-thin shrink-0">
            <div className="p-3">
              {formulaCategories.map((cat) => (
                <div key={cat.name}>
                  <button
                    className="flex items-center gap-1 w-full text-left py-1.5 text-sm text-[#1D2129] hover:text-[#165DFF]"
                    onClick={() => setExpandedCategory(expandedCategory === cat.name ? null : cat.name)}
                  >
                    {expandedCategory === cat.name ? <ChevronDown size={14} /> : <ChevronRight size={14} />}
                    <span>{cat.name}</span>
                  </button>
                  {expandedCategory === cat.name && (
                    <div className="ml-4">
                      {cat.formulas.map((f) => (
                        <button
                          key={f}
                          className={`block w-full text-left py-1 text-xs pl-2 rounded ${
                            selectedFormula === f
                              ? 'text-[#165DFF] bg-[#E8F3FF] font-medium'
                              : 'text-[#4E5969] hover:text-[#165DFF]'
                          }`}
                          onClick={() => setSelectedFormula(f)}
                        >
                          {f}
                        </button>
                      ))}
                    </div>
                  )}
                </div>
              ))}
            </div>
          </div>

          <div className="flex-1 overflow-y-auto bg-white p-4">
            {currentTemplate ? (
              <>
                <div className="flex items-center justify-between mb-4">
                  <div>
                    <h2 className="text-base font-medium text-[#1D2129]">{currentTemplate.name}</h2>
                    <p className="text-xs text-[#86909C] mt-0.5">
                      <Lock size={12} className="inline mr-1" />
                      公共模板，不可编辑
                    </p>
                  </div>
                </div>

                <div className="grid grid-cols-2 gap-3 mb-4">
                  {[
                    { label: '分类', value: currentTemplate.category },
                    { label: '来源', value: currentTemplate.source || '—' },
                    { label: '功用', value: currentTemplate.function },
                    { label: '主治', value: currentTemplate.indications },
                  ].map((item) => (
                    <div key={item.label} className="flex">
                      <span className="text-xs text-[#86909C] w-12 shrink-0">{item.label}：</span>
                      <span className="text-sm text-[#1D2129]">{item.value}</span>
                    </div>
                  ))}
                </div>

                <div className="mb-2">
                  <div className="text-xs text-[#86909C] mb-2">加减：</div>
                  <textarea className="w-full border border-[#E5E6E8] rounded p-2 text-sm h-12 focus:border-[#165DFF] outline-none resize-none" placeholder="暂无" />
                </div>

                <div>
                  <div className="text-sm font-medium text-[#1D2129] mb-2">中药处方 - 饮片</div>
                  <table className="w-full">
                    <thead>
                      <tr>
                        <th className="table-header w-16">序号</th>
                        <th className="table-header">药名</th>
                        <th className="table-header w-24">用量</th>
                      </tr>
                    </thead>
                    <tbody>
                      {currentTemplate.herbs.map((herb, i) => (
                        <tr key={herb.name} className="table-row">
                          <td className="table-cell text-center text-[#86909C]">{i + 1}</td>
                          <td className="table-cell font-medium">{herb.name}</td>
                          <td className="table-cell">{herb.dosage}</td>
                        </tr>
                      ))}
                    </tbody>
                  </table>
                  <div className="text-xs text-[#86909C] mt-2">每剂用量</div>
                </div>
              </>
            ) : (
              <div className="text-center py-16 text-sm text-[#86909C]">请选择模板</div>
            )}
          </div>
        </div>
      </div>
    </div>
  )
}
