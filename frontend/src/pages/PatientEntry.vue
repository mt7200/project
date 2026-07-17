<template>
  <div class="patient-entry">
    <header class="page-header">
      <div class="header-content">
        <h1>患者信息录入</h1>
        <p>新建患者档案，采集基本信息和主诉</p>
      </div>
      <div class="header-actions">
        <button class="btn-secondary">保存草稿</button>
        <button class="btn-primary" @click="handleSubmit">保存并继续</button>
      </div>
    </header>

    <div class="step-indicator">
      <div :class="['step', { active: currentStep >= 1 }]">
        <span class="step-number">1</span>
        <span class="step-label">基本信息</span>
      </div>
      <div class="step-line"></div>
      <div :class="['step', { active: currentStep >= 2 }]">
        <span class="step-number">2</span>
        <span class="step-label">健康信息</span>
      </div>
      <div class="step-line"></div>
      <div :class="['step', { active: currentStep >= 3 }]">
        <span class="step-number">3</span>
        <span class="step-label">主诉与病史</span>
      </div>
    </div>

    <form class="patient-form" @submit.prevent="handleSubmit">
      <div v-if="currentStep === 1" class="form-section">
        <h2>基本信息</h2>
        <div class="form-grid">
          <div class="form-group">
            <label>患者姓名 <span class="required">*</span></label>
            <input
              type="text"
              v-model="form.name"
              placeholder="请输入患者姓名"
              required
            />
          </div>
          <div class="form-group">
            <label>性别 <span class="required">*</span></label>
            <select v-model="form.gender" required>
              <option value="">请选择</option>
              <option value="male">男</option>
              <option value="female">女</option>
            </select>
          </div>
          <div class="form-group">
            <label>年龄 <span class="required">*</span></label>
            <input
              type="number"
              v-model="form.age"
              placeholder="请输入年龄"
              required
            />
          </div>
          <div class="form-group">
            <label>出生日期</label>
            <input type="date" v-model="form.birthDate" />
          </div>
          <div class="form-group">
            <label>联系电话 <span class="required">*</span></label>
            <input
              type="tel"
              v-model="form.phone"
              placeholder="请输入手机号码"
              required
            />
          </div>
          <div class="form-group">
            <label>身份证号</label>
            <input
              type="text"
              v-model="form.idCard"
              placeholder="请输入身份证号码"
            />
          </div>
          <div class="form-group">
            <label>职业</label>
            <input
              type="text"
              v-model="form.occupation"
              placeholder="请输入职业"
            />
          </div>
          <div class="form-group">
            <label>民族</label>
            <select v-model="form.ethnicity">
              <option value="汉族">汉族</option>
              <option value="蒙古族">蒙古族</option>
              <option value="回族">回族</option>
              <option value="藏族">藏族</option>
              <option value="维吾尔族">维吾尔族</option>
              <option value="苗族">苗族</option>
              <option value="其他">其他</option>
            </select>
          </div>
          <div class="form-group">
            <label>婚姻状况</label>
            <select v-model="form.maritalStatus">
              <option value="">请选择</option>
              <option value="single">未婚</option>
              <option value="married">已婚</option>
              <option value="divorced">离异</option>
              <option value="widowed">丧偶</option>
            </select>
          </div>
        </div>

        <div class="form-group full-width">
          <label>居住地址</label>
          <input
            type="text"
            v-model="form.address"
            placeholder="请输入详细地址"
          />
        </div>

        <h3>紧急联系人</h3>
        <div class="form-grid">
          <div class="form-group">
            <label>联系人姓名</label>
            <input
              type="text"
              v-model="form.emergencyContact"
              placeholder="请输入联系人姓名"
            />
          </div>
          <div class="form-group">
            <label>联系电话</label>
            <input
              type="tel"
              v-model="form.emergencyPhone"
              placeholder="请输入联系电话"
            />
          </div>
        </div>
      </div>

      <div v-if="currentStep === 2" class="form-section">
        <h2>健康信息</h2>

        <div class="form-group full-width">
          <label>既往病史</label>
          <textarea
            v-model="form.pastHistory"
            placeholder="请输入既往病史，包括高血压、糖尿病、心脏病等慢性病，以及手术史、外伤史等"
            rows="4"
          />
        </div>

        <div class="form-group full-width">
          <label>家族病史</label>
          <textarea
            v-model="form.familyHistory"
            placeholder="请输入家族病史，包括父母、兄弟姐妹等直系亲属的病史"
            rows="4"
          />
        </div>

        <div class="form-group full-width">
          <label>过敏史</label>
          <textarea
            v-model="form.allergyHistory"
            placeholder="请输入过敏史，包括药物过敏、食物过敏、花粉过敏等"
            rows="4"
          />
        </div>

        <h3>诊断信息</h3>
        <div class="diagnosis-grid">
          <div class="form-group">
            <label>诊断</label>
            <input
              type="text"
              v-model="form.diagnosis"
              placeholder="请输入诊断"
            />
          </div>
          <div class="form-group">
            <label>辩证</label>
            <input
              type="text"
              v-model="form.differentiation"
              placeholder="请输入辩证"
            />
          </div>
          <div class="form-group">
            <label>治法</label>
            <input
              type="text"
              v-model="form.treatmentMethod"
              placeholder="请输入治法"
            />
          </div>
          <div class="form-group">
            <label>方药</label>
            <input
              type="text"
              v-model="form.prescription"
              placeholder="请输入方药"
            />
          </div>
        </div>

        <div class="info-card">
          <div class="info-icon">💡</div>
          <div class="info-content">
            <h4>温馨提示</h4>
            <p>详细的既往病史和过敏史信息有助于提高辨证诊断的准确性。请尽量提供完整的信息。</p>
          </div>
        </div>
      </div>

      <div v-if="currentStep === 3" class="form-section step3-section">
        <div class="step3-tabs">
          <button
            type="button"
            :class="['step3-tab', { active: step3Tab === 'chief' }]"
            @click="step3Tab = 'chief'"
          >
            📝 主诉与现病史
          </button>
          <button
            type="button"
            :class="['step3-tab', { active: step3Tab === 'four' }]"
            @click="step3Tab = 'four'"
          >
            🔍 四诊信息
          </button>
        </div>

        <div v-if="step3Tab === 'chief'" class="step3-content">
          <h2>主诉与现病史</h2>

          <div class="form-group full-width">
            <label>主诉 <span class="required">*</span></label>
            <textarea
              v-model="form.chiefComplaint"
              placeholder="请简述患者就诊的主要原因，包括主要症状、持续时间等。例如：头痛、眩晕3天，加重1天"
              rows="3"
              required
            />
          </div>

          <div class="form-group full-width">
            <label>现病史</label>
            <textarea
              v-model="form.presentIllness"
              placeholder="请详细描述发病经过，包括症状特点、变化过程、已做检查和治疗情况等"
              rows="6"
            />
          </div>

          <div class="action-card">
            <div class="action-icon">📋</div>
            <div class="action-content">
              <h4>下一步操作</h4>
              <p>点击「四诊信息」标签页可填写脉诊、舌诊、望诊、问诊等四诊合参内容。</p>
            </div>
          </div>
        </div>

        <div v-if="step3Tab === 'four'" class="step3-content four-diagnosis">
          <h2>四诊信息采集</h2>

          <div class="four-grid">
            <div class="four-section">
              <h3>📳 脉诊</h3>
              <div class="form-grid">
                <div class="form-group">
                  <label>左手脉象</label>
                  <select v-model="symptoms.pulseLeft">
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
                <div class="form-group">
                  <label>右手脉象</label>
                  <select v-model="symptoms.pulseRight">
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
                <div class="form-group full-width">
                  <label>脉象描述</label>
                  <textarea
                    v-model="symptoms.pulseDescription"
                    placeholder="请描述脉象特点，如脉率、节律、力度等"
                    rows="2"
                  />
                </div>
              </div>
            </div>

            <div class="four-section">
              <h3>👅 舌诊</h3>
              <div class="form-grid">
                <div class="form-group">
                  <label>舌质颜色</label>
                  <select v-model="symptoms.tongueColor">
                    <option value="">请选择</option>
                    <option value="pale">淡舌</option>
                    <option value="pallid">淡白舌</option>
                    <option value="red">红舌</option>
                    <option value="crimson">绛舌</option>
                    <option value="purple">紫舌</option>
                    <option value="cyanotic">青舌</option>
                  </select>
                </div>
                <div class="form-group">
                  <label>舌形</label>
                  <select v-model="symptoms.tongueShape">
                    <option value="">请选择</option>
                    <option value="thin">胖大舌</option>
                    <option value="swollen">肿胀舌</option>
                    <option value="thin">瘦薄舌</option>
                    <option value="cracked">裂纹舌</option>
                    <option value="tooth-marked">齿痕舌</option>
                  </select>
                </div>
                <div class="form-group">
                  <label>舌苔</label>
                  <select v-model="symptoms.tongueCoating">
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
                <div class="form-group">
                  <label>舌质纹理</label>
                  <select v-model="symptoms.tongueTexture">
                    <option value="">请选择</option>
                    <option value="tender">嫩</option>
                    <option value="old">老</option>
                    <option value="moist">润</option>
                    <option value="dry">燥</option>
                  </select>
                </div>
                <div class="form-group full-width">
                  <label>舌诊备注</label>
                  <textarea
                    v-model="symptoms.tongueRemark"
                    placeholder="请补充舌诊的其他特征"
                    rows="2"
                  />
                </div>
              </div>
            </div>

            <div class="four-section">
              <h3>👁️ 望诊</h3>
              <div class="form-grid">
                <div class="form-group">
                  <label>面色</label>
                  <select v-model="symptoms.facialColor">
                    <option value="">请选择</option>
                    <option value="normal">正常</option>
                    <option value="pale">面色苍白</option>
                    <option value="sallow">面色萎黄</option>
                    <option value="pimple">面色潮红</option>
                    <option value="cyanotic">面色青紫</option>
                    <option value="dim">面色晦暗</option>
                  </select>
                </div>
                <div class="form-group">
                  <label>神情</label>
                  <select v-model="symptoms.expression">
                    <option value="">请选择</option>
                    <option value="alert">神志清醒</option>
                    <option value="anxious">焦虑不安</option>
                    <option value="depressed">精神抑郁</option>
                    <option value="languid">精神倦怠</option>
                    <option value="irritable">烦躁易怒</option>
                  </select>
                </div>
                <div class="form-group">
                  <label>精神状态</label>
                  <select v-model="symptoms.mentalState">
                    <option value="">请选择</option>
                    <option value="good">良好</option>
                    <option value="fair">一般</option>
                    <option value="poor">较差</option>
                  </select>
                </div>
                <div class="form-group">
                  <label>呼吸音</label>
                  <select v-model="symptoms.breathSound">
                    <option value="">请选择</option>
                    <option value="normal">正常</option>
                    <option value="coarse">粗</option>
                    <option value="wheeze">哮鸣音</option>
                    <option value="rale">湿啰音</option>
                  </select>
                </div>
              </div>
            </div>

            <div class="four-section">
              <h3>❓ 问诊</h3>
              <div class="form-grid">
                <div class="form-group">
                  <label>出汗情况</label>
                  <select v-model="symptoms.sweating">
                    <option value="">请选择</option>
                    <option value="normal">正常</option>
                    <option value="night-sweat">盗汗</option>
                    <option value="spontaneous">自汗</option>
                    <option value="none">无汗</option>
                  </select>
                </div>
                <div class="form-group">
                  <label>四肢温度</label>
                  <select v-model="symptoms.limbsTemperature">
                    <option value="">请选择</option>
                    <option value="normal">正常</option>
                    <option value="cold">四肢不温</option>
                    <option value="hot">四肢发热</option>
                  </select>
                </div>
                <div class="form-group">
                  <label>睡眠质量</label>
                  <select v-model="symptoms.sleepQuality">
                    <option value="">请选择</option>
                    <option value="good">良好</option>
                    <option value="insomnia">失眠</option>
                    <option value="dreamy">多梦</option>
                    <option value="light">易醒</option>
                  </select>
                </div>
                <div class="form-group">
                  <label>食欲</label>
                  <select v-model="symptoms.appetite">
                    <option value="">请选择</option>
                    <option value="normal">正常</option>
                    <option value="poor">食欲不振</option>
                    <option value="excess">食欲亢进</option>
                  </select>
                </div>
                <div class="form-group">
                  <label>口渴</label>
                  <select v-model="symptoms.thirst">
                    <option value="">请选择</option>
                    <option value="normal">正常</option>
                    <option value="thirsty">口渴</option>
                    <option value="not-thirsty">口不渴</option>
                    <option value="prefer-hot">喜热饮</option>
                    <option value="prefer-cold">喜冷饮</option>
                  </select>
                </div>
                <div class="form-group">
                  <label>口味</label>
                  <select v-model="symptoms.taste">
                    <option value="">请选择</option>
                    <option value="normal">正常</option>
                    <option value="bitter">口苦</option>
                    <option value="sweet">口甜</option>
                    <option value="sticky">口粘腻</option>
                    <option value="dry">口干</option>
                  </select>
                </div>
                <div class="form-group">
                  <label>大便</label>
                  <select v-model="symptoms.bowelMovement">
                    <option value="">请选择</option>
                    <option value="normal">正常</option>
                    <option value="constipation">便秘</option>
                    <option value="diarrhea">腹泻</option>
                    <option value="loose">稀溏</option>
                  </select>
                </div>
                <div class="form-group">
                  <label>小便</label>
                  <select v-model="symptoms.urineColor">
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
      </div>

      <div class="form-actions">
        <button v-if="currentStep > 1" type="button" class="btn-secondary" @click="handlePrev">
          上一步
        </button>
        <button v-if="currentStep < 3" type="button" class="btn-primary" @click="handleNext">
          下一步
        </button>
        <button v-else type="submit" class="btn-primary">
          保存并辨证
        </button>
      </div>
    </form>
  </div>
</template>

<script setup lang="ts">
import { ref } from 'vue'

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
  diagnosis: string
  differentiation: string
  treatmentMethod: string
  prescription: string
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

const form = ref<PatientForm>({
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
  diagnosis: '',
  differentiation: '',
  treatmentMethod: '',
  prescription: '',
})

const symptoms = ref<SymptomForm>({
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
})

const currentStep = ref(1)
const step3Tab = ref<'chief' | 'four'>('chief')

const handleSubmit = () => {
  console.log('Patient form submitted:', form.value)
  console.log('Symptoms submitted:', symptoms.value)
  alert('患者信息已保存！')
}

const handleNext = () => {
  if (currentStep.value < 3) currentStep.value += 1
}

const handlePrev = () => {
  if (currentStep.value > 1) currentStep.value -= 1
}
</script>

<style scoped>
.patient-entry {
  min-height: 100vh;
  background: #f5f7fa;
  padding: 8px 24px;
}

.page-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 6px;
}

.header-content h1 {
  font-size: 20px;
  color: #333;
  font-weight: 600;
  margin-bottom: 2px;
}

.header-content p {
  font-size: 13px;
  color: #999;
}

.header-actions {
  display: flex;
  gap: 12px;
}

.btn-primary,
.btn-secondary {
  padding: 8px 20px;
  border-radius: 8px;
  font-size: 14px;
  font-weight: 500;
  cursor: pointer;
  transition: all 0.2s;
  border: none;
}

.btn-primary {
  background: linear-gradient(135deg, #1890ff, #096dd9);
  color: white;
}

.btn-primary:hover {
  transform: translateY(-1px);
  box-shadow: 0 4px 12px rgba(24, 144, 255, 0.4);
}

.btn-secondary {
  background: white;
  color: #666;
  border: 1px solid #e8e8e8;
}

.btn-secondary:hover {
  border-color: #1890ff;
  color: #1890ff;
}

.step-indicator {
  display: flex;
  align-items: center;
  justify-content: center;
  gap: 0;
  margin-bottom: 8px;
  padding: 8px 24px;
  background: white;
  border-radius: 10px;
  box-shadow: 0 2px 8px rgba(0, 0, 0, 0.04);
}

.step {
  display: flex;
  flex-direction: column;
  align-items: center;
  gap: 4px;
}

.step-number {
  width: 28px;
  height: 28px;
  border-radius: 50%;
  background: #e8e8e8;
  color: #999;
  display: flex;
  align-items: center;
  justify-content: center;
  font-size: 13px;
  font-weight: 600;
  transition: all 0.3s;
}

.step.active .step-number {
  background: #1890ff;
  color: white;
}

.step-label {
  font-size: 14px;
  color: #999;
  transition: all 0.3s;
}

.step.active .step-label {
  color: #1890ff;
  font-weight: 500;
}

.step-line {
  width: 80px;
  height: 2px;
  background: #e8e8e8;
  margin: 0 12px;
  margin-bottom: 14px;
  transition: all 0.3s;
}

.step-line.active {
  background: #1890ff;
}

.patient-form {
  background: white;
  border-radius: 10px;
  padding: 12px 16px;
  box-shadow: 0 2px 8px rgba(0, 0, 0, 0.04);
}

.form-section h2 {
  font-size: 16px;
  color: #333;
  font-weight: 600;
  margin-bottom: 10px;
  padding-bottom: 6px;
  border-bottom: 1px solid #e8e8e8;
}

.form-section h3 {
  font-size: 14px;
  color: #333;
  font-weight: 500;
  margin-top: 8px;
  margin-bottom: 8px;
}

.form-grid {
  display: grid;
  grid-template-columns: repeat(3, 1fr);
  gap: 10px;
  margin-bottom: 8px;
}

.form-group {
  display: flex;
  flex-direction: column;
  gap: 3px;
  margin-bottom: 0;
}

.form-group.full-width {
  grid-column: 1 / -1;
}

.form-group label {
  font-size: 14px;
  color: #666;
  font-weight: 500;
}

.required {
  color: #ff4d4f;
}

.form-group input,
.form-group select,
.form-group textarea {
  padding: 4px 8px;
  border: 1px solid #e8e8e8;
  border-radius: 6px;
  font-size: 13px;
  transition: border-color 0.3s, box-shadow 0.3s;
  background: white;
  font-family: inherit;
}

.form-group input:focus,
.form-group select:focus,
.form-group textarea:focus {
  outline: none;
  border-color: #1890ff;
  box-shadow: 0 0 0 3px rgba(24, 144, 255, 0.1);
}

.form-group input::placeholder,
.form-group textarea::placeholder {
  color: #bbb;
}

.form-group textarea {
  resize: vertical;
  min-height: 36px;
}

.info-card {
  display: flex;
  gap: 10px;
  padding: 10px;
  background: #e6f7ff;
  border-radius: 8px;
  margin-top: 10px;
}

.info-icon {
  font-size: 18px;
}

.info-content h4 {
  font-size: 13px;
  color: #1890ff;
  margin-bottom: 2px;
}

.info-content p {
  font-size: 12px;
  color: #666;
  line-height: 1.4;
}

.action-card {
  display: flex;
  gap: 10px;
  padding: 10px;
  background: #f6ffed;
  border-radius: 8px;
  margin-top: 10px;
}

.action-icon {
  font-size: 18px;
}

.action-content h4 {
  font-size: 13px;
  color: #52c41a;
  margin-bottom: 2px;
}

.action-content p {
  font-size: 12px;
  color: #666;
  line-height: 1.4;
}

.form-actions {
  display: flex;
  justify-content: flex-end;
  gap: 10px;
  margin-top: 8px;
  padding-top: 8px;
  border-top: 1px solid #e8e8e8;
}

.step3-section {
  padding: 0;
}

.step3-tabs {
  display: flex;
  gap: 6px;
  margin-bottom: 10px;
  border-bottom: 2px solid #e8e8e8;
  padding-bottom: 0;
}

.step3-tab {
  padding: 7px 16px;
  background: none;
  border: none;
  font-size: 13px;
  color: #666;
  cursor: pointer;
  border-bottom: 3px solid transparent;
  margin-bottom: -2px;
  transition: all 0.2s;
  border-radius: 6px 6px 0 0;
}

.step3-tab:hover {
  color: #1890ff;
  background: #f0f7ff;
}

.step3-tab.active {
  color: #1890ff;
  font-weight: 600;
  border-bottom-color: #1890ff;
  background: #e6f7ff;
}

.step3-content {
  padding: 0;
}

.step3-content h2 {
  font-size: 16px;
  color: #333;
  font-weight: 600;
  margin-bottom: 10px;
  padding-bottom: 6px;
  border-bottom: 1px solid #e8e8e8;
}

.four-diagnosis {
  margin-top: 4px;
}

.four-grid {
  display: grid;
  grid-template-columns: repeat(2, 1fr);
  gap: 10px;
}

.four-section {
  background: #fafafa;
  border-radius: 8px;
  padding: 10px;
  border: 1px solid #f0f0f0;
}

.four-section h3 {
  font-size: 14px;
  color: #333;
  font-weight: 600;
  margin-bottom: 8px;
  padding-bottom: 5px;
  border-bottom: 1px solid #e8e8e8;
}

.four-section .form-grid {
  grid-template-columns: repeat(2, 1fr);
  gap: 8px;
}

.four-section .form-group textarea {
  resize: vertical;
  min-height: 80px;
}

.diagnosis-grid {
  display: grid;
  grid-template-columns: repeat(4, 1fr);
  gap: 10px;
  margin-bottom: 8px;
}
</style>
