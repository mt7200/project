<template>
  <div class="page-container">
    <div class="page-header">
      <div>
        <h1>诊疗数据统计</h1>
        <p>查看诊疗、开方、审核等核心数据指标和趋势分析</p>
      </div>
      <div :style="{ display: 'flex', gap: '8px' }">
        <button class="btn btn-outline btn-sm" @click="exportMonthly">
          <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M21 15v4a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2v-4"/><polyline points="7 10 12 15 17 10"/><line x1="12" y1="15" x2="12" y2="3"/></svg>
          导出月度数据
        </button>
        <button class="btn btn-outline btn-sm" @click="exportSyndrome">
          <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M21 15v4a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2v-4"/><polyline points="7 10 12 15 17 10"/><line x1="12" y1="15" x2="12" y2="3"/></svg>
          导出证型数据
        </button>
      </div>
    </div>

    <div class="stats-layout">
      <div class="stats-summary-grid">
        <div class="stats-summary-card">
          <div class="stats-icon blue">
            <svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M17 21v-2a4 4 0 0 0-4-4H5a4 4 0 0 0-4 4v2" /><circle cx="9" cy="7" r="4" /><path d="M23 21v-2a4 4 0 0 0-3-3.87" /><path d="M16 3.13a4 4 0 0 1 0 7.75" /></svg>
          </div>
          <div>
            <div class="stats-card-value">{{ summary.total_visits }}</div>
            <div class="stats-card-label">总诊疗人次</div>
            <div class="stats-card-sub">实时统计</div>
          </div>
        </div>
        <div class="stats-summary-card">
          <div class="stats-icon green">
            <svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><rect x="9" y="9" width="13" height="13" rx="2" /><path d="M5 15H4a2 2 0 0 1-2-2V4a2 2 0 0 1 2-2h9a2 2 0 0 1 2 2v1" /></svg>
          </div>
          <div>
            <div class="stats-card-value">{{ summary.total_prescriptions }}</div>
            <div class="stats-card-label">累计处方数</div>
            <div class="stats-card-sub">含中药处方</div>
          </div>
        </div>
        <div class="stats-summary-card">
          <div class="stats-icon purple">
            <svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M9 11l3 3L22 4" /><path d="M21 12v7a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2h11" /></svg>
          </div>
          <div>
            <div class="stats-card-value">{{ summary.review_pass_rate }}%</div>
            <div class="stats-card-label">审方通过率</div>
            <div class="stats-card-sub">AI辅助审核覆盖100%</div>
          </div>
        </div>
        <div class="stats-summary-card">
          <div class="stats-icon orange">
            <svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><polyline points="23 6 13.5 15.5 8.5 10.5 1 18" /><polyline points="17 6 23 6 23 12" /></svg>
          </div>
          <div>
            <div class="stats-card-value">{{ summary.effective_rate }}%</div>
            <div class="stats-card-label">治疗有效率</div>
            <div class="stats-card-sub">低风险处方占比</div>
          </div>
        </div>
      </div>

      <div class="chart-grid">
        <div class="card chart-card">
          <div class="chart-title">月度诊疗趋势</div>
          <div class="chart-container">
            <!-- TODO: 接入 recharts BarChart (visits/prescriptions) -->
            <p class="chart-placeholder">图表待接入 recharts</p>
          </div>
        </div>

        <div class="card chart-card">
          <div class="chart-title">疗效趋势分析</div>
          <div class="chart-container">
            <!-- TODO: 接入 recharts AreaChart (痊愈/显效/好转) -->
            <p class="chart-placeholder">图表待接入 recharts</p>
          </div>
        </div>
      </div>

      <div class="stats-bottom-grid">
        <div class="card chart-card">
          <div class="chart-title">审方通过率周趋势</div>
          <div class="chart-container">
            <!-- TODO: 接入 recharts LineChart (rate) -->
            <p class="chart-placeholder">图表待接入 recharts</p>
          </div>
        </div>

        <div class="card chart-card">
          <div class="chart-title">证型分布</div>
          <div class="chart-container">
            <!-- TODO: 接入 recharts PieChart (syndromeData) -->
            <p class="chart-placeholder">图表待接入 recharts</p>
          </div>
        </div>
      </div>

      <div class="chart-grid">
        <div class="card" :style="{ padding: '16px 20px' }">
          <div class="chart-title">常用中药排名</div>
          <div class="ranking-list">
            <div v-for="(item, index) in herbUsageRanking" :key="item.name" class="ranking-item">
              <span :class="['ranking-num', getRankClass(index)]">{{ index + 1 }}</span>
              <div class="ranking-info">
                <div class="ranking-name">{{ item.name }}</div>
              </div>
              <div class="ranking-bar-bg">
                <div class="ranking-bar-fill" :style="{ width: ((item.count / item.maxCount) * 100) + '%' }" />
              </div>
              <span class="ranking-value">{{ item.count }}</span>
            </div>
          </div>
        </div>

        <div class="card" :style="{ padding: '16px 20px' }">
          <div class="chart-title">常见病种就诊排名</div>
          <div class="ranking-list">
            <div v-for="(item, index) in diagnosisRanking" :key="item.name" class="ranking-item">
              <span :class="['ranking-num', getRankClass(index)]">{{ index + 1 }}</span>
              <div class="ranking-info">
                <div class="ranking-name">{{ item.name }}</div>
              </div>
              <div class="ranking-bar-bg">
                <div class="ranking-bar-fill" :style="{ width: ((item.count / item.maxCount) * 100) + '%' }" />
              </div>
              <span class="ranking-value">{{ item.count }}</span>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref, onMounted, computed } from 'vue'
import { getMonthlyTrend, getSyndromeDistribution, getHerbUsageRanking, getStatistics } from '@/api/statistics'

const monthlyData = ref<{ month: string; visits: number; prescriptions: number; reviewCount: number }[]>([])
const syndromeData = ref<{ name: string; value: number; color: string }[]>([])
const herbUsageRanking = ref<{ name: string; count: number; maxCount: number }[]>([])
const treatmentEffectData = ref<{ month: string; 痊愈: number; 显效: number; 好转: number }[]>([])

const summary = ref<{ total_visits: number; total_prescriptions: number; review_pass_rate: number; effective_rate: number }>({
  total_visits: 0,
  total_prescriptions: 0,
  review_pass_rate: 0,
  effective_rate: 0,
})

const SYNDROME_COLORS = ['#4A90D9', '#7B61FF', '#52C41A', '#FAAD14', '#FF7A45', '#13C2C2', '#EB2F96', '#C0C0C0']

onMounted(async () => {
  try {
    const [monthly, syndrome, herbRank, summaryRes] = await Promise.all([
      getMonthlyTrend(),
      getSyndromeDistribution(),
      getHerbUsageRanking(),
      getStatistics(),
    ])
    monthlyData.value = ((monthly as any[]) || []).map((m) => ({
      month: m.month,
      visits: m.count,
      prescriptions: 0,
      reviewCount: 0,
    }))
    syndromeData.value = ((syndrome as any[]) || []).map((s, i) => ({
      name: s.name,
      value: s.count,
      color: SYNDROME_COLORS[i % SYNDROME_COLORS.length],
    }))
    const herbArr = (herbRank as any[]) || []
    const herbMax = herbArr.reduce((max, h) => Math.max(max, h.count || 0), 0) || 1
    herbUsageRanking.value = herbArr.map((h) => ({ name: h.name, count: h.count, maxCount: herbMax }))
    const s = summaryRes as any
    if (s) {
      summary.value = {
        total_visits: s.total_visits ?? 0,
        total_prescriptions: s.total_prescriptions ?? 0,
        review_pass_rate: s.review_pass_rate ?? 0,
        effective_rate: s.effective_rate ?? 0,
      }
    }
  } catch (e) {
    console.error('加载统计数据失败', e)
  }
})

const diagnosisRanking = computed(() =>
  syndromeData.value.slice(0, 5).map((d) => ({ name: d.name, count: d.value, maxCount: syndromeData.value[0]?.value || 1 }))
)

function exportCSV(data: Record<string, unknown>[], filename: string, headers: Record<string, string>) {
  const hRow = Object.values(headers).join(',')
  const rows = data.map((item) =>
    Object.keys(headers).map((k) => {
      const v = item[k]
      const s = v == null ? '' : String(v)
      return s.includes(',') ? `"${s}"` : s
    }).join(',')
  )
  const csv = [hRow, ...rows].join('\n')
  const blob = new Blob(['\uFEFF' + csv], { type: 'text/csv;charset=utf-8' })
  const url = URL.createObjectURL(blob)
  const a = document.createElement('a')
  a.href = url
  a.download = `${filename}.csv`
  a.click()
  URL.revokeObjectURL(url)
}

function exportMonthly() {
  exportCSV(monthlyData, '月度诊疗趋势', { month: '月份', visits: '诊疗人次', prescriptions: '处方数', reviewCount: '审核数' })
}

function exportSyndrome() {
  exportCSV(syndromeData, '证型分布', { name: '证型', value: '病例数' })
}

function getRankClass(index: number) {
  if (index === 0) return 'top1'
  if (index === 1) return 'top2'
  if (index === 2) return 'top3'
  return 'normal'
}
</script>

<style scoped>
.stats-layout {
  display: flex;
  flex-direction: column;
  gap: 20px;
}

.stats-summary-grid {
  display: grid;
  grid-template-columns: repeat(4, 1fr);
  gap: 14px;
}

.stats-summary-card {
  border-radius: var(--radius);
  padding: 20px;
  border: 1px solid var(--border);
  display: flex;
  align-items: center;
  gap: 14px;
}

.stats-icon {
  width: 48px;
  height: 48px;
  border-radius: var(--radius);
  display: flex;
  align-items: center;
  justify-content: center;
  flex-shrink: 0;
}

.stats-icon.blue { background: var(--primary-bg); color: var(--primary); }
.stats-icon.green { background: #F0FFF4; color: var(--success); }
.stats-icon.purple { background: #F5F0FF; color: #7B61FF; }
.stats-icon.orange { background: #FFF8E6; color: #FAAD14; }

.stats-card-value {
  font-size: 28px;
  font-weight: 700;
  color: var(--text-primary);
  line-height: 1;
}

.stats-card-label {
  font-size: 12px;
  color: var(--text-secondary);
  margin-top: 4px;
}

.stats-card-sub {
  font-size: 11px;
  color: var(--text-muted);
  margin-top: 2px;
}

.stats-card-change {
  display: inline-block;
  font-size: 11px;
  font-weight: 500;
  margin-left: 4px;
}

.stats-card-change.up { color: var(--success); }
.stats-card-change.down { color: var(--danger); }

.chart-grid {
  display: grid;
  grid-template-columns: repeat(2, 1fr);
  gap: 16px;
}

.chart-card {
  padding: 16px 20px;
}

.chart-title {
  font-size: 14px;
  font-weight: 600;
  color: var(--text-primary);
  margin-bottom: 12px;
}

.chart-container {
  height: 260px;
  width: 100%;
}

.chart-full {
  height: 300px;
  width: 100%;
}

.chart-placeholder {
  display: flex;
  align-items: center;
  justify-content: center;
  height: 100%;
  margin: 0;
  color: var(--text-muted);
  font-size: 13px;
}

.stats-bottom-grid {
  display: grid;
  grid-template-columns: 2fr 1fr;
  gap: 16px;
}

.ranking-list {
  display: flex;
  flex-direction: column;
  gap: 8px;
}

.ranking-item {
  display: flex;
  align-items: center;
  gap: 10px;
  padding: 8px 0;
  border-bottom: 1px solid var(--border-light);
}

.ranking-item:last-child {
  border-bottom: none;
}

.ranking-num {
  width: 24px;
  height: 24px;
  border-radius: 6px;
  display: flex;
  align-items: center;
  justify-content: center;
  font-size: 12px;
  font-weight: 700;
  flex-shrink: 0;
}

.ranking-num.top1 { background: #FFD700; color: #fff; }
.ranking-num.top2 { background: #C0C0C0; color: #fff; }
.ranking-num.top3 { background: #CD7F32; color: #fff; }
.ranking-num.normal { background: var(--bg-page); color: var(--text-muted); }

.ranking-info {
  flex: 1;
  min-width: 0;
}

.ranking-name {
  font-size: 13px;
  font-weight: 500;
  color: var(--text-primary);
}

.ranking-count {
  font-size: 12px;
  color: var(--text-muted);
}

.ranking-bar-bg {
  width: 80px;
  height: 6px;
  border-radius: 3px;
  background: var(--border-light);
  overflow: hidden;
  flex-shrink: 0;
}

.ranking-bar-fill {
  height: 100%;
  border-radius: 3px;
  background: var(--primary);
  transition: width 0.3s ease;
}

.ranking-value {
  width: 36px;
  text-align: right;
  font-size: 13px;
  font-weight: 600;
  color: var(--text-primary);
  flex-shrink: 0;
}

@media (max-width: 1200px) {
  .stats-summary-grid {
    grid-template-columns: repeat(2, 1fr);
  }
  .chart-grid {
    grid-template-columns: 1fr;
  }
  .stats-bottom-grid {
    grid-template-columns: 1fr;
  }
}

@media (max-width: 768px) {
  .stats-summary-grid {
    grid-template-columns: 1fr;
  }
}
</style>
