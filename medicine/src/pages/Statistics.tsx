import {
  BarChart, Bar, XAxis, YAxis, CartesianGrid, Tooltip, ResponsiveContainer,
  LineChart, Line, PieChart, Pie, Cell, AreaChart, Area, Legend,
} from 'recharts'
import './Statistics.css'

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

export default function Statistics() {
  return (
    <div className="page-container">
      <div className="page-header">
        <h1>诊疗数据统计</h1>
        <p>查看诊疗、开方、审核等核心数据指标和趋势分析</p>
      </div>

      <div className="stats-layout">
        <div className="stats-summary-grid">
          <div className="stats-summary-card">
            <div className="stats-icon blue">
              <svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2"><path d="M17 21v-2a4 4 0 0 0-4-4H5a4 4 0 0 0-4 4v2" /><circle cx="9" cy="7" r="4" /><path d="M23 21v-2a4 4 0 0 0-3-3.87" /><path d="M16 3.13a4 4 0 0 1 0 7.75" /></svg>
            </div>
            <div>
              <div className="stats-card-value">
                665
                <span className="stats-card-change up">↑12%</span>
              </div>
              <div className="stats-card-label">总诊疗人次</div>
              <div className="stats-card-sub">较上月增加12%</div>
            </div>
          </div>
          <div className="stats-summary-card">
            <div className="stats-icon green">
              <svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2"><rect x="9" y="9" width="13" height="13" rx="2" /><path d="M5 15H4a2 2 0 0 1-2-2V4a2 2 0 0 1 2-2h9a2 2 0 0 1 2 2v1" /></svg>
            </div>
            <div>
              <div className="stats-card-value">
                580
                <span className="stats-card-change up">↑8%</span>
              </div>
              <div className="stats-card-label">累计处方数</div>
              <div className="stats-card-sub">含中药处方比例92%</div>
            </div>
          </div>
          <div className="stats-summary-card">
            <div className="stats-icon purple">
              <svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2"><path d="M9 11l3 3L22 4" /><path d="M21 12v7a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2h11" /></svg>
            </div>
            <div>
              <div className="stats-card-value">95.8%</div>
              <div className="stats-card-label">审方通过率</div>
              <div className="stats-card-sub">AI辅助审核覆盖100%</div>
            </div>
          </div>
          <div className="stats-summary-card">
            <div className="stats-icon orange">
              <svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2"><polyline points="23 6 13.5 15.5 8.5 10.5 1 18" /><polyline points="17 6 23 6 23 12" /></svg>
            </div>
            <div>
              <div className="stats-card-value">
                87.2%
                <span className="stats-card-change up">↑3%</span>
              </div>
              <div className="stats-card-label">治疗有效率</div>
              <div className="stats-card-sub">痊愈+显效+好转占比</div>
            </div>
          </div>
        </div>

        <div className="chart-grid">
          <div className="card chart-card">
            <div className="chart-title">月度诊疗趋势</div>
            <div className="chart-container">
              <ResponsiveContainer width="100%" height="100%">
                <BarChart data={monthlyData} barGap={4}>
                  <CartesianGrid strokeDasharray="3 3" stroke="#F0F2F5" />
                  <XAxis dataKey="month" tick={{ fontSize: 12, fill: '#9CA8B8' }} axisLine={{ stroke: '#E8ECF1' }} tickLine={false} />
                  <YAxis tick={{ fontSize: 12, fill: '#9CA8B8' }} axisLine={false} tickLine={false} />
                  <Tooltip contentStyle={{ borderRadius: 8, border: '1px solid #E8ECF1', fontSize: 13 }} />
                  <Bar dataKey="visits" fill="#4A90D9" radius={[4, 4, 0, 0]} name="诊疗人次" />
                  <Bar dataKey="prescriptions" fill="#7B61FF" radius={[4, 4, 0, 0]} name="处方数" />
                </BarChart>
              </ResponsiveContainer>
            </div>
          </div>

          <div className="card chart-card">
            <div className="chart-title">疗效趋势分析</div>
            <div className="chart-container">
              <ResponsiveContainer width="100%" height="100%">
                <AreaChart data={treatmentEffectData}>
                  <CartesianGrid strokeDasharray="3 3" stroke="#F0F2F5" />
                  <XAxis dataKey="month" tick={{ fontSize: 12, fill: '#9CA8B8' }} axisLine={{ stroke: '#E8ECF1' }} tickLine={false} />
                  <YAxis tick={{ fontSize: 12, fill: '#9CA8B8' }} axisLine={false} tickLine={false} />
                  <Tooltip contentStyle={{ borderRadius: 8, border: '1px solid #E8ECF1', fontSize: 13 }} />
                  <Area type="monotone" dataKey="痊愈" stroke="#52C41A" fill="#F0FFF4" strokeWidth={2} />
                  <Area type="monotone" dataKey="显效" stroke="#4A90D9" fill="#EBF4FD" strokeWidth={2} />
                  <Area type="monotone" dataKey="好转" stroke="#FAAD14" fill="#FFF8E6" strokeWidth={2} />
                </AreaChart>
              </ResponsiveContainer>
            </div>
          </div>
        </div>

        <div className="stats-bottom-grid">
          <div className="card chart-card">
            <div className="chart-title">审方通过率周趋势</div>
            <div className="chart-container">
              <ResponsiveContainer width="100%" height="100%">
                <LineChart data={[{ day: '周一', rate: 96 }, { day: '周二', rate: 94 }, { day: '周三', rate: 97 }, { day: '周四', rate: 95 }, { day: '周五', rate: 98 }, { day: '周六', rate: 93 }, { day: '周日', rate: 92 }]}>
                  <CartesianGrid strokeDasharray="3 3" stroke="#F0F2F5" />
                  <XAxis dataKey="day" tick={{ fontSize: 12, fill: '#9CA8B8' }} axisLine={{ stroke: '#E8ECF1' }} tickLine={false} />
                  <YAxis domain={[85, 100]} tick={{ fontSize: 12, fill: '#9CA8B8' }} axisLine={false} tickLine={false} />
                  <Tooltip contentStyle={{ borderRadius: 8, border: '1px solid #E8ECF1', fontSize: 13 }} formatter={(value: number) => [`${value}%`, '通过率']} />
                  <Line type="monotone" dataKey="rate" stroke="#4A90D9" strokeWidth={2} dot={{ r: 4, fill: '#4A90D9' }} />
                </LineChart>
              </ResponsiveContainer>
            </div>
          </div>

          <div className="card chart-card">
            <div className="chart-title">证型分布</div>
            <div className="chart-container">
              <ResponsiveContainer width="100%" height="100%">
                <PieChart>
                  <Pie data={syndromeData} cx="50%" cy="45%" innerRadius={50} outerRadius={90} paddingAngle={2} dataKey="value">
                    {syndromeData.map((entry, index) => (
                      <Cell key={index} fill={entry.color} />
                    ))}
                  </Pie>
                  <Tooltip contentStyle={{ borderRadius: 8, border: '1px solid #E8ECF1', fontSize: 13 }} />
                  <Legend wrapperStyle={{ fontSize: 11, paddingTop: 10 }} />
                </PieChart>
              </ResponsiveContainer>
            </div>
          </div>
        </div>

        <div className="chart-grid">
          <div className="card" style={{ padding: '16px 20px' }}>
            <div className="chart-title">常用中药排名</div>
            <div className="ranking-list">
              {herbUsageRanking.map((item, index) => (
                <div key={item.name} className="ranking-item">
                  <span className={`ranking-num ${index === 0 ? 'top1' : index === 1 ? 'top2' : index === 2 ? 'top3' : 'normal'}`}>
                    {index + 1}
                  </span>
                  <div className="ranking-info">
                    <div className="ranking-name">{item.name}</div>
                  </div>
                  <div className="ranking-bar-bg">
                    <div className="ranking-bar-fill" style={{ width: `${(item.count / item.maxCount) * 100}%` }} />
                  </div>
                  <span className="ranking-value">{item.count}</span>
                </div>
              ))}
            </div>
          </div>

          <div className="card" style={{ padding: '16px 20px' }}>
            <div className="chart-title">常见病种就诊排名</div>
            <div className="ranking-list">
              {diagnosisRanking.map((item, index) => (
                <div key={item.name} className="ranking-item">
                  <span className={`ranking-num ${index === 0 ? 'top1' : index === 1 ? 'top2' : index === 2 ? 'top3' : 'normal'}`}>
                    {index + 1}
                  </span>
                  <div className="ranking-info">
                    <div className="ranking-name">{item.name}</div>
                  </div>
                  <div className="ranking-bar-bg">
                    <div className="ranking-bar-fill" style={{ width: `${(item.count / item.maxCount) * 100}%` }} />
                  </div>
                  <span className="ranking-value">{item.count}</span>
                </div>
              ))}
            </div>
          </div>
        </div>
      </div>
    </div>
  )
}
