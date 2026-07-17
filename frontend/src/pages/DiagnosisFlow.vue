<template>
  <div class="diagnosis-flow">
    <header class="df-header">
      <div class="df-header-left">
        <h1>诊疗流程</h1>
        <p>患者信息录入 → 四诊合参 → 辨证诊断</p>
      </div>
      <div class="df-header-actions">
        <button class="btn btn-outline">保存草稿</button>
        <button v-if="currentStep === 3" class="btn btn-primary" @click="handleConfirm">确认诊断</button>
      </div>
    </header>

    <div class="df-step-nav">
      <template v-for="(step, idx) in steps" :key="step.num">
        <div
          :class="['df-step', { active: currentStep >= step.num, current: currentStep === step.num }]"
          @click="goToStep(step.num)"
        >
          <span class="df-step-icon">{{ step.icon }}</span>
          <span class="df-step-label">{{ step.label }}</span>
        </div>
        <div v-if="idx < steps.length - 1" :class="['df-step-connector', { done: currentStep > step.num }]">
          <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><polyline points="9 18 15 12 9 6" /></svg>
        </div>
      </template>
    </div>

    <div v-if="currentStep === 1" class="df-card">
      <h2 class="df-section-title">基本信息</h2>
      <div class="df-form-grid">
        <div class="df-form-group">
          <label>患者姓名 <span class="required">*</span></label>
          <input type="text" v-model="form.name" placeholder="请输入患者姓名" required />
        </div>
        <div class="df-form-group">
          <label>性别 <span class="required">*</span></label>
          <select v-model="form.gender" required>
            <option value="">请选择</option>
            <option value="male">男</option>
            <option value="female">女</option>
          </select>
        </div>
        <div class="df-form-group">
          <label>年龄 <span class="required">*</span></label>
          <input type="number" v-model="form.age" placeholder="请输入年龄" required />
        </div>
        <div class="df-form-group">
          <label>出生日期</label>
          <input type="date" v-model="form.birthDate" />
        </div>
        <div class="df-form-group">
          <label>联系电话 <span class="required">*</span></label>
          <input type="tel" v-model="form.phone" placeholder="请输入手机号码" required />
        </div>
        <div class="df-form-group">
          <label>身份证号</label>
          <input type="text" v-model="form.idCard" placeholder="请输入身份证号码" />
        </div>
        <div class="df-form-group">
          <label>职业</label>
          <input type="text" v-model="form.occupation" placeholder="请输入职业" />
        </div>
        <div class="df-form-group">
          <label>民族</label>
          <select v-model="form.ethnicity">
            <option value="汉族">汉族</option>
            <option value="蒙古族">蒙古族</option>
            <option value="回族">回族</option>
            <option value="其他">其他</option>
          </select>
        </div>
        <div class="df-form-group">
          <label>婚姻状况</label>
          <select v-model="form.maritalStatus">
            <option value="">请选择</option>
            <option value="single">未婚</option>
            <option value="married">已婚</option>
            <option value="divorced">离异</option>
          </select>
        </div>
      </div>
      <div class="df-form-group full-width">
        <label>居住地址</label>
        <input type="text" v-model="form.address" placeholder="请输入详细地址" />
      </div>

      <h2 class="df-section-title" :style="{ marginTop: '24px' }">健康信息</h2>
      <div class="df-form-group full-width">
        <label>既往病史</label>
        <textarea v-model="form.pastHistory" placeholder="高血压、糖尿病等慢性病，手术史、外伤史等" rows="3" />
      </div>
      <div class="df-form-grid">
        <div class="df-form-group">
          <label>过敏史</label>
          <textarea v-model="form.allergyHistory" placeholder="药物过敏、食物过敏等" rows="2" />
        </div>
        <div class="df-form-group">
          <label>家族病史</label>
          <textarea v-model="form.familyHistory" placeholder="直系亲属的病史" rows="2" />
        </div>
      </div>

      <div class="df-step-actions">
        <button class="btn btn-primary" @click="currentStep = 2">
          下一步：四诊采集
          <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><polyline points="9 18 15 12 9 6" /></svg>
        </button>
      </div>
    </div>

    <div v-if="currentStep === 2" class="df-card">
      <div class="df-tabs">
        <button :class="['df-tab', { active: step2Tab === 'chief' }]" @click="step2Tab = 'chief'">📝 主诉与现病史</button>
        <button :class="['df-tab', { active: step2Tab === 'four' }]" @click="step2Tab = 'four'">🔍 四诊信息</button>
      </div>

      <div v-if="step2Tab === 'chief'" class="df-tab-content">
        <div class="df-form-group full-width">
          <label>主诉 <span class="required">*</span></label>
          <textarea v-model="form.chiefComplaint" placeholder="请简述患者就诊的主要原因，包括主要症状、持续时间等" rows="3" required />
        </div>
        <div class="df-form-group full-width">
          <label>现病史</label>
          <textarea v-model="form.presentIllness" placeholder="请详细描述发病经过，包括症状特点、变化过程、已做检查和治疗情况等" rows="5" />
        </div>
      </div>

      <div v-if="step2Tab === 'four'" class="df-tab-content">
        <div class="df-four-grid">
          <div class="df-four-section">
            <h3>📳 脉诊</h3>
            <div class="df-form-grid-2">
              <div class="df-form-group">
                <label>左手脉象</label>
                <select v-model="symptoms.pulseLeft">
                  <option value="">请选择</option>
                  <option v-for="v in pulseOptions" :key="v" :value="v">{{ v }}</option>
                </select>
              </div>
              <div class="df-form-group">
                <label>右手脉象</label>
                <select v-model="symptoms.pulseRight">
                  <option value="">请选择</option>
                  <option v-for="v in pulseOptions" :key="v" :value="v">{{ v }}</option>
                </select>
              </div>
            </div>
            <div class="df-form-group full-width">
              <label>脉象描述</label>
              <textarea v-model="symptoms.pulseDescription" placeholder="请描述脉象特点" rows="2" />
            </div>
          </div>

          <div class="df-four-section">
            <h3>👅 舌诊</h3>
            <div class="df-form-grid-2">
              <div class="df-form-group">
                <label>舌质颜色</label>
                <select v-model="symptoms.tongueColor">
                  <option value="">请选择</option>
                  <option value="pale">淡舌</option>
                  <option value="red">红舌</option>
                  <option value="crimson">绛舌</option>
                  <option value="purple">紫舌</option>
                </select>
              </div>
              <div class="df-form-group">
                <label>舌苔</label>
                <select v-model="symptoms.tongueCoating">
                  <option value="">请选择</option>
                  <option value="thin-white">薄白苔</option>
                  <option value="thin-yellow">薄黄苔</option>
                  <option value="white-greasy">白腻苔</option>
                  <option value="yellow-greasy">黄腻苔</option>
                  <option value="less">少苔</option>
                  <option value="peeled">剥苔</option>
                </select>
              </div>
              <div class="df-form-group">
                <label>舌形</label>
                <select v-model="symptoms.tongueShape">
                  <option value="">请选择</option>
                  <option value="swollen">胖大舌</option>
                  <option value="cracked">裂纹舌</option>
                  <option value="tooth-marked">齿痕舌</option>
                </select>
              </div>
              <div class="df-form-group">
                <label>舌质纹理</label>
                <select v-model="symptoms.tongueTexture">
                  <option value="">请选择</option>
                  <option value="tender">嫩</option>
                  <option value="old">老</option>
                  <option value="moist">润</option>
                  <option value="dry">燥</option>
                </select>
              </div>
            </div>
          </div>

          <div class="df-four-section">
            <h3>👁 望诊</h3>
            <div class="df-form-grid-2">
              <div class="df-form-group">
                <label>面色</label>
                <select v-model="symptoms.facialColor">
                  <option value="">请选择</option>
                  <option value="pale">苍白</option>
                  <option value="flushed">潮红</option>
                  <option value="sallow">萎黄</option>
                  <option value="dark">暗黑</option>
                </select>
              </div>
              <div class="df-form-group">
                <label>神态</label>
                <select v-model="symptoms.expression">
                  <option value="">请选择</option>
                  <option value="alert">有神</option>
                  <option value="tired">少神</option>
                  <option value="apathetic">失神</option>
                </select>
              </div>
            </div>
          </div>

          <div class="df-four-section">
            <h3>🗣 问诊</h3>
            <div class="df-form-grid-2">
              <div class="df-form-group">
                <label>睡眠</label>
                <select v-model="symptoms.sleepQuality">
                  <option value="">请选择</option>
                  <option value="good">正常</option>
                  <option value="insomnia">失眠</option>
                  <option value="dreamy">多梦</option>
                  <option value="drowsy">嗜睡</option>
                </select>
              </div>
              <div class="df-form-group">
                <label>食欲</label>
                <select v-model="symptoms.appetite">
                  <option value="">请选择</option>
                  <option value="good">正常</option>
                  <option value="poor">纳差</option>
                  <option value="anorexia">厌食</option>
                </select>
              </div>
              <div class="df-form-group">
                <label>口渴</label>
                <select v-model="symptoms.thirst">
                  <option value="">请选择</option>
                  <option value="none">不渴</option>
                  <option value="thirsty">口渴</option>
                  <option value="dry">口干</option>
                  <option value="bitter">口苦</option>
                </select>
              </div>
              <div class="df-form-group">
                <label>二便</label>
                <select v-model="symptoms.bowelMovement">
                  <option value="">请选择</option>
                  <option value="normal">正常</option>
                  <option value="constipation">便秘</option>
                  <option value="diarrhea">便溏</option>
                </select>
              </div>
            </div>
          </div>
        </div>
      </div>

      <div class="df-step-actions">
        <button class="btn btn-outline" @click="currentStep = 1">
          <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><polyline points="15 18 9 12 15 6" /></svg>
          上一步
        </button>
        <button class="btn btn-primary" @click="currentStep = 3">
          下一步：辨证诊断
          <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><polyline points="9 18 15 12 9 6" /></svg>
        </button>
      </div>
    </div>

    <div v-if="currentStep === 3" class="df-agent-workflow">
      <div class="df-card df-agent-header-card">
        <div class="df-agent-title-row">
          <div>
            <h2 class="df-section-title" :style="{ marginBottom: '4px', borderBottom: 'none', paddingBottom: 0 }">辨证诊断 Agent</h2>
            <p class="df-agent-subtitle">基于四诊信息的智能辨证分析工作流</p>
          </div>
          <div class="df-agent-actions">
            <button v-if="agentStage === 'idle'" class="btn btn-primary" @click="startAgentWorkflow">
              <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><polygon points="5 3 19 12 5 21 5 3" /></svg>
              启动诊断
            </button>
            <button v-if="agentStage === 'output'" class="btn btn-outline" @click="resetAgent">重新诊断</button>
          </div>
        </div>

        <div class="df-agent-pipeline">
          <template v-for="(item, idx) in pipelineStages" :key="item.stage">
            <div v-if="idx > 0" :class="['df-pipeline-connector', { active: item.isActive }]" />
            <div :class="['df-pipeline-node', { active: item.isActive, current: item.isCurrent }]">
              <span class="df-pipeline-icon">{{ item.icon }}</span>
              <span class="df-pipeline-label">{{ item.label }}</span>
              <span v-if="item.isCurrent && agentStage !== 'output'" class="df-pipeline-dot" />
            </div>
          </template>
        </div>
      </div>

      <div v-if="agentStage !== 'idle'" :class="['df-card', 'df-agent-stage-card', agentStage === 'input' ? 'df-stage-active' : 'df-stage-done']">
        <div class="df-stage-header">
          <span class="df-stage-badge stage-input">📥 信息输入</span>
          <span class="df-stage-status">{{ agentStage === 'input' ? '处理中...' : '已完成' }}</span>
        </div>
        <div class="df-agent-input-box">
          <div class="df-agent-input-label">诊疗信息字符串 → Agent输入</div>
          <div class="df-agent-input-content">
            <span>{{ agentInput.slice(0, typingIndex) }}</span>
            <span v-if="agentStage === 'input' && typingIndex < agentInput.length" class="df-typing-cursor">|</span>
          </div>
        </div>
      </div>

      <div v-if="agentStage === 'preprocess' || agentStage === 'diagnosing' || agentStage === 'output'" :class="['df-card', 'df-agent-stage-card', agentStage === 'preprocess' ? 'df-stage-active' : 'df-stage-done']">
        <div class="df-stage-header">
          <span class="df-stage-badge stage-preprocess">🔑 预处理 · 关键词提取</span>
          <span class="df-stage-status">{{ agentStage === 'preprocess' ? '提取中...' : '已完成' }}</span>
        </div>
        <div class="df-keywords-box">
          <div class="df-keywords-label">提取的辨证关键词</div>
          <div class="df-keywords-list">
            <span v-for="(kw, i) in mockKeywords.slice(0, animatingKeywords)" :key="i" class="df-keyword-tag keyword-animate">{{ kw }}</span>
          </div>
        </div>
      </div>

      <div v-if="agentStage === 'diagnosing' || agentStage === 'output'" :class="['df-card', 'df-agent-stage-card', agentStage === 'diagnosing' ? 'df-stage-active' : 'df-stage-done']">
        <div class="df-stage-header">
          <span class="df-stage-badge stage-diagnosing">🧠 Agent 辨证诊断</span>
          <span class="df-stage-status">{{ agentStage === 'diagnosing' ? '分析中...' : '已完成' }}</span>
        </div>
        <div v-if="agentStage === 'diagnosing'" class="df-agent-thinking">
          <div class="df-thinking-dots">
            <span /><span /><span />
          </div>
          <p>Agent 正在进行辨证分析...</p>
          <div class="df-thinking-detail">基于关键词匹配与中医知识图谱推理</div>
        </div>
        <div v-else class="df-agent-done-msg">
          <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="#52C41A" stroke-width="2"><path d="M22 11.08V12a10 10 0 1 1-5.93-9.14" /><polyline points="22 4 12 14.01 9 11.01" /></svg>
          <span>辨证分析完成，输出 {{ agentOutput?.length || 0 }} 个候选证型</span>
        </div>
      </div>

      <div v-if="agentStage === 'output' && agentOutput" class="df-card df-agent-stage-card df-stage-active df-output-card">
        <div class="df-stage-header">
          <span class="df-stage-badge stage-output">📊 诊断结果输出</span>
        </div>

        <div class="df-result-cards">
          <div
            v-for="result in agentOutput"
            :key="result.pattern"
            :class="['df-result-card', { selected: selectedPattern === result.pattern }]"
            @click="handleSelectPattern(result)"
          >
            <div class="df-result-header">
              <span class="df-pattern-name">{{ result.pattern }}</span>
              <span class="df-confidence">{{ result.confidence }}%</span>
            </div>
            <p class="df-result-desc">{{ result.description }}</p>
            <div class="df-symptom-tags">
              <span v-for="(s, i) in result.symptoms" :key="i" class="df-symptom-tag">{{ s }}</span>
            </div>
          </div>
        </div>

        <div v-if="customDiagnoses.length > 0" class="df-custom-section-inline">
          <div class="df-card-header" :style="{ marginTop: '16px' }">
            <h2>已选辨证结果</h2>
            <span class="df-count-badge">{{ customDiagnoses.length }}</span>
          </div>
          <div class="df-custom-list">
            <div v-for="diag in customDiagnoses" :key="diag.id" class="df-custom-card">
              <div class="df-custom-header">
                <span class="df-custom-pattern">{{ diag.pattern }}</span>
                <button class="df-btn-remove" @click="handleRemoveCustom(diag.id)">×</button>
              </div>
              <p class="df-custom-desc">{{ diag.description }}</p>
              <div class="df-symptom-tags">
                <span v-for="(s, i) in diag.symptoms" :key="i" class="df-symptom-tag">{{ s }}</span>
              </div>
            </div>
          </div>
        </div>

        <div class="df-add-form" :style="{ marginTop: '16px' }">
          <h3 class="df-add-form-title">添加/修改辨证结果</h3>
          <div class="df-form-group">
            <label>证型名称</label>
            <input type="text" v-model="customPattern" placeholder="请输入证型名称或点击上方AI建议" />
          </div>
          <div class="df-form-group">
            <label>证型描述</label>
            <textarea v-model="customDescription" placeholder="请输入证型描述" rows="2" />
            <div v-if="selectedResult" class="df-ai-suggestion">
              <span class="df-suggestion-label">AI建议：</span>
              <button class="df-suggestion-btn" @click="customDescription = selectedResult.description">
                {{ selectedResult.description }}
              </button>
            </div>
          </div>
          <div class="df-form-group">
            <label>关键症状（用逗号分隔）</label>
            <input type="text" v-model="customSymptoms" placeholder="如：眩晕、头痛、失眠多梦" />
            <div v-if="selectedResult" class="df-ai-suggestion">
              <span class="df-suggestion-label">AI建议症状：</span>
              <div class="df-symptom-chips">
                <button
                  v-for="(s, i) in selectedResult.symptoms"
                  :key="i"
                  :class="['df-symptom-chip', { selected: customSymptoms.includes(s) }]"
                  @click="addSymptom(s)"
                >
                  {{ s }}
                </button>
              </div>
            </div>
          </div>
          <div class="df-add-actions">
            <button class="btn btn-ghost" @click="clearCustom">清空</button>
            <button class="btn btn-primary" @click="handleAddCustomDiagnosis">添加到自选</button>
          </div>
        </div>

        <div :style="{ marginTop: '20px' }">
          <h2 class="df-section-title">证候详情</h2>
          <div class="df-detail-grid">
            <div class="df-detail-item"><label>证型名称</label><span>{{ selectedPattern || '肝阳上亢证' }}</span></div>
            <div class="df-detail-item"><label>证候编码</label><span>B01.02</span></div>
            <div class="df-detail-item"><label>病因病机</label><span>情志内伤，肝肾阴虚，水不涵木</span></div>
            <div class="df-detail-item"><label>典型脉象</label><span>脉弦数</span></div>
            <div class="df-detail-item"><label>典型舌象</label><span>舌红，苔黄</span></div>
          </div>
          <div class="df-diff-section">
            <h3>症状辨证权重</h3>
            <div v-for="(item, index) in patternDetails['肝阳上亢']?.differentiation" :key="index" class="df-diff-item">
              <span class="df-diff-symptom">{{ item.symptom }}</span>
              <div class="df-diff-bar">
                <div :class="['df-diff-fill', item.weight === '主要' ? 'major' : 'minor']" :style="{ width: item.weight === '主要' ? '80%' : '50%' }" />
              </div>
              <span :class="['df-diff-weight', item.weight === '主要' ? 'major' : 'minor']">{{ item.weight }}</span>
            </div>
          </div>
        </div>
      </div>

      <div v-if="agentStage === 'idle'" class="df-card df-agent-idle-card">
        <div class="df-idle-content">
          <div class="df-idle-icon">🧠</div>
          <h3>辨证诊断 Agent 就绪</h3>
          <p>点击"启动诊断"按钮，Agent 将自动完成以下工作流：</p>
          <div class="df-idle-steps">
            <div class="df-idle-step"><span class="df-idle-step-num">1</span><span>接收诊疗流程信息字符串</span></div>
            <div class="df-idle-step-arrow">→</div>
            <div class="df-idle-step"><span class="df-idle-step-num">2</span><span>预处理提取关键词</span></div>
            <div class="df-idle-step-arrow">→</div>
            <div class="df-idle-step"><span class="df-idle-step-num">3</span><span>Agent辨证分析</span></div>
            <div class="df-idle-step-arrow">→</div>
            <div class="df-idle-step"><span class="df-idle-step-num">4</span><span>输出诊断结果</span></div>
          </div>
        </div>
      </div>

      <div class="df-agent-sidebar">
        <div class="df-sidebar-card">
          <h3>四诊摘要</h3>
          <div class="df-summary-list">
            <div class="df-summary-item"><label>脉诊</label><span>{{ symptoms.pulseLeft ? `左手${symptoms.pulseLeft}` : '左手未述' }}，{{ symptoms.pulseRight ? `右手${symptoms.pulseRight}` : '右手未述' }}</span></div>
            <div class="df-summary-item"><label>舌诊</label><span>{{ symptoms.tongueColor ? `舌质${symptoms.tongueColor}` : '未述' }}，{{ symptoms.tongueCoating ? `苔${symptoms.tongueCoating}` : '未述' }}</span></div>
            <div class="df-summary-item"><label>望诊</label><span>{{ symptoms.facialColor ? `面色${symptoms.facialColor}` : '未述' }}</span></div>
            <div class="df-summary-item"><label>问诊</label><span>{{ askSummary }}</span></div>
          </div>
        </div>
        <div class="df-sidebar-card df-warning-card">
          <div class="df-warning-icon">⚠️</div>
          <div>
            <h4>注意事项</h4>
            <p>Agent诊断结果仅供参考，请结合临床经验进行最终判断</p>
          </div>
        </div>
      </div>

      <div class="df-step-actions">
        <button class="btn btn-outline" @click="currentStep = 2">
          <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><polyline points="15 18 9 12 15 6" /></svg>
          上一步
        </button>
        <button v-if="agentStage === 'output'" class="btn btn-primary btn-lg" @click="handleConfirm">确认诊断</button>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref, computed, watch } from 'vue'

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

type AgentStage = 'idle' | 'input' | 'preprocess' | 'diagnosing' | 'output'

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

const pulseOptions = ['浮', '沉', '迟', '数', '弱', '弦', '滑', '涩', '紧', '缓', '细', '芤', '虚', '实']
const mockKeywords = ['眩晕', '头痛', '失眠', '脉弦数', '舌红', '苔黄', '腰膝酸软', '口苦', '面色潮红']

const steps = [
  { num: 1, label: '患者录入', icon: '📋' },
  { num: 2, label: '四诊采集', icon: '🔍' },
  { num: 3, label: '辨证诊断', icon: '🩺' },
]

const currentStep = ref(1)
const step2Tab = ref<'chief' | 'four'>('chief')

const form = ref<PatientForm>({
  name: '', gender: '', age: '', phone: '', idCard: '', birthDate: '',
  occupation: '', ethnicity: '汉族', maritalStatus: '', address: '',
  emergencyContact: '', emergencyPhone: '', chiefComplaint: '',
  presentIllness: '', pastHistory: '', familyHistory: '', allergyHistory: '',
})

const symptoms = ref<SymptomForm>({
  pulseLeft: '', pulseRight: '', pulseDescription: '', tongueColor: '',
  tongueShape: '', tongueCoating: '', tongueTexture: '', tongueRemark: '',
  facialColor: '', expression: '', mentalState: '', breathSound: '',
  speechSound: '', sweating: '', limbsTemperature: '', sleepQuality: '',
  appetite: '', thirst: '', taste: '', bowelMovement: '', urineColor: '',
  menstrualCycle: '',
})

const selectedPattern = ref('')
const customDiagnoses = ref<CustomDiagnosis[]>([])
const customPattern = ref('')
const customDescription = ref('')
const customSymptoms = ref('')

const agentStage = ref<AgentStage>('idle')
const agentInput = ref('')
const extractedKeywords = ref<string[]>([])
const agentOutput = ref<DiagnosisResult[] | null>(null)
const animatingKeywords = ref(0)
const typingIndex = ref(0)

const selectedResult = computed(() => diagnosisResults.find(r => r.pattern === selectedPattern.value))

const pipelineStages = computed(() => {
  const stageOrder: AgentStage[] = ['input', 'preprocess', 'diagnosing', 'output']
  const stageLabels: Record<AgentStage, string> = { idle: '', input: '信息输入', preprocess: '预处理·关键词提取', diagnosing: 'Agent诊断', output: '结果输出' }
  const stageIcons: Record<AgentStage, string> = { idle: '', input: '📥', preprocess: '🔑', diagnosing: '🧠', output: '📊' }
  const currentIdx = stageOrder.indexOf(agentStage.value)
  return stageOrder.map((stage, idx) => ({
    stage,
    label: stageLabels[stage],
    icon: stageIcons[stage],
    isActive: idx <= currentIdx,
    isCurrent: stage === agentStage.value,
  }))
})

const askSummary = computed(() => {
  const parts = [
    symptoms.value.sleepQuality && `睡眠${symptoms.value.sleepQuality}`,
    symptoms.value.appetite && `食欲${symptoms.value.appetite}`,
    symptoms.value.thirst && `口渴${symptoms.value.thirst}`,
    symptoms.value.bowelMovement && `二便${symptoms.value.bowelMovement}`,
  ].filter(Boolean).join('，')
  return parts || '未述'
})

const goToStep = (num: number) => {
  if (currentStep.value >= num) currentStep.value = num
}

const handleSelectPattern = (result: DiagnosisResult) => {
  customPattern.value = result.pattern
  customDescription.value = result.description
  customSymptoms.value = result.symptoms.join('、')
  selectedPattern.value = result.pattern
}

const handleAddCustomDiagnosis = () => {
  if (!customPattern.value.trim()) return
  const newDiagnosis: CustomDiagnosis = {
    id: Date.now().toString(),
    pattern: customPattern.value,
    description: customDescription.value,
    symptoms: customSymptoms.value.split(/[,，、]/).map(s => s.trim()).filter(s => s)
  }
  customDiagnoses.value = [...customDiagnoses.value, newDiagnosis]
  customPattern.value = ''
  customDescription.value = ''
  customSymptoms.value = ''
  selectedPattern.value = ''
}

const handleRemoveCustom = (id: string) => {
  customDiagnoses.value = customDiagnoses.value.filter(d => d.id !== id)
}

const handleConfirm = () => {
  alert('辨证诊断已保存！')
}

const buildDiagnosisInput = () => {
  const parts: string[] = []
  if (form.value.name) parts.push(`患者${form.value.name}，${form.value.gender === 'male' ? '男' : '女'}，${form.value.age}岁。`)
  if (form.value.chiefComplaint) parts.push(`主诉：${form.value.chiefComplaint}。`)
  if (form.value.presentIllness) parts.push(`现病史：${form.value.presentIllness}。`)
  if (form.value.pastHistory) parts.push(`既往史：${form.value.pastHistory}。`)
  if (symptoms.value.pulseLeft || symptoms.value.pulseRight) parts.push(`脉诊：左手${symptoms.value.pulseLeft || '未述'}，右手${symptoms.value.pulseRight || '未述'}。${symptoms.value.pulseDescription || ''}`)
  if (symptoms.value.tongueColor || symptoms.value.tongueCoating) parts.push(`舌诊：舌质${symptoms.value.tongueColor || '未述'}，苔${symptoms.value.tongueCoating || '未述'}。`)
  if (symptoms.value.facialColor) parts.push(`望诊：面色${symptoms.value.facialColor}。`)
  if (symptoms.value.sleepQuality || symptoms.value.appetite || symptoms.value.thirst || symptoms.value.bowelMovement) {
    const askParts: string[] = []
    if (symptoms.value.sleepQuality) askParts.push(`睡眠${symptoms.value.sleepQuality}`)
    if (symptoms.value.appetite) askParts.push(`食欲${symptoms.value.appetite}`)
    if (symptoms.value.thirst) askParts.push(`口渴${symptoms.value.thirst}`)
    if (symptoms.value.bowelMovement) askParts.push(`二便${symptoms.value.bowelMovement}`)
    parts.push(`问诊：${askParts.join('，')}。`)
  }
  return parts.join('') || '暂无诊疗信息，请返回前两步填写患者信息。'
}

const startAgentWorkflow = () => {
  const inputText = buildDiagnosisInput()
  agentInput.value = inputText
  agentStage.value = 'input'
  extractedKeywords.value = []
  agentOutput.value = null
  animatingKeywords.value = 0
  typingIndex.value = 0
}

const resetAgent = () => {
  agentStage.value = 'idle'
  agentOutput.value = null
  typingIndex.value = 0
  animatingKeywords.value = 0
}

const clearCustom = () => {
  customPattern.value = ''
  customDescription.value = ''
  customSymptoms.value = ''
  selectedPattern.value = ''
}

const addSymptom = (s: string) => {
  const current = customSymptoms.value.split(/[,，、]/).map(x => x.trim()).filter(x => x)
  if (!current.includes(s)) {
    customSymptoms.value = [...current, s].join('、')
  }
}

watch([agentStage, typingIndex, animatingKeywords], (_a, _b, onCleanup) => {
  const stage = agentStage.value
  if (stage === 'input') {
    if (typingIndex.value < agentInput.value.length) {
      const timer = setTimeout(() => { typingIndex.value += 3 }, 30)
      onCleanup(() => clearTimeout(timer))
    } else {
      const timer = setTimeout(() => { agentStage.value = 'preprocess' }, 500)
      onCleanup(() => clearTimeout(timer))
    }
  }
  if (stage === 'preprocess') {
    if (animatingKeywords.value < mockKeywords.length) {
      const timer = setTimeout(() => { animatingKeywords.value += 1 }, 300)
      onCleanup(() => clearTimeout(timer))
    } else {
      const timer = setTimeout(() => { agentStage.value = 'diagnosing' }, 600)
      onCleanup(() => clearTimeout(timer))
    }
  }
  if (stage === 'diagnosing') {
    const timer = setTimeout(() => {
      agentOutput.value = diagnosisResults
      agentStage.value = 'output'
    }, 2000)
    onCleanup(() => clearTimeout(timer))
  }
})
</script>

<style scoped>
.diagnosis-flow {
  padding: 8px 20px;
  max-width: 1400px;
  margin: 0 auto;
}

.df-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 6px;
}

.df-header h1 {
  font-size: 20px;
  font-weight: 600;
  color: var(--text-primary);
}

.df-header p {
  font-size: 12px;
  color: var(--text-secondary);
  margin-top: 2px;
}

.df-header-actions {
  display: flex;
  gap: 10px;
}

.df-step-nav {
  display: flex;
  align-items: center;
  gap: 0;
  background: var(--bg-white);
  border: 1px solid var(--border);
  border-radius: var(--radius-lg);
  padding: 5px 16px;
  margin-bottom: 8px;
  box-shadow: var(--shadow-sm);
}

.df-step {
  display: flex;
  align-items: center;
  gap: 5px;
  padding: 4px 10px;
  border-radius: var(--radius);
  cursor: default;
  transition: var(--transition);
  font-size: 13px;
  color: var(--text-muted);
  font-weight: 500;
}

.df-step.active {
  color: var(--primary);
  cursor: pointer;
}

.df-step.active:hover {
  background: var(--primary-bg);
}

.df-step.current {
  background: var(--primary-bg);
  color: var(--primary);
  font-weight: 600;
}

.df-step-icon {
  font-size: 16px;
}

.df-step-label {
  font-size: 14px;
}

.df-step-connector {
  color: var(--border);
  display: flex;
  align-items: center;
  padding: 0 4px;
}

.df-step-connector.done {
  color: var(--primary);
}

.df-card {
  background: var(--bg-white);
  border: 1px solid var(--border);
  border-radius: var(--radius-lg);
  padding: 12px 16px;
  box-shadow: var(--shadow-sm);
  margin-bottom: 8px;
}

.df-card-header {
  display: flex;
  align-items: center;
  justify-content: space-between;
  margin-bottom: 20px;
  padding-bottom: 16px;
  border-bottom: 1px solid var(--border-light);
}

.df-card-header h2 {
  font-size: 17px;
  font-weight: 600;
  color: var(--text-primary);
}

.df-section-title {
  font-size: 15px;
  font-weight: 600;
  color: var(--text-primary);
  margin-bottom: 10px;
  padding-bottom: 6px;
  border-bottom: 1px solid var(--border-light);
}

.df-form-grid {
  display: grid;
  grid-template-columns: repeat(3, 1fr);
  gap: 10px;
  margin-bottom: 6px;
}

.df-form-grid-2 {
  display: grid;
  grid-template-columns: repeat(2, 1fr);
  gap: 8px;
}

.df-form-group {
  display: flex;
  flex-direction: column;
  gap: 3px;
  margin-bottom: 6px;
}

.df-form-group.full-width {
  grid-column: 1 / -1;
}

.df-form-group label {
  font-size: 13px;
  color: var(--text-secondary);
  font-weight: 500;
}

.df-form-group .required {
  color: var(--danger);
}

.df-form-group input,
.df-form-group select,
.df-form-group textarea {
  padding: 5px 8px;
  border: 1px solid var(--border);
  border-radius: var(--radius-sm);
  font-size: 13px;
  background: var(--bg-white);
  color: var(--text-primary);
  transition: var(--transition);
  font-family: var(--font-family);
}

.df-form-group input:focus,
.df-form-group select:focus,
.df-form-group textarea:focus {
  border-color: var(--primary);
  box-shadow: 0 0 0 2px var(--primary-bg);
  outline: none;
}

.df-form-group textarea {
  resize: vertical;
  min-height: 38px;
}

.df-tabs {
  display: flex;
  gap: 4px;
  margin-bottom: 8px;
  border-bottom: 2px solid var(--border-light);
}

.df-tab {
  padding: 6px 14px;
  background: none;
  border: none;
  border-bottom: 2px solid transparent;
  margin-bottom: -2px;
  font-size: 13px;
  font-weight: 500;
  color: var(--text-secondary);
  cursor: pointer;
  transition: var(--transition);
  border-radius: var(--radius-sm) var(--radius-sm) 0 0;
}

.df-tab:hover {
  color: var(--primary);
  background: var(--primary-bg);
}

.df-tab.active {
  color: var(--primary);
  border-bottom-color: var(--primary);
  font-weight: 600;
}

.df-tab-content {
  padding: 2px 0;
}

.df-four-grid {
  display: grid;
  grid-template-columns: repeat(2, 1fr);
  gap: 8px;
}

.df-four-section {
  background: var(--bg-page);
  border: 1px solid var(--border-light);
  border-radius: var(--radius);
  padding: 10px;
}

.df-four-section h3 {
  font-size: 14px;
  font-weight: 600;
  color: var(--text-primary);
  margin-bottom: 6px;
  padding-bottom: 5px;
  border-bottom: 1px solid var(--border-light);
}

.df-four-section .df-form-group input,
.df-four-section .df-form-group select {
  padding: 6px 10px;
}

.df-four-section .df-form-group textarea {
  resize: vertical;
  min-height: 80px;
  padding: 6px 10px;
}

.df-step-actions {
  display: flex;
  justify-content: flex-end;
  gap: 8px;
  margin-top: 2px;
  padding-top: 2px;
  border-top: 1px solid var(--border-light);
}

.df-diagnosis-layout {
  display: grid;
  grid-template-columns: 1fr 300px;
  gap: 16px;
  align-items: start;
}

.df-diagnosis-main {
  display: flex;
  flex-direction: column;
  gap: 16px;
}

.df-diagnosis-sidebar {
  display: flex;
  flex-direction: column;
  gap: 16px;
  position: sticky;
  top: 76px;
}

.df-result-cards {
  display: flex;
  flex-direction: column;
  gap: 12px;
}

.df-result-card {
  padding: 16px;
  border: 2px solid var(--border);
  border-radius: var(--radius);
  cursor: pointer;
  transition: var(--transition);
}

.df-result-card:hover {
  border-color: var(--primary-light);
}

.df-result-card.selected {
  border-color: var(--primary);
  background: var(--primary-bg);
}

.df-result-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 10px;
}

.df-pattern-name {
  font-size: 16px;
  font-weight: 600;
  color: var(--text-primary);
}

.df-confidence {
  font-size: 18px;
  font-weight: 700;
  color: var(--primary);
}

.df-result-desc {
  font-size: 13px;
  color: var(--text-secondary);
  line-height: 1.6;
  margin-bottom: 10px;
}

.df-symptom-tags {
  display: flex;
  flex-wrap: wrap;
  gap: 6px;
}

.df-symptom-tag {
  padding: 3px 10px;
  background: var(--bg-page);
  border-radius: 100px;
  font-size: 12px;
  color: var(--text-secondary);
}

.df-ai-badge {
  padding: 3px 10px;
  background: linear-gradient(135deg, #722ed1, #531d93);
  color: white;
  font-size: 11px;
  font-weight: 600;
  border-radius: 100px;
}

.df-custom-section {
  border-color: var(--success);
}

.df-custom-list {
  display: flex;
  flex-direction: column;
  gap: 10px;
}

.df-custom-card {
  padding: 14px;
  background: #F0FFF4;
  border: 1px solid #B7EB8F;
  border-radius: var(--radius);
}

.df-custom-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 6px;
}

.df-custom-pattern {
  font-size: 15px;
  font-weight: 600;
  color: #389E0D;
}

.df-btn-remove {
  width: 22px;
  height: 22px;
  border: none;
  background: #F5F5F5;
  border-radius: 50%;
  font-size: 14px;
  color: #999;
  cursor: pointer;
  display: flex;
  align-items: center;
  justify-content: center;
}

.df-btn-remove:hover {
  background: #FFD6D6;
  color: var(--danger);
}

.df-custom-desc {
  font-size: 13px;
  color: var(--text-secondary);
  line-height: 1.5;
  margin-bottom: 8px;
}

.df-count-badge {
  display: inline-flex;
  align-items: center;
  justify-content: center;
  min-width: 20px;
  height: 20px;
  padding: 0 6px;
  background: var(--danger);
  color: white;
  font-size: 11px;
  font-weight: 600;
  border-radius: 10px;
}

.df-add-form {
  display: flex;
  flex-direction: column;
  gap: 12px;
}

.df-add-actions {
  display: flex;
  justify-content: flex-end;
  gap: 10px;
  margin-top: 4px;
}

.df-ai-suggestion {
  margin-top: 8px;
  padding: 10px 12px;
  background: var(--primary-bg);
  border-radius: var(--radius-sm);
  border-left: 3px solid var(--primary);
}

.df-suggestion-label {
  font-size: 12px;
  color: var(--primary);
  font-weight: 500;
  display: block;
  margin-bottom: 6px;
}

.df-suggestion-btn {
  width: 100%;
  text-align: left;
  background: none;
  border: none;
  font-size: 13px;
  color: var(--text-primary);
  line-height: 1.6;
  cursor: pointer;
  padding: 0;
}

.df-suggestion-btn:hover {
  color: var(--primary);
}

.df-symptom-chips {
  display: flex;
  flex-wrap: wrap;
  gap: 6px;
  margin-top: 6px;
}

.df-symptom-chip {
  padding: 3px 10px;
  background: var(--bg-white);
  border: 1px solid var(--border);
  border-radius: 100px;
  font-size: 12px;
  color: var(--text-secondary);
  cursor: pointer;
  transition: var(--transition);
}

.df-symptom-chip:hover {
  border-color: var(--primary);
  color: var(--primary);
}

.df-symptom-chip.selected {
  background: var(--primary);
  border-color: var(--primary);
  color: white;
}

.df-detail-grid {
  display: grid;
  grid-template-columns: repeat(3, 1fr);
  gap: 12px;
  margin-bottom: 20px;
}

.df-detail-item {
  display: flex;
  flex-direction: column;
  gap: 4px;
}

.df-detail-item label {
  font-size: 12px;
  color: var(--text-muted);
}

.df-detail-item span {
  font-size: 13px;
  color: var(--text-primary);
  font-weight: 500;
}

.df-diff-section {
  padding-top: 16px;
  border-top: 1px solid var(--border-light);
}

.df-diff-section h3 {
  font-size: 14px;
  font-weight: 600;
  color: var(--text-primary);
  margin-bottom: 12px;
}

.df-diff-item {
  display: flex;
  align-items: center;
  gap: 12px;
  margin-bottom: 10px;
}

.df-diff-symptom {
  width: 72px;
  font-size: 13px;
  color: var(--text-primary);
}

.df-diff-bar {
  flex: 1;
  height: 8px;
  background: var(--border-light);
  border-radius: 4px;
  overflow: hidden;
}

.df-diff-fill {
  height: 100%;
  border-radius: 4px;
  transition: width 0.3s;
}

.df-diff-fill.major {
  background: var(--primary);
}

.df-diff-fill.minor {
  background: var(--primary-light);
}

.df-diff-weight {
  width: 40px;
  font-size: 12px;
  text-align: right;
}

.df-diff-weight.major {
  color: var(--primary);
  font-weight: 600;
}

.df-diff-weight.minor {
  color: var(--text-muted);
}

.df-sidebar-card {
  background: var(--bg-white);
  border: 1px solid var(--border);
  border-radius: var(--radius);
  padding: 10px;
  box-shadow: var(--shadow-sm);
}

.df-sidebar-card h3 {
  font-size: 14px;
  font-weight: 600;
  color: var(--text-primary);
  margin-bottom: 8px;
}

.df-summary-list {
  display: flex;
  flex-direction: column;
  gap: 8px;
}

.df-summary-item {
  display: flex;
  flex-direction: column;
  gap: 2px;
  padding: 6px 8px;
  background: var(--bg-page);
  border-radius: var(--radius-sm);
}

.df-summary-item label {
  font-size: 11px;
  color: var(--text-muted);
}

.df-summary-item span {
  font-size: 13px;
  color: var(--text-primary);
}

.df-warning-card {
  display: flex;
  gap: 12px;
  background: #FFF7E6;
  border-color: #FFD591;
}

.df-warning-icon {
  font-size: 22px;
}

.df-warning-card h4 {
  font-size: 14px;
  color: #D46B08;
  margin-bottom: 4px;
}

.df-warning-card p {
  font-size: 13px;
  color: var(--text-secondary);
  line-height: 1.5;
}

.df-agent-workflow {
  display: flex;
  flex-direction: column;
  gap: 16px;
}

.df-agent-header-card {
  padding: 20px 24px;
}

.df-agent-title-row {
  display: flex;
  justify-content: space-between;
  align-items: flex-start;
  margin-bottom: 16px;
}

.df-agent-subtitle {
  font-size: 13px;
  color: var(--text-muted);
  margin-top: 4px;
}

.df-agent-actions {
  display: flex;
  gap: 8px;
}

.df-agent-pipeline {
  display: flex;
  align-items: center;
  gap: 0;
  padding: 12px 16px;
  background: var(--bg-page);
  border-radius: var(--radius);
  border: 1px solid var(--border-light);
}

.df-pipeline-node {
  display: flex;
  align-items: center;
  gap: 6px;
  padding: 8px 14px;
  border-radius: var(--radius);
  font-size: 13px;
  color: var(--text-muted);
  transition: var(--transition);
  position: relative;
  white-space: nowrap;
}

.df-pipeline-node.active {
  color: var(--primary);
  background: var(--primary-bg);
}

.df-pipeline-node.current {
  background: var(--primary);
  color: #fff;
  font-weight: 600;
  box-shadow: 0 2px 8px rgba(74, 144, 217, 0.3);
}

.df-pipeline-icon {
  font-size: 16px;
}

.df-pipeline-label {
  font-size: 12px;
}

.df-pipeline-connector {
  width: 32px;
  height: 2px;
  background: var(--border);
  flex-shrink: 0;
  transition: var(--transition);
}

.df-pipeline-connector.active {
  background: var(--primary);
}

.df-pipeline-dot {
  position: absolute;
  bottom: -4px;
  left: 50%;
  transform: translateX(-50%);
  width: 6px;
  height: 6px;
  border-radius: 50%;
  background: var(--primary);
  animation: pipeline-pulse 1.2s ease-in-out infinite;
}

@keyframes pipeline-pulse {
  0%, 100% { opacity: 1; transform: translateX(-50%) scale(1); }
  50% { opacity: 0.5; transform: translateX(-50%) scale(1.5); }
}

.df-agent-stage-card {
  position: relative;
  transition: var(--transition);
  animation: stage-fade-in 0.4s ease-out;
}

@keyframes stage-fade-in {
  from { opacity: 0; transform: translateY(12px); }
  to { opacity: 1; transform: translateY(0); }
}

.df-stage-active {
  border-color: var(--primary);
  box-shadow: 0 0 0 1px var(--primary-bg), var(--shadow);
}

.df-stage-done {
  border-color: var(--success);
  opacity: 0.85;
}

.df-stage-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 14px;
}

.df-stage-badge {
  display: inline-flex;
  align-items: center;
  gap: 4px;
  padding: 4px 12px;
  border-radius: 100px;
  font-size: 13px;
  font-weight: 600;
}

.stage-input {
  background: #E6F7FF;
  color: #1890FF;
}

.stage-preprocess {
  background: #FFF8E6;
  color: #D4880A;
}

.stage-diagnosing {
  background: #F0E6FF;
  color: #722ED1;
}

.stage-output {
  background: #F0FFF4;
  color: #389E0D;
}

.df-stage-status {
  font-size: 12px;
  color: var(--text-muted);
  font-weight: 500;
}

.df-stage-active .df-stage-status {
  color: var(--primary);
  animation: status-blink 1.5s ease-in-out infinite;
}

@keyframes status-blink {
  0%, 100% { opacity: 1; }
  50% { opacity: 0.4; }
}

.df-agent-input-box {
  background: var(--bg-page);
  border-radius: var(--radius);
  padding: 14px 16px;
  border: 1px solid var(--border-light);
}

.df-agent-input-label {
  font-size: 11px;
  color: var(--text-muted);
  margin-bottom: 8px;
  font-weight: 500;
  text-transform: uppercase;
  letter-spacing: 0.5px;
}

.df-agent-input-content {
  font-size: 13px;
  color: var(--text-primary);
  line-height: 1.8;
  min-height: 40px;
}

.df-typing-cursor {
  color: var(--primary);
  font-weight: 700;
  animation: cursor-blink 0.8s step-end infinite;
}

@keyframes cursor-blink {
  0%, 100% { opacity: 1; }
  50% { opacity: 0; }
}

.df-keywords-box {
  background: var(--bg-page);
  border-radius: var(--radius);
  padding: 14px 16px;
  border: 1px solid var(--border-light);
}

.df-keywords-label {
  font-size: 11px;
  color: var(--text-muted);
  margin-bottom: 10px;
  font-weight: 500;
  text-transform: uppercase;
  letter-spacing: 0.5px;
}

.df-keywords-list {
  display: flex;
  flex-wrap: wrap;
  gap: 8px;
}

.df-keyword-tag {
  padding: 4px 14px;
  background: var(--bg-white);
  border: 1px solid var(--primary-light);
  border-radius: 100px;
  font-size: 13px;
  color: var(--primary);
  font-weight: 500;
  animation: keyword-pop 0.3s ease-out;
}

@keyframes keyword-pop {
  from { opacity: 0; transform: scale(0.8); }
  to { opacity: 1; transform: scale(1); }
}

.df-agent-thinking {
  text-align: center;
  padding: 24px 16px;
  background: linear-gradient(135deg, #F0E6FF 0%, #EBF4FD 100%);
  border-radius: var(--radius);
}

.df-thinking-dots {
  display: flex;
  justify-content: center;
  gap: 6px;
  margin-bottom: 12px;
}

.df-thinking-dots span {
  width: 10px;
  height: 10px;
  border-radius: 50%;
  background: #722ED1;
  animation: thinking-bounce 1.4s ease-in-out infinite;
}

.df-thinking-dots span:nth-child(2) {
  animation-delay: 0.2s;
}

.df-thinking-dots span:nth-child(3) {
  animation-delay: 0.4s;
}

@keyframes thinking-bounce {
  0%, 80%, 100% { transform: scale(0.6); opacity: 0.4; }
  40% { transform: scale(1); opacity: 1; }
}

.df-agent-thinking p {
  font-size: 14px;
  color: #722ED1;
  font-weight: 600;
  margin-bottom: 4px;
}

.df-thinking-detail {
  font-size: 12px;
  color: var(--text-muted);
}

.df-agent-done-msg {
  display: flex;
  align-items: center;
  gap: 10px;
  padding: 14px 16px;
  background: #F0FFF4;
  border-radius: var(--radius);
  border: 1px solid #B7EB8F;
  font-size: 14px;
  color: #389E0D;
  font-weight: 500;
}

.df-output-card {
  border-color: var(--success);
}

.df-add-form-title {
  font-size: 15px;
  font-weight: 600;
  color: var(--text-primary);
  margin-bottom: 14px;
  padding-bottom: 10px;
  border-bottom: 1px solid var(--border-light);
}

.df-custom-section-inline {
  margin-top: 4px;
}

.df-agent-idle-card {
  padding: 40px 24px;
  text-align: center;
}

.df-idle-content {
  display: flex;
  flex-direction: column;
  align-items: center;
  gap: 12px;
}

.df-idle-icon {
  font-size: 48px;
  margin-bottom: 4px;
}

.df-idle-content h3 {
  font-size: 18px;
  font-weight: 600;
  color: var(--text-primary);
}

.df-idle-content p {
  font-size: 13px;
  color: var(--text-secondary);
}

.df-idle-steps {
  display: flex;
  align-items: center;
  gap: 8px;
  margin-top: 16px;
  padding: 16px 20px;
  background: var(--bg-page);
  border-radius: var(--radius);
  border: 1px solid var(--border-light);
  flex-wrap: wrap;
  justify-content: center;
}

.df-idle-step {
  display: flex;
  align-items: center;
  gap: 6px;
  padding: 8px 14px;
  background: var(--bg-white);
  border: 1px solid var(--border);
  border-radius: var(--radius);
  font-size: 13px;
  color: var(--text-primary);
}

.df-idle-step-num {
  width: 22px;
  height: 22px;
  border-radius: 50%;
  background: var(--primary);
  color: #fff;
  font-size: 12px;
  font-weight: 600;
  display: flex;
  align-items: center;
  justify-content: center;
}

.df-idle-step-arrow {
  font-size: 16px;
  color: var(--primary);
  font-weight: 700;
}

.df-agent-sidebar {
  display: flex;
  flex-direction: column;
  gap: 16px;
  margin-top: 4px;
}

@media (max-width: 1100px) {
  .df-diagnosis-layout {
    grid-template-columns: 1fr;
  }
  .df-diagnosis-sidebar {
    position: static;
  }
  .df-form-grid {
    grid-template-columns: repeat(2, 1fr);
  }
  .df-four-grid {
    grid-template-columns: 1fr;
  }
  .df-detail-grid {
    grid-template-columns: repeat(2, 1fr);
  }
  .df-agent-pipeline {
    flex-wrap: wrap;
    gap: 4px;
  }
  .df-pipeline-connector {
    width: 16px;
  }
  .df-idle-steps {
    flex-direction: column;
  }
  .df-idle-step-arrow {
    transform: rotate(90deg);
  }
}
</style>
