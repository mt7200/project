import React, { useState } from 'react';
import './PatientEntry.css';

interface PatientForm {
  name: string;
  gender: string;
  age: string;
  phone: string;
  idCard: string;
  birthDate: string;
  occupation: string;
  ethnicity: string;
  maritalStatus: string;
  address: string;
  emergencyContact: string;
  emergencyPhone: string;
  chiefComplaint: string;
  presentIllness: string;
  pastHistory: string;
  familyHistory: string;
  allergyHistory: string;
}

interface SymptomForm {
  pulseLeft: string;
  pulseRight: string;
  pulseDescription: string;
  tongueColor: string;
  tongueShape: string;
  tongueCoating: string;
  tongueTexture: string;
  tongueRemark: string;
  facialColor: string;
  expression: string;
  mentalState: string;
  breathSound: string;
  speechSound: string;
  sweating: string;
  limbsTemperature: string;
  sleepQuality: string;
  appetite: string;
  thirst: string;
  taste: string;
  bowelMovement: string;
  urineColor: string;
  menstrualCycle: string;
}

const PatientEntry: React.FC = () => {
  const [form, setForm] = useState<PatientForm>({
    name: '',
    gender: '',
    age: '',
    phone: '',
    idCard: '',
    birthDate: '',
    occupation: '',
    ethnicity: '汉族',
    maritalStatus: '',
    address: '',
    emergencyContact: '',
    emergencyPhone: '',
    chiefComplaint: '',
    presentIllness: '',
    pastHistory: '',
    familyHistory: '',
    allergyHistory: '',
  });

  const [symptoms, setSymptoms] = useState<SymptomForm>({
    pulseLeft: '',
    pulseRight: '',
    pulseDescription: '',
    tongueColor: '',
    tongueShape: '',
    tongueCoating: '',
    tongueTexture: '',
    tongueRemark: '',
    facialColor: '',
    expression: '',
    mentalState: '',
    breathSound: '',
    speechSound: '',
    sweating: '',
    limbsTemperature: '',
    sleepQuality: '',
    appetite: '',
    thirst: '',
    taste: '',
    bowelMovement: '',
    urineColor: '',
    menstrualCycle: '',
  });

  const [currentStep, setCurrentStep] = useState(1);
  const [step3Tab, setStep3Tab] = useState<'chief' | 'four'>('chief');

  const handleChange = (e: React.ChangeEvent<HTMLInputElement | HTMLSelectElement | HTMLTextAreaElement>) => {
    const { name, value } = e.target;
    setForm(prev => ({ ...prev, [name]: value }));
  };

  const handleSymptomChange = (field: keyof SymptomForm, value: string) => {
    setSymptoms(prev => ({ ...prev, [field]: value }));
  };

  const handleSubmit = (e: React.FormEvent) => {
    e.preventDefault();
    console.log('Patient form submitted:', form);
    console.log('Symptoms submitted:', symptoms);
    alert('患者信息已保存！');
  };

  const handleNext = () => {
    if (currentStep < 3) setCurrentStep(prev => prev + 1);
  };

  const handlePrev = () => {
    if (currentStep > 1) setCurrentStep(prev => prev - 1);
  };

  return (
    <div className="patient-entry">
      <header className="page-header">
        <div className="header-content">
          <h1>患者信息录入</h1>
          <p>新建患者档案，采集基本信息和主诉</p>
        </div>
        <div className="header-actions">
          <button className="btn-secondary">保存草稿</button>
          <button className="btn-primary" onClick={handleSubmit}>保存并继续</button>
        </div>
      </header>

      <div className="step-indicator">
        <div className={`step ${currentStep >= 1 ? 'active' : ''}`}>
          <span className="step-number">1</span>
          <span className="step-label">基本信息</span>
        </div>
        <div className="step-line"></div>
        <div className={`step ${currentStep >= 2 ? 'active' : ''}`}>
          <span className="step-number">2</span>
          <span className="step-label">健康信息</span>
        </div>
        <div className="step-line"></div>
        <div className={`step ${currentStep >= 3 ? 'active' : ''}`}>
          <span className="step-number">3</span>
          <span className="step-label">主诉与病史</span>
        </div>
      </div>

      <form className="patient-form" onSubmit={handleSubmit}>
        {currentStep === 1 && (
          <div className="form-section">
            <h2>基本信息</h2>
            <div className="form-grid">
              <div className="form-group">
                <label>患者姓名 <span className="required">*</span></label>
                <input
                  type="text"
                  name="name"
                  value={form.name}
                  onChange={handleChange}
                  placeholder="请输入患者姓名"
                  required
                />
              </div>
              <div className="form-group">
                <label>性别 <span className="required">*</span></label>
                <select name="gender" value={form.gender} onChange={handleChange} required>
                  <option value="">请选择</option>
                  <option value="male">男</option>
                  <option value="female">女</option>
                </select>
              </div>
              <div className="form-group">
                <label>年龄 <span className="required">*</span></label>
                <input
                  type="number"
                  name="age"
                  value={form.age}
                  onChange={handleChange}
                  placeholder="请输入年龄"
                  required
                />
              </div>
              <div className="form-group">
                <label>出生日期</label>
                <input
                  type="date"
                  name="birthDate"
                  value={form.birthDate}
                  onChange={handleChange}
                />
              </div>
              <div className="form-group">
                <label>联系电话 <span className="required">*</span></label>
                <input
                  type="tel"
                  name="phone"
                  value={form.phone}
                  onChange={handleChange}
                  placeholder="请输入手机号码"
                  required
                />
              </div>
              <div className="form-group">
                <label>身份证号</label>
                <input
                  type="text"
                  name="idCard"
                  value={form.idCard}
                  onChange={handleChange}
                  placeholder="请输入身份证号码"
                />
              </div>
              <div className="form-group">
                <label>职业</label>
                <input
                  type="text"
                  name="occupation"
                  value={form.occupation}
                  onChange={handleChange}
                  placeholder="请输入职业"
                />
              </div>
              <div className="form-group">
                <label>民族</label>
                <select name="ethnicity" value={form.ethnicity} onChange={handleChange}>
                  <option value="汉族">汉族</option>
                  <option value="蒙古族">蒙古族</option>
                  <option value="回族">回族</option>
                  <option value="藏族">藏族</option>
                  <option value="维吾尔族">维吾尔族</option>
                  <option value="苗族">苗族</option>
                  <option value="其他">其他</option>
                </select>
              </div>
              <div className="form-group">
                <label>婚姻状况</label>
                <select name="maritalStatus" value={form.maritalStatus} onChange={handleChange}>
                  <option value="">请选择</option>
                  <option value="single">未婚</option>
                  <option value="married">已婚</option>
                  <option value="divorced">离异</option>
                  <option value="widowed">丧偶</option>
                </select>
              </div>
            </div>

            <div className="form-group full-width">
              <label>居住地址</label>
              <input
                type="text"
                name="address"
                value={form.address}
                onChange={handleChange}
                placeholder="请输入详细地址"
              />
            </div>

            <h3>紧急联系人</h3>
            <div className="form-grid">
              <div className="form-group">
                <label>联系人姓名</label>
                <input
                  type="text"
                  name="emergencyContact"
                  value={form.emergencyContact}
                  onChange={handleChange}
                  placeholder="请输入联系人姓名"
                />
              </div>
              <div className="form-group">
                <label>联系电话</label>
                <input
                  type="tel"
                  name="emergencyPhone"
                  value={form.emergencyPhone}
                  onChange={handleChange}
                  placeholder="请输入联系电话"
                />
              </div>
            </div>
          </div>
        )}

        {currentStep === 2 && (
          <div className="form-section">
            <h2>健康信息</h2>

            <div className="form-group full-width">
              <label>既往病史</label>
              <textarea
                name="pastHistory"
                value={form.pastHistory}
                onChange={handleChange}
                placeholder="请输入既往病史，包括高血压、糖尿病、心脏病等慢性病，以及手术史、外伤史等"
                rows={4}
              />
            </div>

            <div className="form-group full-width">
              <label>家族病史</label>
              <textarea
                name="familyHistory"
                value={form.familyHistory}
                onChange={handleChange}
                placeholder="请输入家族病史，包括父母、兄弟姐妹等直系亲属的病史"
                rows={4}
              />
            </div>

            <div className="form-group full-width">
              <label>过敏史</label>
              <textarea
                name="allergyHistory"
                value={form.allergyHistory}
                onChange={handleChange}
                placeholder="请输入过敏史，包括药物过敏、食物过敏、花粉过敏等"
                rows={4}
              />
            </div>

            <div className="info-card">
              <div className="info-icon">💡</div>
              <div className="info-content">
                <h4>温馨提示</h4>
                <p>详细的既往病史和过敏史信息有助于提高辨证诊断的准确性。请尽量提供完整的信息。</p>
              </div>
            </div>
          </div>
        )}

        {currentStep === 3 && (
          <div className="form-section step3-section">
            <div className="step3-tabs">
              <button
                type="button"
                className={`step3-tab ${step3Tab === 'chief' ? 'active' : ''}`}
                onClick={() => setStep3Tab('chief')}
              >
                📝 主诉与现病史
              </button>
              <button
                type="button"
                className={`step3-tab ${step3Tab === 'four' ? 'active' : ''}`}
                onClick={() => setStep3Tab('four')}
              >
                🔍 四诊信息
              </button>
            </div>

            {step3Tab === 'chief' && (
              <div className="step3-content">
                <h2>主诉与现病史</h2>

                <div className="form-group full-width">
                  <label>主诉 <span className="required">*</span></label>
                  <textarea
                    name="chiefComplaint"
                    value={form.chiefComplaint}
                    onChange={handleChange}
                    placeholder="请简述患者就诊的主要原因，包括主要症状、持续时间等。例如：头痛、眩晕3天，加重1天"
                    rows={3}
                    required
                  />
                </div>

                <div className="form-group full-width">
                  <label>现病史</label>
                  <textarea
                    name="presentIllness"
                    value={form.presentIllness}
                    onChange={handleChange}
                    placeholder="请详细描述发病经过，包括症状特点、变化过程、已做检查和治疗情况等"
                    rows={6}
                  />
                </div>

                <div className="action-card">
                  <div className="action-icon">📋</div>
                  <div className="action-content">
                    <h4>下一步操作</h4>
                    <p>点击「四诊信息」标签页可填写脉诊、舌诊、望诊、问诊等四诊合参内容。</p>
                  </div>
                </div>
              </div>
            )}

            {step3Tab === 'four' && (
              <div className="step3-content four-diagnosis">
                <h2>四诊信息采集</h2>

                <div className="four-grid">
                  <div className="four-section">
                    <h3>📳 脉诊</h3>
                    <div className="form-grid">
                      <div className="form-group">
                        <label>左手脉象</label>
                        <select
                          value={symptoms.pulseLeft}
                          onChange={(e) => handleSymptomChange('pulseLeft', e.target.value)}
                        >
                          <option value="">请选择</option>
                          <option value="float">浮</option>
                          <option value="deep">沉</option>
                          <option value="slow">迟</option>
                          <option value="rapid">数</option>
                          <option value="weak">弱</option>
                          <option value="string">弦</option>
                          <option value="slippery">滑</option>
                          <option value="rough">涩</option>
                          <option value="tight">紧</option>
                          <option value="moderate">缓</option>
                          <option value="wiry">细</option>
                          <option value="hollow">芤</option>
                          <option value="vacuous">虚</option>
                          <option value="replete">实</option>
                        </select>
                      </div>
                      <div className="form-group">
                        <label>右手脉象</label>
                        <select
                          value={symptoms.pulseRight}
                          onChange={(e) => handleSymptomChange('pulseRight', e.target.value)}
                        >
                          <option value="">请选择</option>
                          <option value="float">浮</option>
                          <option value="deep">沉</option>
                          <option value="slow">迟</option>
                          <option value="rapid">数</option>
                          <option value="weak">弱</option>
                          <option value="string">弦</option>
                          <option value="slippery">滑</option>
                          <option value="rough">涩</option>
                          <option value="tight">紧</option>
                          <option value="moderate">缓</option>
                          <option value="wiry">细</option>
                          <option value="hollow">芤</option>
                          <option value="vacuous">虚</option>
                          <option value="replete">实</option>
                        </select>
                      </div>
                      <div className="form-group full-width">
                        <label>脉象描述</label>
                        <textarea
                          value={symptoms.pulseDescription}
                          onChange={(e) => handleSymptomChange('pulseDescription', e.target.value)}
                          placeholder="请描述脉象特点，如脉率、节律、力度等"
                          rows={2}
                        />
                      </div>
                    </div>
                  </div>

                  <div className="four-section">
                    <h3>👅 舌诊</h3>
                    <div className="form-grid">
                      <div className="form-group">
                        <label>舌质颜色</label>
                        <select
                          value={symptoms.tongueColor}
                          onChange={(e) => handleSymptomChange('tongueColor', e.target.value)}
                        >
                          <option value="">请选择</option>
                          <option value="pale">淡舌</option>
                          <option value="pallid">淡白舌</option>
                          <option value="red">红舌</option>
                          <option value="crimson">绛舌</option>
                          <option value="purple">紫舌</option>
                          <option value="cyanotic">青舌</option>
                        </select>
                      </div>
                      <div className="form-group">
                        <label>舌形</label>
                        <select
                          value={symptoms.tongueShape}
                          onChange={(e) => handleSymptomChange('tongueShape', e.target.value)}
                        >
                          <option value="">请选择</option>
                          <option value="thin">胖大舌</option>
                          <option value="swollen">肿胀舌</option>
                          <option value="thin">瘦薄舌</option>
                          <option value="cracked">裂纹舌</option>
                          <option value="tooth-marked">齿痕舌</option>
                        </select>
                      </div>
                      <div className="form-group">
                        <label>舌苔</label>
                        <select
                          value={symptoms.tongueCoating}
                          onChange={(e) => handleSymptomChange('tongueCoating', e.target.value)}
                        >
                          <option value="">请选择</option>
                          <option value="thin-white">薄白苔</option>
                          <option value="thin-yellow">薄黄苔</option>
                          <option value="white-greasy">白腻苔</option>
                          <option value="yellow-greasy">黄腻苔</option>
                          <option value="thin">薄苔</option>
                          <option value="thick">厚苔</option>
                          <option value="less">少苔</option>
                          <option value="peeled">剥苔</option>
                        </select>
                      </div>
                      <div className="form-group">
                        <label>舌质纹理</label>
                        <select
                          value={symptoms.tongueTexture}
                          onChange={(e) => handleSymptomChange('tongueTexture', e.target.value)}
                        >
                          <option value="">请选择</option>
                          <option value="tender">嫩</option>
                          <option value="old">老</option>
                          <option value="moist">润</option>
                          <option value="dry">燥</option>
                        </select>
                      </div>
                      <div className="form-group full-width">
                        <label>舌诊备注</label>
                        <textarea
                          value={symptoms.tongueRemark}
                          onChange={(e) => handleSymptomChange('tongueRemark', e.target.value)}
                          placeholder="请补充舌诊的其他特征"
                          rows={2}
                        />
                      </div>
                    </div>
                  </div>

                  <div className="four-section">
                    <h3>👁️ 望诊</h3>
                    <div className="form-grid">
                      <div className="form-group">
                        <label>面色</label>
                        <select
                          value={symptoms.facialColor}
                          onChange={(e) => handleSymptomChange('facialColor', e.target.value)}
                        >
                          <option value="">请选择</option>
                          <option value="normal">正常</option>
                          <option value="pale">面色苍白</option>
                          <option value="sallow">面色萎黄</option>
                          <option value="pimple">面色潮红</option>
                          <option value="cyanotic">面色青紫</option>
                          <option value="dim">面色晦暗</option>
                        </select>
                      </div>
                      <div className="form-group">
                        <label>神情</label>
                        <select
                          value={symptoms.expression}
                          onChange={(e) => handleSymptomChange('expression', e.target.value)}
                        >
                          <option value="">请选择</option>
                          <option value="alert">神志清醒</option>
                          <option value="anxious">焦虑不安</option>
                          <option value="depressed">精神抑郁</option>
                          <option value="languid">精神倦怠</option>
                          <option value="irritable">烦躁易怒</option>
                        </select>
                      </div>
                      <div className="form-group">
                        <label>精神状态</label>
                        <select
                          value={symptoms.mentalState}
                          onChange={(e) => handleSymptomChange('mentalState', e.target.value)}
                        >
                          <option value="">请选择</option>
                          <option value="good">良好</option>
                          <option value="fair">一般</option>
                          <option value="poor">较差</option>
                        </select>
                      </div>
                      <div className="form-group">
                        <label>呼吸音</label>
                        <select
                          value={symptoms.breathSound}
                          onChange={(e) => handleSymptomChange('breathSound', e.target.value)}
                        >
                          <option value="">请选择</option>
                          <option value="normal">正常</option>
                          <option value="coarse">粗</option>
                          <option value="wheeze">哮鸣音</option>
                          <option value="rale">湿啰音</option>
                        </select>
                      </div>
                    </div>
                  </div>

                  <div className="four-section">
                    <h3>❓ 问诊</h3>
                    <div className="form-grid">
                      <div className="form-group">
                        <label>出汗情况</label>
                        <select
                          value={symptoms.sweating}
                          onChange={(e) => handleSymptomChange('sweating', e.target.value)}
                        >
                          <option value="">请选择</option>
                          <option value="normal">正常</option>
                          <option value="night-sweat">盗汗</option>
                          <option value="spontaneous">自汗</option>
                          <option value="none">无汗</option>
                        </select>
                      </div>
                      <div className="form-group">
                        <label>四肢温度</label>
                        <select
                          value={symptoms.limbsTemperature}
                          onChange={(e) => handleSymptomChange('limbsTemperature', e.target.value)}
                        >
                          <option value="">请选择</option>
                          <option value="normal">正常</option>
                          <option value="cold">四肢不温</option>
                          <option value="hot">四肢发热</option>
                        </select>
                      </div>
                      <div className="form-group">
                        <label>睡眠质量</label>
                        <select
                          value={symptoms.sleepQuality}
                          onChange={(e) => handleSymptomChange('sleepQuality', e.target.value)}
                        >
                          <option value="">请选择</option>
                          <option value="good">良好</option>
                          <option value="insomnia">失眠</option>
                          <option value="dreamy">多梦</option>
                          <option value="light">易醒</option>
                        </select>
                      </div>
                      <div className="form-group">
                        <label>食欲</label>
                        <select
                          value={symptoms.appetite}
                          onChange={(e) => handleSymptomChange('appetite', e.target.value)}
                        >
                          <option value="">请选择</option>
                          <option value="normal">正常</option>
                          <option value="poor">食欲不振</option>
                          <option value="excess">食欲亢进</option>
                        </select>
                      </div>
                      <div className="form-group">
                        <label>口渴</label>
                        <select
                          value={symptoms.thirst}
                          onChange={(e) => handleSymptomChange('thirst', e.target.value)}
                        >
                          <option value="">请选择</option>
                          <option value="normal">正常</option>
                          <option value="thirsty">口渴</option>
                          <option value="not-thirsty">口不渴</option>
                          <option value="prefer-hot">喜热饮</option>
                          <option value="prefer-cold">喜冷饮</option>
                        </select>
                      </div>
                      <div className="form-group">
                        <label>口味</label>
                        <select
                          value={symptoms.taste}
                          onChange={(e) => handleSymptomChange('taste', e.target.value)}
                        >
                          <option value="">请选择</option>
                          <option value="normal">正常</option>
                          <option value="bitter">口苦</option>
                          <option value="sweet">口甜</option>
                          <option value="sticky">口粘腻</option>
                          <option value="dry">口干</option>
                        </select>
                      </div>
                      <div className="form-group">
                        <label>大便</label>
                        <select
                          value={symptoms.bowelMovement}
                          onChange={(e) => handleSymptomChange('bowelMovement', e.target.value)}
                        >
                          <option value="">请选择</option>
                          <option value="normal">正常</option>
                          <option value="constipation">便秘</option>
                          <option value="diarrhea">腹泻</option>
                          <option value="loose">稀溏</option>
                        </select>
                      </div>
                      <div className="form-group">
                        <label>小便</label>
                        <select
                          value={symptoms.urineColor}
                          onChange={(e) => handleSymptomChange('urineColor', e.target.value)}
                        >
                          <option value="">请选择</option>
                          <option value="normal">正常</option>
                          <option value="yellow">尿黄</option>
                          <option value="clear">尿清长</option>
                          <option value="short">尿短赤</option>
                        </select>
                      </div>
                    </div>
                  </div>
                </div>
              </div>
            )}
          </div>
        )}

        <div className="form-actions">
          {currentStep > 1 && (
            <button type="button" className="btn-secondary" onClick={handlePrev}>
              上一步
            </button>
          )}
          {currentStep < 3 ? (
            <button type="button" className="btn-primary" onClick={handleNext}>
              下一步
            </button>
          ) : (
            <button type="submit" className="btn-primary">
              保存并辨证
            </button>
          )}
        </div>
      </form>
    </div>
  );
};

export default PatientEntry;
