<template>
  <div class="page-container">
    <div class="page-header">
      <h1>处方审核与风险提示</h1>
      <p>智能审查处方合理性、药物配伍、剂量安全</p>
    </div>

    <div class="review-summary">
      <div class="card summary-stat">
        <div class="stat-icon blue">
          <svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M14 2H6a2 2 0 0 0-2 2v16a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V8z" /><polyline points="14 2 14 8 20 8" /></svg>
        </div>
        <div>
          <div class="stat-value">{{ stats.total }}</div>
          <div class="stat-label">待审处方总数</div>
        </div>
      </div>
      <div class="card summary-stat">
        <div class="stat-icon orange">
          <svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><circle cx="12" cy="12" r="10" /><polyline points="12 6 12 12 16 14" /></svg>
        </div>
        <div>
          <div class="stat-value">{{ stats.pending }}</div>
          <div class="stat-label">等待审核</div>
        </div>
      </div>
      <div class="card summary-stat">
        <div class="stat-icon green">
          <svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M9 11l3 3L22 4" /><path d="M21 12v7a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2h11" /></svg>
        </div>
        <div>
          <div class="stat-value">{{ stats.approved }}</div>
          <div class="stat-label">已通过</div>
        </div>
      </div>
      <div class="card summary-stat">
        <div class="stat-icon red">
          <svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M10.29 3.86L1.82 18a2 2 0 0 0 1.71 3h16.94a2 2 0 0 0 1.71-3L13.71 3.86a2 2 0 0 0-3.42 0z" /><line x1="12" y1="9" x2="12" y2="13" /><line x1="12" y1="17" x2="12.01" y2="17" /></svg>
        </div>
        <div>
          <div class="stat-value">{{ stats.highRisk }}</div>
          <div class="stat-label">高风险处方</div>
        </div>
      </div>
    </div>

    <div class="tabs">
      <button :class="['tab', { active: filter === 'all' }]" @click="filter = 'all'">全部</button>
      <button :class="['tab', { active: filter === 'pending' }]" @click="filter = 'pending'">待审核</button>
      <button :class="['tab', { active: filter === 'approved' }]" @click="filter = 'approved'">已通过</button>
      <button :class="['tab', { active: filter === 'rejected' }]" @click="filter = 'rejected'">已驳回</button>
    </div>

    <div class="review-layout">
      <div class="review-main">
        <div class="review-list-card">
          <div
            v-for="rx in filteredPrescriptions"
            :key="rx.id"
            class="card review-item"
            @click="selectedRx = rx"
          >
            <div class="review-item-header" @click="toggleExpand(rx.id)">
              <div class="left">
                <span :class="['review-priority', rx.riskLevel]" />
                <div>
                  <div class="review-patient">{{ rx.patientName }} · {{ rx.patientGender }} {{ rx.patientAge }}岁</div>
                  <div class="review-prescription">{{ rx.diagnosis }} / {{ rx.syndrome }}</div>
                </div>
              </div>
              <div class="right">
                <span :class="['tag', rx.riskLevel === 'high' ? 'tag-red' : rx.riskLevel === 'medium' ? 'tag-yellow' : 'tag-green']">
                  {{ rx.riskLevel === 'high' ? '高风险' : rx.riskLevel === 'medium' ? '中风险' : '低风险' }} {{ rx.riskScore }}
                </span>
                <span :class="['review-status', rx.status]">
                  {{ rx.status === 'pending' ? '待审核' : rx.status === 'approved' ? '已通过' : '已驳回' }}
                </span>
                <span :class="['review-chevron', { open: expandedId === rx.id }]">
                  <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><polyline points="6 9 12 15 18 9" /></svg>
                </span>
              </div>
            </div>
            <div v-if="expandedId === rx.id" class="review-item-body">
              <div class="review-body-section">
                <h4>处方组成</h4>
                <div class="review-herbs-tags">
                  <span v-for="h in rx.herbs" :key="h" class="review-herb-tag">{{ h }}</span>
                </div>
              </div>
              <div v-if="rx.risks.length > 0" class="review-body-section">
                <h4>风险项</h4>
                <ul class="review-risk-list">
                  <li v-for="(r, i) in rx.risks" :key="i" class="danger">{{ r }}</li>
                </ul>
              </div>
              <div v-if="rx.suggestions.length > 0" class="review-body-section">
                <h4>建议</h4>
                <ul class="review-risk-list">
                  <li v-for="(s, i) in rx.suggestions" :key="i" class="success">{{ s }}</li>
                </ul>
              </div>
              <div class="review-actions">
                <template v-if="rx.status === 'pending'">
                  <button class="btn btn-ghost btn-sm">退回修改</button>
                  <button class="btn btn-danger btn-sm">驳回</button>
                  <button class="btn btn-primary btn-sm" @click="router.push('/emr')">审核通过</button>
                </template>
              </div>
            </div>
          </div>
        </div>
      </div>

      <div class="review-detail-sidebar">
        <div class="card">
          <div class="card-header">
            <h2>处方详情</h2>
          </div>
          <div class="card-body">
            <template v-if="selectedRx">
              <div class="detail-section">
                <div class="detail-label">患者信息</div>
                <div class="detail-row"><label>姓名</label><span>{{ selectedRx.patientName }}</span></div>
                <div class="detail-row"><label>性别 / 年龄</label><span>{{ selectedRx.patientGender }} / {{ selectedRx.patientAge }}岁</span></div>
                <div class="detail-row"><label>诊断</label><span>{{ selectedRx.diagnosis }}</span></div>
                <div class="detail-row"><label>证型</label><span>{{ selectedRx.syndrome }}</span></div>
                <div class="detail-row"><label>提交时间</label><span>{{ selectedRx.date }}</span></div>
              </div>
              <div class="detail-section">
                <div class="detail-label">风险评估</div>
                <div class="detail-row">
                  <label>总体风险等级</label>
                  <span :class="['review-status', selectedRx.riskLevel === 'high' ? 'rejected' : selectedRx.riskLevel === 'medium' ? 'pending' : 'approved']">
                    {{ selectedRx.riskLevel === 'high' ? '高风险' : selectedRx.riskLevel === 'medium' ? '中风险' : '低风险' }}
                  </span>
                </div>
                <div class="detail-row">
                  <label>风险评分</label>
                  <span>{{ selectedRx.riskScore }} / 100</span>
                </div>
                <div class="risk-bar">
                  <div :class="['risk-bar-fill', selectedRx.riskLevel]" :style="{ width: selectedRx.riskScore + '%' }" />
                </div>
              </div>
              <div class="detail-section">
                <div class="detail-label">审查项</div>
                <div class="detail-row">
                  <label>配伍禁忌</label>
                  <span :class="['tag', selectedRx.compatibilityRisk ? 'tag-red' : 'tag-green']">
                    {{ selectedRx.compatibilityRisk ? '异常' : '通过' }}
                  </span>
                </div>
                <div class="detail-row">
                  <label>剂量合理性</label>
                  <span :class="['tag', selectedRx.dosageRisk ? 'tag-red' : 'tag-green']">
                    {{ selectedRx.dosageRisk ? '异常' : '通过' }}
                  </span>
                </div>
                <div class="detail-row">
                  <label>禁忌症审查</label>
                  <span :class="['tag', selectedRx.contraindicationRisk ? 'tag-yellow' : 'tag-green']">
                    {{ selectedRx.contraindicationRisk ? '注意' : '通过' }}
                  </span>
                </div>
              </div>
            </template>
            <div v-else class="empty-state" :style="{ padding: '50px 20px' }">
              <p>点击左侧处方查看详情</p>
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
const expandedId = ref<number | null>(null)
const selectedRx = ref<Prescription | null>(null)
const filter = ref<string>('all')

const toggleExpand = (id: number) => {
  expandedId.value = expandedId.value === id ? null : id
}

const filteredPrescriptions = computed(() =>
  filter.value === 'all' ? prescriptions : prescriptions.filter((p) => p.status === filter.value)
)

const stats = {
  total: prescriptions.length,
  pending: prescriptions.filter((p) => p.status === 'pending').length,
  approved: prescriptions.filter((p) => p.status === 'approved').length,
  highRisk: prescriptions.filter((p) => p.riskLevel === 'high').length,
}
</script>

<style scoped>
.card-header h2 {
  font-size: 16px;
  font-weight: 600;
  color: var(--text-primary);
}

.review-layout {
  display: flex;
  gap: 20px;
  align-items: flex-start;
}

.review-main {
  flex: 1;
  min-width: 0;
}

.review-summary {
  display: grid;
  grid-template-columns: repeat(4, 1fr);
  gap: 14px;
  margin-bottom: 20px;
}

.summary-stat {
  border-radius: var(--radius);
  padding: 20px;
  display: flex;
  align-items: center;
  gap: 14px;
  border: 1px solid var(--border);
}

.stat-icon {
  width: 46px;
  height: 46px;
  border-radius: var(--radius);
  display: flex;
  align-items: center;
  justify-content: center;
  flex-shrink: 0;
}

.stat-icon.blue { background: var(--primary-bg); color: var(--primary); }
.stat-icon.green { background: #F0FFF4; color: var(--success); }
.stat-icon.orange { background: #FFF8E6; color: var(--warning); }
.stat-icon.red { background: #FFF0F0; color: var(--danger); }

.stat-value {
  font-size: 28px;
  font-weight: 700;
  color: var(--text-primary);
  line-height: 1;
}

.stat-label {
  font-size: 12px;
  color: var(--text-secondary);
  margin-top: 4px;
}

.review-list-card {
  display: flex;
  flex-direction: column;
  gap: 10px;
}

.review-item {
  border: 1px solid var(--border);
  border-radius: var(--radius);
  overflow: hidden;
  transition: var(--transition);
}

.review-item:hover {
  box-shadow: var(--shadow);
}

.review-item-header {
  display: flex;
  align-items: center;
  justify-content: space-between;
  padding: 14px 18px;
  cursor: pointer;
  background: var(--bg-white);
  transition: var(--transition);
}

.review-item-header:hover {
  background: #FAFBFD;
}

.review-item-header .left {
  display: flex;
  align-items: center;
  gap: 12px;
}

.review-priority {
  width: 8px;
  height: 8px;
  border-radius: 50%;
  flex-shrink: 0;
}

.review-priority.high { background: var(--danger); }
.review-priority.medium { background: var(--warning); }
.review-priority.low { background: var(--success); }

.review-patient {
  font-size: 15px;
  font-weight: 600;
  color: var(--text-primary);
}

.review-prescription {
  font-size: 13px;
  color: var(--text-secondary);
}

.review-item-header .right {
  display: flex;
  align-items: center;
  gap: 14px;
}

.review-status {
  font-size: 13px;
  font-weight: 500;
}

.review-status.pending { color: var(--warning); }
.review-status.approved { color: var(--success); }
.review-status.rejected { color: var(--danger); }

.review-chevron {
  color: var(--text-muted);
  transition: transform 0.3s ease;
}

.review-chevron.open {
  transform: rotate(180deg);
}

.review-item-body {
  padding: 0 18px 16px;
  border-top: 1px solid var(--border-light);
}

.review-body-section {
  margin-top: 14px;
}

.review-body-section h4 {
  font-size: 13px;
  font-weight: 600;
  color: var(--text-primary);
  margin-bottom: 6px;
}

.review-herbs-tags {
  display: flex;
  flex-wrap: wrap;
  gap: 6px;
}

.review-herb-tag {
  padding: 3px 10px;
  border-radius: 100px;
  font-size: 12px;
  background: var(--bg-page);
  color: var(--text-primary);
  border: 1px solid var(--border-light);
}

.review-risk-list {
  list-style: none;
  padding: 0;
}

.review-risk-list li {
  font-size: 13px;
  padding: 6px 0 6px 20px;
  position: relative;
  color: var(--text-secondary);
}

.review-risk-list li::before {
  position: absolute;
  left: 0;
}

.review-risk-list li.danger::before { content: '✕'; color: var(--danger); }
.review-risk-list li.warning::before { content: '⚠'; color: var(--warning); }
.review-risk-list li.info::before { content: 'ℹ'; color: var(--primary); }
.review-risk-list li.success::before { content: '✓'; color: var(--success); }

.review-actions {
  margin-top: 14px;
  display: flex;
  gap: 8px;
  justify-content: flex-end;
  padding-top: 10px;
  border-top: 1px solid var(--border-light);
}

.review-detail-sidebar {
  width: 420px;
  flex-shrink: 0;
  position: sticky;
  top: 72px;
}

.detail-section {
  margin-bottom: 16px;
  padding-bottom: 16px;
  border-bottom: 1px solid var(--border-light);
}

.detail-section:last-child {
  border-bottom: none;
  margin-bottom: 0;
  padding-bottom: 0;
}

.detail-label {
  font-size: 11px;
  font-weight: 600;
  color: var(--text-muted);
  text-transform: uppercase;
  letter-spacing: 0.5px;
  margin-bottom: 8px;
}

.detail-row {
  display: flex;
  justify-content: space-between;
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
  height: 6px;
  border-radius: 3px;
  background: var(--border-light);
  margin-top: 6px;
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

@media (max-width: 1200px) {
  .review-summary {
    grid-template-columns: repeat(2, 1fr);
  }
  .review-layout {
    flex-direction: column;
  }
  .review-detail-sidebar {
    width: 100%;
    position: static;
  }
}

@media (max-width: 768px) {
  .review-summary {
    grid-template-columns: 1fr;
  }
}
</style>
