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
import { ref, computed, onMounted } from 'vue'
import { useRouter } from 'vue-router'
import { getHerbs } from '@/api/herb'
import { getFormulas, getFormula } from '@/api/formula'
import { getPatients } from '@/api/patient'
import { getPrescriptions } from '@/api/prescription'

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

const mockPatients = ref<Array<{ id: number; name: string; gender: string; age: number; diagnosis: string }>>([])

const herbDatabase = ref<Herb[]>([])

const commonFormulas = ref<{ id: number; name: string; category: string; herbs: string[] }[]>([])

const prescriptions = ref<Prescription[]>([])

const router = useRouter()

const selectedPatient = ref<number | null>(null)
const selectedFormula = ref('')
const searchHerb = ref('')
const selectedHerbs = ref<SelectedHerb[]>([])
const notes = ref('')
const compatibilityWarnings = ref<string[]>([])
const expandedId = ref<number | null>(null)
const selectedRx = ref<Prescription | null>(null)

onMounted(async () => {
  try {
    const [herbsRes, formulasRes, prescriptionsRes, patientsRes] = await Promise.all([
      getHerbs(),
      getFormulas(),
      getPrescriptions(),
      getPatients(),
    ])
    herbDatabase.value = ((herbsRes as any[]) || []).map((h) => ({
      id: h.id,
      name: h.name,
      category: h.category || '',
      nature: h.nature || '',
      taste: h.taste || '',
      meridian: h.meridian || '',
      minDosage: h.min_dosage ?? 0,
      maxDosage: h.max_dosage ?? 0,
      unit: h.unit || 'g',
      toxic: !!h.is_toxic,
      functions: h.functions ? [h.functions] : [],
    }))
    commonFormulas.value = ((formulasRes as any[]) || []).map(f => ({ id: f.id, name: f.name, category: f.category_l1 || '', herbs: [] as string[] }))
    const patientList = ((patientsRes as any[]) || []).map((p) => ({
      id: p.id,
      name: p.name,
      gender: p.gender || '',
      age: p.age ?? 0,
      diagnosis: p.diagnosis || '',
    }))
    mockPatients.value = patientList
    const patientMap = new Map(patientList.map((p) => [p.id, p]))
    prescriptions.value = ((prescriptionsRes as any[]) || []).map((rx) => {
      const p = patientMap.get(rx.patient_id)
      return {
        id: rx.id,
        patientName: p?.name || '未知患者',
        patientAge: p?.age || 0,
        patientGender: p?.gender || '',
        diagnosis: rx.diagnosis || '',
        syndrome: rx.syndrome || '',
        herbs: [] as string[],
        reviewer: rx.reviewer || '系统自动',
        riskLevel: (rx.risk_level || 'low') as 'low' | 'medium' | 'high',
        riskScore: rx.risk_score || 0,
        status: (rx.status === 'draft' ? 'pending' : rx.status) as 'pending' | 'approved' | 'rejected',
        date: rx.created_at ? String(rx.created_at).replace('T', ' ').slice(0, 16) : '',
        compatibilityRisk: !!rx.compatibility_risk,
        dosageRisk: !!rx.dosage_risk,
        contraindicationRisk: !!rx.contraindication_risk,
        risks: rx.risks || [],
        suggestions: rx.suggestions || [],
      }
    })
  } catch (e) {
    console.error('加载开方审方数据失败', e)
  }
})

const checkCompatibilities = (herbs: SelectedHerb[]) => {
  const warnings: string[] = []
  for (let i = 0; i < herbs.length; i++) {
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

const applyFormula = async (formulaName: string) => {
  selectedFormula.value = formulaName
  const formula = commonFormulas.value.find((f) => f.name === formulaName)
  if (!formula) return
  let herbNames: string[] = []
  try {
    const detail = await getFormula(formula.id) as { herbs: string[] }
    herbNames = detail.herbs || []
  } catch (_) {
    herbNames = []
  }
  const defaultDosages: Record<string, number> = {
    '柴胡': 12, '黄芩': 9, '党参': 9, '半夏': 9, '炙甘草': 6, '生姜': 9, '大枣': 12,
    '当归': 12, '川芎': 9, '白芍': 12, '熟地黄': 15, '桂枝': 9,
    '山茱萸': 12, '山药': 12, '泽泻': 9, '牡丹皮': 9, '茯苓': 15, '白术': 12,
  }
  const herbs = herbNames
    .map((herbName) => {
      const herb = herbDatabase.value.find((h) => h.name === herbName)
      if (!herb) return null
      return { ...herb, currentDosage: defaultDosages[herbName] || 9 }
    })
    .filter((h): h is SelectedHerb => h !== null)
  selectedHerbs.value = herbs
  checkCompatibilities(herbs)
}

const filteredHerbs = computed(() => {
  const term = searchHerb.value.toLowerCase()
  return herbDatabase.value.filter((h) =>
    h.name.includes(term) || h.category.includes(term) || h.taste.includes(term) || h.meridian.includes(term) || h.functions.some((f) => f.includes(term))
  )
})

const pendingCount = computed(() => prescriptions.value.filter((p) => p.status === 'pending').length)
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
