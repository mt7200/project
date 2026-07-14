import React, { useState } from 'react'
import './DiagnosisFlow.css'

interface PatientForm {
  name: string
  gender: string
  age: string
  phone: string
  idCard: string
  birthDate: string
  occupation: string
  ethnicity: string
  maritalStatus: string
  address: string
  emergencyContact: string
  emergencyPhone: string
  chiefComplaint: string
  presentIllness: string
  pastHistory: string
  familyHistory: string
  allergyHistory: string
}

interface SymptomForm {
  pulseLeft: string
  pulseRight: string
  pulseDescription: string
  tongueColor: string
  tongueShape: string
  tongueCoating: string
  tongueTexture: string
  tongueRemark: string
  facialColor: string
  expression: string
  mentalState: string
  breathSound: string
  speechSound: string
  sweating: string
  limbsTemperature: string
  sleepQuality: string
  appetite: string
  thirst: string
  taste: string
  bowelMovement: string
  urineColor: string
  menstrualCycle: string
}

interface DiagnosisResult {
  pattern: string
  confidence: number
  description: string
  symptoms: string[]
}

interface CustomDiagnosis {
  id: string
  pattern: string
  description: string
  symptoms: string[]
}

const diagnosisResults: DiagnosisResult[] = [
  {
    pattern: '肝阳上亢',
    confidence: 92,
    description: '肝阳偏亢，上扰头目，导致头晕头痛；肝肾阴虚，腰膝失养，故腰膝酸软；阴虚阳亢，虚火内扰心神，故失眠多梦。',
    symptoms: ['眩晕', '头痛', '失眠多梦', '腰膝酸软', '口苦咽干', '舌红苔黄', '脉弦数']
  },
  {
    pattern: '阴虚阳亢',
    confidence: 78,
    description: '阴液亏虚，阳气偏亢，虚热内生，上扰清窍。',
    symptoms: ['头晕耳鸣', '潮热盗汗', '五心烦热', '舌红少苔', '脉细数']
  },
  {
    pattern: '肝郁气滞',
    confidence: 65,
    description: '肝气郁结，气机不畅，情志不舒。',
    symptoms: ['胁肋胀痛', '胸闷善太息', '抑郁多疑', '脉弦']
  }
]

const patternDetails = {
  '肝阳上亢': {
    name: '肝阳上亢证',
    code: 'B01.02',
    etiology: '情志内伤，肝肾阴虚，水不涵木',
    pathogenesis: '肝阳偏亢，上扰头目',
    pulse: '脉弦数',
    tongue: '舌红，苔黄',
    differentiation: [
      { symptom: '眩晕', weight: '主要' },
      { symptom: '头痛', weight: '主要' },
      { symptom: '失眠多梦', weight: '次要' },
      { symptom: '腰膝酸软', weight: '次要' },
      { symptom: '口苦咽干', weight: '次要' }
    ]
  }
}

const DiagnosisFlow: React.FC = () => {
  const [currentStep, setCurrentStep] = useState(1)
  const [step2Tab, setStep2Tab] = useState<'chief' | 'four'>('chief')

  const [form, setForm] = useState<PatientForm>({
    name: '', gender: '', age: '', phone: '', idCard: '', birthDate: '',
    occupation: '', ethnicity: '汉族', maritalStatus: '', address: '',
    emergencyContact: '', emergencyPhone: '', chiefComplaint: '',
    presentIllness: '', pastHistory: '', familyHistory: '', allergyHistory: '',
  })

  const [symptoms, setSymptoms] = useState<SymptomForm>({
    pulseLeft: '', pulseRight: '', pulseDescription: '', tongueColor: '',
    tongueShape: '', tongueCoating: '', tongueTexture: '', tongueRemark: '',
    facialColor: '', expression: '', mentalState: '', breathSound: '',
    speechSound: '', sweating: '', limbsTemperature: '', sleepQuality: '',
    appetite: '', thirst: '', taste: '', bowelMovement: '', urineColor: '',
    menstrualCycle: '',
  })

  // Diagnosis state
  const [selectedPattern, setSelectedPattern] = useState<string>('')
  const [customDiagnoses, setCustomDiagnoses] = useState<CustomDiagnosis[]>([])
  const [customPattern, setCustomPattern] = useState('')
  const [customDescription, setCustomDescription] = useState('')
  const [customSymptoms, setCustomSymptoms] = useState('')

  const handleChange = (e: React.ChangeEvent<HTMLInputElement | HTMLSelectElement | HTMLTextAreaElement>) => {
    const { name, value } = e.target
    setForm(prev => ({ ...prev, [name]: value }))
  }

  const handleSymptomChange = (field: keyof SymptomForm, value: string) => {
    setSymptoms(prev => ({ ...prev, [field]: value }))
  }

  const handleSelectPattern = (result: DiagnosisResult) => {
    setCustomPattern(result.pattern)
    setCustomDescription(result.description)
    setCustomSymptoms(result.symptoms.join('、'))
    setSelectedPattern(result.pattern)
  }

  const handleAddCustomDiagnosis = () => {
    if (!customPattern.trim()) return
    const newDiagnosis: CustomDiagnosis = {
      id: Date.now().toString(),
      pattern: customPattern,
      description: customDescription,
      symptoms: customSymptoms.split(/[,，、]/).map(s => s.trim()).filter(s => s)
    }
    setCustomDiagnoses(prev => [...prev, newDiagnosis])
    setCustomPattern('')
    setCustomDescription('')
    setCustomSymptoms('')
    setSelectedPattern('')
  }

  const handleRemoveCustom = (id: string) => {
    setCustomDiagnoses(prev => prev.filter(d => d.id !== id))
  }

  const handleConfirm = () => {
    alert('辨证诊断已保存！')
  }

  const selectedResult = diagnosisResults.find(r => r.pattern === selectedPattern)

  const steps = [
    { num: 1, label: '患者录入', icon: '📋' },
    { num: 2, label: '四诊采集', icon: '🔍' },
    { num: 3, label: '辨证诊断', icon: '🩺' },
  ]

  return (
    <div className="diagnosis-flow">
      <header className="df-header">
        <div className="df-header-left">
          <h1>诊疗流程</h1>
          <p>患者信息录入 → 四诊合参 → 辨证诊断</p>
        </div>
        <div className="df-header-actions">
          <button className="btn btn-outline">保存草稿</button>
          {currentStep === 3 && (
            <button className="btn btn-primary" onClick={handleConfirm}>确认诊断</button>
          )}
        </div>
      </header>

      {/* Step Navigator */}
      <div className="df-step-nav">
        {steps.map((step, idx) => (
          <React.Fragment key={step.num}>
            <div
              className={`df-step ${currentStep >= step.num ? 'active' : ''} ${currentStep === step.num ? 'current' : ''}`}
              onClick={() => { if (currentStep >= step.num) setCurrentStep(step.num) }}
            >
              <span className="df-step-icon">{step.icon}</span>
              <span className="df-step-label">{step.label}</span>
            </div>
            {idx < steps.length - 1 && (
              <div className={`df-step-connector ${currentStep > step.num ? 'done' : ''}`}>
                <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2"><polyline points="9 18 15 12 9 6" /></svg>
              </div>
            )}
          </React.Fragment>
        ))}
      </div>

      {/* Step 1: Patient Entry */}
      {currentStep === 1 && (
        <div className="df-card">
          <h2 className="df-section-title">基本信息</h2>
          <div className="df-form-grid">
            <div className="df-form-group">
              <label>患者姓名 <span className="required">*</span></label>
              <input type="text" name="name" value={form.name} onChange={handleChange} placeholder="请输入患者姓名" required />
            </div>
            <div className="df-form-group">
              <label>性别 <span className="required">*</span></label>
              <select name="gender" value={form.gender} onChange={handleChange} required>
                <option value="">请选择</option>
                <option value="male">男</option>
                <option value="female">女</option>
              </select>
            </div>
            <div className="df-form-group">
              <label>年龄 <span className="required">*</span></label>
              <input type="number" name="age" value={form.age} onChange={handleChange} placeholder="请输入年龄" required />
            </div>
            <div className="df-form-group">
              <label>出生日期</label>
              <input type="date" name="birthDate" value={form.birthDate} onChange={handleChange} />
            </div>
            <div className="df-form-group">
              <label>联系电话 <span className="required">*</span></label>
              <input type="tel" name="phone" value={form.phone} onChange={handleChange} placeholder="请输入手机号码" required />
            </div>
            <div className="df-form-group">
              <label>身份证号</label>
              <input type="text" name="idCard" value={form.idCard} onChange={handleChange} placeholder="请输入身份证号码" />
            </div>
            <div className="df-form-group">
              <label>职业</label>
              <input type="text" name="occupation" value={form.occupation} onChange={handleChange} placeholder="请输入职业" />
            </div>
            <div className="df-form-group">
              <label>民族</label>
              <select name="ethnicity" value={form.ethnicity} onChange={handleChange}>
                <option value="汉族">汉族</option>
                <option value="蒙古族">蒙古族</option>
                <option value="回族">回族</option>
                <option value="其他">其他</option>
              </select>
            </div>
            <div className="df-form-group">
              <label>婚姻状况</label>
              <select name="maritalStatus" value={form.maritalStatus} onChange={handleChange}>
                <option value="">请选择</option>
                <option value="single">未婚</option>
                <option value="married">已婚</option>
                <option value="divorced">离异</option>
              </select>
            </div>
          </div>
          <div className="df-form-group full-width">
            <label>居住地址</label>
            <input type="text" name="address" value={form.address} onChange={handleChange} placeholder="请输入详细地址" />
          </div>

          <h2 className="df-section-title" style={{ marginTop: 24 }}>健康信息</h2>
          <div className="df-form-group full-width">
            <label>既往病史</label>
            <textarea name="pastHistory" value={form.pastHistory} onChange={handleChange} placeholder="高血压、糖尿病等慢性病，手术史、外伤史等" rows={3} />
          </div>
          <div className="df-form-grid">
            <div className="df-form-group">
              <label>过敏史</label>
              <textarea name="allergyHistory" value={form.allergyHistory} onChange={handleChange} placeholder="药物过敏、食物过敏等" rows={2} />
            </div>
            <div className="df-form-group">
              <label>家族病史</label>
              <textarea name="familyHistory" value={form.familyHistory} onChange={handleChange} placeholder="直系亲属的病史" rows={2} />
            </div>
          </div>

          <div className="df-step-actions">
            <button className="btn btn-primary" onClick={() => setCurrentStep(2)}>
              下一步：四诊采集
              <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2"><polyline points="9 18 15 12 9 6" /></svg>
            </button>
          </div>
        </div>
      )}

      {/* Step 2: Four Diagnoses */}
      {currentStep === 2 && (
        <div className="df-card">
          <div className="df-tabs">
            <button className={`df-tab ${step2Tab === 'chief' ? 'active' : ''}`} onClick={() => setStep2Tab('chief')}>
              📝 主诉与现病史
            </button>
            <button className={`df-tab ${step2Tab === 'four' ? 'active' : ''}`} onClick={() => setStep2Tab('four')}>
              🔍 四诊信息
            </button>
          </div>

          {step2Tab === 'chief' && (
            <div className="df-tab-content">
              <div className="df-form-group full-width">
                <label>主诉 <span className="required">*</span></label>
                <textarea name="chiefComplaint" value={form.chiefComplaint} onChange={handleChange} placeholder="请简述患者就诊的主要原因，包括主要症状、持续时间等" rows={3} required />
              </div>
              <div className="df-form-group full-width">
                <label>现病史</label>
                <textarea name="presentIllness" value={form.presentIllness} onChange={handleChange} placeholder="请详细描述发病经过，包括症状特点、变化过程、已做检查和治疗情况等" rows={5} />
              </div>
            </div>
          )}

          {step2Tab === 'four' && (
            <div className="df-tab-content">
              <div className="df-four-grid">
                <div className="df-four-section">
                  <h3>📳 脉诊</h3>
                  <div className="df-form-grid-2">
                    <div className="df-form-group">
                      <label>左手脉象</label>
                      <select value={symptoms.pulseLeft} onChange={(e) => handleSymptomChange('pulseLeft', e.target.value)}>
                        <option value="">请选择</option>
                        {['浮', '沉', '迟', '数', '弱', '弦', '滑', '涩', '紧', '缓', '细', '芤', '虚', '实'].map(v => <option key={v} value={v}>{v}</option>)}
                      </select>
                    </div>
                    <div className="df-form-group">
                      <label>右手脉象</label>
                      <select value={symptoms.pulseRight} onChange={(e) => handleSymptomChange('pulseRight', e.target.value)}>
                        <option value="">请选择</option>
                        {['浮', '沉', '迟', '数', '弱', '弦', '滑', '涩', '紧', '缓', '细', '芤', '虚', '实'].map(v => <option key={v} value={v}>{v}</option>)}
                      </select>
                    </div>
                  </div>
                  <div className="df-form-group full-width">
                    <label>脉象描述</label>
                    <textarea value={symptoms.pulseDescription} onChange={(e) => handleSymptomChange('pulseDescription', e.target.value)} placeholder="请描述脉象特点" rows={2} />
                  </div>
                </div>

                <div className="df-four-section">
                  <h3>👅 舌诊</h3>
                  <div className="df-form-grid-2">
                    <div className="df-form-group">
                      <label>舌质颜色</label>
                      <select value={symptoms.tongueColor} onChange={(e) => handleSymptomChange('tongueColor', e.target.value)}>
                        <option value="">请选择</option>
                        <option value="pale">淡舌</option><option value="red">红舌</option>
                        <option value="crimson">绛舌</option><option value="purple">紫舌</option>
                      </select>
                    </div>
                    <div className="df-form-group">
                      <label>舌苔</label>
                      <select value={symptoms.tongueCoating} onChange={(e) => handleSymptomChange('tongueCoating', e.target.value)}>
                        <option value="">请选择</option>
                        <option value="thin-white">薄白苔</option><option value="thin-yellow">薄黄苔</option>
                        <option value="white-greasy">白腻苔</option><option value="yellow-greasy">黄腻苔</option>
                        <option value="less">少苔</option><option value="peeled">剥苔</option>
                      </select>
                    </div>
                    <div className="df-form-group">
                      <label>舌形</label>
                      <select value={symptoms.tongueShape} onChange={(e) => handleSymptomChange('tongueShape', e.target.value)}>
                        <option value="">请选择</option>
                        <option value="swollen">胖大舌</option><option value="cracked">裂纹舌</option>
                        <option value="tooth-marked">齿痕舌</option>
                      </select>
                    </div>
                    <div className="df-form-group">
                      <label>舌质纹理</label>
                      <select value={symptoms.tongueTexture} onChange={(e) => handleSymptomChange('tongueTexture', e.target.value)}>
                        <option value="">请选择</option>
                        <option value="tender">嫩</option><option value="old">老</option>
                        <option value="moist">润</option><option value="dry">燥</option>
                      </select>
                    </div>
                  </div>
                </div>

                <div className="df-four-section">
                  <h3>👁 望诊</h3>
                  <div className="df-form-grid-2">
                    <div className="df-form-group">
                      <label>面色</label>
                      <select value={symptoms.facialColor} onChange={(e) => handleSymptomChange('facialColor', e.target.value)}>
                        <option value="">请选择</option>
                        <option value="pale">苍白</option><option value="flushed">潮红</option>
                        <option value="sallow">萎黄</option><option value="dark">暗黑</option>
                      </select>
                    </div>
                    <div className="df-form-group">
                      <label>神态</label>
                      <select value={symptoms.expression} onChange={(e) => handleSymptomChange('expression', e.target.value)}>
                        <option value="">请选择</option>
                        <option value="alert">有神</option><option value="tired">少神</option>
                        <option value="apathetic">失神</option>
                      </select>
                    </div>
                  </div>
                </div>

                <div className="df-four-section">
                  <h3>🗣 问诊</h3>
                  <div className="df-form-grid-2">
                    <div className="df-form-group">
                      <label>睡眠</label>
                      <select value={symptoms.sleepQuality} onChange={(e) => handleSymptomChange('sleepQuality', e.target.value)}>
                        <option value="">请选择</option>
                        <option value="good">正常</option><option value="insomnia">失眠</option>
                        <option value="dreamy">多梦</option><option value="drowsy">嗜睡</option>
                      </select>
                    </div>
                    <div className="df-form-group">
                      <label>食欲</label>
                      <select value={symptoms.appetite} onChange={(e) => handleSymptomChange('appetite', e.target.value)}>
                        <option value="">请选择</option>
                        <option value="good">正常</option><option value="poor">纳差</option>
                        <option value="anorexia">厌食</option>
                      </select>
                    </div>
                    <div className="df-form-group">
                      <label>口渴</label>
                      <select value={symptoms.thirst} onChange={(e) => handleSymptomChange('thirst', e.target.value)}>
                        <option value="">请选择</option>
                        <option value="none">不渴</option><option value="thirsty">口渴</option>
                        <option value="dry">口干</option><option value="bitter">口苦</option>
                      </select>
                    </div>
                    <div className="df-form-group">
                      <label>二便</label>
                      <select value={symptoms.bowelMovement} onChange={(e) => handleSymptomChange('bowelMovement', e.target.value)}>
                        <option value="">请选择</option>
                        <option value="normal">正常</option><option value="constipation">便秘</option>
                        <option value="diarrhea">便溏</option>
                      </select>
                    </div>
                  </div>
                </div>
              </div>
            </div>
          )}

          <div className="df-step-actions">
            <button className="btn btn-outline" onClick={() => setCurrentStep(1)}>
              <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2"><polyline points="15 18 9 12 15 6" /></svg>
              上一步
            </button>
            <button className="btn btn-primary" onClick={() => setCurrentStep(3)}>
              下一步：辨证诊断
              <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2"><polyline points="9 18 15 12 9 6" /></svg>
            </button>
          </div>
        </div>
      )}

      {/* Step 3: Diagnosis */}
      {currentStep === 3 && (
        <div className="df-diagnosis-layout">
          <div className="df-diagnosis-main">
            {/* AI Diagnosis Results */}
            <div className="df-card">
              <div className="df-card-header">
                <h2>AI 辨证结果</h2>
                <span className="df-ai-badge">AI</span>
              </div>
              <div className="df-result-cards">
                {diagnosisResults.map((result) => (
                  <div
                    key={result.pattern}
                    className={`df-result-card ${selectedPattern === result.pattern ? 'selected' : ''}`}
                    onClick={() => handleSelectPattern(result)}
                  >
                    <div className="df-result-header">
                      <span className="df-pattern-name">{result.pattern}</span>
                      <span className="df-confidence">{result.confidence}%</span>
                    </div>
                    <p className="df-result-desc">{result.description}</p>
                    <div className="df-symptom-tags">
                      {result.symptoms.map((s, i) => (
                        <span key={i} className="df-symptom-tag">{s}</span>
                      ))}
                    </div>
                  </div>
                ))}
              </div>
            </div>

            {/* Custom Diagnosis */}
            {customDiagnoses.length > 0 && (
              <div className="df-card df-custom-section">
                <div className="df-card-header">
                  <h2>已选辨证结果</h2>
                  <span className="df-count-badge">{customDiagnoses.length}</span>
                </div>
                <div className="df-custom-list">
                  {customDiagnoses.map((diag) => (
                    <div key={diag.id} className="df-custom-card">
                      <div className="df-custom-header">
                        <span className="df-custom-pattern">{diag.pattern}</span>
                        <button className="df-btn-remove" onClick={() => handleRemoveCustom(diag.id)}>×</button>
                      </div>
                      <p className="df-custom-desc">{diag.description}</p>
                      <div className="df-symptom-tags">
                        {diag.symptoms.map((s, i) => (
                          <span key={i} className="df-symptom-tag">{s}</span>
                        ))}
                      </div>
                    </div>
                  ))}
                </div>
              </div>
            )}

            {/* Add Custom */}
            <div className="df-card">
              <h2 className="df-section-title">添加辨证结果</h2>
              <div className="df-add-form">
                <div className="df-form-group">
                  <label>证型名称</label>
                  <input type="text" value={customPattern} onChange={(e) => setCustomPattern(e.target.value)} placeholder="请输入证型名称或点击上方AI建议" />
                </div>
                <div className="df-form-group">
                  <label>证型描述</label>
                  <textarea value={customDescription} onChange={(e) => setCustomDescription(e.target.value)} placeholder="请输入证型描述" rows={2} />
                  {selectedResult && (
                    <div className="df-ai-suggestion">
                      <span className="df-suggestion-label">AI建议：</span>
                      <button className="df-suggestion-btn" onClick={() => setCustomDescription(selectedResult.description)}>
                        {selectedResult.description}
                      </button>
                    </div>
                  )}
                </div>
                <div className="df-form-group">
                  <label>关键症状（用逗号分隔）</label>
                  <input type="text" value={customSymptoms} onChange={(e) => setCustomSymptoms(e.target.value)} placeholder="如：眩晕、头痛、失眠多梦" />
                  {selectedResult && (
                    <div className="df-ai-suggestion">
                      <span className="df-suggestion-label">AI建议症状：</span>
                      <div className="df-symptom-chips">
                        {selectedResult.symptoms.map((s, i) => (
                          <button
                            key={i}
                            className={`df-symptom-chip ${customSymptoms.includes(s) ? 'selected' : ''}`}
                            onClick={() => {
                              const current = customSymptoms.split(/[,，、]/).map(s => s.trim()).filter(s => s)
                              if (!current.includes(s)) {
                                setCustomSymptoms([...current, s].join('、'))
                              }
                            }}
                          >
                            {s}
                          </button>
                        ))}
                      </div>
                    </div>
                  )}
                </div>
                <div className="df-add-actions">
                  <button className="btn btn-ghost" onClick={() => { setCustomPattern(''); setCustomDescription(''); setCustomSymptoms(''); setSelectedPattern('') }}>清空</button>
                  <button className="btn btn-primary" onClick={handleAddCustomDiagnosis}>添加到自选</button>
                </div>
              </div>
            </div>

            {/* Pattern Detail */}
            <div className="df-card">
              <h2 className="df-section-title">证候详情</h2>
              <div className="df-detail-grid">
                <div className="df-detail-item"><label>证型名称</label><span>{selectedPattern || '肝阳上亢证'}</span></div>
                <div className="df-detail-item"><label>证候编码</label><span>B01.02</span></div>
                <div className="df-detail-item"><label>病因病机</label><span>情志内伤，肝肾阴虚，水不涵木</span></div>
                <div className="df-detail-item"><label>典型脉象</label><span>脉弦数</span></div>
                <div className="df-detail-item"><label>典型舌象</label><span>舌红，苔黄</span></div>
              </div>
              <div className="df-diff-section">
                <h3>症状辨证权重</h3>
                {patternDetails['肝阳上亢']?.differentiation.map((item, index) => (
                  <div key={index} className="df-diff-item">
                    <span className="df-diff-symptom">{item.symptom}</span>
                    <div className="df-diff-bar">
                      <div className={`df-diff-fill ${item.weight === '主要' ? 'major' : 'minor'}`} style={{ width: item.weight === '主要' ? '80%' : '50%' }} />
                    </div>
                    <span className={`df-diff-weight ${item.weight === '主要' ? 'major' : 'minor'}`}>{item.weight}</span>
                  </div>
                ))}
              </div>
            </div>

            <div className="df-step-actions">
              <button className="btn btn-outline" onClick={() => setCurrentStep(2)}>
                <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2"><polyline points="15 18 9 12 15 6" /></svg>
                上一步
              </button>
              <button className="btn btn-primary btn-lg" onClick={handleConfirm}>确认诊断</button>
            </div>
          </div>

          {/* Sidebar */}
          <div className="df-diagnosis-sidebar">
            <div className="df-sidebar-card">
              <h3>四诊摘要</h3>
              <div className="df-summary-list">
                <div className="df-summary-item"><label>脉诊</label><span>左手弦数，右手细弱</span></div>
                <div className="df-summary-item"><label>舌诊</label><span>舌红，苔黄腻</span></div>
                <div className="df-summary-item"><label>望诊</label><span>面色潮红，神情焦虑</span></div>
                <div className="df-summary-item"><label>问诊</label><span>头痛眩晕，失眠多梦，口苦咽干</span></div>
              </div>
            </div>
            <div className="df-sidebar-card df-warning-card">
              <div className="df-warning-icon">⚠️</div>
              <div>
                <h4>注意事项</h4>
                <p>患者有高血压病史，处方需注意监测血压变化</p>
              </div>
            </div>
          </div>
        </div>
      )}
    </div>
  )
}

export default DiagnosisFlow
