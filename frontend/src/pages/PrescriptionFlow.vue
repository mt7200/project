<template>
  <div class="pf-page">
    <header class="pf-header">
      <h1>开方审方</h1>
      <p>智能开方与处方审核一体化工作台</p>
    </header>

    <div class="pf-body">
      <!-- ===== 左侧：智能开方 ===== -->
      <div class="pf-left">
        <div class="pf-section-title">
          <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M9 5H7a2 2 0 0 0-2 2v12a2 2 0 0 0 2 2h10a2 2 0 0 0 2-2V7a2 2 0 0 0-2-2h-2" /><rect x="9" y="3" width="6" height="4" rx="1" /><path d="M12 11v3" /><path d="M9 12.5h6" /></svg>
          智能开方
        </div>

        <div v-if="compatibilityWarnings.length > 0" class="pf-warning-banner">
          <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M10.29 3.86L1.82 18a2 2 0 0 0 1.71 3h16.94a2 2 0 0 0 1.71-3L13.71 3.86a2 2 0 0 0-3.42 0z" /><line x1="12" y1="9" x2="12" y2="13" /><line x1="12" y1="17" x2="12.01" y2="17" /></svg>
          <span>配伍风险 {{ compatibilityWarnings.length }} 项</span>
        </div>

        <div class="card pf-compact">
          <div class="card-header"><h3>选择患者</h3></div>
          <div class="card-body">
            <div class="pf-patient-list">
              <div
                v-for="p in mockPatients"
                :key="p.id"
                :class="['pf-patient-card', { selected: selectedPatient === p.id }]"
                @click="selectedPatient = p.id"
              >
                <div class="pf-patient-avatar">{{ p.name[0] }}</div>
                <div class="pf-patient-info">
                  <span class="pf-patient-name">{{ p.name }}</span>
                  <span class="pf-patient-meta">{{ p.gender }} · {{ p.age }}岁</span>
                </div>
                <span class="tag tag-blue">{{ p.diagnosis }}</span>
              </div>
            </div>
          </div>
        </div>

        <div class="card pf-compact">
          <div class="card-header"><h3>推荐方剂</h3></div>
          <div class="card-body">
            <div class="pf-formula-grid">
              <button
                v-for="f in commonFormulas"
                :key="f.name"
                :class="['pf-formula-card', { active: selectedFormula === f.name }]"
                @click="applyFormula(f.name)"
              >
                <span class="pf-formula-name">{{ f.name }}</span>
                <span class="tag tag-blue">{{ f.category }}</span>
                <span class="pf-formula-herbs">{{ f.herbs.join('、') }}</span>
              </button>
            </div>
          </div>
        </div>

        <div class="card pf-compact">
          <div class="card-header">
            <h3>处方明细</h3>
            <span class="pf-herb-count">{{ selectedHerbs.length }} 味</span>
          </div>
          <div class="card-body">
            <div v-if="selectedHerbs.length === 0" class="empty-state" :style="{ padding: '30px 10px' }">
              <p>请选择方剂或从药库添加</p>
            </div>
            <div v-else class="pf-herbs-list">
              <div
                v-for="herb in selectedHerbs"
                :key="herb.id"
                :class="['pf-herb-item', { warning: herb.currentDosage > herb.maxDosage || (herb.currentDosage < herb.minDosage && herb.currentDosage > 0) }]"
              >
                <div class="pf-herb-main">
                  <span class="pf-herb-name">
                    {{ herb.name
                    }}<span v-if="herb.toxic" class="tag tag-red" :style="{ marginLeft: '4px', fontSize: '10px' }">毒</span>
                  </span>
                  <span class="pf-herb-info">{{ herb.nature }}·{{ herb.taste }}·归{{ herb.meridian }}</span>
                </div>
                <div class="pf-herb-dosage">
                  <span class="pf-dosage-range">{{ herb.minDosage }}-{{ herb.maxDosage }}{{ herb.unit }}</span>
                  <div class="pf-dosage-input-group">
                    <button class="pf-dosage-btn" @click="updateDosage(herb.id, Math.max(herb.currentDosage - 1, 0))">−</button>
                    <input
                      type="number"
                      :class="['pf-dosage-input', { over: herb.currentDosage > herb.maxDosage, under: herb.currentDosage < herb.minDosage && herb.currentDosage > 0 }]"
                      :value="herb.currentDosage"
                      step="1"
                      @input="onDosageInput(herb.id, $event)"
                    />
                    <button class="pf-dosage-btn" @click="updateDosage(herb.id, herb.currentDosage + 1)">+</button>
                    <span class="pf-dosage-unit">{{ herb.unit }}</span>
                  </div>
                </div>
                <button class="pf-herb-remove" @click="removeHerb(herb.id)">
                  <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><line x1="18" y1="6" x2="6" y2="18" /><line x1="6" y1="6" x2="18" y2="18" /></svg>
                </button>
              </div>
            </div>
          </div>
        </div>

        <div class="card pf-compact">
          <div class="card-header"><h3>药库检索</h3></div>
          <div class="card-body">
            <input class="form-input" placeholder="搜索药名、类别、功效..." v-model="searchHerb" />
            <div class="pf-herb-library scrollbar">
              <div
                v-for="h in filteredHerbs"
                :key="h.id"
                :class="['pf-herb-lib-item', { selected: selectedHerbs.some(sh => sh.id === h.id) }]"
                @click="addHerb(h)"
              >
                <div class="pf-herb-lib-info">
                  <span class="pf-herb-lib-name">{{ h.name }}</span>
                  <span class="pf-herb-lib-nature">{{ h.nature }}，{{ h.taste }} · 归 {{ h.meridian }}</span>
                </div>
                <span class="pf-herb-lib-dosage">{{ h.minDosage }}-{{ h.maxDosage }}{{ h.unit }}</span>
              </div>
            </div>
          </div>
        </div>

        <div class="card pf-compact">
          <div class="card-header"><h3>医嘱备注</h3></div>
          <div class="card-body">
            <textarea class="form-textarea" :style="{ minHeight: '60px' }" placeholder="用法用量、煎服方法、忌口等..." v-model="notes"></textarea>
          </div>
        </div>

        <div class="pf-actions">
          <button class="btn btn-outline">暂存草稿</button>
          <button class="btn btn-primary">提交审方</button>
        </div>
      </div>

      <!-- ===== 右侧：处方审核 ===== -->
      <div class="pf-right">
        <div class="pf-section-title">
          <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M9 11l3 3L22 4" /><path d="M21 12v7a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2h11" /></svg>
          处方审核
          <span v-if="pendingCount > 0" class="pf-badge">{{ pendingCount }}</span>
        </div>

        <div class="pf-review-list">
          <div
            v-for="rx in prescriptions"
            :key="rx.id"
            class="card pf-review-card"
            @click="selectedRx = selectedRx?.id === rx.id ? null : rx"
          >
            <div class="pf-review-card-header" @click="expandedId = expandedId === rx.id ? null : rx.id">
              <div class="pf-review-left">
                <span :class="['pf-review-priority', rx.riskLevel]"></span>
                <div>
                  <div class="pf-review-patient">{{ rx.patientName }} · {{ rx.patientGender }} {{ rx.patientAge }}岁</div>
                  <div class="pf-review-diagnosis">{{ rx.diagnosis }} / {{ rx.syndrome }}</div>
                </div>
              </div>
              <div class="pf-review-right">
                <span :class="['tag', rx.riskLevel === 'high' ? 'tag-red' : rx.riskLevel === 'medium' ? 'tag-yellow' : 'tag-green']">
                  {{ rx.riskLevel === 'high' ? '高' : rx.riskLevel === 'medium' ? '中' : '低' }} {{ rx.riskScore }}
                </span>
                <span :class="['pf-review-status', rx.status]">
                  {{ rx.status === 'pending' ? '待审' : rx.status === 'approved' ? '通过' : '驳回' }}
                </span>
              </div>
            </div>
            <div v-if="expandedId === rx.id" class="pf-review-body">
              <div class="pf-herbs-tags">
                <span v-for="h in rx.herbs" :key="h" class="pf-herb-tag">{{ h }}</span>
              </div>
              <div v-if="rx.risks.length > 0" class="pf-review-section">
                <h4>风险项</h4>
                <ul class="pf-risk-list"><li v-for="(r, i) in rx.risks" :key="i" class="danger">{{ r }}</li></ul>
              </div>
              <div v-if="rx.suggestions.length > 0" class="pf-review-section">
                <h4>建议</h4>
                <ul class="pf-risk-list"><li v-for="(s, i) in rx.suggestions" :key="i" class="success">{{ s }}</li></ul>
              </div>
              <div v-if="rx.status === 'pending'" class="pf-review-actions">
                <button class="btn btn-ghost btn-sm">退回</button>
                <button class="btn btn-danger btn-sm">驳回</button>
                <button class="btn btn-primary btn-sm" @click="router.push('/emr')">通过</button>
              </div>
            </div>
          </div>
        </div>

        <div v-if="selectedRx" class="card pf-detail-card">
          <div class="card-header"><h3>处方详情</h3></div>
          <div class="card-body">
            <div class="detail-section">
              <div class="detail-label">患者信息</div>
              <div class="detail-row"><label>姓名</label><span>{{ selectedRx?.patientName }}</span></div>
              <div class="detail-row"><label>性别/年龄</label><span>{{ selectedRx?.patientGender }} / {{ selectedRx?.patientAge }}岁</span></div>
              <div class="detail-row"><label>诊断</label><span>{{ selectedRx?.diagnosis }}</span></div>
              <div class="detail-row"><label>证型</label><span>{{ selectedRx?.syndrome }}</span></div>
            </div>
            <div class="detail-section">
              <div class="detail-label">风险评估</div>
              <div class="detail-row">
                <label>风险等级</label>
                <span :class="['tag', selectedRx?.riskLevel === 'high' ? 'tag-red' : selectedRx?.riskLevel === 'medium' ? 'tag-yellow' : 'tag-green']">
                  {{ selectedRx?.riskLevel === 'high' ? '高风险' : selectedRx?.riskLevel === 'medium' ? '中风险' : '低风险' }}
                </span>
              </div>
              <div class="detail-row"><label>风险评分</label><span>{{ selectedRx?.riskScore }}/100</span></div>
              <div class="risk-bar"><div :class="['risk-bar-fill', selectedRx?.riskLevel]" :style="{ width: selectedRx?.riskScore + '%' }"></div></div>
            </div>
            <div class="detail-section">
              <div class="detail-label">审查项</div>
              <div class="detail-row"><label>配伍禁忌</label><span :class="['tag', selectedRx?.compatibilityRisk ? 'tag-red' : 'tag-green']">{{ selectedRx?.compatibilityRisk ? '异常' : '通过' }}</span></div>
              <div class="detail-row"><label>剂量合理性</label><span :class="['tag', selectedRx?.dosageRisk ? 'tag-red' : 'tag-green']">{{ selectedRx?.dosageRisk ? '异常' : '通过' }}</span></div>
              <div class="detail-row"><label>禁忌症审查</label><span :class="['tag', selectedRx?.contraindicationRisk ? 'tag-yellow' : 'tag-green']">{{ selectedRx?.contraindicationRisk ? '注意' : '通过' }}</span></div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref, computed } from 'vue'
import { useRouter } from 'vue-router'

interface Herb {
  id: number
  name: string
  category: string
  nature: string
  taste: string
  meridian: string
  minDosage: number
  maxDosage: number
  unit: string
  toxic: boolean
  incompatibilities: string[]
  synergies: string[]
  functions: string[]
}

interface SelectedHerb extends Herb {
  currentDosage: number
}

interface Prescription {
  id: number
  patientName: string
  patientAge: number
  patientGender: string
  diagnosis: string
  syndrome: string
  herbs: string[]
  reviewer: string
  riskLevel: 'low' | 'medium' | 'high'
  riskScore: number
  status: 'pending' | 'approved' | 'rejected'
  date: string
  compatibilityRisk: boolean
  dosageRisk: boolean
  contraindicationRisk: boolean
  risks: string[]
  suggestions: string[]
}

const mockPatients = [
  { id: 1, name: '张三', gender: '男', age: 45, diagnosis: '风寒感冒', date: '2026-05-05' },
  { id: 2, name: '李四', gender: '女', age: 38, diagnosis: '肝郁气滞', date: '2026-05-04' },
  { id: 3, name: '王五', gender: '男', age: 62, diagnosis: '肾阳虚证', date: '2026-05-03' },
]

const herbDatabase: Herb[] = [
  { id: 1, name: '柴胡', category: '解表药', nature: '微寒', taste: '辛苦', meridian: '肝、胆', minDosage: 3, maxDosage: 10, unit: 'g', toxic: false, incompatibilities: [], synergies: ['黄芩', '半夏', '党参'], functions: ['疏散退热', '疏肝解郁', '升举阳气'] },
  { id: 2, name: '黄芩', category: '清热药', nature: '寒', taste: '苦', meridian: '肺、胆、胃、大肠', minDosage: 3, maxDosage: 10, unit: 'g', toxic: false, incompatibilities: [], synergies: ['柴胡', '黄连'], functions: ['清热燥湿', '泻火解毒', '止血安胎'] },
  { id: 3, name: '党参', category: '补虚药', nature: '平', taste: '甘', meridian: '脾、肺', minDosage: 9, maxDosage: 30, unit: 'g', toxic: false, incompatibilities: ['藜芦'], synergies: ['黄芪', '白术'], functions: ['补中益气', '健脾益肺'] },
  { id: 4, name: '半夏', category: '化痰药', nature: '温', taste: '辛', meridian: '脾、胃、肺', minDosage: 3, maxDosage: 9, unit: 'g', toxic: true, incompatibilities: ['乌头', '附子'], synergies: ['陈皮', '茯苓'], functions: ['燥湿化痰', '降逆止呕', '消痞散结'] },
  { id: 5, name: '附子', category: '温里药', nature: '大热', taste: '辛甘', meridian: '心、肾、脾', minDosage: 3, maxDosage: 15, unit: 'g', toxic: true, incompatibilities: ['半夏', '瓜蒌', '川贝母', '白蔹', '白及'], synergies: ['干姜', '肉桂'], functions: ['回阳救逆', '补火助阳', '散寒止痛'] },
  { id: 6, name: '当归', category: '补虚药', nature: '温', taste: '甘辛', meridian: '肝、心、脾', minDosage: 6, maxDosage: 12, unit: 'g', toxic: false, incompatibilities: [], synergies: ['川芎', '白芍', '熟地黄'], functions: ['补血活血', '调经止痛', '润肠通便'] },
  { id: 7, name: '炙甘草', category: '补虚药', nature: '平', taste: '甘', meridian: '心、肺、脾、胃', minDosage: 1.5, maxDosage: 9, unit: 'g', toxic: false, incompatibilities: ['甘遂', '大戟', '芫花', '海藻'], synergies: [], functions: ['补脾益气', '清热解毒', '调和诸药'] },
  { id: 8, name: '黄芪', category: '补虚药', nature: '微温', taste: '甘', meridian: '肺、脾', minDosage: 9, maxDosage: 30, unit: 'g', toxic: false, incompatibilities: [], synergies: ['党参', '白术', '当归'], functions: ['补气升阳', '固表止汗', '利水消肿'] },
  { id: 9, name: '白芍', category: '补虚药', nature: '微寒', taste: '苦酸', meridian: '肝、脾', minDosage: 6, maxDosage: 15, unit: 'g', toxic: false, incompatibilities: ['藜芦'], synergies: ['当归', '川芎'], functions: ['养血调经', '敛阴止汗', '柔肝止痛'] },
  { id: 10, name: '桂枝', category: '解表药', nature: '温', taste: '辛甘', meridian: '心、肺、膀胱', minDosage: 3, maxDosage: 10, unit: 'g', toxic: false, incompatibilities: [], synergies: ['白芍', '生姜'], functions: ['发汗解肌', '温经通脉', '助阳化气'] },
  { id: 11, name: '生姜', category: '解表药', nature: '微温', taste: '辛', meridian: '肺、脾、胃', minDosage: 3, maxDosage: 10, unit: 'g', toxic: false, incompatibilities: [], synergies: ['桂枝', '大枣'], functions: ['解表散寒', '温中止呕', '化痰止咳'] },
  { id: 12, name: '大枣', category: '补虚药', nature: '温', taste: '甘', meridian: '脾、胃', minDosage: 6, maxDosage: 15, unit: 'g', toxic: false, incompatibilities: [], synergies: ['生姜', '炙甘草'], functions: ['补中益气', '养血安神'] },
  { id: 13, name: '茯苓', category: '利水渗湿药', nature: '平', taste: '甘淡', meridian: '心、脾、肾', minDosage: 9, maxDosage: 15, unit: 'g', toxic: false, incompatibilities: [], synergies: ['白术', '党参'], functions: ['利水渗湿', '健脾宁心'] },
  { id: 14, name: '川芎', category: '活血化瘀药', nature: '温', taste: '辛', meridian: '肝、胆、心包', minDosage: 3, maxDosage: 10, unit: 'g', toxic: false, incompatibilities: [], synergies: ['当归', '白芍'], functions: ['活血行气', '祛风止痛'] },
  { id: 15, name: '熟地黄', category: '补虚药', nature: '微温', taste: '甘', meridian: '肝、肾', minDosage: 9, maxDosage: 30, unit: 'g', toxic: false, incompatibilities: [], synergies: ['当归', '山茱萸'], functions: ['补血滋阴', '益精填髓'] },
]

const commonFormulas = [
  { name: '小柴胡汤', category: '和解剂', herbs: ['柴胡', '黄芩', '党参', '半夏', '炙甘草', '生姜', '大枣'] },
  { name: '四物汤', category: '补益剂', herbs: ['当归', '川芎', '白芍', '熟地黄'] },
  { name: '六味地黄丸', category: '补益剂', herbs: ['熟地黄', '山茱萸', '山药', '泽泻', '牡丹皮', '茯苓'] },
  { name: '桂枝汤', category: '解表剂', herbs: ['桂枝', '白芍', '炙甘草', '生姜', '大枣'] },
  { name: '逍遥散', category: '和解剂', herbs: ['柴胡', '当归', '白芍', '白术', '茯苓', '炙甘草'] },
]

const prescriptions: Prescription[] = [
  {
    id: 1, patientName: '张三', patientAge: 45, patientGender: '男',
    diagnosis: '风寒感冒', syndrome: '风寒束表证',
    herbs: ['麻黄', '桂枝', '杏仁', '甘草', '生姜'],
    reviewer: '系统自动', riskLevel: 'high', riskScore: 78, status: 'pending',
    date: '2026-05-05 14:30',
    compatibilityRisk: true, dosageRisk: true, contraindicationRisk: false,
    risks: ['麻黄用量超出药典上限（12g > 10g）', '麻黄与桂枝配伍辛温过强'],
    suggestions: ['建议将麻黄减量至9g', '考虑添加白芍以制约辛温太过']
  },
  {
    id: 2, patientName: '李四', patientAge: 38, patientGender: '女',
    diagnosis: '月经不调', syndrome: '肝郁血虚证',
    herbs: ['当归', '川芎', '白芍', '柴胡', '茯苓', '白术', '炙甘草', '薄荷'],
    reviewer: '系统自动', riskLevel: 'low', riskScore: 12, status: 'approved',
    date: '2026-05-04 10:15',
    compatibilityRisk: false, dosageRisk: false, contraindicationRisk: false,
    risks: [], suggestions: []
  },
  {
    id: 3, patientName: '王五', patientAge: 62, patientGender: '男',
    diagnosis: '慢性支气管炎', syndrome: '痰湿阻肺证',
    herbs: ['半夏', '陈皮', '茯苓', '甘草', '细辛', '五味子'],
    reviewer: '系统自动', riskLevel: 'medium', riskScore: 45, status: 'pending',
    date: '2026-05-04 16:20',
    compatibilityRisk: true, dosageRisk: false, contraindicationRisk: true,
    risks: ['半夏与甘草配伍需注意比例', '细辛含马兜铃酸成分需关注'],
    suggestions: ['半夏建议炮制后使用', '细辛用量建议控制在3g以内']
  },
  {
    id: 4, patientName: '赵六', patientAge: 55, patientGender: '女',
    diagnosis: '高血压', syndrome: '肝阳上亢证',
    herbs: ['天麻', '钩藤', '石决明', '栀子', '黄芩', '川牛膝', '杜仲'],
    reviewer: '系统自动', riskLevel: 'low', riskScore: 18, status: 'approved',
    date: '2026-05-03 09:00',
    compatibilityRisk: false, dosageRisk: false, contraindicationRisk: false,
    risks: [], suggestions: []
  },
]

const router = useRouter()

const selectedPatient = ref<number | null>(null)
const selectedFormula = ref('')
const searchHerb = ref('')
const selectedHerbs = ref<SelectedHerb[]>([])
const notes = ref('')
const compatibilityWarnings = ref<string[]>([])
const expandedId = ref<number | null>(null)
const selectedRx = ref<Prescription | null>(null)

const checkCompatibilities = (herbs: SelectedHerb[]) => {
  const warnings: string[] = []
  for (let i = 0; i < herbs.length; i++) {
    for (let j = i + 1; j < herbs.length; j++) {
      if (herbs[i].incompatibilities.includes(herbs[j].name)) {
        warnings.push(`${herbs[i].name} 与 ${herbs[j].name} 存在配伍禁忌，请谨慎使用！`)
      }
      if (herbs[j].incompatibilities.includes(herbs[i].name)) {
        warnings.push(`${herbs[j].name} 与 ${herbs[i].name} 存在配伍禁忌，请谨慎使用！`)
      }
    }
    if (herbs[i].currentDosage > herbs[i].maxDosage) {
      warnings.push(`${herbs[i].name} 超出药典规定最大剂量（${herbs[i].maxDosage}${herbs[i].unit}）`)
    }
    if (herbs[i].currentDosage < herbs[i].minDosage && herbs[i].currentDosage > 0) {
      warnings.push(`${herbs[i].name} 低于药典规定最小剂量（${herbs[i].minDosage}${herbs[i].unit}）`)
    }
  }
  compatibilityWarnings.value = warnings
}

const addHerb = (herb: Herb) => {
  if (selectedHerbs.value.some((h) => h.id === herb.id)) return
  const newHerb: SelectedHerb = { ...herb, currentDosage: Math.round((herb.minDosage + herb.maxDosage) / 2 * 10) / 10 }
  const updated = [...selectedHerbs.value, newHerb]
  selectedHerbs.value = updated
  checkCompatibilities(updated)
}

const removeHerb = (id: number) => {
  const updated = selectedHerbs.value.filter((h) => h.id !== id)
  selectedHerbs.value = updated
  checkCompatibilities(updated)
}

const updateDosage = (id: number, value: number) => {
  const updated = selectedHerbs.value.map((h) => h.id === id ? { ...h, currentDosage: value } : h)
  selectedHerbs.value = updated
  checkCompatibilities(updated)
}

const onDosageInput = (id: number, e: Event) => {
  updateDosage(id, parseFloat((e.target as HTMLInputElement).value) || 0)
}

const applyFormula = (formulaName: string) => {
  selectedFormula.value = formulaName
  const formula = commonFormulas.find((f) => f.name === formulaName)
  if (formula) {
    const defaultDosages: Record<string, number> = {
      '柴胡': 12, '黄芩': 9, '党参': 9, '半夏': 9, '炙甘草': 6, '生姜': 9, '大枣': 12,
      '当归': 12, '川芎': 9, '白芍': 12, '熟地黄': 15, '桂枝': 9,
      '山茱萸': 12, '山药': 12, '泽泻': 9, '牡丹皮': 9, '茯苓': 15, '白术': 12,
    }
    const herbs = formula.herbs
      .map((herbName) => {
        const herb = herbDatabase.find((h) => h.name === herbName)
        if (!herb) return null
        return { ...herb, currentDosage: defaultDosages[herbName] || 9 }
      })
      .filter((h): h is SelectedHerb => h !== null)
    selectedHerbs.value = herbs
    checkCompatibilities(herbs)
  }
}

const filteredHerbs = computed(() => {
  const term = searchHerb.value.toLowerCase()
  return herbDatabase.filter((h) =>
    h.name.includes(term) || h.category.includes(term) || h.taste.includes(term) || h.meridian.includes(term) || h.functions.some((f) => f.includes(term))
  )
})

const pendingCount = computed(() => prescriptions.filter((p) => p.status === 'pending').length)
</script>

<style scoped>
.pf-page {
  padding: 16px 20px;
  max-width: 1400px;
  margin: 0 auto;
  height: 100%;
  display: flex;
  flex-direction: column;
}

.pf-header {
  margin-bottom: 14px;
  flex-shrink: 0;
}

.pf-header h1 {
  font-size: 20px;
  font-weight: 600;
  color: var(--text-primary);
}

.pf-header p {
  font-size: 13px;
  color: var(--text-secondary);
  margin-top: 2px;
}

.pf-body {
  display: flex;
  gap: 16px;
  flex: 1;
  min-height: 0;
  overflow: hidden;
}

.pf-left {
  flex: 1;
  min-width: 0;
  overflow-y: auto;
  padding-right: 4px;
  display: flex;
  flex-direction: column;
  gap: 10px;
}

.pf-right {
  width: 420px;
  flex-shrink: 0;
  overflow-y: auto;
  padding-left: 4px;
  display: flex;
  flex-direction: column;
  gap: 10px;
}

.pf-section-title {
  display: flex;
  align-items: center;
  gap: 8px;
  font-size: 15px;
  font-weight: 600;
  color: var(--text-primary);
  padding: 8px 0 4px;
  flex-shrink: 0;
}

.pf-badge {
  display: inline-flex;
  align-items: center;
  justify-content: center;
  min-width: 18px;
  height: 18px;
  padding: 0 5px;
  background: var(--danger);
  color: #fff;
  font-size: 11px;
  font-weight: 600;
  border-radius: 9px;
}

.pf-compact .card-header {
  padding: 10px 14px;
}

.pf-compact .card-header h3 {
  font-size: 14px;
  font-weight: 600;
  color: var(--text-primary);
}

.pf-compact .card-body {
  padding: 10px 14px;
}

.pf-warning-banner {
  background: #FFF7E6;
  border: 1px solid #FFD591;
  border-radius: var(--radius);
  padding: 8px 12px;
  display: flex;
  align-items: center;
  gap: 8px;
  color: #D46B08;
  font-size: 13px;
  font-weight: 500;
  flex-shrink: 0;
}

.pf-patient-list {
  display: flex;
  gap: 8px;
  flex-wrap: wrap;
}

.pf-patient-card {
  display: flex;
  align-items: center;
  gap: 8px;
  padding: 8px 12px;
  border: 1px solid var(--border);
  border-radius: var(--radius);
  cursor: pointer;
  transition: var(--transition);
  flex: 1;
  min-width: 140px;
}

.pf-patient-card:hover {
  border-color: var(--primary-light);
  background: var(--primary-bg);
}

.pf-patient-card.selected {
  border-color: var(--primary);
  background: var(--primary-bg);
}

.pf-patient-avatar {
  width: 32px;
  height: 32px;
  border-radius: 50%;
  background: var(--primary);
  color: #fff;
  display: flex;
  align-items: center;
  justify-content: center;
  font-size: 14px;
  font-weight: 600;
  flex-shrink: 0;
}

.pf-patient-info {
  display: flex;
  flex-direction: column;
  line-height: 1.3;
}

.pf-patient-name {
  font-size: 13px;
  font-weight: 500;
  color: var(--text-primary);
}

.pf-patient-meta {
  font-size: 11px;
  color: var(--text-muted);
}

.pf-formula-grid {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(150px, 1fr));
  gap: 8px;
}

.pf-formula-card {
  display: flex;
  flex-direction: column;
  gap: 4px;
  padding: 10px;
  border: 1px solid var(--border);
  border-radius: var(--radius);
  background: var(--bg-white);
  text-align: left;
  transition: var(--transition);
}

.pf-formula-card:hover {
  border-color: var(--primary-light);
  box-shadow: var(--shadow);
}

.pf-formula-card.active {
  border-color: var(--primary);
  background: var(--primary-bg);
}

.pf-formula-name {
  font-size: 14px;
  font-weight: 600;
  color: var(--text-primary);
}

.pf-formula-herbs {
  font-size: 11px;
  color: var(--text-muted);
  line-height: 1.4;
}

.pf-herb-count {
  font-size: 12px;
  color: var(--text-muted);
  background: var(--bg-page);
  padding: 2px 8px;
  border-radius: 100px;
}

.pf-herbs-list {
  display: flex;
  flex-direction: column;
  gap: 6px;
}

.pf-herb-item {
  display: flex;
  align-items: center;
  gap: 10px;
  padding: 8px 10px;
  background: var(--bg-page);
  border-radius: var(--radius);
  border: 1px solid var(--border-light);
  transition: var(--transition);
}

.pf-herb-item.warning {
  background: #FFF7E6;
  border-color: #FFD591;
}

.pf-herb-main {
  flex: 1;
  min-width: 0;
  display: flex;
  flex-direction: column;
  gap: 2px;
}

.pf-herb-name {
  font-size: 14px;
  font-weight: 600;
  color: var(--text-primary);
}

.pf-herb-info {
  font-size: 11px;
  color: var(--text-muted);
}

.pf-herb-dosage {
  display: flex;
  flex-direction: column;
  align-items: flex-end;
  gap: 2px;
}

.pf-dosage-range {
  font-size: 10px;
  color: var(--text-muted);
}

.pf-dosage-input-group {
  display: flex;
  align-items: center;
  gap: 3px;
}

.pf-dosage-btn {
  width: 24px;
  height: 24px;
  border: 1px solid var(--border);
  background: var(--bg-white);
  border-radius: 4px;
  cursor: pointer;
  font-size: 14px;
  display: flex;
  align-items: center;
  justify-content: center;
  color: var(--text-secondary);
  transition: var(--transition);
}

.pf-dosage-btn:hover {
  border-color: var(--primary);
  color: var(--primary);
}

.pf-dosage-input {
  width: 50px;
  height: 24px;
  text-align: center;
  border: 1px solid var(--border);
  border-radius: 4px;
  font-size: 13px;
  font-weight: 500;
}

.pf-dosage-input.over {
  border-color: var(--danger);
  background: #FFF0F0;
}

.pf-dosage-input.under {
  border-color: var(--warning);
  background: #FFFBE6;
}

.pf-dosage-unit {
  font-size: 12px;
  color: var(--text-secondary);
}

.pf-herb-remove {
  width: 24px;
  height: 24px;
  border: none;
  background: transparent;
  cursor: pointer;
  color: var(--text-muted);
  border-radius: 4px;
  display: flex;
  align-items: center;
  justify-content: center;
  transition: var(--transition);
}

.pf-herb-remove:hover {
  background: #FFF0F0;
  color: var(--danger);
}

.pf-herb-library {
  margin-top: 8px;
  max-height: 200px;
  overflow-y: auto;
  display: flex;
  flex-direction: column;
  gap: 2px;
}

.pf-herb-lib-item {
  display: flex;
  align-items: center;
  justify-content: space-between;
  padding: 6px 10px;
  border-radius: var(--radius-sm);
  cursor: pointer;
  transition: var(--transition);
  border: 1px solid transparent;
}

.pf-herb-lib-item:hover {
  background: var(--primary-bg);
  border-color: var(--primary-light);
}

.pf-herb-lib-item.selected {
  background: var(--primary-bg);
  border-color: var(--primary);
}

.pf-herb-lib-info {
  display: flex;
  flex-direction: column;
  gap: 1px;
}

.pf-herb-lib-name {
  font-size: 13px;
  font-weight: 500;
  color: var(--text-primary);
}

.pf-herb-lib-nature {
  font-size: 10px;
  color: var(--text-muted);
}

.pf-herb-lib-dosage {
  font-size: 10px;
  color: var(--primary);
  white-space: nowrap;
}

.pf-actions {
  display: flex;
  justify-content: flex-end;
  gap: 8px;
  padding: 4px 0;
  flex-shrink: 0;
}

.pf-review-list {
  display: flex;
  flex-direction: column;
  gap: 8px;
}

.pf-review-card {
  border: 1px solid var(--border);
  border-radius: var(--radius);
  overflow: hidden;
  cursor: pointer;
  transition: var(--transition);
}

.pf-review-card:hover {
  box-shadow: var(--shadow);
}

.pf-review-card-header {
  display: flex;
  align-items: center;
  justify-content: space-between;
  padding: 10px 14px;
}

.pf-review-left {
  display: flex;
  align-items: center;
  gap: 10px;
}

.pf-review-priority {
  width: 8px;
  height: 8px;
  border-radius: 50%;
  flex-shrink: 0;
}

.pf-review-priority.high { background: var(--danger); }
.pf-review-priority.medium { background: var(--warning); }
.pf-review-priority.low { background: var(--success); }

.pf-review-patient {
  font-size: 14px;
  font-weight: 600;
  color: var(--text-primary);
}

.pf-review-diagnosis {
  font-size: 12px;
  color: var(--text-secondary);
}

.pf-review-right {
  display: flex;
  align-items: center;
  gap: 10px;
}

.pf-review-status {
  font-size: 12px;
  font-weight: 500;
}

.pf-review-status.pending { color: var(--warning); }
.pf-review-status.approved { color: var(--success); }
.pf-review-status.rejected { color: var(--danger); }

.pf-review-body {
  padding: 0 14px 12px;
  border-top: 1px solid var(--border-light);
}

.pf-herbs-tags {
  display: flex;
  flex-wrap: wrap;
  gap: 4px;
  margin-top: 10px;
}

.pf-herb-tag {
  padding: 2px 8px;
  border-radius: 100px;
  font-size: 11px;
  background: var(--bg-page);
  color: var(--text-primary);
  border: 1px solid var(--border-light);
}

.pf-review-section {
  margin-top: 10px;
}

.pf-review-section h4 {
  font-size: 12px;
  font-weight: 600;
  color: var(--text-primary);
  margin-bottom: 4px;
}

.pf-risk-list {
  list-style: none;
  padding: 0;
}

.pf-risk-list li {
  font-size: 12px;
  padding: 3px 0 3px 16px;
  position: relative;
  color: var(--text-secondary);
}

.pf-risk-list li.danger::before { content: '✕'; position: absolute; left: 0; color: var(--danger); }
.pf-risk-list li.success::before { content: '✓'; position: absolute; left: 0; color: var(--success); }

.pf-review-actions {
  margin-top: 10px;
  display: flex;
  gap: 6px;
  justify-content: flex-end;
  padding-top: 8px;
  border-top: 1px solid var(--border-light);
}

.pf-detail-card .card-header {
  padding: 10px 14px;
}

.pf-detail-card .card-header h3 {
  font-size: 14px;
  font-weight: 600;
}

.pf-detail-card .card-body {
  padding: 10px 14px;
}

.detail-section {
  margin-bottom: 12px;
}

.detail-section:last-child {
  margin-bottom: 0;
}

.detail-label {
  font-size: 12px;
  font-weight: 600;
  color: var(--text-primary);
  margin-bottom: 6px;
  padding-bottom: 4px;
  border-bottom: 1px solid var(--border-light);
}

.detail-row {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 4px 0;
  font-size: 13px;
}

.detail-row label {
  color: var(--text-secondary);
}

.detail-row span {
  color: var(--text-primary);
  font-weight: 500;
}

.risk-bar {
  height: 5px;
  border-radius: 3px;
  background: var(--border-light);
  margin-top: 4px;
  overflow: hidden;
}

.risk-bar-fill {
  height: 100%;
  border-radius: 3px;
  transition: width 0.3s ease;
}

.risk-bar-fill.low { background: var(--success); }
.risk-bar-fill.medium { background: var(--warning); }
.risk-bar-fill.high { background: var(--danger); }

@media (max-width: 1100px) {
  .pf-body {
    flex-direction: column;
    overflow-y: auto;
  }
  .pf-right {
    width: 100%;
  }
}
</style>
