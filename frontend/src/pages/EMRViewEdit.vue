<template>
  <div class="page-container">
    <div class="page-header">
      <div>
        <h1>电子病历查看 / 编辑</h1>
        <p>查看和编辑患者的四诊信息、辨证诊断及处方记录</p>
      </div>
      <div :style="{ display: 'flex', gap: '8px' }">
        <button v-if="isHistoryTab" class="btn btn-outline btn-sm" @click="exportHistory">
          <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M21 15v4a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2v-4"/><polyline points="7 10 12 15 17 10"/><line x1="12" y1="15" x2="12" y2="3"/></svg>
          导出历史记录
        </button>
        <button v-else class="btn btn-outline btn-sm" @click="exportList">
          <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M21 15v4a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2v-4"/><polyline points="7 10 12 15 17 10"/><line x1="12" y1="15" x2="12" y2="3"/></svg>
          导出列表
        </button>
      </div>
    </div>

    <!-- Tabs -->
    <div class="emr-tabs">
      <button
        v-for="tab in TABS"
        :key="tab"
        :class="['emr-tab', { active: activeTab === tab }]"
        @click="handleTabChange(tab)"
      >
        {{ tab }}
      </button>
    </div>

    <!-- Filter indicators -->
    <div
      v-if="filterMonth || filterSyndrome"
      :style="{ display: 'flex', alignItems: 'center', gap: '8px', marginBottom: '16px', flexWrap: 'wrap' }"
    >
      <span
        v-if="filterMonth"
        :style="{ display: 'inline-flex', alignItems: 'center', gap: '4px', padding: '4px 10px', borderRadius: '16px', fontSize: '13px', background: '#e8f4fd', color: '#1976d2', border: '1px solid #bbdefb' }"
      >
        月份：{{ filterMonth }}
        <button
          @click="filterMonth = ''"
          :style="{ background: 'none', border: 'none', cursor: 'pointer', color: '#1976d2', fontSize: '16px', lineHeight: 1, padding: 0 }"
          title="清除月份筛选"
        >×</button>
      </span>
      <span
        v-if="filterSyndrome"
        :style="{ display: 'inline-flex', alignItems: 'center', gap: '4px', padding: '4px 10px', borderRadius: '16px', fontSize: '13px', background: '#fce4ec', color: '#c62828', border: '1px solid #f8bbd0' }"
      >
        证型：{{ filterSyndrome }}
        <button
          @click="filterSyndrome = ''"
          :style="{ background: 'none', border: 'none', cursor: 'pointer', color: '#c62828', fontSize: '16px', lineHeight: 1, padding: 0 }"
          title="清除证型筛选"
        >×</button>
      </span>
      <button class="btn btn-ghost btn-sm" @click="filterMonth = ''; filterSyndrome = ''">
        清除全部
      </button>
    </div>

    <!-- ===== 历史诊疗 Tab ===== -->
    <template v-if="isHistoryTab">
      <div class="history-summary">
        <div class="summary-stat">
          <div class="stat-icon blue">
            <svg width="22" height="22" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M14 2H6a2 2 0 0 0-2 2v16a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V8z" /><polyline points="14 2 14 8 20 8" /></svg>
          </div>
          <div>
            <div class="stat-value">{{ statSummary.total }}</div>
            <div class="stat-label">总诊疗次数</div>
          </div>
        </div>
        <div class="summary-stat">
          <div class="stat-icon green">
            <svg width="22" height="22" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M22 11.08V12a10 10 0 1 1-5.93-9.14" /><polyline points="22 4 12 14.01 9 11.01" /></svg>
          </div>
          <div>
            <div class="stat-value">{{ statSummary.cured }}</div>
            <div class="stat-label">痊愈</div>
          </div>
        </div>
        <div class="summary-stat">
          <div class="stat-icon orange">
            <svg width="22" height="22" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><polyline points="23 6 13.5 15.5 8.5 10.5 1 18" /><polyline points="17 6 23 6 23 12" /></svg>
          </div>
          <div>
            <div class="stat-value">{{ statSummary.improved }}</div>
            <div class="stat-label">好转/显效</div>
          </div>
        </div>
      </div>

      <div class="card" :style="{ marginBottom: '20px' }">
        <div class="card-body">
          <div class="history-filters">
            <div class="filter-item">
              <input
                class="form-input"
                placeholder="搜索患者姓名或诊断..."
                :value="historySearchText"
                @input="historySearchText = ($event.target as HTMLInputElement).value"
              />
            </div>
            <div class="filter-item">
              <input
                class="form-input"
                type="month"
                :value="historyFilterDate"
                @input="historyFilterDate = ($event.target as HTMLInputElement).value"
              />
            </div>
            <div class="filter-item">
              <select
                class="form-select"
                :value="historyFilterResult"
                @change="historyFilterResult = ($event.target as HTMLSelectElement).value"
              >
                <option value="">全部疗效</option>
                <option value="痊愈">痊愈</option>
                <option value="显效">显效</option>
                <option value="好转">好转</option>
              </select>
            </div>
            <button
              v-if="historySearchText || historyFilterDate || historyFilterResult"
              class="btn btn-ghost btn-sm"
              @click="historySearchText = ''; historyFilterDate = ''; historyFilterResult = ''"
            >
              清除筛选
            </button>
          </div>
        </div>
      </div>

      <div class="history-layout">
        <div class="history-table-wrapper">
          <div class="card">
            <div class="herb-table-wrapper scrollbar" :style="{ maxHeight: '600px' }">
              <table class="table">
                <thead>
                  <tr>
                    <th>患者姓名</th>
                    <th>性别/年龄</th>
                    <th>就诊日期</th>
                    <th>主诉</th>
                    <th>诊断</th>
                    <th>证型</th>
                    <th>处方</th>
                    <th>疗效</th>
                    <th>医师</th>
                  </tr>
                </thead>
                <tbody>
                  <tr
                    v-for="r in filteredHistoryRecords"
                    :key="r.id"
                    :style="{ cursor: 'pointer' }"
                    @click="selectedRecord = r"
                  >
                    <td><span :style="{ fontWeight: 500 }">{{ r.patientName }}</span></td>
                    <td class="text-muted">{{ r.gender }} / {{ r.age }}</td>
                    <td class="text-muted">{{ r.visitDate }}</td>
                    <td class="text-muted" :style="{ maxWidth: '160px', overflow: 'hidden', textOverflow: 'ellipsis', whiteSpace: 'nowrap' }">{{ r.chiefComplaint }}</td>
                    <td>{{ r.diagnosis }}</td>
                    <td class="text-muted">{{ r.syndrome }}</td>
                    <td class="text-muted" :style="{ maxWidth: '140px', overflow: 'hidden', textOverflow: 'ellipsis', whiteSpace: 'nowrap' }">{{ r.prescription }}</td>
                    <td>
                      <span :class="['tag', r.treatmentResult === '痊愈' ? 'tag-green' : r.treatmentResult === '显效' ? 'tag-blue' : 'tag-yellow']">{{ r.treatmentResult }}</span>
                    </td>
                    <td class="text-muted">{{ r.docName }}</td>
                  </tr>
                </tbody>
              </table>
            </div>
          </div>
        </div>

        <div v-if="selectedRecord" class="history-detail-sidebar">
          <div class="card">
            <div class="card-header">
              <h2>诊疗详情</h2>
              <button class="btn btn-ghost btn-sm" @click="selectedRecord = null">
                <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><line x1="18" y1="6" x2="6" y2="18" /><line x1="6" y1="6" x2="18" y2="18" /></svg>
              </button>
            </div>
            <div class="card-body">
              <div class="detail-section">
                <div class="detail-label">基本信息</div>
                <div class="detail-row"><label>患者</label><span>{{ selectedRecord.patientName }}</span></div>
                <div class="detail-row"><label>性别/年龄</label><span>{{ selectedRecord.gender }} / {{ selectedRecord.age }}岁</span></div>
                <div class="detail-row"><label>就诊日期</label><span>{{ selectedRecord.visitDate }}</span></div>
                <div class="detail-row"><label>就诊医师</label><span>{{ selectedRecord.docName }}</span></div>
              </div>
              <div class="detail-section">
                <div class="detail-label">诊疗信息</div>
                <div class="detail-row"><label>主诉</label><span>{{ selectedRecord.chiefComplaint }}</span></div>
                <div class="detail-row"><label>诊断</label><span><span class="tag tag-blue">{{ selectedRecord.diagnosis }}</span></span></div>
                <div class="detail-row"><label>证型</label><span>{{ selectedRecord.syndrome }}</span></div>
                <div class="detail-row"><label>处方</label><span>{{ selectedRecord.prescription }}</span></div>
              </div>
              <div class="detail-section">
                <div class="detail-label">结果</div>
                <div class="detail-row"><label>疗效</label>
                  <span :class="['tag', selectedRecord.treatmentResult === '痊愈' ? 'tag-green' : selectedRecord.treatmentResult === '显效' ? 'tag-blue' : 'tag-yellow']">{{ selectedRecord.treatmentResult }}</span>
                </div>
                <div class="detail-row"><label>随访建议</label><span>{{ selectedRecord.followUp }}</span></div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </template>

    <!-- ===== 患者列表 Tab (可复诊/未诊断完成/已完成/待诊断) ===== -->
    <div v-else class="emr-layout">
      <div class="emr-list-panel">
        <div class="emr-search-box">
          <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><circle cx="11" cy="11" r="8" /><line x1="21" y1="21" x2="16.65" y2="16.65" /></svg>
          <input
            class="form-input"
            placeholder="搜索姓名或诊断..."
            :value="searchTerm"
            @input="searchTerm = ($event.target as HTMLInputElement).value"
          />
        </div>
        <div class="emr-list scrollbar">
          <div
            v-for="patient in filteredPatients"
            :key="patient.id"
            :class="['emr-list-item', 'card', { active: selectedId === patient.id }]"
          >
            <div :style="{ cursor: 'pointer' }" @click="handleSelect(patient)">
              <div class="emr-list-header">
                <span class="emr-list-name">{{ patient.name }}</span>
                <span class="emr-list-date">{{ patient.visitDate }}</span>
              </div>
              <div class="emr-list-meta">
                {{ patient.gender }} · {{ patient.age }}岁 · {{ patient.diagnosis }}
              </div>
            </div>
            <div :style="{ marginTop: '6px', display: 'flex', gap: '4px' }">
              <button
                class="btn btn-primary btn-sm"
                :style="{ fontSize: '11px', padding: '2px 8px' }"
                @click.stop="goToWorkspace(patient)"
              >
                接诊
              </button>
            </div>
          </div>
          <div v-if="filteredPatients.length === 0" :style="{ padding: '20px', textAlign: 'center', color: 'var(--text-muted)' }">
            暂无患者数据
          </div>
        </div>
      </div>

      <div class="emr-editor-panel">
        <!-- 已完成 Tab 完整病历 -->
        <div v-if="activeTab === '已完成' && data" class="card" :style="{ padding: '20px 24px' }">
          <div class="emr-record-header">
            <div>
              <h3>{{ data.name }} 的病历</h3>
              <span class="emr-record-id">病历号：{{ data.id }}</span>
            </div>
            <div class="emr-actions">
              <template v-if="!isEditing">
                <button class="btn btn-outline" @click="handleEdit">
                  <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M11 4H4a2 2 0 0 0-2 2v14a2 2 0 0 0 2 2h14a2 2 0 0 0 2-2v-7" /><path d="M18.5 2.5a2.121 2.121 0 0 1 3 3L12 15l-4 1 1-4 9.5-9.5z" /></svg>
                  编辑
                </button>
              </template>
              <template v-else>
                <button class="btn btn-outline" @click="handleCancel">取消</button>
                <button class="btn btn-primary" @click="handleSave">保存</button>
              </template>
            </div>
          </div>

          <div class="emr-section">
            <div class="emr-section-title">基本信息</div>
            <div class="emr-field-row">
              <div class="emr-field">
                <label>姓名</label>
                <input v-if="isEditing" class="editing-value" :value="editingData?.name" @input="setField('name', ($event.target as HTMLInputElement).value)" />
                <span v-else class="value">{{ data.name }}</span>
              </div>
              <div class="emr-field">
                <label>性别</label>
                <select v-if="isEditing" class="editing-value" :value="editingData?.gender" @change="setField('gender', ($event.target as HTMLSelectElement).value)">
                  <option>男</option><option>女</option>
                </select>
                <span v-else class="value">{{ data.gender }}</span>
              </div>
              <div class="emr-field">
                <label>年龄</label>
                <input v-if="isEditing" class="editing-value" type="number" :value="editingData?.age" @input="setField('age', Number(($event.target as HTMLInputElement).value))" />
                <span v-else class="value">{{ data.age }}岁</span>
              </div>
              <div class="emr-field">
                <label>就诊日期</label>
                <input v-if="isEditing" class="editing-value" type="date" :value="editingData?.visitDate" @input="setField('visitDate', ($event.target as HTMLInputElement).value)" />
                <span v-else class="value">{{ data.visitDate }}</span>
              </div>
            </div>
          </div>

          <div class="emr-section">
            <div class="emr-section-title">主诉与现病史</div>
            <div class="emr-field" :style="{ marginBottom: '10px' }">
              <label>主诉</label>
              <input v-if="isEditing" class="editing-value" :value="editingData?.chiefComplaint" @input="setField('chiefComplaint', ($event.target as HTMLInputElement).value)" />
              <span v-else class="value">{{ data.chiefComplaint }}</span>
            </div>
            <div class="emr-field">
              <label>现病史</label>
              <textarea v-if="isEditing" class="editing-value" rows="3" :value="editingData?.presentIllness" @input="setField('presentIllness', ($event.target as HTMLTextAreaElement).value)" />
              <span v-else class="value">{{ data.presentIllness }}</span>
            </div>
          </div>

          <div class="emr-section">
            <div class="emr-section-title">既往史</div>
            <div class="emr-field">
              <textarea v-if="isEditing" class="editing-value" rows="2" :value="editingData?.pastHistory" @input="setField('pastHistory', ($event.target as HTMLTextAreaElement).value)" />
              <span v-else class="value">{{ data.pastHistory }}</span>
            </div>
          </div>

          <div class="emr-section">
            <div class="emr-section-title">四诊信息</div>
            <div class="emr-field-row">
              <div class="emr-field">
                <label>舌象</label>
                <input v-if="isEditing" class="editing-value" :value="editingData?.tongueImage" @input="setField('tongueImage', ($event.target as HTMLInputElement).value)" />
                <span v-else class="value">{{ data.tongueImage }}</span>
              </div>
              <div class="emr-field">
                <label>脉象</label>
                <input v-if="isEditing" class="editing-value" :value="editingData?.pulseImage" @input="setField('pulseImage', ($event.target as HTMLInputElement).value)" />
                <span v-else class="value">{{ data.pulseImage }}</span>
              </div>
              <div class="emr-field">
                <label>面色</label>
                <input v-if="isEditing" class="editing-value" :value="editingData?.complexion" @input="setField('complexion', ($event.target as HTMLInputElement).value)" />
                <span v-else class="value">{{ data.complexion }}</span>
              </div>
              <div class="emr-field">
                <label>语声</label>
                <input v-if="isEditing" class="editing-value" :value="editingData?.voice" @input="setField('voice', ($event.target as HTMLInputElement).value)" />
                <span v-else class="value">{{ data.voice }}</span>
              </div>
            </div>
          </div>

          <div class="emr-section">
            <div class="emr-section-title">辨证诊断</div>
            <div v-if="isEditing" class="syndrome-select-hint">
              <label class="form-label">选择证型</label>
              <div class="syndrome-options">
                <button
                  v-for="s in syndromeOptions"
                  :key="s"
                  :class="['syndrome-option', { selected: editingData?.syndrome === s }]"
                  @click="setField('syndrome', s)"
                >
                  {{ s }}
                </button>
              </div>
            </div>
            <div class="emr-field-row">
              <div class="emr-field">
                <label>证型</label>
                <input v-if="isEditing" class="editing-value" :value="editingData?.syndrome" @input="setField('syndrome', ($event.target as HTMLInputElement).value)" />
                <span v-else class="value">{{ data.syndrome }}</span>
              </div>
              <div class="emr-field">
                <label>诊断</label>
                <input v-if="isEditing" class="editing-value" :value="editingData?.diagnosis" @input="setField('diagnosis', ($event.target as HTMLInputElement).value)" />
                <span v-else class="value">{{ data.diagnosis }}</span>
              </div>
              <div class="emr-field">
                <label>治法</label>
                <input v-if="isEditing" class="editing-value" :value="editingData?.treatmentPrinciple" @input="setField('treatmentPrinciple', ($event.target as HTMLInputElement).value)" />
                <span v-else class="value">{{ data.treatmentPrinciple }}</span>
              </div>
            </div>
          </div>

          <div class="emr-section">
            <div class="emr-section-title">处方</div>
            <div class="emr-field">
              <textarea v-if="isEditing" class="editing-value" rows="2" :value="editingData?.prescription" @input="setField('prescription', ($event.target as HTMLTextAreaElement).value)" />
              <span v-else class="value" :style="{ fontFamily: 'var(--font-family)', fontSize: '14px', fontWeight: 500 }">{{ data.prescription }}</span>
            </div>
          </div>

          <div class="emr-section">
            <div class="emr-section-title">医嘱</div>
            <div class="emr-field">
              <textarea v-if="isEditing" class="editing-value" rows="2" :value="editingData?.notes" @input="setField('notes', ($event.target as HTMLTextAreaElement).value)" />
              <span v-else class="value">{{ data.notes }}</span>
            </div>
          </div>
        </div>

        <!-- 其他 Tab 简化患者信息卡 -->
        <div v-else-if="selectedPatient" class="card patient-info-card">
          <div class="info-header">
            <h3>{{ selectedPatient.name }} 的信息</h3>
          </div>
          <div class="info-row">
            <label>性别</label>
            <span>{{ selectedPatient.gender }}</span>
          </div>
          <div class="info-row">
            <label>年龄</label>
            <span>{{ selectedPatient.age }}岁</span>
          </div>
          <div class="info-row">
            <label>诊断</label>
            <span>{{ selectedPatient.diagnosis }}</span>
          </div>
          <div class="info-row">
            <label>就诊日期</label>
            <span>{{ selectedPatient.visitDate }}</span>
          </div>
          <div v-if="selectedPatient.followUp" class="info-row">
            <label>随访建议</label>
            <span>{{ selectedPatient.followUp }}</span>
          </div>
        </div>

        <!-- 空状态 -->
        <div v-else class="card">
          <div class="empty-state" :style="{ padding: '80px 20px' }">
            <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.5"><path d="M14 2H6a2 2 0 0 0-2 2v16a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V8z" /><polyline points="14 2 14 8 20 8" /><line x1="16" y1="13" x2="8" y2="13" /><line x1="16" y1="17" x2="8" y2="17" /></svg>
            <p>请从左侧选择患者查看信息</p>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref, computed, onMounted } from 'vue'
import { useRouter, useRoute } from 'vue-router'
import { exportToCSV } from '@/utils/common'

interface EMR {
  id: number
  name: string
  gender: string
  age: number
  visitDate: string
  chiefComplaint: string
  presentIllness: string
  pastHistory: string
  tongueImage: string
  pulseImage: string
  complexion: string
  voice: string
  syndrome: string
  diagnosis: string
  treatmentPrinciple: string
  prescription: string
  notes: string
}

const mockEMRs: EMR[] = [
  {
    id: 10001, name: '张三', gender: '男', age: 45,
    visitDate: '2026-05-05', chiefComplaint: '恶寒发热2天，伴头痛鼻塞',
    presentIllness: '患者2天前因受凉后出现恶寒、发热、头痛、鼻塞流清涕、咳嗽、痰白清稀。自服感冒药效果不佳。',
    pastHistory: '既往体健，无药物过敏史，无慢性病史。',
    tongueImage: '舌质淡红，苔薄白', pulseImage: '脉浮紧',
    complexion: '面色微白', voice: '语声重浊',
    syndrome: '风寒束表证', diagnosis: '风寒感冒',
    treatmentPrinciple: '辛温解表，宣肺散寒',
    prescription: '麻黄9g、桂枝6g、杏仁9g、炙甘草3g',
    notes: '嘱服药后盖被取微汗，避风寒，忌食生冷。3剂，每日1剂，水煎服。',
  },
  {
    id: 10002, name: '李四', gender: '女', age: 38,
    visitDate: '2026-05-04', chiefComplaint: '月经不调半年，伴胸胁胀痛',
    presentIllness: '患者近半年来月经周期紊乱，经量时多时少，经前乳房胀痛，胸胁胀满，情绪易怒，失眠多梦。',
    pastHistory: '有轻度乳腺增生病史，无手术史。',
    tongueImage: '舌质淡红，苔薄白', pulseImage: '脉弦细',
    complexion: '面色微暗', voice: '语声正常',
    syndrome: '肝郁血虚证', diagnosis: '月经不调',
    treatmentPrinciple: '疏肝解郁，养血调经',
    prescription: '柴胡12g、当归12g、白芍15g、茯苓15g、白术12g、薄荷6g、生姜9g、炙甘草6g',
    notes: '嘱保持心情舒畅，避免劳累。7剂，每日1剂，水煎服。',
  },
  {
    id: 10003, name: '王五', gender: '男', age: 62,
    visitDate: '2026-05-03', chiefComplaint: '反复腰痛3年，加重1周',
    presentIllness: '患者3年来反复出现腰痛，劳累后加重，伴下肢酸软无力，夜尿频多，畏寒肢冷。近1周症状加重。',
    pastHistory: '有高血压病史5年，规律服用降压药，血压控制可。',
    tongueImage: '舌质淡胖，苔白滑', pulseImage: '脉沉弱',
    complexion: '面色㿠白', voice: '语声低微',
    syndrome: '肾阳虚证', diagnosis: '腰痛病',
    treatmentPrinciple: '温补肾阳，强腰壮骨',
    prescription: '熟地黄24g、山茱萸12g、山药12g、茯苓9g、牡丹皮9g、泽泻9g、桂枝3g、附子3g',
    notes: '嘱注意腰部保暖，避免重体力劳动。7剂，每日1剂，水煎服。',
  },
]

interface PatientSummary {
  id: number
  name: string
  gender: string
  age: number
  diagnosis: string
  visitDate: string
  followUp: string
}

const mockPatientsByStatus: Record<string, PatientSummary[]> = {
  '可复诊': [
    { id: 1, name: '张三', gender: '男', age: 45, diagnosis: '风寒感冒', visitDate: '2026-05-05', followUp: '7日后复诊' },
    { id: 2, name: '王五', gender: '男', age: 62, diagnosis: '腰痛病', visitDate: '2026-05-03', followUp: '7日后复诊' },
  ],
  '未诊断完成': [
    { id: 3, name: '钱九', gender: '男', age: 35, diagnosis: '待查', visitDate: '2026-05-06', followUp: '' },
    { id: 4, name: '吴十', gender: '女', age: 28, diagnosis: '待查', visitDate: '2026-05-06', followUp: '' },
  ],
  '已完成': [
    { id: 5, name: '李四', gender: '女', age: 38, diagnosis: '月经不调', visitDate: '2026-05-04', followUp: '已痊愈' },
    { id: 6, name: '赵六', gender: '女', age: 55, diagnosis: '高血压', visitDate: '2026-05-03', followUp: '已痊愈' },
  ],
  '待诊断': [
    { id: 7, name: '郑十一', gender: '男', age: 50, diagnosis: '-', visitDate: '2026-05-07', followUp: '' },
    { id: 8, name: '陈十二', gender: '女', age: 42, diagnosis: '-', visitDate: '2026-05-07', followUp: '' },
  ],
}

interface HistoryRecord {
  id: number
  patientName: string
  gender: string
  age: number
  visitDate: string
  chiefComplaint: string
  diagnosis: string
  syndrome: string
  prescription: string
  treatmentResult: string
  followUp: string
  docName: string
}

const historyRecords: HistoryRecord[] = [
  {
    id: 20001, patientName: '张三', gender: '男', age: 45,
    visitDate: '2026-05-05', chiefComplaint: '恶寒发热2天', diagnosis: '风寒感冒',
    syndrome: '风寒束表证', prescription: '麻黄汤加减',
    treatmentResult: '好转', followUp: '7日后复诊',
    docName: '张仲景',
  },
  {
    id: 20002, patientName: '张三', gender: '男', age: 45,
    visitDate: '2026-04-20', chiefComplaint: '咳嗽3天', diagnosis: '咳嗽病',
    syndrome: '风热犯肺证', prescription: '桑菊饮加减',
    treatmentResult: '痊愈', followUp: '无需复诊',
    docName: '张仲景',
  },
  {
    id: 20003, patientName: '李四', gender: '女', age: 38,
    visitDate: '2026-05-04', chiefComplaint: '月经不调半年', diagnosis: '月经不调',
    syndrome: '肝郁血虚证', prescription: '逍遥散加减',
    treatmentResult: '显效', followUp: '14日后复诊',
    docName: '华佗',
  },
  {
    id: 20004, patientName: '李四', gender: '女', age: 38,
    visitDate: '2026-03-15', chiefComplaint: '头痛乏力', diagnosis: '头痛病',
    syndrome: '气血两虚证', prescription: '八珍汤加减',
    treatmentResult: '好转', followUp: '30日后复诊',
    docName: '张仲景',
  },
  {
    id: 20005, patientName: '王五', gender: '男', age: 62,
    visitDate: '2026-05-03', chiefComplaint: '腰痛加重1周', diagnosis: '腰痛病',
    syndrome: '肾阳虚证', prescription: '金匮肾气丸加减',
    treatmentResult: '好转', followUp: '7日后复诊',
    docName: '张仲景',
  },
  {
    id: 20006, patientName: '王五', gender: '男', age: 62,
    visitDate: '2026-03-10', chiefComplaint: '头晕1月', diagnosis: '眩晕病',
    syndrome: '肝阳上亢证', prescription: '天麻钩藤饮加减',
    treatmentResult: '好转', followUp: '14日后复诊',
    docName: '华佗',
  },
  {
    id: 20007, patientName: '赵六', gender: '女', age: 55,
    visitDate: '2026-05-03', chiefComplaint: '失眠心悸', diagnosis: '不寐',
    syndrome: '心脾两虚证', prescription: '归脾汤加减',
    treatmentResult: '显效', followUp: '14日后复诊',
    docName: '张仲景',
  },
  {
    id: 20008, patientName: '赵六', gender: '女', age: 55,
    visitDate: '2026-02-20', chiefComplaint: '胃脘痛', diagnosis: '胃痛病',
    syndrome: '脾胃虚寒证', prescription: '理中汤加减',
    treatmentResult: '痊愈', followUp: '无需复诊',
    docName: '张仲景',
  },
  {
    id: 20009, patientName: '孙七', gender: '男', age: 28,
    visitDate: '2026-05-01', chiefComplaint: '咽喉痛3天', diagnosis: '咽喉炎',
    syndrome: '风热侵袭证', prescription: '银翘散加减',
    treatmentResult: '好转', followUp: '5日后复诊',
    docName: '华佗',
  },
  {
    id: 20010, patientName: '周八', gender: '女', age: 70,
    visitDate: '2026-04-28', chiefComplaint: '关节疼痛', diagnosis: '痹证',
    syndrome: '风寒湿痹证', prescription: '独活寄生汤加减',
    treatmentResult: '好转', followUp: '14日后复诊',
    docName: '张仲景',
  },
]

const syndromeOptions = [
  '风寒束表证', '风热犯肺证', '肝郁气滞证', '肝郁血虚证',
  '肾阳虚证', '肾阴虚证', '脾虚湿盛证', '痰湿阻肺证',
  '肝阳上亢证', '气血两虚证', '瘀血阻络证',
]

const TABS = ['可复诊', '未诊断完成', '已完成', '待诊断', '历史诊疗']

const monthMap: Record<string, string> = {
  '1月': '01', '2月': '02', '3月': '03', '4月': '04', '5月': '05',
  '6月': '06', '7月': '07', '8月': '08', '9月': '09', '10月': '10',
  '11月': '11', '12月': '12',
}

const router = useRouter()
const route = useRoute()

const activeTab = ref('可复诊')
const selectedId = ref<number | null>(null)
const isEditing = ref(false)
const editingData = ref<EMR | null>(null)
const searchTerm = ref('')
const filterMonth = ref('')
const filterSyndrome = ref('')

const historySearchText = ref('')
const historyFilterDate = ref('')
const historyFilterResult = ref('')
const selectedRecord = ref<HistoryRecord | null>(null)

const isHistoryTab = computed(() => activeTab.value === '历史诊疗')
const currentPatients = computed(() => !isHistoryTab.value ? (mockPatientsByStatus[activeTab.value] || []) : [])

const filteredPatients = computed(() => {
  return currentPatients.value.filter((p) => {
    if (searchTerm.value && !p.name.includes(searchTerm.value) && !p.diagnosis.includes(searchTerm.value)) return false
    if (filterMonth.value) {
      const monthNum = monthMap[filterMonth.value]
      if (monthNum && !p.visitDate.includes(`-${monthNum}-`)) return false
    }
    if (filterSyndrome.value) {
      const matchedNames = mockEMRs.filter((e) => e.syndrome === filterSyndrome.value).map((e) => e.name)
      if (!matchedNames.includes(p.name)) return false
    }
    return true
  })
})

const selectedPatient = computed(() => currentPatients.value.find((p) => p.id === selectedId.value) || null)

const selectedEMR = computed(() => selectedPatient.value
  ? mockEMRs.find((e) => e.name === selectedPatient.value!.name) || null
  : null)

const filteredHistoryRecords = computed(() => {
  return historyRecords.filter((r) => {
    if (historySearchText.value && !r.patientName.includes(historySearchText.value) && !r.diagnosis.includes(historySearchText.value)) return false
    if (historyFilterDate.value && !r.visitDate.includes(historyFilterDate.value)) return false
    if (historyFilterResult.value && r.treatmentResult !== historyFilterResult.value) return false
    return true
  })
})

const statSummary = computed(() => {
  const results = historyRecords.map((r) => r.treatmentResult)
  return {
    total: results.length,
    cured: results.filter((r) => r === '痊愈').length,
    improved: results.filter((r) => r === '显效' || r === '好转').length,
  }
})

const data = computed(() => editingData.value || selectedEMR.value)

const setField = <K extends keyof EMR>(field: K, value: EMR[K]) => {
  if (editingData.value) {
    editingData.value = { ...editingData.value, [field]: value }
  }
}

const handleSelect = (patient: PatientSummary) => {
  selectedId.value = patient.id
  isEditing.value = false
  editingData.value = null
}

const handleTabChange = (tab: string) => {
  activeTab.value = tab
  selectedId.value = null
  isEditing.value = false
  editingData.value = null
  searchTerm.value = ''
  selectedRecord.value = null
  filterMonth.value = ''
  filterSyndrome.value = ''
}

const handleEdit = () => {
  if (selectedEMR.value) {
    editingData.value = { ...selectedEMR.value }
    isEditing.value = true
  }
}

const handleSave = () => {
  isEditing.value = false
  editingData.value = null
}

const handleCancel = () => {
  isEditing.value = false
  editingData.value = null
}

const goToWorkspace = (patient: PatientSummary) => {
  router.push({ path: '/workspace', query: { id: String(patient.id) } })
}

const exportHistory = () => {
  const headers = { patientName: '患者姓名', gender: '性别', age: '年龄', visitDate: '就诊日期', chiefComplaint: '主诉', diagnosis: '诊断', syndrome: '证型', prescription: '处方', treatmentResult: '疗效', docName: '医师' }
  exportToCSV(historyRecords, '历史诊疗记录', headers)
}

const exportList = () => {
  const headers = { name: '姓名', gender: '性别', age: '年龄', visitDate: '就诊日期', diagnosis: '诊断' }
  exportToCSV(filteredPatients.value, `电子病历_${activeTab.value}`, headers)
}

onMounted(() => {
  const month = route.query.month as string | undefined
  const syndrome = route.query.syndrome as string | undefined
  if (month) {
    activeTab.value = '已完成'
    filterMonth.value = month
  }
  if (syndrome) {
    activeTab.value = '已完成'
    filterSyndrome.value = syndrome
  }
})
</script>

<style scoped>
.emr-layout {
  display: flex;
  gap: 20px;
}

.emr-list-panel {
  width: 340px;
  flex-shrink: 0;
  display: flex;
  flex-direction: column;
  gap: 12px;
}

.emr-search-box {
  position: relative;
}

.emr-search-box svg {
  position: absolute;
  left: 12px;
  top: 50%;
  transform: translateY(-50%);
  color: var(--text-muted);
}

.emr-search-box .form-input {
  padding-left: 36px;
}

.emr-list {
  flex: 1;
  display: flex;
  flex-direction: column;
  gap: 6px;
}

.emr-list-item {
  padding: 12px 14px;
  border: 1px solid var(--border);
  border-radius: var(--radius);
  cursor: pointer;
  transition: var(--transition);
}

.emr-list-item:hover {
  border-color: var(--primary-light);
}

.emr-list-item.active {
  border-color: var(--primary);
  background: var(--primary-bg);
}

.emr-list-header {
  display: flex;
  justify-content: space-between;
  align-items: flex-start;
  margin-bottom: 6px;
}

.emr-list-name {
  font-size: 14px;
  font-weight: 600;
  color: var(--text-primary);
}

.emr-list-date {
  font-size: 11px;
  color: var(--text-muted);
}

.emr-list-meta {
  font-size: 12px;
  color: var(--text-secondary);
  line-height: 1.5;
}

.emr-editor-panel {
  flex: 1;
  min-width: 0;
}

.emr-section {
  margin-bottom: 20px;
}

.emr-section-title {
  font-size: 15px;
  font-weight: 600;
  color: var(--text-primary);
  margin-bottom: 12px;
  padding-bottom: 6px;
  border-bottom: 1px solid var(--border-light);
  display: flex;
  align-items: center;
  justify-content: space-between;
}

.emr-field-row {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(200px, 1fr));
  gap: 12px;
  margin-bottom: 10px;
}

.emr-field {
  display: flex;
  flex-direction: column;
  gap: 4px;
}

.emr-field label {
  font-size: 12px;
  font-weight: 500;
  color: var(--text-secondary);
}

.emr-field .value {
  font-size: 13px;
  color: var(--text-primary);
}

.emr-field .editing-value {
  padding: 6px 10px;
  border: 1px solid var(--border);
  border-radius: var(--radius-sm);
  font-size: 13px;
  color: var(--text-primary);
  width: 100%;
  transition: var(--transition);
}

.emr-field .editing-value:focus {
  border-color: var(--primary);
  box-shadow: 0 0 0 2px var(--primary-bg);
}

.emr-record-header {
  display: flex;
  justify-content: space-between;
  align-items: flex-start;
  margin-bottom: 16px;
}

.emr-record-header h3 {
  font-size: 18px;
  font-weight: 600;
  color: var(--text-primary);
}

.emr-record-id {
  font-size: 12px;
  color: var(--text-muted);
}

.emr-actions {
  display: flex;
  gap: 8px;
}

.emr-edit-bar {
  display: flex;
  justify-content: flex-end;
  gap: 10px;
  padding-top: 16px;
  border-top: 1px solid var(--border);
  margin-top: 20px;
}

.syndrome-select-hint {
  margin-bottom: 10px;
}

.syndrome-options {
  display: flex;
  flex-wrap: wrap;
  gap: 8px;
}

.syndrome-option {
  padding: 6px 14px;
  border: 1px solid var(--border);
  border-radius: 100px;
  font-size: 13px;
  background: var(--bg-white);
  color: var(--text-primary);
  transition: var(--transition);
}

.syndrome-option:hover {
  border-color: var(--primary-light);
  background: var(--primary-bg);
}

.syndrome-option.selected {
  border-color: var(--primary);
  background: var(--primary-bg);
  color: var(--primary);
  font-weight: 500;
}

/* Tabs */
.emr-tabs {
  display: flex;
  gap: 4px;
  margin-bottom: 20px;
  background: var(--bg-card);
  border-radius: var(--radius);
  padding: 4px;
  border: 1px solid var(--border);
  flex-wrap: wrap;
}

.emr-tab {
  padding: 8px 18px;
  border: none;
  background: transparent;
  border-radius: var(--radius-sm);
  font-size: 13px;
  font-weight: 500;
  color: var(--text-secondary);
  cursor: pointer;
  transition: var(--transition);
  white-space: nowrap;
}

.emr-tab:hover {
  color: var(--text-primary);
  background: var(--bg-hover);
}

.emr-tab.active {
  background: var(--primary);
  color: #fff;
}

/* History tab content */
.history-summary {
  display: grid;
  grid-template-columns: repeat(3, 1fr);
  gap: 16px;
  margin-bottom: 20px;
}

.summary-stat {
  display: flex;
  align-items: center;
  gap: 14px;
  padding: 16px 20px;
  background: var(--bg-card);
  border: 1px solid var(--border);
  border-radius: var(--radius);
}

.stat-icon {
  width: 44px;
  height: 44px;
  border-radius: 10px;
  display: flex;
  align-items: center;
  justify-content: center;
  flex-shrink: 0;
}

.stat-icon.blue { background: #eef3ff; color: #4a7cf7; }
.stat-icon.green { background: #ecfdf3; color: #22c55e; }
.stat-icon.orange { background: #fff7ed; color: #f97316; }

.stat-value {
  font-size: 22px;
  font-weight: 700;
  color: var(--text-primary);
  line-height: 1.2;
}

.stat-label {
  font-size: 12px;
  color: var(--text-secondary);
  margin-top: 2px;
}

.history-filters {
  display: flex;
  gap: 12px;
  align-items: center;
  flex-wrap: wrap;
}

.filter-item {
  flex: 1;
  min-width: 160px;
}

.history-layout {
  display: flex;
  gap: 20px;
}

.history-table-wrapper {
  flex: 1;
  min-width: 0;
}

.history-detail-sidebar {
  width: 340px;
  flex-shrink: 0;
}

.detail-section {
  margin-bottom: 16px;
}

.detail-label {
  font-size: 12px;
  font-weight: 600;
  color: var(--text-secondary);
  text-transform: uppercase;
  letter-spacing: 0.5px;
  margin-bottom: 8px;
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
  font-weight: 500;
}

.detail-row span {
  color: var(--text-primary);
  text-align: right;
}

/* Patient info card for non-completed tabs */
.patient-info-card {
  padding: 20px 24px;
}

.patient-info-card .info-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 16px;
}

.patient-info-card .info-header h3 {
  font-size: 18px;
  font-weight: 600;
  color: var(--text-primary);
}

.patient-info-card .info-row {
  display: flex;
  padding: 8px 0;
  border-bottom: 1px solid var(--border-light);
  font-size: 13px;
}

.patient-info-card .info-row:last-child {
  border-bottom: none;
}

.patient-info-card .info-row label {
  width: 100px;
  color: var(--text-secondary);
  font-weight: 500;
  flex-shrink: 0;
}

.patient-info-card .info-row span {
  color: var(--text-primary);
}

@media (max-width: 1000px) {
  .emr-layout {
    flex-direction: column;
  }
  .emr-list-panel {
    width: 100%;
  }
  .history-layout {
    flex-direction: column;
  }
  .history-detail-sidebar {
    width: 100%;
  }
  .history-summary {
    grid-template-columns: 1fr;
  }
}
</style>
