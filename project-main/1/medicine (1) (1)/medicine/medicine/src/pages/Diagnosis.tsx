import React, { useState } from 'react';
import './Diagnosis.css';

interface DiagnosisResult {
  pattern: string;
  confidence: number;
  description: string;
  symptoms: string[];
}

interface SimilarCase {
  id: string;
  name: string;
  gender: string;
  age: number;
  chiefComplaint: string;
  diagnosis: string;
  matchScore: number;
  date: string;
  doctor: string;
  treatment: string;
  outcome: string;
  keySymptoms: string[];
  pulse: string;
  tongue: string;
}

interface CustomDiagnosis {
  id: string;
  pattern: string;
  description: string;
  symptoms: string[];
}

const Diagnosis: React.FC = () => {
  const [selectedPattern, setSelectedPattern] = useState<string>('');
  const [selectedCase, setSelectedCase] = useState<SimilarCase | null>(null);
  const [customDiagnoses, setCustomDiagnoses] = useState<CustomDiagnosis[]>([]);
  const [customPattern, setCustomPattern] = useState('');
  const [customDescription, setCustomDescription] = useState('');
  const [customSymptoms, setCustomSymptoms] = useState('');

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
  ];

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
  };

  const similarCases: SimilarCase[] = [
    {
      id: 'M20240315001',
      name: '王建国',
      gender: '男',
      age: 52,
      chiefComplaint: '头痛眩晕3年，加重1周',
      diagnosis: '肝阳上亢证',
      matchScore: 92,
      date: '2024-03-15',
      doctor: '张主任',
      treatment: '天麻钩藤饮加减',
      outcome: '好转',
      keySymptoms: ['眩晕', '头痛', '失眠多梦', '腰膝酸软', '口苦咽干'],
      pulse: '脉弦数',
      tongue: '舌红苔黄'
    },
    {
      id: 'M20240228002',
      name: '刘秀英',
      gender: '女',
      age: 45,
      chiefComplaint: '头晕耳鸣半年',
      diagnosis: '阴虚阳亢证',
      matchScore: 87,
      date: '2024-02-28',
      doctor: '李医师',
      treatment: '镇肝熄风汤加减',
      outcome: '显效',
      keySymptoms: ['头晕耳鸣', '潮热盗汗', '五心烦热', '失眠多梦'],
      pulse: '脉细数',
      tongue: '舌红少苔'
    },
    {
      id: 'M20240120003',
      name: '赵德明',
      gender: '男',
      age: 58,
      chiefComplaint: '头痛头胀2周',
      diagnosis: '肝阳上亢证',
      matchScore: 85,
      date: '2024-01-20',
      doctor: '王主任',
      treatment: '天麻钩藤饮合镇肝熄风汤',
      outcome: '好转',
      keySymptoms: ['头痛头胀', '眩晕', '口苦', '心烦易怒'],
      pulse: '脉弦',
      tongue: '舌红苔黄'
    },
    {
      id: 'M20231215004',
      name: '陈桂兰',
      gender: '女',
      age: 49,
      chiefComplaint: '失眠多梦3月',
      diagnosis: '肝郁化火证',
      matchScore: 78,
      date: '2023-12-15',
      doctor: '张主任',
      treatment: '丹栀逍遥散加减',
      outcome: '好转',
      keySymptoms: ['失眠多梦', '心烦易怒', '胸胁胀闷', '口苦咽干'],
      pulse: '脉弦数',
      tongue: '舌红苔黄'
    },
    {
      id: 'M20231128005',
      name: '孙伟民',
      gender: '男',
      age: 55,
      chiefComplaint: '眩晕反复发作半年',
      diagnosis: '肝阳上亢证',
      matchScore: 82,
      date: '2023-11-28',
      doctor: '刘医师',
      treatment: '天麻钩藤饮加减',
      outcome: '显效',
      keySymptoms: ['眩晕', '头痛', '肢体麻木', '记忆力下降'],
      pulse: '脉弦细',
      tongue: '舌淡红苔白'
    }
  ];

  const handleSelectPattern = (result: DiagnosisResult) => {
    setCustomPattern(result.pattern);
    setCustomDescription(result.description);
    setCustomSymptoms(result.symptoms.join('、'));
    setSelectedPattern(result.pattern);
  };

  const handleAddCustomDiagnosis = () => {
    if (!customPattern.trim()) return;
    const newDiagnosis: CustomDiagnosis = {
      id: Date.now().toString(),
      pattern: customPattern,
      description: customDescription,
      symptoms: customSymptoms.split(/[,，、]/).map(s => s.trim()).filter(s => s)
    };
    setCustomDiagnoses(prev => [...prev, newDiagnosis]);
    setCustomPattern('');
    setCustomDescription('');
    setCustomSymptoms('');
    setSelectedPattern('');
  };

  const handleRemoveCustom = (id: string) => {
    setCustomDiagnoses(prev => prev.filter(d => d.id !== id));
  };

  const handleConfirm = () => {
    console.log('Diagnosis confirmed:', { selectedPattern, customDiagnoses });
    alert('辨证诊断已保存！');
  };

  const selectedResult = diagnosisResults.find(r => r.pattern === selectedPattern);

  return (
    <div className="diagnosis">
      <header className="page-header">
        <div className="header-content">
          <h1>辨证诊断与结果展示</h1>
          <p>患者：张伟 | 病历号：P20260508001</p>
        </div>
        <div className="header-actions">
          <button className="btn-secondary">返回修改</button>
          <button className="btn-primary" onClick={handleConfirm}>确认诊断</button>
        </div>
      </header>

      <div className="diagnosis-content">
        <div className="diagnosis-main">
          {customDiagnoses.length > 0 && (
            <section className="custom-diagnosis-section">
              <div className="section-header">
                <h2>自选辨证结果</h2>
                <span className="count-badge">{customDiagnoses.length}</span>
              </div>
              <div className="custom-diagnosis-list">
                {customDiagnoses.map((diag) => (
                  <div key={diag.id} className="custom-diagnosis-card">
                    <div className="custom-card-header">
                      <span className="custom-pattern">{diag.pattern}</span>
                      <button className="btn-remove" onClick={() => handleRemoveCustom(diag.id)}>×</button>
                    </div>
                    <p className="custom-desc">{diag.description}</p>
                    <div className="symptom-tags">
                      {diag.symptoms.map((s, i) => (
                        <span key={i} className="symptom-tag">{s}</span>
                      ))}
                    </div>
                  </div>
                ))}
              </div>
            </section>
          )}

          <section className="add-custom-section">
            <h2>添加辨证结果</h2>
            <div className="add-custom-form">
              <div className="form-group">
                <label>证型名称</label>
                <input
                  type="text"
                  value={customPattern}
                  onChange={(e) => setCustomPattern(e.target.value)}
                  placeholder="请输入证型名称或点击下方AI建议"
                />
                <div className="ai-suggestions">
                  <div className="suggestion-label">AI推荐证型：</div>
                  <div className="suggestion-chips">
                    {diagnosisResults.map((result, index) => (
                      <button
                        key={index}
                        className={`suggestion-chip ${selectedPattern === result.pattern ? 'selected' : ''}`}
                        onClick={() => handleSelectPattern(result)}
                      >
                        <span className="chip-name">{result.pattern}</span>
                        <span className="chip-confidence">{result.confidence}%</span>
                      </button>
                    ))}
                  </div>
                </div>
              </div>

              <div className="form-group">
                <label>证型描述</label>
                <textarea
                  value={customDescription}
                  onChange={(e) => setCustomDescription(e.target.value)}
                  placeholder="请输入证型描述"
                  rows={2}
                />
                {selectedResult && (
                  <div className="ai-suggestion-text">
                    <span className="suggestion-label">AI建议描述：</span>
                    <button
                      className="suggestion-text-btn"
                      onClick={() => setCustomDescription(selectedResult.description)}
                    >
                      {selectedResult.description}
                    </button>
                  </div>
                )}
              </div>

              <div className="form-group">
                <label>关键症状（用逗号分隔）</label>
                <input
                  type="text"
                  value={customSymptoms}
                  onChange={(e) => setCustomSymptoms(e.target.value)}
                  placeholder="如：眩晕、头痛、失眠多梦"
                />
                {selectedResult && (
                  <div className="ai-suggestion-symptoms">
                    <span className="suggestion-label">AI建议症状：</span>
                    <div className="symptom-chips">
                      {selectedResult.symptoms.map((s, i) => (
                        <button
                          key={i}
                          className={`symptom-chip ${customSymptoms.includes(s) ? 'selected' : ''}`}
                          onClick={() => {
                            const current = customSymptoms.split(/[,，、]/).map(s => s.trim()).filter(s => s);
                            if (!current.includes(s)) {
                              const newList = [...current, s];
                              setCustomSymptoms(newList.join('、'));
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

              <div className="form-actions">
                <button
                  className="btn-clear"
                  onClick={() => {
                    setCustomPattern('');
                    setCustomDescription('');
                    setCustomSymptoms('');
                    setSelectedPattern('');
                  }}
                >
                  清空
                </button>
                <button className="btn-add" onClick={handleAddCustomDiagnosis}>添加到自选</button>
              </div>
            </div>
          </section>

          <section className="pattern-detail-section">
            <h2>证候详情</h2>
            <div className="detail-card">
              <div className="detail-grid">
                <div className="detail-item">
                  <label>证型名称</label>
                  <span className="value">{selectedPattern || '肝阳上亢证'}</span>
                </div>
                <div className="detail-item">
                  <label>证候编码</label>
                  <span className="value">B01.02</span>
                </div>
                <div className="detail-item">
                  <label>病因病机</label>
                  <span className="value">情志内伤，肝肾阴虚，水不涵木</span>
                </div>
                <div className="detail-item">
                  <label>病机概述</label>
                  <span className="value">肝阳偏亢，上扰头目</span>
                </div>
                <div className="detail-item">
                  <label>典型脉象</label>
                  <span className="value">脉弦数</span>
                </div>
                <div className="detail-item">
                  <label>典型舌象</label>
                  <span className="value">舌红，苔黄</span>
                </div>
              </div>

              <div className="symptom-differentiation">
                <h3>症状辨证权重</h3>
                <div className="diff-list">
                  {patternDetails['肝阳上亢']?.differentiation.map((item, index) => (
                    <div key={index} className="diff-item">
                      <span className="diff-symptom">{item.symptom}</span>
                      <div className="diff-bar">
                        <div
                          className={`diff-fill ${item.weight === '主要' ? 'major' : 'minor'}`}
                          style={{ width: item.weight === '主要' ? '80%' : '50%' }}
                        ></div>
                      </div>
                      <span className={`diff-weight ${item.weight === '主要' ? 'major' : 'minor'}`}>
                        {item.weight}
                      </span>
                    </div>
                  ))}
                </div>
              </div>
            </div>
          </section>
        </div>

        <aside className="diagnosis-sidebar">
          <div className="sidebar-card">
            <h3>四诊摘要</h3>
            <div className="summary-list">
              <div className="summary-item">
                <div className="summary-content">
                  <label>脉诊</label>
                  <span>左手弦数，右手细弱</span>
                </div>
              </div>
              <div className="summary-item">
                <div className="summary-content">
                  <label>舌诊</label>
                  <span>舌红，苔黄腻</span>
                </div>
              </div>
              <div className="summary-item">
                <div className="summary-content">
                  <label>望诊</label>
                  <span>面色潮红，神情焦虑</span>
                </div>
              </div>
              <div className="summary-item">
                <div className="summary-content">
                  <label>问诊</label>
                  <span>头痛眩晕，失眠多梦，口苦咽干</span>
                </div>
              </div>
            </div>
          </div>

          <div className="sidebar-card">
            <h3>相似病历</h3>
            <div className="similar-cases-list">
              {similarCases.slice(0, 3).map((caseItem) => (
                <div
                  key={caseItem.id}
                  className={`similar-case-item ${selectedCase?.id === caseItem.id ? 'selected' : ''}`}
                  onClick={() => setSelectedCase(selectedCase?.id === caseItem.id ? null : caseItem)}
                >
                  <div className="case-header">
                    <span className="case-name">{caseItem.name}</span>
                    <span className="case-match">{caseItem.matchScore}%</span>
                  </div>
                  <p className="case-diagnosis">{caseItem.diagnosis}</p>
                  <p className="case-date">{caseItem.date}</p>
                </div>
              ))}
            </div>
            {similarCases.length > 3 && (
              <button className="btn-link">展开全部 ({similarCases.length})</button>
            )}
          </div>

          {selectedCase && (
            <div className="sidebar-card case-detail-card">
              <div className="detail-header">
                <h3>病历详情</h3>
                <button className="btn-close" onClick={() => setSelectedCase(null)}>×</button>
              </div>
              <div className="patient-info-section">
                <div className="info-row">
                  <span className="info-label">姓名</span>
                  <span className="info-value">{selectedCase.name}</span>
                </div>
                <div className="info-row">
                  <span className="info-label">性别/年龄</span>
                  <span className="info-value">{selectedCase.gender}/{selectedCase.age}岁</span>
                </div>
                <div className="info-row">
                  <span className="info-label">病历号</span>
                  <span className="info-value">{selectedCase.id}</span>
                </div>
                <div className="info-row">
                  <span className="info-label">就诊日期</span>
                  <span className="info-value">{selectedCase.date}</span>
                </div>
                <div className="info-row">
                  <span className="info-label">主治医师</span>
                  <span className="info-value">{selectedCase.doctor}</span>
                </div>
              </div>
              <div className="section">
                <h4>主诉</h4>
                <p>{selectedCase.chiefComplaint}</p>
              </div>
              <div className="section">
                <h4>辨证结果</h4>
                <div className="diagnosis-tag">{selectedCase.diagnosis}</div>
              </div>
              <div className="section">
                <h4>关键症状</h4>
                <div className="symptom-list">
                  {selectedCase.keySymptoms.map((s, i) => (
                    <span key={i} className="symptom-tag">{s}</span>
                  ))}
                </div>
              </div>
              <div className="section">
                <h4>治疗方案</h4>
                <div className="treatment-card-mini">{selectedCase.treatment}</div>
              </div>
              <div className="section">
                <h4>治疗结果</h4>
                <div className={`outcome-badge ${selectedCase.outcome}`}>
                  {selectedCase.outcome}
                </div>
              </div>
            </div>
          )}

          <div className="sidebar-card warning-card">
            <div className="warning-icon">⚠️</div>
            <div className="warning-content">
              <h4>注意事项</h4>
              <p>患者有高血压病史，处方需注意监测血压变化</p>
            </div>
          </div>
        </aside>
      </div>
    </div>
  );
};

export default Diagnosis;
