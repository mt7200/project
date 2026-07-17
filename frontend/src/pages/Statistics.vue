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
            <div class="stats-card-value">
              665
              <span class="stats-card-change up">↑12%</span>
            </div>
            <div class="stats-card-label">总诊疗人次</div>
            <div class="stats-card-sub">较上月增加12%</div>
          </div>
        </div>
        <div class="stats-summary-card">
          <div class="stats-icon green">
            <svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><rect x="9" y="9" width="13" height="13" rx="2" /><path d="M5 15H4a2 2 0 0 1-2-2V4a2 2 0 0 1 2-2h9a2 2 0 0 1 2 2v1" /></svg>
          </div>
          <div>
            <div class="stats-card-value">
              580
              <span class="stats-card-change up">↑8%</span>
            </div>
            <div class="stats-card-label">累计处方数</div>
            <div class="stats-card-sub">含中药处方比例92%</div>
          </div>
        </div>
        <div class="stats-summary-card">
          <div class="stats-icon purple">
            <svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M9 11l3 3L22 4" /><path d="M21 12v7a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2h11" /></svg>
          </div>
          <div>
            <div class="stats-card-value">95.8%</div>
            <div class="stats-card-label">审方通过率</div>
            <div class="stats-card-sub">AI辅助审核覆盖100%</div>
          </div>
        </div>
        <div class="stats-summary-card">
          <div class="stats-icon orange">
            <svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><polyline points="23 6 13.5 15.5 8.5 10.5 1 18" /><polyline points="17 6 23 6 23 12" /></svg>
          </div>
          <div>
            <div class="stats-card-value">
              87.2%
              <span class="stats-card-change up">↑3%</span>
            </div>
            <div class="stats-card-label">治疗有效率</div>
            <div class="stats-card-sub">痊愈+显效+好转占比</div>
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
const monthlyData = [
  { month: '1月', visits: 128, prescriptions: 110, reviewCount: 105 },
  { month: '2月', visits: 98, prescriptions: 82, reviewCount: 80 },
  { month: '3月', visits: 145, prescriptions: 128, reviewCount: 122 },
  { month: '4月', visits: 156, prescriptions: 138, reviewCount: 132 },
  { month: '5月', visits: 138, prescriptions: 122, reviewCount: 118 },
]

const syndromeData = [
  { name: '风寒束表', value: 28, color: '#4A90D9' },
  { name: '肝郁气滞', value: 22, color: '#7B61FF' },
  { name: '肾阳虚', value: 18, color: '#52C41A' },
  { name: '风热犯肺', value: 15, color: '#FAAD14' },
  { name: '痰湿阻肺', value: 12, color: '#FF7A45' },
  { name: '其他证型', value: 10, color: '#C0C0C0' },
]

const herbUsageRanking = [
  { name: '甘草', count: 156, maxCount: 180 },
  { name: '茯苓', count: 142, maxCount: 180 },
  { name: '当归', count: 128, maxCount: 180 },
  { name: '白术', count: 115, maxCount: 180 },
  { name: '柴胡', count: 108, maxCount: 180 },
  { name: '白芍', count: 96, maxCount: 180 },
  { name: '黄芪', count: 88, maxCount: 180 },
  { name: '党参', count: 82, maxCount: 180 },
]

const diagnosisRanking = [
  { name: '风寒感冒', count: 45, maxCount: 50 },
  { name: '月经不调', count: 32, maxCount: 50 },
  { name: '腰痛病', count: 28, maxCount: 50 },
  { name: '咳嗽病', count: 24, maxCount: 50 },
  { name: '不寐', count: 20, maxCount: 50 },
]

const treatmentEffectData = [
  { month: '1月', 痊愈: 35, 显效: 42, 好转: 28 },
  { month: '2月', 痊愈: 28, 显效: 35, 好转: 22 },
  { month: '3月', 痊愈: 40, 显效: 48, 好转: 32 },
  { month: '4月', 痊愈: 45, 显效: 50, 好转: 35 },
  { month: '5月', 痊愈: 38, 显效: 44, 好转: 30 },
]

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
