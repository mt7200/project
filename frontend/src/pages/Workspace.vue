<template>
  <div class="ws-page">
    <div class="ws-body">
      <!-- ========== 患者栏 ========== -->
      <div class="ws-col ws-patient-bar">
        <div class="ws-col-title">
          <span class="ws-col-icon blue">
            <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5">
              <path d="M17 21v-2a4 4 0 0 0-4-4H5a4 4 0 0 0-4 4v2" /><circle cx="9" cy="7" r="4" />
            </svg>
          </span>
          患者列表
        </div>
        <div class="ws-card">
          <div class="ws-card-body" :style="{ padding: '0' }">
            <div
              v-for="patient in emrPatientList"
              :key="patient.id"
              :class="['ws-patient-item', { selected: selectedPatientFromBar === patient.id }]"
              @click="selectPatientFromBar(patient)"
            >
              <div class="ws-patient-item-head">
                <span class="ws-patient-name">{{ patient.name }}</span>
                <span class="ws-patient-gender">{{ patient.gender }}/{{ patient.age }}岁</span>
              </div>
              <div class="ws-patient-diagnosis">{{ patient.diagnosis }}</div>
              <div class="ws-patient-status">{{ patient.status }}</div>
            </div>
          </div>
        </div>
        <div v-if="selectedPatientInfo" class="ws-card" :style="{ marginTop: '8px' }">
          <div class="ws-card-head"><h3>患者信息</h3></div>
          <div class="ws-card-body" :style="{ flex: '1', minHeight: '0' }">
            <div class="ws-field"><label>姓名</label><span>{{ selectedPatientInfo.name }}</span></div>
            <div class="ws-field"><label>性别</label><span>{{ selectedPatientInfo.gender }}</span></div>
            <div class="ws-field"><label>年龄</label><span>{{ selectedPatientInfo.age }}岁</span></div>
            <div class="ws-field"><label>诊断</label><span>{{ selectedPatientInfo.diagnosis }}</span></div>
            <div class="ws-field"><label>状态</label><span>{{ selectedPatientInfo.status }}</span></div>
          </div>
        </div>
      </div>

      <!-- ========== 左栏：诊疗流程 ========== -->
      <div class="ws-col ws-left">
        <div class="ws-col-title">
          <span class="ws-col-icon blue">
            <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5"><circle cx="12" cy="12" r="10" /><polyline points="12 6 12 12 16 14" /></svg>
          </span>
          诊疗流程
        </div>

        <!-- 患者录入 -->
        <div class="ws-card" :style="currentStep >= 1 ? { flex: 'none' } : {}">
          <div class="ws-card-head"><h3>患者录入</h3></div>
          <div v-if="currentStep >= 1" class="ws-card-body" :style="{ fontSize: '11px', lineHeight: '1.7', padding: '6px 10px' }">
            <div :style="{ display: 'flex', flexWrap: 'wrap', gap: '2px 12px', marginBottom: '4px' }">
              <span><strong>姓名：</strong>{{ form.name || '—' }}</span>
              <span><strong>性别：</strong>{{ form.gender === 'male' ? '男' : form.gender === 'female' ? '女' : '—' }}</span>
              <span><strong>年龄：</strong>{{ form.age || '—' }}</span>
              <span><strong>电话：</strong>{{ form.phone || '—' }}</span>
            </div>
            <div :style="{ marginBottom: '2px' }">
              <strong>主诉：</strong>{{ form.chiefComplaint || '—' }}<br />
              <strong>现病史：</strong>{{ form.presentIllness || '—' }}<br />
              <strong>既往史：</strong>{{ form.pastHistory || '—' }}<strong :style="{ marginLeft: '8px' }">过敏：</strong>{{ form.allergyHistory || '—' }}<br />
              <strong>个人史：</strong>{{ form.personalHistory || '—' }}<br />
              <strong>诊断/辨证：</strong>{{ form.diagnosis || '—' }}　{{ form.differentiation || '—' }}<br />
              <strong>脉诊：</strong>{{ symptoms.pulseDescription || '—' }}<br />
              <strong>舌诊：</strong>{{ tongueSummary || '—' }}<br />
              <strong>望诊：</strong>{{ inspectionSummary || '—' }}<br />
              <strong>问诊：</strong>{{ inquirySummary || '—' }}
            </div>
          </div>
          <div v-else class="ws-card-body">
            <div class="ws-form-grid">
              <div class="ws-field"><label>姓名 <span class="req">*</span></label><input v-model="form.name" placeholder="患者姓名" /></div>
              <div class="ws-field"><label>性别</label><select v-model="form.gender"><option value="">选择</option><option value="male">男</option><option value="female">女</option></select></div>
              <div class="ws-field"><label>年龄</label><input type="number" v-model="form.age" placeholder="岁" /></div>
              <div class="ws-field"><label>电话</label><input v-model="form.phone" placeholder="手机号" /></div>
            </div>
            <div ref="chiefComplaintRef" class="ws-field full ws-chief-complaint-field" :style="{ position: 'relative' }">
              <label>主诉 <span class="req">*</span></label>
              <textarea
                v-model="form.chiefComplaint"
                @focus="showChiefComplaintPicker = true"
                placeholder="点击选择症状标签或手动输入"
                rows="2"
                :style="{ cursor: 'pointer' }"
              />
              <div v-if="showChiefComplaintPicker" class="ws-picker-panel ws-chief-complaint-picker">
                <div class="ws-pulse-tags">
                  <span
                    v-for="v in chiefComplaintTags"
                    :key="'cc-' + v"
                    class="ws-pulse-tag"
                    @click="appendForm('chiefComplaint', v)"
                  >{{ v }}</span>
                </div>
              </div>
            </div>
            <div ref="presentIllnessRef" class="ws-field full" :style="{ position: 'relative' }">
              <label>现病史</label>
              <textarea
                v-model="form.presentIllness"
                @focus="showPresentIllnessPicker = true"
                placeholder="点击选择标签或手动输入"
                rows="2"
                :style="{ cursor: 'pointer' }"
              />
              <div v-if="showPresentIllnessPicker" class="ws-picker-panel ws-chief-complaint-picker">
                <div v-for="(sec, si) in presentIllnessSections" :key="'pi-sec-' + si" class="ws-pulse-section">
                  <span class="ws-pulse-section-label">{{ sec.label }}</span>
                  <div class="ws-pulse-tags">
                    <span
                      v-for="v in sec.tags"
                      :key="'pi-' + si + '-' + v"
                      class="ws-pulse-tag"
                      @click="appendForm('presentIllness', v)"
                    >{{ v }}</span>
                  </div>
                </div>
              </div>
            </div>
            <div class="ws-form-grid">
              <div ref="pastHistoryRef" class="ws-field" :style="{ position: 'relative' }">
                <label>既往病史</label>
                <input
                  v-model="form.pastHistory"
                  @focus="showPastHistoryPicker = true"
                  placeholder="点击选择或手动输入"
                  :style="{ cursor: 'pointer' }"
                />
                <div v-if="showPastHistoryPicker" class="ws-picker-panel ws-chief-complaint-picker">
                  <div class="ws-pulse-section">
                    <span class="ws-pulse-section-label">既往有</span>
                    <div class="ws-pulse-tags">
                      <span
                        v-for="v in pastHistoryTags"
                        :key="'ph-' + v"
                        class="ws-pulse-tag"
                        @click="appendForm('pastHistory', v)"
                      >{{ v }}</span>
                    </div>
                  </div>
                </div>
              </div>
              <div ref="allergyRef" class="ws-field" :style="{ position: 'relative' }">
                <label>过敏史</label>
                <input
                  v-model="form.allergyHistory"
                  @focus="showAllergyPicker = true"
                  placeholder="点击选择或手动输入"
                  :style="{ cursor: 'pointer' }"
                />
                <div v-if="showAllergyPicker" class="ws-picker-panel ws-chief-complaint-picker">
                  <div class="ws-pulse-tags">
                    <span
                      v-for="v in allergyTags"
                      :key="'al-' + v"
                      class="ws-pulse-tag"
                      @click="appendForm('allergyHistory', v)"
                    >{{ v }}</span>
                  </div>
                </div>
              </div>
            </div>
            <div ref="personalHistoryRef" class="ws-field full" :style="{ position: 'relative' }">
              <label>个人史</label>
              <textarea
                v-model="form.personalHistory"
                @focus="showPersonalHistoryPicker = true"
                placeholder="点击选择标签或手动输入"
                rows="2"
                :style="{ cursor: 'pointer' }"
              />
              <div v-if="showPersonalHistoryPicker" class="ws-picker-panel ws-chief-complaint-picker">
                <div v-for="(sec, si) in personalHistorySections" :key="'ps-sec-' + si" class="ws-pulse-section">
                  <span class="ws-pulse-section-label">{{ sec.label }}</span>
                  <div class="ws-pulse-tags">
                    <span
                      v-for="v in sec.tags"
                      :key="'ps-' + si + '-' + v"
                      class="ws-pulse-tag"
                      @click="appendForm('personalHistory', v)"
                    >{{ v }}</span>
                  </div>
                </div>
              </div>
            </div>
            <div class="ws-form-grid">
              <div class="ws-field"><label>诊断</label><input v-model="form.diagnosis" placeholder="请输入诊断" /></div>
              <div class="ws-field"><label>辩证</label><input v-model="form.differentiation" placeholder="请输入辩证" /></div>
              <div class="ws-field"><label>治法</label><input v-model="form.treatmentMethod" placeholder="请输入治法" /></div>
              <div class="ws-field"><label>方药</label><input v-model="form.prescription" placeholder="请输入方药" /></div>
            </div>
          </div>
        </div>

        <!-- 四诊采集 (Step 0) / 处方管理 (Step 1,2) -->
        <div v-if="currentStep >= 1" class="ws-card" :style="{ flex: '1', display: 'flex', flexDirection: 'column' }">
          <div class="ws-card-head" :style="{ background: 'var(--primary-bg)' }">
            <h3 :style="{ color: 'var(--primary)' }">
              <svg width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                <polyline points="9 11 12 14 22 4" /><path d="M21 12v7a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2h11" />
              </svg>
              处方管理
            </h3>
          </div>
          <div class="ws-card-body" :style="{ flex: '1', minHeight: '0', overflowY: 'auto' }">
            <!-- 多推荐方剂选择（可多选）+ 自定义 -->
            <div :style="{ display: 'flex', gap: '6px', marginBottom: '8px', flexWrap: 'wrap' }">
              <div
                v-for="(f, i) in prescriptionMock.formulas"
                :key="i"
                @click="toggleFormulaSelection(i)"
                :style="getFormulaCardStyle(selectedFormulaIndices.includes(i))"
              >
                <span v-if="selectedFormulaIndices.includes(i)" :style="{ position: 'absolute', top: '-4px', right: '-4px', width: '16px', height: '16px', borderRadius: '50%', background: 'var(--primary)', color: '#fff', fontSize: '9px', lineHeight: '16px', textAlign: 'center', fontWeight: '600' }">✓</span>
                <div :class="['ws-ai-formula-name', { active: selectedFormulaIndices.includes(i) }]">{{ f.name }}</div>
                <div :style="{ fontSize: '10px', color: 'var(--text-muted)', marginTop: '1px' }">{{ f.herbs.length }}味</div>
                <span :style="{ fontSize: '8px', background: '#52C41A', color: '#fff', padding: '1px 8px', borderRadius: '8px', fontWeight: '600', display: 'inline-block', marginTop: '2px', letterSpacing: '0.5px' }">AI推荐</span>
              </div>
              <div
                @click="showCustomEditor = !showCustomEditor"
                :style="{
                  flex: '0.7',
                  padding: '6px 8px',
                  borderRadius: '6px',
                  cursor: 'pointer',
                  textAlign: 'center',
                  border: showCustomEditor ? '1.5px solid var(--primary)' : '1px dashed #B5B5B5',
                  background: showCustomEditor ? '#FFF7E6' : '#FAFAFA',
                  display: 'flex',
                  alignItems: 'center',
                  justifyContent: 'center',
                  gap: '3px'
                }"
              >
                <span :style="{ fontSize: '14px', lineHeight: '1', color: showCustomEditor ? 'var(--primary)' : 'var(--text-muted)' }">+</span>
                <span :style="{ fontSize: '11px', fontWeight: showCustomEditor ? '600' : '400', color: showCustomEditor ? 'var(--primary)' : 'var(--text-muted)' }">附加方剂</span>
                <span v-if="showCustomEditor" :style="{ fontSize: '9px', background: '#FFF7E6', color: '#D46B08', padding: '0 6px', borderRadius: '4px' }">展开</span>
              </div>
            </div>

            <!-- 通用：方剂名编辑（自定义时） -->
            <div v-if="showCustomEditor" :style="{ marginBottom: '6px', position: 'relative' }">
              <div class="ws-sub-title" :style="{ fontSize: '11px', marginTop: '0', marginBottom: '4px' }">方剂名称</div>
              <input
                :style="{ width: '100%', boxSizing: 'border-box', border: '1px solid var(--border)', borderRadius: '6px', fontSize: '13px', fontWeight: '600', padding: '4px 10px', outline: 'none' }"
                :value="customFormulaName"
                @input="onCustomFormulaNameInput"
                @focus="showFormulaSearchResults = formulaSearchQuery.length > 0"
                placeholder="输入方剂名称搜索自动补全"
              />
              <div v-if="showFormulaSearchResults" :style="{ position: 'absolute', top: '100%', left: '0', right: '0', background: '#fff', border: '1px solid var(--border)', borderRadius: '6px', zIndex: '100', maxHeight: '160px', overflowY: 'auto', boxShadow: '0 4px 12px rgba(0,0,0,0.1)' }">
                <div
                  v-for="(f, i) in formulaSearchResults"
                  :key="i"
                  :style="{ padding: '6px 10px', cursor: 'pointer', fontSize: '12px', borderBottom: '1px solid #F0F0F0' }"
                  @mousedown="selectFormulaFromSearch(f)"
                >
                  <strong>{{ f.name }}</strong>
                  <span :style="{ color: 'var(--text-muted)', marginLeft: '8px' }">{{ f.herbs.length }}味</span>
                </div>
                <div v-if="formulaSearchResults.length === 0" :style="{ padding: '6px 10px', fontSize: '11px', color: 'var(--text-muted)' }">无匹配方剂</div>
              </div>
            </div>

            <!-- 通用：方剂名编辑（仅AI方剂） -->
            <div
              v-if="!showCustomEditor && selectedFormulaIndices.length > 0"
              :style="{ fontSize: '13px', fontWeight: '600', color: 'var(--primary)', marginBottom: '6px', textAlign: 'center', padding: '4px', background: 'var(--primary-bg)', borderRadius: '6px', cursor: 'pointer' }"
              @click="startEditFormulaName"
            >
              {{ editFormulaName || currentFormulaName }}
              <span :style="{ fontWeight: '400', fontSize: '10px', color: 'var(--text-muted)', marginLeft: '6px' }">点击编辑</span>
            </div>

            <!-- ===== 统一药材显示（AI + 自定义合并） ===== -->
            <div class="ws-sub-title" :style="{ fontSize: '11px', marginTop: '0' }">组成
              <span :style="{ fontWeight: '400', color: 'var(--text-muted)', marginLeft: '6px', fontSize: '10px' }">点击药材可修改</span>
              <span v-if="showCustomEditor && customHerbs.length > 0" :style="{ marginLeft: '8px', fontSize: '10px', color: '#D46B08', background: '#FFF7E6', padding: '0 6px', borderRadius: '4px' }">
                +{{ customHerbs.length }}味自定义
              </span>
            </div>
            <div :style="{ display: 'flex', flexDirection: 'column', gap: '4px', marginBottom: '8px' }">
              <template v-if="mergedHerbs.length === 0">
                <div :style="{ fontSize: '11px', color: 'var(--text-muted)', padding: '4px 0' }">暂未添加药材</div>
              </template>
              <template v-for="mh in mergedHerbs" :key="'merged-' + mh.name">
                <!-- Editing mode -->
                <div v-if="isHerbEditing(mh)" :style="{ display: 'flex', gap: '4px', alignItems: 'center', padding: '2px 6px', background: '#fff', border: '1px solid var(--primary)', borderRadius: '6px' }">
                  <input :style="{ width: '70px', border: 'none', outline: 'none', fontSize: '12px', padding: '2px 0' }" :value="mh.isAI ? editName : editCustomName" @input="onHerbNameInput(mh, $event)" placeholder="药名" />
                  <input :style="{ width: '50px', border: 'none', outline: 'none', fontSize: '12px', padding: '2px 0', textAlign: 'right' }" :value="mh.isAI ? editDosage : editCustomDosage" @input="onHerbDosageInput(mh, $event)" placeholder="剂量" />
                  <button :style="{ border: 'none', background: 'var(--primary)', color: '#fff', borderRadius: '4px', fontSize: '10px', padding: '1px 6px', cursor: 'pointer' }" @click="saveHerbEdit(mh)">✓</button>
                  <button :style="{ border: 'none', background: 'transparent', color: '#999', cursor: 'pointer', fontSize: '12px' }" @click="mh.isAI ? (editingHerbIdx = null) : (editingCustomHerbIdx = null)">×</button>
                  <button :style="{ border: 'none', background: '#FF4D4F', color: '#fff', borderRadius: '4px', fontSize: '10px', padding: '1px 6px', cursor: 'pointer' }" @click="deleteHerb(mh)">删</button>
                </div>
                <!-- Display mode -->
                <div
                  v-else
                  class="ws-tag"
                  :style="{
                    fontSize: '12px',
                    background: mh.isAI ? '#F0FFF4' : '#FFF7E6',
                    borderColor: mh.isAI ? '#95DE64' : '#FFD591',
                    padding: '3px 10px',
                    cursor: 'pointer',
                    display: 'flex',
                    alignItems: 'center',
                    gap: '6px'
                  }"
                  @click="startHerbEdit(mh)"
                >
                  <span>{{ mh.name }} <strong>{{ mh.dosage }}</strong></span>
                  <span :style="{ display: 'flex', gap: '2px', flexWrap: 'wrap' }">
                    <span
                      v-for="(s, si) in mh.sources"
                      :key="si"
                      :style="{
                        fontSize: '8px',
                        padding: '0 4px',
                        borderRadius: '3px',
                        background: s === '手动' ? '#E6E6E6' : mh.isAI ? '#D9F7BE' : '#FFE58F',
                        color: s === '手动' ? '#666' : mh.isAI ? '#389E0D' : '#D46B08',
                        whiteSpace: 'nowrap'
                      }"
                    >{{ s }}</span>
                  </span>
                </div>
              </template>
              <span class="ws-tag" :style="{ fontSize: '12px', background: '#FAFAFA', borderColor: '#D9D9D9', padding: '3px 10px', cursor: 'pointer', color: 'var(--text-muted)' }" @click="addHerb">
                + 添加药材
              </span>
            </div>

            <div v-if="deletedHerb && !deletedCustomHerb" :style="{ display: 'flex', alignItems: 'center', gap: '8px', marginBottom: '6px', padding: '4px 10px', background: '#FFF7E6', border: '1px solid #FFD591', borderRadius: '6px', fontSize: '11px' }">
              <span :style="{ color: 'var(--text-secondary)' }">已删除 {{ deletedHerb.herb.name }} {{ deletedHerb.herb.dosage }}</span>
              <button :style="{ border: '1px solid var(--primary)', background: '#fff', color: 'var(--primary)', borderRadius: '4px', fontSize: '11px', padding: '1px 10px', cursor: 'pointer' }" @click="undoDeleteHerb">撤销</button>
            </div>
            <div v-if="deletedCustomHerb" :style="{ display: 'flex', alignItems: 'center', gap: '8px', marginBottom: '6px', padding: '4px 10px', background: '#FFF7E6', border: '1px solid #FFD591', borderRadius: '6px', fontSize: '11px' }">
              <span :style="{ color: 'var(--text-secondary)' }">已删除 {{ deletedCustomHerb.herb.name }} {{ deletedCustomHerb.herb.dosage }}</span>
              <button :style="{ border: '1px solid var(--primary)', background: '#fff', color: 'var(--primary)', borderRadius: '4px', fontSize: '11px', padding: '1px 10px', cursor: 'pointer' }" @click="undoDeleteCustomHerb">撤销</button>
            </div>

            <!-- ===== 统一功效显示（AI + 自定义合并） ===== -->
            <div class="ws-sub-title" :style="{ fontSize: '11px' }">功效 <span :style="{ fontWeight: '400', color: 'var(--text-muted)', fontSize: '10px' }">点击编辑</span></div>
            <div :style="{ display: 'flex', flexWrap: 'wrap', gap: '4px', marginBottom: '8px', fontSize: '12px', color: 'var(--text-secondary)' }">
              <span v-if="mergedEffectsData.length === 0" :style="{ fontSize: '11px', color: 'var(--text-muted)' }">暂未添加功效</span>
              <template v-for="me in mergedEffectsData" :key="'eff-' + (me.isAI ? 'ai' : 'cus') + '-' + me.origIdx">
                <div v-if="me.isEditing" :style="{ display: 'flex', gap: '2px', alignItems: 'center' }">
                  <input v-focus :style="{ width: '70px', border: '1px solid var(--primary)', borderRadius: '4px', fontSize: '11px', padding: '1px 4px', outline: 'none' }" :value="me.isAI ? editEffect : editCustomEffect" @input="onEffectNameInput(me.isAI, $event)" />
                  <button :style="{ border: 'none', background: 'var(--primary)', color: '#fff', borderRadius: '4px', fontSize: '9px', padding: '1px 5px', cursor: 'pointer' }" @click="saveEffectEdit(me.isAI, me.origIdx, me.cIdx)">✓</button>
                  <button :style="{ border: 'none', background: '#FF4D4F', color: '#fff', borderRadius: '4px', fontSize: '9px', padding: '1px 5px', cursor: 'pointer' }" @click="deleteEffect(me.isAI, me.origIdx, me.cIdx)">×</button>
                </div>
                <span
                  v-else
                  :style="{
                    padding: '2px 8px',
                    borderRadius: '4px',
                    border: '1px solid',
                    cursor: 'pointer',
                    fontSize: '11px',
                    background: me.isAI ? '#FFF7E6' : '#FFFBE6',
                    borderColor: me.isAI ? '#FFD591' : '#FFE58F'
                  }"
                  @click="startEffectEdit(me.isAI, me.origIdx, me.cIdx, me.effect)"
                >{{ me.effect }}</span>
              </template>
              <span :style="{ padding: '2px 8px', background: '#FAFAFA', borderRadius: '4px', border: '1px dashed #D9D9D9', cursor: 'pointer', fontSize: '11px', color: 'var(--text-muted)' }" @click="addEffect">+ 添加功效</span>
            </div>

            <!-- ===== 统一推荐理由显示 ===== -->
            <div class="ws-sub-title" :style="{ fontSize: '11px' }">推荐理由
              <span :style="{ fontWeight: '400', color: 'var(--text-muted)', marginLeft: '6px', fontSize: '10px' }">点击可编辑</span>
            </div>
            <div v-if="editingReason" :style="{ display: 'flex', flexDirection: 'column', gap: '4px', marginBottom: '8px' }">
              <textarea v-focus :style="{ fontSize: '11px', lineHeight: '1.6', padding: '6px 10px', background: '#fff', border: '1px solid var(--primary)', borderRadius: '6px', resize: 'vertical', outline: 'none', width: '100%', boxSizing: 'border-box' }" v-model="editReason" rows="3" />
              <div :style="{ display: 'flex', gap: '4px' }">
                <button :style="{ border: '1px solid var(--primary)', background: 'var(--primary)', color: '#fff', borderRadius: '4px', fontSize: '10px', padding: '2px 12px', cursor: 'pointer' }" @click="editingReason = false">✓ 确认</button>
                <button :style="{ border: '1px solid #999', background: '#fff', color: '#999', borderRadius: '4px', fontSize: '10px', padding: '2px 12px', cursor: 'pointer' }" @click="cancelReasonEdit">× 取消</button>
              </div>
            </div>
            <div
              v-else
              :style="{ fontSize: '11px', color: 'var(--text-secondary)', lineHeight: '1.6', padding: '6px 10px', background: 'var(--bg-page)', borderRadius: '6px', cursor: 'pointer', marginBottom: showCustomEditor ? '8px' : '0' }"
              @click="startReasonEdit"
            >{{ displayReason || '点击此处输入推荐理由...' }}</div>

            <!-- ===== 附加方剂编辑器（精简） ===== -->
            <template v-if="showCustomEditor">
              <div :style="{ borderTop: '1px dashed var(--border)', margin: '8px 0 6px' }" />
              <div :style="{ display: 'flex', gap: '4px', flexWrap: 'wrap', alignItems: 'center' }">
                <span :style="{ fontSize: '10px', color: '#D46B08', background: '#FFF7E6', padding: '2px 6px', borderRadius: '4px' }">
                  附加方剂已合并到上方，可直接编辑
                </span>
              </div>
            </template>
          </div>
        </div>

        <!-- 四诊采集 (Step 0) -->
        <div v-else class="ws-card">
          <div class="ws-card-head"><h3>四诊采集</h3></div>
          <div class="ws-card-body">
            <div class="ws-sub-title">脉诊</div>
            <div class="ws-field full" :style="{ position: 'relative' }">
              <input :value="symptoms.pulseDescription" @input="symptoms.pulseDescription = ($event.target as HTMLInputElement).value" @focus="showPulsePicker = true" placeholder="点击选择或输入脉象" :style="{ cursor: 'pointer' }" />
              <div v-if="showPulsePicker" class="ws-picker-panel">
                <div class="ws-pulse-section"><span class="ws-pulse-section-label">左脉</span><div class="ws-pulse-tags"><span v-for="v in pulseOptions" :key="'l-' + v" class="ws-pulse-tag" @click="appendSymptom('pulseDescription', v)">{{ v }}</span></div></div>
                <div class="ws-pulse-section"><span class="ws-pulse-section-label">右脉</span><div class="ws-pulse-tags"><span v-for="v in pulseOptions" :key="'r-' + v" class="ws-pulse-tag" @click="appendSymptom('pulseDescription', v)">{{ v }}</span></div></div>
                <div class="ws-pulse-section"><span class="ws-pulse-section-label">脉象描述</span><div class="ws-pulse-tags"><span v-for="v in pulseDescriptionTags" :key="'d-' + v" class="ws-pulse-tag" @click="appendSymptom('pulseDescription', v)">{{ v }}</span></div></div>
              </div>
            </div>
            <div class="ws-field full" :style="{ display: 'flex', alignItems: 'center', gap: '8px', marginTop: '-4px', marginBottom: '6px' }">
              <span :style="{ fontSize: '10px', color: 'var(--text-muted)', display: 'flex', alignItems: 'center', gap: '4px', cursor: 'pointer', padding: '3px 10px', background: '#F5F5F5', borderRadius: '4px', border: '1px dashed #D9D9D9' }" @click="pulseImportData = '脉诊仪数据已导入（2026-07-16 14:32）'">
                <svg width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M21 15v4a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2v-4" /><polyline points="7 10 12 15 17 10" /><line x1="12" y1="15" x2="12" y2="3" /></svg>
                脉诊数据导入
              </span>
              <span v-if="pulseImportData" :style="{ fontSize: '10px', color: '#52C41A' }">✓ {{ pulseImportData }}</span>
            </div>
            <div class="ws-sub-title">舌诊</div>
            <div class="ws-field full" :style="{ position: 'relative' }">
              <input :value="tongueDisplay" @input="onTongueInput" @focus="showTonguePicker = true" placeholder="点击选择或输入舌象" :style="{ cursor: 'pointer' }" />
              <div v-if="showTonguePicker" class="ws-picker-panel">
                <div class="ws-pulse-section"><span class="ws-pulse-section-label">舌质</span><div class="ws-pulse-tags"><span v-for="v in tongueColorTags" :key="'tc-' + v" class="ws-pulse-tag" @click="handleSymptomChange('tongueColor', v)">{{ v }}</span></div></div>
                <div class="ws-pulse-section"><span class="ws-pulse-section-label">舌苔</span><div class="ws-pulse-tags"><span v-for="v in tongueCoatingTags" :key="'tco-' + v" class="ws-pulse-tag" @click="handleSymptomChange('tongueCoating', v)">{{ v }}</span></div></div>
                <div class="ws-pulse-section"><span class="ws-pulse-section-label">舌形</span><div class="ws-pulse-tags"><span v-for="v in tongueShapeTags" :key="'ts-' + v" class="ws-pulse-tag" @click="handleSymptomChange('tongueShape', v)">{{ v }}</span></div></div>
                <div class="ws-pulse-section"><span class="ws-pulse-section-label">纹理</span><div class="ws-pulse-tags"><span v-for="v in tongueTextureTags" :key="'tt-' + v" class="ws-pulse-tag" @click="handleSymptomChange('tongueTexture', v)">{{ v }}</span></div></div>
              </div>
            </div>
            <div class="ws-field full" :style="{ display: 'flex', alignItems: 'center', gap: '8px', marginTop: '-4px', marginBottom: '6px' }">
              <span :style="{ fontSize: '10px', color: 'var(--text-muted)', display: 'flex', alignItems: 'center', gap: '4px', cursor: 'pointer', padding: '3px 10px', background: '#F5F5F5', borderRadius: '4px', border: '1px dashed #D9D9D9' }" @click="triggerTonguePhotoUpload">
                <svg width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M23 19a2 2 0 0 1-2 2H3a2 2 0 0 1-2-2V8a2 2 0 0 1 2-2h4l2-3h6l2 3h4a2 2 0 0 1 2 2z" /><circle cx="12" cy="13" r="4" /></svg>
                舌诊拍照
              </span>
              <span v-if="tonguePhoto" :style="{ position: 'relative', display: 'inline-block' }">
                <img :src="tonguePhoto" alt="舌诊照片" :style="{ height: '28px', width: '28px', borderRadius: '4px', objectFit: 'cover', border: '1px solid var(--border)', cursor: 'pointer' }" @click="openTonguePhoto" />
                <span :style="{ position: 'absolute', top: '-5px', right: '-5px', width: '12px', height: '12px', borderRadius: '50%', background: '#FF4D4F', color: '#fff', fontSize: '8px', lineHeight: '12px', textAlign: 'center', cursor: 'pointer' }" @click="tonguePhoto = null">×</span>
              </span>
            </div>
            <div class="ws-sub-title">望诊</div>
            <div class="ws-field full" :style="{ position: 'relative' }">
              <input :value="inspectionDisplay" @input="onInspectionInput" @focus="showInspectionPicker = true" placeholder="点击选择或输入望诊信息" :style="{ cursor: 'pointer' }" />
              <div v-if="showInspectionPicker" class="ws-picker-panel">
                <div class="ws-pulse-section"><span class="ws-pulse-section-label">面色</span><div class="ws-pulse-tags"><span v-for="v in facialColorTags" :key="'fc-' + v" class="ws-pulse-tag" @click="handleSymptomChange('facialColor', v)">{{ v }}</span></div></div>
                <div class="ws-pulse-section"><span class="ws-pulse-section-label">神态</span><div class="ws-pulse-tags"><span v-for="v in expressionTags" :key="'ex-' + v" class="ws-pulse-tag" @click="handleSymptomChange('expression', v)">{{ v }}</span></div></div>
              </div>
            </div>
            <div class="ws-sub-title">问诊</div>
            <div class="ws-field full" :style="{ position: 'relative' }">
              <input :value="inquiryDisplay" @input="onInquiryInput" @focus="showInquiryPicker = true" placeholder="点击选择或输入问诊信息" :style="{ cursor: 'pointer' }" />
              <div v-if="showInquiryPicker" class="ws-picker-panel ws-chief-complaint-picker">
                <div v-for="(sec, si) in inquirySections" :key="'iq-sec-' + si" class="ws-pulse-section">
                  <span class="ws-pulse-section-label">{{ sec.label }}</span>
                  <div class="ws-pulse-tags">
                    <span
                      v-for="v in sec.tags"
                      :key="'iq-' + si + '-' + v"
                      class="ws-pulse-tag"
                      @click="appendInquiry(sec.label, v)"
                    >{{ v }}</span>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>

      <!-- ========== 中栏：步骤向导 ========== -->
      <div class="ws-col ws-center">
        <div class="ws-col-title">
          <span class="ws-col-icon purple">
            <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5"><path d="M9 5H7a2 2 0 0 0-2 2v12a2 2 0 0 0 2 2h10a2 2 0 0 0 2-2V7a2 2 0 0 0-2-2h-2" /><rect x="9" y="3" width="6" height="4" rx="1" /><path d="M12 11v3" /><path d="M9 12.5h6" /></svg>
          </span>
          {{ wizardSteps[currentStep] }}
        </div>

        <!-- 步骤指示器 -->
        <div :style="{ display: 'flex', alignItems: 'center', justifyContent: 'center', gap: '0', marginBottom: '8px', flexShrink: '0' }">
          <template v-for="(step, index) in wizardSteps" :key="step">
            <div :style="{ display: 'flex', alignItems: 'center' }">
              <div :style="{
                display: 'flex',
                alignItems: 'center',
                justifyContent: 'center',
                width: '24px',
                height: '24px',
                borderRadius: '50%',
                background: index < currentStep ? 'var(--success)' : index === currentStep ? 'var(--primary)' : 'var(--border)',
                color: '#fff',
                fontSize: '11px',
                fontWeight: '600',
                flexShrink: '0'
              }">
                {{ index < currentStep ? '✓' : index + 1 }}
              </div>
              <span :style="{ fontSize: '11px', marginLeft: '5px', fontWeight: index === currentStep ? '600' : '400', color: index === currentStep ? 'var(--text-primary)' : 'var(--text-muted)' }">{{ step }}</span>
              <div v-if="index < wizardSteps.length - 1" :style="{ width: '40px', height: '2px', margin: '0 8px', background: index < currentStep ? 'var(--success)' : 'var(--border)', borderRadius: '1px' }" />
            </div>
          </template>
        </div>

        <!-- ===== 步骤0：辨证诊断 ===== -->
        <div v-if="currentStep === 0" class="ws-card">
          <div class="ws-card-head"><h3>AI 推荐辨证</h3></div>
          <div class="ws-card-body">
            <div class="ws-diag-results">
              <div
                v-for="result in diagnosisResults"
                :key="result.pattern"
                :class="['ws-diag-card', { selected: selectedPattern === result.pattern }]"
                @click="handleSelectPattern(result)"
              >
                <div class="ws-diag-head">
                  <span class="ws-diag-name">{{ result.pattern }}</span>
                  <span class="ws-diag-conf">{{ result.confidence }}%</span>
                </div>
                <div class="ws-diag-desc">{{ result.description }}</div>
                <div class="ws-tags"><span v-for="s in result.symptoms" :key="s" class="ws-tag">{{ s }}</span></div>
              </div>
            </div>
            <div v-if="selectedResult" class="ws-ai-suggest">
              已选择：<strong>{{ selectedResult.pattern }}</strong>（匹配度 {{ selectedResult.confidence }}%）— 已自动填充诊断、辨证
            </div>
          </div>
        </div>

        <!-- ===== 步骤1：智能开方 ===== -->
        <div v-if="currentStep === 1" :style="{ display: 'flex', flexDirection: 'column', flex: '1', minHeight: '0' }">
          <div class="ws-card" :style="{ flex: '1', display: 'flex', flexDirection: 'column' }">
            <div class="ws-card-head">
              <h3>
                <svg width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                  <circle cx="12" cy="12" r="10" /><path d="M12 16v-4" /><path d="M12 8h.01" />
                </svg>
                Agent辅助诊疗分析
              </h3>
            </div>
            <div class="ws-card-body" :style="{ flex: '1', fontSize: '12px', padding: '10px 14px' }">
              <div class="ws-sub-title" :style="{ fontSize: '11px', marginTop: '0', marginBottom: '6px' }">① 当前诊疗信息</div>
              <div :style="{ color: 'var(--text-secondary)', lineHeight: '1.8', marginBottom: '10px', padding: '6px 10px', background: 'var(--bg-page)', borderRadius: '6px' }">
                <strong :style="{ color: 'var(--text-primary)' }">主诉：</strong>{{ prescriptionMock.complaint }}<br />
                <strong :style="{ color: 'var(--text-primary)' }">现病史：</strong>{{ prescriptionMock.symptoms.join('、') }}<br />
                <strong :style="{ color: 'var(--text-primary)' }">舌象：</strong>{{ prescriptionMock.tongue }}　
                <strong :style="{ color: 'var(--text-primary)' }">脉象：</strong>{{ prescriptionMock.pulse }}<br />
                <strong :style="{ color: 'var(--text-primary)' }">辨证：</strong><span :style="{ color: 'var(--primary)', fontWeight: '500' }">{{ prescriptionMock.syndrome }}</span>
              </div>

              <div class="ws-sub-title" :style="{ fontSize: '11px', marginBottom: '6px' }">② Agent预处理 → 关键词提取</div>
              <div class="ws-tags" :style="{ marginBottom: '10px' }">
                <span
                  v-for="(kw, i) in prescriptionMock.keywords"
                  :key="i"
                  class="ws-tag"
                  :style="{ background: keywordBgColors[i % 7], borderColor: keywordBorderColors[i % 7], fontSize: '11px' }"
                >{{ kw }}</span>
              </div>

              <div class="ws-sub-title" :style="{ fontSize: '11px', marginBottom: '6px' }">③ Agent分析结果</div>
              <div :style="{ display: 'flex', gap: '16px', flexWrap: 'wrap', marginBottom: '6px' }">
                <span :style="{ fontSize: '12px' }"><strong>证型识别：</strong>{{ prescriptionMock.syndrome }}</span>
                <span :style="{ fontSize: '12px' }"><strong>治法建议：</strong>{{ prescriptionMock.treatment }}、生津止咳</span>
                <span :style="{ fontSize: '12px' }"><strong>推荐方向：</strong>润肺养阴类方剂</span>
              </div>
              <div :style="{ marginBottom: '2px' }">
                <span :style="{ fontSize: '11px', color: 'var(--text-muted)' }">推荐方剂列表（润肺养阴类）：</span>
                <div :style="{ display: 'flex', gap: '4px', flexWrap: 'wrap', marginTop: '2px' }">
                  <span
                    v-for="(f, i) in allDirectionFormulas"
                    :key="i"
                    :style="getDirectionFormulaStyle(f)"
                    @click="handleFormulaClick(f)"
                  >{{ f.name }} ({{ f.herbs.length }}味)<span v-if="f.source === 'common'" :style="{ fontSize: '8px', color: '#D46B08', marginLeft: '4px' }">常用</span></span>
                </div>
              </div>
            </div>
          </div>
        </div>

        <!-- ===== 步骤2：处方审核 ===== -->
        <template v-if="currentStep === 2">
          <div class="ws-card" :style="{ flex: 'none' }">
            <div class="ws-card-head">
              <h3>
                <svg width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                  <circle cx="12" cy="12" r="10" /><path d="M12 16v-4" /><path d="M12 8h.01" />
                </svg>
                Agent 智能审方
              </h3>
            </div>
            <div class="ws-card-body" :style="{ padding: '6px 10px' }">
              <div class="ws-sub-title" :style="{ fontSize: '10px', marginTop: '0' }">① 诊疗信息输入</div>
              <div :style="{ fontSize: '10px', color: 'var(--text-secondary)', lineHeight: '1.5', marginBottom: '2px', padding: '3px 6px', background: 'var(--bg-page)', borderRadius: '4px' }">
                <strong :style="{ color: 'var(--text-primary)' }">李某</strong> · 男 58岁 · 2026-07-14<br />
                主诉：反复头晕头痛3年，加重1周 · 血压 158/96 mmHg<br />
                既往史：高血压病史5年 · 过敏史：无
              </div>

              <div class="ws-sub-title" :style="{ fontSize: '10px' }">② 关键词提取</div>
              <div class="ws-tags" :style="{ marginBottom: '2px' }">
                <span v-for="(kw, i) in auditKeywords" :key="i" class="ws-tag" :style="{ background: kw.bg, borderColor: kw.border }">{{ kw.text }}</span>
              </div>

              <div class="ws-sub-title" :style="{ fontSize: '10px' }">③ Agent 审方分析</div>
              <div :style="{ fontSize: '10px', color: 'var(--text-secondary)', marginBottom: '2px' }">
                <div v-for="(step, i) in auditSteps" :key="i" :style="{ display: 'flex', alignItems: 'center', gap: '5px', padding: '2px 0' }">
                  <svg width="10" height="10" viewBox="0 0 24 24" fill="none" stroke="#52C41A" stroke-width="3"><polyline points="20 6 9 17 4 12" /></svg>
                  <span :style="{ color: 'var(--text-primary)', fontWeight: '500' }">{{ step.label }}</span>
                  <span :style="{ color: 'var(--text-muted)' }">— {{ step.detail }}</span>
                </div>
              </div>

              <div class="ws-sub-title" :style="{ fontSize: '10px' }">④ 审方结果输出</div>
              <div :style="{ fontSize: '10px', lineHeight: '1.5', padding: '4px 6px', background: '#F0FFF4', border: '1px solid #95DE64', borderRadius: '4px', color: 'var(--text-primary)' }">
                <div :style="{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: '2px' }">
                  <strong :style="{ fontSize: '11px', color: '#389E0D' }">✓ 审方通过</strong>
                  <span :style="{ fontSize: '9px', color: '#389E0D', background: '#D9F7BE', padding: '0 5px', borderRadius: '3px' }">低风险 12</span>
                </div>
                <div :style="{ color: 'var(--text-secondary)' }">
                  推荐处方：天麻 12g · 钩藤 15g · 石决明 30g · 黄芩 9g · 牛膝 12g · 杜仲 12g · 栀子 9g · 茯神 15g
                </div>
                <div :style="{ color: 'var(--text-secondary)', marginTop: '1px' }">
                  煎服：每日1剂，水煎400ml，分早晚两次温服
                </div>
              </div>
            </div>
          </div>

          <div class="ws-card" :style="{ flex: '1', display: 'flex', flexDirection: 'column' }">
            <div class="ws-card-head"><h3>当前处方</h3></div>
            <div class="ws-card-body" :style="{ overflowY: 'auto', flex: '1' }">
              <div class="ws-rx-list">
                <div class="ws-rx-card selected" :style="{ cursor: 'default' }">
                  <div class="ws-rx-head">
                    <div class="ws-rx-left">
                      <span class="ws-rx-dot low" />
                      <div>
                        <div class="ws-rx-patient">{{ form.name || '李某' }} · {{ form.gender || '男' }} {{ form.age || '58' }}岁</div>
                        <div class="ws-rx-diag">{{ form.diagnosis || '高血压病' }} / {{ selectedPattern || form.differentiation || '肝阳上亢证' }}</div>
                      </div>
                    </div>
                    <div class="ws-rx-right">
                      <span class="ws-risk-tag low">低 12</span>
                      <span class="ws-status pending">待审</span>
                    </div>
                  </div>
                  <div class="ws-rx-body">
                    <div class="ws-sub-title">处方药材</div>
                    <div class="ws-tags" :style="{ marginBottom: '6px' }">
                      <span v-for="(h, i) in rxDisplayHerbs" :key="i" class="ws-tag" :style="{ display: 'inline-flex', alignItems: 'center', gap: '4px' }">{{ h.name }} {{ h.dosage }}<span :style="{ fontSize: '7px', padding: '0 3px', borderRadius: '2px', background: '#F0F0F0', color: '#666' }">{{ h.sources.join('/') }}</span></span>
                    </div>
                    <div class="ws-rx-section">
                      <div class="ws-sub-title">风险项</div>
                      <ul class="ws-risk-list">
                        <li class="danger">未发现配伍禁忌</li>
                        <li class="danger">所有药材剂量在安全范围</li>
                      </ul>
                    </div>
                    <div class="ws-rx-section">
                      <div class="ws-sub-title">建议</div>
                      <ul class="ws-risk-list">
                        <li class="success">建议饭后温服</li>
                        <li class="success">忌食生冷辛辣</li>
                      </ul>
                    </div>
                    <div class="ws-btn-row" :style="{ marginTop: '8px' }">
                      <button class="btn btn-ghost btn-sm">退回</button>
                      <button class="btn btn-danger btn-sm">驳回</button>
                      <button class="btn btn-primary btn-sm" @click="router.push('/emr')">通过</button>
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </template>

        <!-- 导航按钮 -->
        <div class="ws-btn-row" :style="{ justifyContent: 'space-between', marginTop: '8px' }">
          <div>
            <button v-if="currentStep > 0" class="btn btn-outline btn-sm" @click="currentStep = currentStep - 1">← 上一步</button>
          </div>
          <div>
            <button v-if="currentStep < wizardSteps.length - 1" class="btn btn-primary btn-sm" @click="currentStep = currentStep + 1">下一步 →</button>
            <button v-else class="btn btn-primary btn-sm" @click="router.push('/emr')">提交审方</button>
          </div>
        </div>
      </div>
    </div>
    <!-- 底部操作栏 -->
    <div :style="{ display: 'flex', justifyContent: 'flex-end', gap: '8px', padding: '8px 4px 0', borderTop: '1px solid var(--border)', marginTop: '8px', flexShrink: '0' }">
      <button class="btn btn-outline btn-sm">暂存草稿</button>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref, computed, onMounted, onUnmounted } from 'vue'
import { useRouter } from 'vue-router'
import { getHerbs } from '@/api/herb'
import { getFormulas } from '@/api/formula'
import { getPatients } from '@/api/patient'
import { getPrescriptions } from '@/api/prescription'
import { getSymptomDict, getSyndromePatterns } from '@/api/dict'
import type { Patient } from '@/types/patient'

const router = useRouter()

const vFocus = { mounted: (el: HTMLInputElement) => el.focus() }

/* ============ Types ============ */
interface PatientForm {
  name: string; gender: string; age: string; phone: string; idCard: string; birthDate: string
  occupation: string; ethnicity: string; maritalStatus: string; address: string
  chiefComplaint: string; presentIllness: string; pastHistory: string; familyHistory: string; allergyHistory: string; personalHistory: string
  diagnosis: string; differentiation: string; treatmentMethod: string; prescription: string
}
interface SymptomForm {
  pulseLeft: string; pulseRight: string; pulseDescription: string
  tongueColor: string; tongueShape: string; tongueCoating: string; tongueTexture: string
  facialColor: string; expression: string; mentalState: string
  sleepQuality: string; appetite: string; thirst: string; taste: string; bowelMovement: string; urineColor: string
}
interface DiagnosisResult { pattern: string; confidence: number; description: string; symptoms: string[] }
interface CustomDiagnosis { id: string; pattern: string; description: string; symptoms: string[] }
interface Herb {
  id: number; name: string; category: string; nature: string; taste: string; meridian: string
  minDosage: number; maxDosage: number; unit: string; toxic: boolean
  functions: string[]
}
interface SelectedHerb extends Herb { currentDosage: number }
interface Prescription {
  id: number; patientName: string; patientAge: number; patientGender: string
  diagnosis: string; syndrome: string; herbs: string[]
  riskLevel: 'low' | 'medium' | 'high'; riskScore: number; status: 'pending' | 'approved' | 'rejected'
  date: string; compatibilityRisk: boolean; dosageRisk: boolean; contraindicationRisk: boolean
  risks: string[]; suggestions: string[]
}
interface EditableHerb { name: string; dosage: string }
interface MergedHerb {
  name: string; dosage: string; sources: string[]
  isAI: boolean; origIdx: number; isCustom: boolean; customIdx: number
}
interface MergedEffect { effect: string; isAI: boolean; cIdx: number; origIdx: number; isEditing: boolean }

/* ============ Data ============ */
const diagnosisResults: DiagnosisResult[] = [
  { pattern: '肝阳上亢证', confidence: 92, description: '肝阳偏亢，上扰头目，导致头晕头痛；肝肾阴虚，腰膝失养，故腰膝酸软。', symptoms: ['眩晕', '头痛', '失眠多梦', '腰膝酸软', '口苦咽干'] },
  { pattern: '阴虚阳亢证', confidence: 78, description: '阴液亏虚，阳气偏亢，虚热内生，上扰清窍。', symptoms: ['头晕耳鸣', '潮热盗汗', '五心烦热'] },
  { pattern: '肝郁气滞证', confidence: 65, description: '肝气郁结，气机不畅，情志不舒。', symptoms: ['胁肋胀痛', '胸闷善太息', '抑郁多疑'] },
]

const patternToDiagnosis = ref<Record<string, { diagnosis: string; differentiation: string; treatmentMethod: string; prescription: string }>>({})

const herbDatabase = ref<Herb[]>([])

const commonFormulas = ref<{ name: string; category: string; categoryL2: string; herbs: string[] }[]>([])

const prescriptions = ref<Prescription[]>([])

const pulseOptions = ['浮', '沉', '迟', '数', '弱', '弦', '滑', '涩', '紧', '缓', '细', '虚', '实']

const emrPatientList = ref<Patient[]>([])

const prescriptionMock = {
  complaint: '咳嗽反复2周，夜间加重',
  symptoms: ['咽干', '痰少', '口渴'],
  tongue: '舌红少苔',
  pulse: '细数',
  syndrome: '肺阴虚证',
  keywords: ['咳嗽', '咽干', '痰少', '口渴', '舌红少苔', '细数', '肺阴虚'],
  treatment: '养阴润肺',
  formulas: [
    {
      name: '沙参麦冬汤',
      herbs: [
        { name: '北沙参', dosage: '15g' },
        { name: '麦冬', dosage: '12g' },
        { name: '玉竹', dosage: '10g' },
        { name: '桑叶', dosage: '10g' },
        { name: '天花粉', dosage: '10g' },
      ],
      effects: ['养阴清肺', '生津润燥', '止咳化痰'],
      reason: '根据患者肺阴亏虚、津液不足、干咳少痰等表现，以沙参麦冬汤养阴清肺、生津润燥，为经典首选方案。',
    },
    {
      name: '百合固金汤',
      herbs: [
        { name: '百合', dosage: '12g' },
        { name: '生地黄', dosage: '15g' },
        { name: '熟地黄', dosage: '12g' },
        { name: '麦冬', dosage: '10g' },
        { name: '川贝母', dosage: '6g' },
        { name: '桔梗', dosage: '6g' },
      ],
      effects: ['滋肾保肺', '止咳化痰', '清热凉血'],
      reason: '患者肺阴虚兼阴虚内热明显，百合固金汤可滋肾保肺、清热润燥，适合阴虚咳嗽较甚者。',
    },
    {
      name: '养阴清肺汤',
      herbs: [
        { name: '生地黄', dosage: '12g' },
        { name: '麦冬', dosage: '12g' },
        { name: '白芍', dosage: '10g' },
        { name: '牡丹皮', dosage: '10g' },
        { name: '贝母', dosage: '6g' },
        { name: '玄参', dosage: '12g' },
        { name: '薄荷', dosage: '6g' },
      ],
      effects: ['养阴清肺', '解毒利咽', '润燥止咳'],
      reason: '患者咽干口渴症状突出，养阴清肺汤原方善治阴虚肺燥，兼可利咽生津，为对本证之良方。',
    },
  ],
}

/* ============ Tag Data (from API, fallback to hardcoded) ============ */
const chiefComplaintTags = ref(['咳嗽','干咳','咳痰','夜咳','晨咳','咽干','咽痒','咽痛','痰中带血','声音嘶哑','咽部异物感','反复感冒','发热','喷嚏','流涕','鼻塞','头痛','头晕','耳鸣','汗多','盗汗','自汗','头汗','易汗出','胃胀','胃痛','胃不适','腹胀','腹痛','腹泻','恶心','呕吐','反酸','嗳气','烧心','纳差','便秘','便','便血','黑便','大便干','大便黏','五更泻','腹痛欲便','里急后重','排便不爽','溏结不调','胸闷','胸痛','心悸','气短','气喘','气促','眠差','眠浅','多梦','易醒','早醒','入睡困难','嗜睡','尿频','尿急','尿痛','尿不尽','尿灼热','尿分叉','夜尿多','尿浊','尿血','水肿','阳痿','遗精','早泄','肩痛','胁痛','背痛','腰痛','颈椎痛','关节痛','关节僵硬','四肢麻木','半身麻木','四肢无力','偏瘫','拘挛','眼干','口干','口苦','牙痛','齿衄','口疮','皮疹','斑疹','丘疹','风团','皮肤红斑','皮肤瘙痒','痛经','闭经','崩漏','月经量多','月经量少','月经提前','月经延后','经期错乱','带下量多','带下量少','带下异味','黄带','偶尔','1天','2天','3天','4天','5天','1周','2周','3周','1个月','2个月','3个月','半年','1年'])

const presentIllnessSections = ref([
  { label: '诱因', tags: ['无明显诱因','受凉','劳累','接触感冒患者','季节变化','淋雨'] },
  { label: '特征', tags: ['高热','低热','喷嚏频繁','喷嚏阵发性','发热反复'] },
  { label: '影响', tags: ['休息后缓解','受凉后加重','夜间加重','活动后加重','多饮水后缓解'] },
  { label: '伴随', tags: ['流涕','咽痛','咳嗽','头痛','肌肉酸痛'] },
])

const pastHistoryTags = ref(['高血压','高血脂','心脏病','糖尿病','痛风','精神疾病','脑梗死','肝炎','胃炎','肺结核','哮喘','鼻炎','甲亢','血液病'])

const allergyTags = ref(['青霉素','链霉素','卡那霉素','林可霉素','左氧氟沙星','溴芬酸钠','阿托品','头孢类','磺胺类','酒精','碘伏','去痛片','扑热息痛','安痛定','安定','鲁米那','阿司匹林','普鲁卡因','花粉','霉菌','尘螨','毛皮屑','牛奶','鸡蛋','大豆','小麦','花生','鱼虾','坚果'])

const personalHistorySections = ref([
  { label: '吸烟/饮酒', tags: ['吸烟','偶尔吸烟','长期吸烟','不饮酒','偶尔饮酒','长期饮酒'] },
  { label: '婚育', tags: ['未婚','已婚','未孕','备孕','怀孕','闭经','有早产史','有流产史','有痛经史'] },
])

const pulseDescriptionTags = ['弦细','滑数','沉迟','浮紧','细弱','洪大','濡缓','涩滞','虚浮','实有力']
const tongueColorTags = ['淡','红','绛','紫','青']
const tongueCoatingTags = ['薄白','薄黄','白腻','黄腻','少苔','剥苔','厚苔']
const tongueShapeTags = ['胖大','肿胀','瘦薄','裂纹','齿痕']
const tongueTextureTags = ['嫩','老','润','燥']
const facialColorTags = ['苍白','潮红','萎黄','暗黑','正常']
const expressionTags = ['有神','少神','失神','烦躁','抑郁']

const inquirySections = [
  { label: '寒热', tags: ['恶风','恶寒','怕冷','怕热','潮热','手足心热'], field: 'sleepQuality' as const },
  { label: '汗出', tags: ['自汗','盗汗','汗多','冷汗','头汗','手足心汗'], field: 'sleepQuality' as const },
  { label: '饮食', tags: ['纳可','纳差','口干','口苦','喜冷饮','喜热饮'], field: 'appetite' as const },
  { label: '二便', tags: ['小便正常','尿黄','多尿','少尿','大便正常','便溏','大便干','大便黏'], field: 'bowelMovement' as const },
]

const keywordBgColors = ['#E8F4FD','#F0EBFF','#FFF7E6','#FFF0F0','#F0FFF4','#E6FFFB','#FFF0F6']
const keywordBorderColors = ['#91CAFF','#B89EFF','#FFD591','#FFA39E','#95DE64','#87E8DE','#FF85C0']

const auditKeywords = [
  { text: '高血压', bg: '#E8F4FD', border: '#91CAFF' },
  { text: '肝阳上亢', bg: '#F0EBFF', border: '#B89EFF' },
  { text: '头晕', bg: '#FFF7E6', border: '#FFD591' },
  { text: '头痛', bg: '#FFF0F0', border: '#FFA39E' },
  { text: '失眠', bg: '#F0FFF4', border: '#95DE64' },
  { text: '口苦咽干', bg: '#E6FFFB', border: '#87E8DE' },
]

const auditSteps = [
  { label: '证型匹配', detail: '肝阳上亢证（匹配度 92%）' },
  { label: '方剂推荐', detail: '天麻钩藤饮加减' },
  { label: '配伍检查', detail: '未发现配伍禁忌' },
  { label: '剂量校验', detail: '所有药材在安全范围' },
  { label: '禁忌审查', detail: '无禁忌证冲突' },
]

/* ============ State ============ */
const form = ref<PatientForm>({
  name: '', gender: '', age: '', phone: '', idCard: '', birthDate: '',
  occupation: '', ethnicity: '汉族', maritalStatus: '', address: '',
  chiefComplaint: '', presentIllness: '', pastHistory: '', familyHistory: '', allergyHistory: '', personalHistory: '',
  diagnosis: '', differentiation: '', treatmentMethod: '', prescription: '',
})
const symptoms = ref<SymptomForm>({
  pulseLeft: '', pulseRight: '', pulseDescription: '', tongueColor: '', tongueShape: '',
  tongueCoating: '', tongueTexture: '', facialColor: '', expression: '', mentalState: '',
  sleepQuality: '', appetite: '', thirst: '', taste: '', bowelMovement: '', urineColor: '',
})
const showPulsePicker = ref(false)
const showTonguePicker = ref(false)
const showInspectionPicker = ref(false)
const showInquiryPicker = ref(false)
const tonguePhoto = ref<string | null>(null)
const pulseImportData = ref('')
const showChiefComplaintPicker = ref(false)
const showPresentIllnessPicker = ref(false)
const showPastHistoryPicker = ref(false)
const showAllergyPicker = ref(false)
const showPersonalHistoryPicker = ref(false)

const chiefComplaintRef = ref<HTMLElement | null>(null)
const presentIllnessRef = ref<HTMLElement | null>(null)
const pastHistoryRef = ref<HTMLElement | null>(null)
const allergyRef = ref<HTMLElement | null>(null)
const personalHistoryRef = ref<HTMLElement | null>(null)

const selectedPattern = ref('')
const customDiagnoses = ref<CustomDiagnosis[]>([])
const customPattern = ref('')
const customDescription = ref('')
const customSymptoms = ref('')

const selectedFormulaIndices = ref<number[]>([0])
const aiHerbs = ref<EditableHerb[]>(prescriptionMock.formulas[0].herbs.map(h => ({ ...h })))
const editingHerbIdx = ref<number | null>(null)
const editName = ref('')
const editDosage = ref('')
const deletedHerb = ref<{ herb: EditableHerb; index: number } | null>(null)

const editingFormulaName = ref(false)
const editFormulaName = ref('')

const formulaEffects = ref<string[]>([...prescriptionMock.formulas[0].effects])
const editingEffectIdx = ref<number | null>(null)
const editEffect = ref('')

const editingReason = ref(false)
const editReason = ref('')

const showCustomEditor = ref(false)
const customHerbs = ref<EditableHerb[]>([])
const customEffects = ref<string[]>([])
const customReason = ref('')
const customFormulaName = ref('自定义方剂')
const formulaSearchQuery = ref('')
const showFormulaSearchResults = ref(false)
const selectedCommonFormulaNames = ref<string[]>([])

const editingCustomHerbIdx = ref<number | null>(null)
const editCustomName = ref('')
const editCustomDosage = ref('')
const deletedCustomHerb = ref<{ herb: EditableHerb; index: number } | null>(null)
const editingCustomEffectIdx = ref<number | null>(null)
const editCustomEffect = ref('')
const editingCustomReason = ref(false)
const editCustomReason = ref('')

const selectedFormula = ref('')
const searchHerb = ref('')
const selectedHerbs = ref<SelectedHerb[]>([])
const notes = ref('')
const compatibilityWarnings = ref<string[]>([])
const expandedRxId = ref<number | null>(null)
const selectedRx = ref<Prescription | null>(null)
const selectedPatientFromBar = ref<number | null>(null)

const currentStep = ref(0)
const wizardSteps = ['辨证诊断', '智能开方', '处方审核']

let undoTimeout: ReturnType<typeof setTimeout> | null = null

/* ============ Computed ============ */
const selectedResult = computed(() => diagnosisResults.find(r => r.pattern === selectedPattern.value))
const pendingCount = computed(() => prescriptions.value.filter(p => p.status === 'pending').length)

const selectedPatientInfo = computed(() => emrPatientList.value.find(x => x.id === selectedPatientFromBar.value) || null)

const tongueDisplay = computed(() => {
  let val = symptoms.value.tongueColor
  if (symptoms.value.tongueCoating) val += ' ' + symptoms.value.tongueCoating
  if (symptoms.value.tongueShape) val += ' ' + symptoms.value.tongueShape
  if (symptoms.value.tongueTexture) val += ' ' + symptoms.value.tongueTexture
  return val
})
const inspectionDisplay = computed(() => symptoms.value.facialColor + (symptoms.value.expression ? ' ' + symptoms.value.expression : ''))
const inquiryDisplay = computed(() => {
  let val = symptoms.value.sleepQuality
  if (symptoms.value.appetite) val += ' ' + symptoms.value.appetite
  if (symptoms.value.thirst) val += ' ' + symptoms.value.thirst
  if (symptoms.value.bowelMovement) val += ' ' + symptoms.value.bowelMovement
  return val
})

const tongueSummary = computed(() => [symptoms.value.tongueColor, symptoms.value.tongueCoating, symptoms.value.tongueShape, symptoms.value.tongueTexture].filter(Boolean).join(' '))
const inspectionSummary = computed(() => [symptoms.value.facialColor, symptoms.value.expression].filter(Boolean).join(' '))
const inquirySummary = computed(() => [symptoms.value.sleepQuality, symptoms.value.appetite, symptoms.value.thirst, symptoms.value.bowelMovement].filter(Boolean).join(' '))

function getMergedFromIndices(indices: number[]) {
  if (indices.length === 0) return { herbs: [] as EditableHerb[], effects: [] as string[], reason: '' }
  const allHerbs: EditableHerb[] = []
  const seenNames = new Set<string>()
  const allEffects: string[] = []
  const seenEffects = new Set<string>()
  const allReasons: string[] = []
  indices.forEach(i => {
    const f = prescriptionMock.formulas[i]
    f.herbs.forEach(h => {
      if (!seenNames.has(h.name)) { seenNames.add(h.name); allHerbs.push({ ...h }) }
    })
    f.effects.forEach(e => {
      if (!seenEffects.has(e)) { seenEffects.add(e); allEffects.push(e) }
    })
    allReasons.push(f.reason)
  })
  return { herbs: allHerbs, effects: allEffects, reason: allReasons.join('；') }
}

const aiReason = computed(() => getMergedFromIndices(selectedFormulaIndices.value).reason)
const displayReason = computed(() => {
  if (showCustomEditor.value && customReason.value) {
    return aiReason.value ? aiReason.value + '；' + customReason.value : customReason.value
  }
  return aiReason.value
})

const currentFormulaName = computed(() => {
  return selectedFormulaIndices.value.length === 1
    ? prescriptionMock.formulas[selectedFormulaIndices.value[0]].name
    : '合方(' + selectedFormulaIndices.value.map(idx => prescriptionMock.formulas[idx].name).join('+') + ')'
})

const mergedHerbs = computed<MergedHerb[]>(() => {
  const displayHerbs = showCustomEditor.value ? [...aiHerbs.value, ...customHerbs.value] : aiHerbs.value
  const aiCount = aiHerbs.value.length
  const sourceMap = new Map<string, Set<string>>()
  for (const idx of selectedFormulaIndices.value) {
    const f = prescriptionMock.formulas[idx]
    for (const h of f.herbs) {
      if (!sourceMap.has(h.name)) sourceMap.set(h.name, new Set())
      sourceMap.get(h.name)!.add(f.name)
    }
  }
  for (const name of selectedCommonFormulaNames.value) {
    const cf = commonFormulas.value.find(c => c.name === name)
    if (cf) {
      for (const h of cf.herbs) {
        if (!sourceMap.has(h)) sourceMap.set(h, new Set())
        sourceMap.get(h)!.add(name)
      }
    }
  }
  const seenNames = new Set<string>()
  const result: MergedHerb[] = []
  for (let idx = 0; idx < displayHerbs.length; idx++) {
    const h = displayHerbs[idx]
    if (seenNames.has(h.name)) continue
    seenNames.add(h.name)
    const rawSources = sourceMap.get(h.name)
    const sources = rawSources ? Array.from(rawSources) : ['手动']
    result.push({
      name: h.name, dosage: h.dosage, sources,
      isAI: idx < aiCount, origIdx: idx,
      isCustom: idx >= aiCount, customIdx: idx - aiCount,
    })
  }
  return result
})

const mergedEffectsData = computed<MergedEffect[]>(() => {
  const display = showCustomEditor.value ? [...formulaEffects.value, ...customEffects.value] : formulaEffects.value
  const aiCount = formulaEffects.value.length
  return display.map((e, i) => ({
    effect: e,
    isAI: i < aiCount,
    cIdx: i - aiCount,
    origIdx: i,
    isEditing: i < aiCount ? editingEffectIdx.value === i : editingCustomEffectIdx.value === (i - aiCount),
  }))
})

const formulaSearchResults = computed(() => {
  const combined = [
    ...prescriptionMock.formulas,
    ...commonFormulas.value.map(f => ({ name: f.name, herbs: f.herbs.map(h => ({ name: h, dosage: '9g' })), effects: [] as string[], reason: '' })),
  ]
  return combined.filter(f => f.name.includes(formulaSearchQuery.value))
})

const treatmentToCategoryL1 = (treatment: string): string => {
  return '经典方剂'
}

const directionCategoryL1 = computed(() => treatmentToCategoryL1(prescriptionMock.treatment))

const allDirectionFormulas = computed(() => {
  const aiFormulas = prescriptionMock.formulas.map((f, i) => ({ ...f, idx: i, source: 'ai' as const }))
  const cat = directionCategoryL1.value
  const commonFiltered = commonFormulas.value
    .filter(cf => !prescriptionMock.formulas.some(af => af.name === cf.name))
    .filter(cf => !cat || cf.category === cat)
    .slice(0, 30)
    .map((cf, i) => ({
      name: cf.name,
      herbs: cf.herbs.map(h => ({ name: h, dosage: '9g' })),
      effects: [] as string[],
      reason: '',
      idx: i + prescriptionMock.formulas.length,
      source: 'common' as const,
    }))
  return [...aiFormulas, ...commonFiltered]
})

const rxDisplayHerbs = computed(() => {
  const herbs = [...getMergedFromIndices(selectedFormulaIndices.value).herbs, ...customHerbs.value]
  const rxSourceMap = new Map<string, Set<string>>()
  for (const idx of selectedFormulaIndices.value) {
    const f = prescriptionMock.formulas[idx]
    for (const h of f.herbs) {
      if (!rxSourceMap.has(h.name)) rxSourceMap.set(h.name, new Set())
      rxSourceMap.get(h.name)!.add(f.name)
    }
  }
  for (const name of selectedCommonFormulaNames.value) {
    const cf = commonFormulas.value.find(c => c.name === name)
    if (cf) {
      for (const h of cf.herbs) {
        if (!rxSourceMap.has(h)) rxSourceMap.set(h, new Set())
        rxSourceMap.get(h)!.add(name)
      }
    }
  }
  const rxSeen = new Set<string>()
  const result: { name: string; dosage: string; sources: string[] }[] = []
  for (const h of herbs) {
    if (rxSeen.has(h.name)) continue
    rxSeen.add(h.name)
    const s = rxSourceMap.get(h.name)
    const sources = s ? Array.from(s) : ['手动']
    result.push({ name: h.name, dosage: h.dosage, sources })
  }
  return result
})

const filteredHerbs = computed(() => {
  const t = searchHerb.value.toLowerCase()
  return herbDatabase.value.filter(h => h.name.includes(t) || h.category.includes(t) || h.functions.some(f => f.includes(t)))
})

/* ============ Functions ============ */
function handleSymptomChange(field: keyof SymptomForm, value: string) {
  symptoms.value[field] = value
}

function appendForm(field: keyof PatientForm, v: string) {
  const cur = form.value[field]
  form.value[field] = cur ? cur + ' ' + v : v
}

function appendSymptom(field: keyof SymptomForm, v: string) {
  const cur = symptoms.value[field]
  symptoms.value[field] = cur ? cur + ' ' + v : v
}

function appendInquiry(label: string, v: string) {
  if (label === '寒热' || label === '汗出') {
    appendSymptom('sleepQuality', v)
  } else if (label === '饮食') {
    appendSymptom('appetite', v)
  } else if (label === '二便') {
    appendSymptom('bowelMovement', v)
  }
}

function selectPatientFromBar(patient: Patient) {
  selectedPatientFromBar.value = patient.id
  form.value = { ...form.value, name: patient.name, gender: patient.gender === '男' ? 'male' : 'female', age: String(patient.age) }
}

function handleSelectPattern(result: DiagnosisResult) {
  customPattern.value = result.pattern
  customDescription.value = result.description
  customSymptoms.value = result.symptoms.join('、')
  selectedPattern.value = result.pattern
  const mockData = patternToDiagnosis.value[result.pattern]
  if (mockData) {
    form.value = { ...form.value, diagnosis: mockData.diagnosis, differentiation: mockData.differentiation }
  }
}

function onTongueInput(e: Event) {
  const val = (e.target as HTMLInputElement).value
  symptoms.value.tongueColor = val
  symptoms.value.tongueCoating = ''
  symptoms.value.tongueShape = ''
  symptoms.value.tongueTexture = ''
}
function onInspectionInput(e: Event) {
  const val = (e.target as HTMLInputElement).value
  symptoms.value.facialColor = val
  symptoms.value.expression = ''
}
function onInquiryInput(e: Event) {
  const val = (e.target as HTMLInputElement).value
  symptoms.value.sleepQuality = val
  symptoms.value.appetite = ''
  symptoms.value.thirst = ''
  symptoms.value.bowelMovement = ''
}

function triggerTonguePhotoUpload() {
  const input = document.createElement('input')
  input.type = 'file'
  input.accept = 'image/*'
  input.onchange = (e: Event) => {
    const file = (e.target as HTMLInputElement).files?.[0]
    if (file) {
      const reader = new FileReader()
      reader.onload = (ev) => { tonguePhoto.value = ev.target?.result as string }
      reader.readAsDataURL(file)
    }
  }
  input.click()
}
function openTonguePhoto() {
  if (tonguePhoto.value) window.open(tonguePhoto.value)
}

function toggleFormulaSelection(i: number) {
  let newIndices: number[]
  if (selectedFormulaIndices.value.includes(i)) {
    newIndices = selectedFormulaIndices.value.filter(idx => idx !== i)
  } else {
    newIndices = [...selectedFormulaIndices.value, i]
  }
  selectedFormulaIndices.value = newIndices
  const merged = getMergedFromIndices(newIndices)
  aiHerbs.value = merged.herbs
  formulaEffects.value = merged.effects
  editReason.value = merged.reason
  editFormulaName.value = newIndices.length === 1
    ? prescriptionMock.formulas[newIndices[0]].name
    : '合方(' + newIndices.map(idx => prescriptionMock.formulas[idx].name).join('+') + ')'
  deletedHerb.value = null
  editingFormulaName.value = false
  editingEffectIdx.value = null
  editingReason.value = false
}

function toggleCommonFormula(name: string) {
  const isSelected = selectedCommonFormulaNames.value.includes(name)
  let newNames: string[]
  if (isSelected) {
    newNames = selectedCommonFormulaNames.value.filter(n => n !== name)
  } else {
    newNames = [...selectedCommonFormulaNames.value, name]
  }
  selectedCommonFormulaNames.value = newNames
  const allHerbs: EditableHerb[] = []
  const allEffects: string[] = []
  const allReasons: string[] = []
  newNames.forEach(n => {
    const cf = commonFormulas.value.find(c => c.name === n)
    if (cf) { cf.herbs.forEach(h => allHerbs.push({ name: h, dosage: '9g' })) }
  })
  customHerbs.value = allHerbs
  customEffects.value = allEffects
  customReason.value = allReasons.join('；')
  if (newNames.length > 0) {
    customFormulaName.value = newNames.join(' + ')
    showCustomEditor.value = true
  } else {
    customFormulaName.value = '自定义方剂'
    showCustomEditor.value = false
  }
  formulaSearchQuery.value = ''
  showFormulaSearchResults.value = false
}

function handleFormulaClick(f: any) {
  if (f.source === 'ai') {
    toggleFormulaSelection(f.idx)
  } else {
    toggleCommonFormula(f.name)
  }
}

function isFormulaSelected(f: any): boolean {
  if (f.source === 'ai') return selectedFormulaIndices.value.includes(f.idx)
  return selectedCommonFormulaNames.value.includes(f.name)
}

function getFormulaCardStyle(selected: boolean) {
  return {
    flex: '1', padding: '6px 8px', borderRadius: '6px', cursor: 'pointer', textAlign: 'center', minWidth: '60px',
    border: selected ? '1.5px solid var(--primary)' : '1px solid #E0E0E0',
    background: selected ? 'var(--primary-bg)' : '#FAFAFA',
    position: 'relative' as const,
  }
}

function getDirectionFormulaStyle(f: any) {
  const selected = isFormulaSelected(f)
  const isCommon = f.source === 'common'
  const isHighlighted = isCommon && showCustomEditor.value && customFormulaName.value === f.name
  return {
    fontSize: '11px', padding: '2px 8px', borderRadius: '4px', cursor: 'pointer',
    background: selected ? 'var(--primary-bg)' : isHighlighted ? '#FFF7E6' : '#FAFAFA',
    border: selected ? '1px solid var(--primary)' : isHighlighted ? '1px solid #FFD591' : '1px solid #E0E0E0',
    color: selected ? 'var(--primary)' : isHighlighted ? '#D46B08' : 'var(--text-secondary)',
    fontWeight: (selected || isHighlighted) ? '600' : '400',
  }
}

function onCustomFormulaNameInput(e: Event) {
  const val = (e.target as HTMLInputElement).value
  customFormulaName.value = val
  formulaSearchQuery.value = val
  showFormulaSearchResults.value = val.length > 0
  if (!val.trim()) {
    customHerbs.value = []
    customEffects.value = []
    customReason.value = ''
    selectedCommonFormulaNames.value = []
  }
}

function selectFormulaFromSearch(f: any) {
  customFormulaName.value = f.name
  customHerbs.value = f.herbs.map((h: any) => ({ ...h }))
  customEffects.value = f.effects ? [...f.effects] : []
  customReason.value = f.reason || ''
  showFormulaSearchResults.value = false
  formulaSearchQuery.value = ''
}

function startEditFormulaName() {
  editingFormulaName.value = true
  editFormulaName.value = currentFormulaName.value
}

function isHerbEditing(mh: MergedHerb): boolean {
  return mh.isAI ? editingHerbIdx.value === mh.origIdx : editingCustomHerbIdx.value === mh.customIdx
}

function onHerbNameInput(mh: MergedHerb, e: Event) {
  const val = (e.target as HTMLInputElement).value
  if (mh.isAI) editName.value = val
  else editCustomName.value = val
}
function onHerbDosageInput(mh: MergedHerb, e: Event) {
  const val = (e.target as HTMLInputElement).value
  if (mh.isAI) editDosage.value = val
  else editCustomDosage.value = val
}

function startHerbEdit(mh: MergedHerb) {
  let found = false
  for (let j = 0; j < aiHerbs.value.length; j++) {
    if (aiHerbs.value[j].name === mh.name) {
      editingHerbIdx.value = j
      editName.value = aiHerbs.value[j].name
      editDosage.value = aiHerbs.value[j].dosage
      found = true
      break
    }
  }
  if (!found) {
    for (let j = 0; j < customHerbs.value.length; j++) {
      if (customHerbs.value[j].name === mh.name) {
        editingCustomHerbIdx.value = j
        editCustomName.value = customHerbs.value[j].name
        editCustomDosage.value = customHerbs.value[j].dosage
        break
      }
    }
  }
}

function saveHerbEdit(mh: MergedHerb) {
  const name = (mh.isAI ? editName.value : editCustomName.value).trim()
  if (!name) return
  if (mh.isAI) {
    const updated = [...aiHerbs.value]
    updated[mh.origIdx] = { name, dosage: editDosage.value.trim() }
    aiHerbs.value = updated
    editingHerbIdx.value = null
  } else {
    const updated = [...customHerbs.value]
    updated[mh.customIdx] = { name, dosage: editCustomDosage.value.trim() }
    customHerbs.value = updated
    editingCustomHerbIdx.value = null
  }
}

function deleteHerb(mh: MergedHerb) {
  if (mh.isAI) {
    deletedHerb.value = { herb: aiHerbs.value[mh.origIdx], index: mh.origIdx }
    aiHerbs.value = aiHerbs.value.filter((_, idx) => idx !== mh.origIdx)
    editingHerbIdx.value = null
  } else {
    deletedCustomHerb.value = { herb: customHerbs.value[mh.customIdx], index: mh.customIdx }
    customHerbs.value = customHerbs.value.filter((_, idx) => idx !== mh.customIdx)
    editingCustomHerbIdx.value = null
  }
  if (undoTimeout) clearTimeout(undoTimeout)
  undoTimeout = setTimeout(() => { deletedHerb.value = null; deletedCustomHerb.value = null }, 6000)
}

function undoDeleteHerb() {
  if (!deletedHerb.value) return
  const restored = [...aiHerbs.value]
  restored.splice(deletedHerb.value.index, 0, deletedHerb.value.herb)
  aiHerbs.value = restored
  deletedHerb.value = null
  if (undoTimeout) clearTimeout(undoTimeout)
}

function undoDeleteCustomHerb() {
  if (!deletedCustomHerb.value) return
  const restored = [...customHerbs.value]
  restored.splice(deletedCustomHerb.value.index, 0, deletedCustomHerb.value.herb)
  customHerbs.value = restored
  deletedCustomHerb.value = null
  if (undoTimeout) clearTimeout(undoTimeout)
}

function addHerb() {
  if (showCustomEditor.value) {
    customHerbs.value = [...customHerbs.value, { name: '', dosage: '' }]
    editingCustomHerbIdx.value = customHerbs.value.length - 1
    editCustomName.value = ''
    editCustomDosage.value = ''
  } else {
    aiHerbs.value = [...aiHerbs.value, { name: '', dosage: '' }]
    editingHerbIdx.value = aiHerbs.value.length - 1
    editName.value = ''
    editDosage.value = ''
  }
}

function onEffectNameInput(isAI: boolean, e: Event) {
  const val = (e.target as HTMLInputElement).value
  if (isAI) editEffect.value = val
  else editCustomEffect.value = val
}

function startEffectEdit(isAI: boolean, i: number, cIdx: number, effect: string) {
  if (isAI) { editingEffectIdx.value = i; editEffect.value = effect }
  else { editingCustomEffectIdx.value = cIdx; editCustomEffect.value = effect }
}

function saveEffectEdit(isAI: boolean, i: number, cIdx: number) {
  const val = (isAI ? editEffect.value : editCustomEffect.value).trim()
  if (!val) return
  if (isAI) { const u = [...formulaEffects.value]; u[i] = val; formulaEffects.value = u; editingEffectIdx.value = null }
  else { const u = [...customEffects.value]; u[cIdx] = val; customEffects.value = u; editingCustomEffectIdx.value = null }
}

function deleteEffect(isAI: boolean, i: number, cIdx: number) {
  if (isAI) { formulaEffects.value = formulaEffects.value.filter((_, idx) => idx !== i); editingEffectIdx.value = null }
  else { customEffects.value = customEffects.value.filter((_, idx) => idx !== cIdx); editingCustomEffectIdx.value = null }
}

function addEffect() {
  if (showCustomEditor.value) {
    customEffects.value = [...customEffects.value, '']
    editingCustomEffectIdx.value = customEffects.value.length - 1
    editCustomEffect.value = ''
  } else {
    formulaEffects.value = [...formulaEffects.value, '']
    editingEffectIdx.value = formulaEffects.value.length - 1
    editEffect.value = ''
  }
}

function startReasonEdit() {
  editingReason.value = true
  editReason.value = displayReason.value
}

function cancelReasonEdit() {
  editingReason.value = false
  editReason.value = aiReason.value
}

function checkCompatibilities(herbs: SelectedHerb[]) {
  const w: string[] = []
  for (let i = 0; i < herbs.length; i++) {
    if (herbs[i].currentDosage > herbs[i].maxDosage) w.push(`${herbs[i].name} 超出最大剂量（${herbs[i].maxDosage}${herbs[i].unit}）`)
  }
  compatibilityWarnings.value = w
}

function addHerbToSelection(herb: Herb) {
  if (selectedHerbs.value.some(h => h.id === herb.id)) return
  const updated = [...selectedHerbs.value, { ...herb, currentDosage: Math.round((herb.minDosage + herb.maxDosage) / 2) }]
  selectedHerbs.value = updated
  checkCompatibilities(updated)
}

function removeHerbFromSelection(id: number) {
  const updated = selectedHerbs.value.filter(h => h.id !== id)
  selectedHerbs.value = updated
  checkCompatibilities(updated)
}

function updateDosage(id: number, value: number) {
  const updated = selectedHerbs.value.map(h => h.id === id ? { ...h, currentDosage: value } : h)
  selectedHerbs.value = updated
  checkCompatibilities(updated)
}

function applyFormula(name: string) {
  selectedFormula.value = name
  const formula = commonFormulas.value.find(f => f.name === name)
  if (!formula) return
  const dosages: Record<string, number> = { '柴胡': 12, '黄芩': 9, '党参': 9, '半夏': 9, '炙甘草': 6, '生姜': 9, '大枣': 12, '当归': 12, '川芎': 9, '白芍': 12, '熟地黄': 15, '桂枝': 9, '茯苓': 15, '白术': 12 }
  const herbs = formula.herbs.map(n => { const h = herbDatabase.value.find(x => x.name === n); return h ? { ...h, currentDosage: dosages[n] || 9 } : null }).filter((h): h is SelectedHerb => h !== null)
  selectedHerbs.value = herbs
  checkCompatibilities(herbs)
}

/* ============ Lifecycle ============ */
function handleClickOutside(e: MouseEvent) {
  const target = e.target as HTMLElement
  if (chiefComplaintRef.value && !chiefComplaintRef.value.contains(target)) showChiefComplaintPicker.value = false
  if (presentIllnessRef.value && !presentIllnessRef.value.contains(target)) showPresentIllnessPicker.value = false
  if (pastHistoryRef.value && !pastHistoryRef.value.contains(target)) showPastHistoryPicker.value = false
  if (allergyRef.value && !allergyRef.value.contains(target)) showAllergyPicker.value = false
  if (personalHistoryRef.value && !personalHistoryRef.value.contains(target)) showPersonalHistoryPicker.value = false
  if (!target.closest('.ws-picker-panel') && !target.closest('.ws-field input')) {
    showPulsePicker.value = false
    showTonguePicker.value = false
    showInspectionPicker.value = false
    showInquiryPicker.value = false
  }
}

onMounted(async () => {
  const state = window.history.state as Record<string, unknown> | null
  const patient = state?.patient as { id: number; name: string; gender: string; age: number; diagnosis: string } | undefined
  if (patient) {
    selectedPatientFromBar.value = patient.id
    form.value = {
      ...form.value,
      name: patient.name,
      gender: patient.gender === '男' ? 'male' : 'female',
      age: String(patient.age),
    }
    window.history.replaceState({}, '')
  }
  document.addEventListener('mousedown', handleClickOutside)

  // Fetch data from APIs
  try {
    const [herbsRes, formulasRes, prescriptionsRes, patientsRes, patternsRes, symptomDictRes] = await Promise.all([
      getHerbs(),
      getFormulas(),
      getPrescriptions(),
      getPatients(),
      getSyndromePatterns(),
      getSymptomDict(),
    ])
    herbDatabase.value = ((herbsRes as any[]) || []).map(h => ({
      id: h.id, name: h.name, category: h.category || '',
      nature: h.nature || '', taste: h.taste || '', meridian: h.meridian || '',
      minDosage: h.min_dosage ?? 0, maxDosage: h.max_dosage ?? 0, unit: h.unit || 'g',
      toxic: !!h.is_toxic,
      functions: h.functions ? [h.functions] : [],
    }))
    commonFormulas.value = ((formulasRes as any[]) || []).map(f => ({ name: f.name, category: f.category_l1 || '', categoryL2: f.category_l2 || '', herbs: ((f.herbs as string[]) || []) }))
    prescriptions.value = (prescriptionsRes as Prescription[]) || []
    emrPatientList.value = (patientsRes as Patient[]) || []
    // Convert syndrome patterns array to record
    const patternsArr = (patternsRes as Array<{ pattern: string; diagnosis: string; differentiation: string; treatmentMethod: string; prescription: string }>) || []
    const record: Record<string, { diagnosis: string; differentiation: string; treatmentMethod: string; prescription: string }> = {}
    patternsArr.forEach(p => { record[p.pattern] = { diagnosis: p.diagnosis, differentiation: p.differentiation, treatmentMethod: p.treatmentMethod, prescription: p.prescription } })
    patternToDiagnosis.value = record
    // Map symptom_dict data into tag picker arrays
    const dictItems = (symptomDictRes as Array<{ category: string; sub_category: string | null; label: string }>) || []
    const ccLabels = dictItems.filter(s => s.category === 'chief_complaint').map(s => s.label)
    if (ccLabels.length) chiefComplaintTags.value = ccLabels
    const piMap = new Map<string, string[]>()
    dictItems.filter(s => s.category === 'present_illness').forEach(s => {
      const key = s.sub_category || '其他'
      if (!piMap.has(key)) piMap.set(key, [])
      piMap.get(key)!.push(s.label)
    })
    if (piMap.size) presentIllnessSections.value = Array.from(piMap.entries()).map(([label, tags]) => ({ label, tags }))
    const phLabels = dictItems.filter(s => s.category === 'past_history').map(s => s.label)
    if (phLabels.length) pastHistoryTags.value = phLabels
    const alLabels = dictItems.filter(s => s.category === 'allergy').map(s => s.label)
    if (alLabels.length) allergyTags.value = alLabels
    const peLabels = dictItems.filter(s => s.category === 'personal').map(s => s.label)
    if (peLabels.length) personalHistorySections.value = [{ label: '个人习惯', tags: peLabels }]
  } catch (_) {
    // Keep fallback hardcoded refs on error
  }
})

onUnmounted(() => {
  document.removeEventListener('mousedown', handleClickOutside)
  if (undoTimeout) clearTimeout(undoTimeout)
})
</script>

<style scoped>
.ws-page {
  padding: 8px 8px;
  width: 100%;
  margin: 0;
  height: 100%;
  display: flex;
  flex-direction: column;
  overflow: hidden;
}

.ws-body {
  display: flex;
  gap: 10px;
  flex: 1;
  min-height: 0;
  overflow: hidden;
}

.ws-col {
  display: flex;
  flex-direction: column;
  gap: 6px;
  padding: 0 2px;
  min-height: 0;
  overflow: hidden;
}

.ws-patient-bar {
  flex: 1;
  min-width: 0;
}

.ws-col.ws-patient-bar {
  max-width: none;
}

.ws-left {
  flex: 4;
  min-width: 0;
}

.ws-center {
  flex: 1.5;
  min-width: 0;
}

.ws-right {
  flex: 2;
  min-width: 0;
}

.ws-col-title {
  display: flex;
  align-items: center;
  gap: 6px;
  font-size: 13px;
  font-weight: 700;
  color: var(--text-primary);
  padding: 4px 4px 4px;
  flex-shrink: 0;
  letter-spacing: 0.3px;
}

.ws-col-icon {
  display: inline-flex;
  align-items: center;
  justify-content: center;
  width: 22px;
  height: 22px;
  border-radius: 5px;
}

.ws-col-icon.blue {
  background: #E8F4FD;
  color: #4A90D9;
}

.ws-col-icon.purple {
  background: #F0EBFF;
  color: #7B61FF;
}

.ws-col-icon.green {
  background: #E8F8EF;
  color: #52C41A;
}

.ws-badge {
  display: inline-flex;
  align-items: center;
  justify-content: center;
  min-width: 16px;
  height: 16px;
  padding: 0 4px;
  background: var(--danger);
  color: #fff;
  font-size: 10px;
  font-weight: 600;
  border-radius: 8px;
}

.ws-card {
  background: var(--bg-white);
  border: 1px solid var(--border);
  border-radius: 8px;
  overflow: hidden;
  box-shadow: 0 1px 3px rgba(0, 0, 0, 0.04);
  display: flex;
  flex-direction: column;
  min-height: 0;
  flex: 1;
}

.ws-card-head {
  display: flex;
  align-items: center;
  justify-content: space-between;
  padding: 6px 10px;
  border-bottom: 1px solid var(--border-light);
  background: #FAFBFC;
  flex-shrink: 0;
}

.ws-card-head h3 {
  font-size: 12px;
  font-weight: 600;
  color: var(--text-primary);
  display: flex;
  align-items: center;
  gap: 5px;
}

.ws-card-body {
  padding: 8px 10px;
  overflow-y: auto;
  flex: 1;
  min-height: 0;
}

.ws-ai-badge {
  font-size: 9px;
  font-weight: 700;
  color: #fff;
  background: linear-gradient(135deg, #7B61FF, #4A90D9);
  padding: 1px 5px;
  border-radius: 3px;
  letter-spacing: 0.5px;
}

.ws-warning {
  background: #FFF7E6;
  border: 1px solid #FFD591;
  border-radius: 6px;
  padding: 5px 8px;
  display: flex;
  align-items: center;
  gap: 6px;
  color: #D46B08;
  font-size: 11px;
  font-weight: 500;
  flex-shrink: 0;
}

.ws-form-grid {
  display: grid;
  grid-template-columns: 1fr 1fr;
  gap: 5px;
}

.ws-field {
  display: flex;
  flex-direction: column;
  gap: 2px;
}

.ws-field.full {
  grid-column: 1 / -1;
  margin-top: 4px;
}

.ws-field label {
  font-size: 10px;
  font-weight: 500;
  color: var(--text-secondary);
}

.ws-field .req {
  color: var(--danger);
}

.ws-field input,
.ws-field select,
.ws-field textarea {
  padding: 3px 6px;
  border: 1px solid var(--border);
  border-radius: 5px;
  font-size: 11px;
  color: var(--text-primary);
  background: var(--bg-white);
  transition: border-color 0.15s;
}

.ws-field input:focus,
.ws-field select:focus,
.ws-field textarea:focus {
  outline: none;
  border-color: var(--primary);
  box-shadow: 0 0 0 2px var(--primary-bg);
}

.ws-field textarea {
  resize: vertical;
  min-height: 28px;
}

.ws-sub-title {
  font-size: 11px;
  font-weight: 600;
  color: var(--text-primary);
  margin: 5px 0 3px;
  padding-bottom: 2px;
  border-bottom: 1px solid var(--border-light);
}

.ws-sub-title:first-child {
  margin-top: 0;
}

.ws-picker-panel {
  position: absolute;
  top: 100%;
  left: 0;
  right: 0;
  z-index: 100;
  background: #fff;
  border: 1px solid var(--border);
  border-radius: 6px;
  box-shadow: 0 4px 12px rgba(0,0,0,0.1);
  padding: 8px;
  display: flex;
  flex-direction: column;
  gap: 6px;
  margin-top: 2px;
}

.ws-pulse-section {
  display: flex;
  flex-direction: column;
  gap: 3px;
}

.ws-pulse-section-label {
  font-size: 10px;
  font-weight: 600;
  color: var(--text-secondary);
}

.ws-pulse-tags {
  display: flex;
  flex-wrap: wrap;
  gap: 3px;
}

.ws-pulse-tag {
  padding: 2px 7px;
  border-radius: 100px;
  font-size: 10px;
  background: var(--bg-page);
  color: var(--text-primary);
  border: 1px solid var(--border-light);
  cursor: pointer;
  transition: all 0.15s;
  user-select: none;
}

.ws-pulse-tag:hover {
  background: var(--primary-bg);
  border-color: var(--primary);
  color: var(--primary);
}

.ws-chief-complaint-picker .ws-pulse-tags {
  gap: 2px;
}

.ws-chief-complaint-picker .ws-pulse-tag {
  padding: 1px 5px;
  font-size: 10px;
}

.ws-diag-results {
  display: flex;
  flex-direction: column;
  gap: 4px;
}

.ws-diag-card {
  padding: 6px 8px;
  border: 1px solid var(--border);
  border-radius: 6px;
  cursor: pointer;
  transition: all 0.15s;
}

.ws-diag-card:hover {
  border-color: var(--primary-light);
  background: var(--primary-bg);
}

.ws-diag-card.selected {
  border-color: var(--primary);
  background: var(--primary-bg);
  box-shadow: 0 0 0 2px rgba(74, 144, 217, 0.15);
}

.ws-diag-head {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 2px;
}

.ws-diag-name {
  font-size: 12px;
  font-weight: 600;
  color: var(--text-primary);
}

.ws-diag-conf {
  font-size: 11px;
  font-weight: 700;
  color: var(--primary);
}

.ws-diag-desc {
  font-size: 10px;
  color: var(--text-secondary);
  line-height: 1.4;
  margin: 1px 0;
}

.ws-tags {
  display: flex;
  flex-wrap: wrap;
  gap: 2px;
  margin-top: 3px;
}

.ws-tag {
  padding: 1px 5px;
  border-radius: 100px;
  font-size: 9px;
  background: var(--bg-page);
  color: var(--text-primary);
  border: 1px solid var(--border-light);
}

.ws-tag.clickable {
  cursor: pointer;
  transition: all 0.15s;
}

.ws-tag.clickable:hover,
.ws-tag.clickable.selected {
  background: var(--primary-bg);
  border-color: var(--primary);
  color: var(--primary);
}

.ws-chosen-diag {
  padding: 4px 8px;
  background: var(--primary-bg);
  border: 1px solid var(--primary-light);
  border-radius: 6px;
  margin-bottom: 4px;
  font-size: 10px;
}

.ws-chosen-head {
  display: flex;
  justify-content: space-between;
  align-items: center;
}

.ws-btn-x {
  border: none;
  background: transparent;
  cursor: pointer;
  font-size: 12px;
  color: var(--text-muted);
  padding: 0 2px;
}

.ws-btn-x:hover {
  color: var(--danger);
}

.ws-ai-suggest {
  margin-top: 4px;
  padding: 4px 8px;
  background: var(--primary-bg);
  border-radius: 5px;
  font-size: 10px;
  color: var(--primary);
}

.ws-btn-row {
  display: flex;
  gap: 4px;
  align-items: center;
  margin-top: 4px;
  flex-shrink: 0;
}

.ws-formula-grid {
  display: grid;
  grid-template-columns: repeat(2, 1fr);
  gap: 4px;
}

.ws-formula-card {
  display: flex;
  flex-direction: column;
  gap: 1px;
  padding: 6px 8px;
  border: 1px solid var(--border);
  border-radius: 6px;
  background: var(--bg-white);
  text-align: left;
  cursor: pointer;
  transition: all 0.15s;
}

.ws-formula-card:hover {
  border-color: var(--primary-light);
  box-shadow: 0 2px 6px rgba(0, 0, 0, 0.06);
}

.ws-formula-card.active {
  border-color: var(--primary);
  background: var(--primary-bg);
}

.ws-formula-name {
  font-size: 12px;
  font-weight: 600;
  color: var(--text-primary);
}

.ws-formula-cat {
  font-size: 9px;
  color: var(--primary);
}

.ws-formula-herbs {
  font-size: 9px;
  color: var(--text-muted);
  line-height: 1.3;
}

.ws-count {
  font-size: 10px;
  color: var(--text-muted);
  font-weight: 400;
  background: var(--bg-page);
  padding: 1px 5px;
  border-radius: 100px;
}

.ws-empty {
  text-align: center;
  padding: 10px 8px;
  color: var(--text-muted);
  font-size: 11px;
}

.ws-herbs-list {
  display: flex;
  flex-direction: column;
  gap: 3px;
}

.ws-herb {
  display: flex;
  align-items: center;
  gap: 5px;
  padding: 4px 6px;
  background: var(--bg-page);
  border-radius: 5px;
  border: 1px solid var(--border-light);
  transition: all 0.15s;
}

.ws-herb.warn {
  background: #FFF7E6;
  border-color: #FFD591;
}

.ws-herb-info {
  flex: 1;
  min-width: 0;
}

.ws-herb-name {
  font-size: 11px;
  font-weight: 600;
  color: var(--text-primary);
}

.ws-toxic {
  display: inline-block;
  font-size: 8px;
  font-weight: 700;
  color: #fff;
  background: var(--danger);
  padding: 0 3px;
  border-radius: 2px;
  margin-left: 2px;
  vertical-align: middle;
}

.ws-herb-meta {
  font-size: 9px;
  color: var(--text-muted);
}

.ws-herb-dosage {
  display: flex;
  flex-direction: column;
  align-items: flex-end;
  gap: 1px;
}

.ws-range {
  font-size: 8px;
  color: var(--text-muted);
}

.ws-dosage-ctrl {
  display: flex;
  align-items: center;
  gap: 2px;
}

.ws-dosage-ctrl button {
  width: 18px;
  height: 18px;
  border: 1px solid var(--border);
  background: var(--bg-white);
  border-radius: 3px;
  cursor: pointer;
  font-size: 11px;
  display: flex;
  align-items: center;
  justify-content: center;
  color: var(--text-secondary);
  transition: all 0.15s;
}

.ws-dosage-ctrl button:hover {
  border-color: var(--primary);
  color: var(--primary);
}

.ws-dosage-ctrl input {
  width: 36px;
  height: 18px;
  text-align: center;
  border: 1px solid var(--border);
  border-radius: 3px;
  font-size: 10px;
  font-weight: 500;
}

.ws-dosage-ctrl input.over {
  border-color: var(--danger);
  background: #FFF0F0;
}

.ws-dosage-ctrl input.under {
  border-color: var(--warning);
  background: #FFFBE6;
}

.ws-dosage-ctrl span {
  font-size: 9px;
  color: var(--text-secondary);
}

.ws-herb-x {
  border: none;
  background: transparent;
  cursor: pointer;
  font-size: 12px;
  color: var(--text-muted);
  padding: 0;
}

.ws-herb-x:hover {
  color: var(--danger);
}

.ws-search {
  width: 100%;
  padding: 4px 8px;
  border: 1px solid var(--border);
  border-radius: 5px;
  font-size: 11px;
  margin-bottom: 4px;
}

.ws-search:focus {
  outline: none;
  border-color: var(--primary);
}

.ws-lib-list {
  max-height: 120px;
  overflow-y: auto;
  display: flex;
  flex-direction: column;
  gap: 1px;
}

.ws-lib-item {
  display: flex;
  align-items: center;
  justify-content: space-between;
  padding: 3px 6px;
  border-radius: 4px;
  cursor: pointer;
  transition: all 0.15s;
  border: 1px solid transparent;
}

.ws-lib-item:hover {
  background: var(--primary-bg);
  border-color: var(--primary-light);
}

.ws-lib-item.selected {
  background: var(--primary-bg);
  border-color: var(--primary);
}

.ws-lib-name {
  font-size: 11px;
  font-weight: 500;
  color: var(--text-primary);
}

.ws-lib-meta {
  font-size: 8px;
  color: var(--text-muted);
  margin-left: 3px;
}

.ws-lib-dose {
  font-size: 8px;
  color: var(--primary);
  white-space: nowrap;
}

.ws-notes {
  width: 100%;
  padding: 4px 6px;
  border: 1px solid var(--border);
  border-radius: 5px;
  font-size: 11px;
  resize: none;
  min-height: 36px;
  max-height: 60px;
}

.ws-notes:focus {
  outline: none;
  border-color: var(--primary);
}

.ws-rx-list {
  display: flex;
  flex-direction: column;
}

.ws-rx-card {
  border-bottom: 1px solid var(--border-light);
  cursor: pointer;
  transition: background 0.15s;
}

.ws-rx-card:last-child {
  border-bottom: none;
}

.ws-rx-card:hover {
  background: #FAFBFC;
}

.ws-rx-card.selected {
  background: var(--primary-bg);
}

.ws-rx-head {
  display: flex;
  align-items: center;
  justify-content: space-between;
  padding: 6px 10px;
}

.ws-rx-left {
  display: flex;
  align-items: center;
  gap: 6px;
}

.ws-rx-dot {
  width: 7px;
  height: 7px;
  border-radius: 50%;
  flex-shrink: 0;
}

.ws-rx-dot.high { background: var(--danger); }
.ws-rx-dot.medium { background: var(--warning); }
.ws-rx-dot.low { background: var(--success); }

.ws-rx-patient {
  font-size: 12px;
  font-weight: 600;
  color: var(--text-primary);
}

.ws-rx-diag {
  font-size: 10px;
  color: var(--text-secondary);
}

.ws-rx-right {
  display: flex;
  align-items: center;
  gap: 4px;
}

.ws-risk-tag {
  font-size: 9px;
  font-weight: 500;
  padding: 1px 5px;
  border-radius: 3px;
}

.ws-risk-tag.high { background: #FFF0F0; color: var(--danger); }
.ws-risk-tag.medium { background: #FFFBE6; color: #D48806; }
.ws-risk-tag.low { background: #F0FFF4; color: var(--success); }

.ws-status {
  font-size: 10px;
  font-weight: 500;
}

.ws-status.pending { color: var(--warning); }
.ws-status.approved { color: var(--success); }
.ws-status.rejected { color: var(--danger); }

.ws-rx-body {
  padding: 0 10px 6px;
  border-top: 1px solid var(--border-light);
}

.ws-rx-section {
  margin-top: 4px;
}

.ws-risk-list {
  list-style: none;
  padding: 0;
}

.ws-risk-list li {
  font-size: 10px;
  padding: 1px 0 1px 12px;
  position: relative;
  color: var(--text-secondary);
}

.ws-risk-list li.danger::before { content: '\2715'; position: absolute; left: 0; color: var(--danger); font-size: 9px; }
.ws-risk-list li.success::before { content: '\2713'; position: absolute; left: 0; color: var(--success); font-size: 9px; }

.ws-col::-webkit-scrollbar,
.ws-card-body::-webkit-scrollbar,
.ws-lib-list::-webkit-scrollbar {
  width: 4px;
}

.ws-col::-webkit-scrollbar-track,
.ws-card-body::-webkit-scrollbar-track,
.ws-lib-list::-webkit-scrollbar-track {
  background: transparent;
}

.ws-col::-webkit-scrollbar-thumb,
.ws-card-body::-webkit-scrollbar-thumb,
.ws-lib-list::-webkit-scrollbar-thumb {
  background: var(--border);
  border-radius: 2px;
}

.ws-col::-webkit-scrollbar-thumb:hover,
.ws-card-body::-webkit-scrollbar-thumb:hover,
.ws-lib-list::-webkit-scrollbar-thumb:hover {
  background: var(--text-muted);
}

.ws-patient-bar .ws-card {
  flex: none;
}

.ws-patient-item {
  padding: 8px 10px;
  border-bottom: 1px solid var(--border-light);
  cursor: pointer;
  transition: background 0.15s;
}

.ws-patient-item:last-child {
  border-bottom: none;
}

.ws-patient-item:hover {
  background: #F5F7FA;
}

.ws-patient-item.selected {
  background: var(--primary-bg);
}

.ws-patient-item-head {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 2px;
}

.ws-patient-name {
  font-size: 13px;
  font-weight: 600;
  color: var(--text-primary);
}

.ws-patient-gender {
  font-size: 10px;
  color: var(--text-muted);
}

.ws-patient-diagnosis {
  font-size: 11px;
  color: var(--text-secondary);
  margin-bottom: 2px;
}

.ws-patient-status {
  font-size: 10px;
  color: var(--primary);
  font-weight: 500;
}

.ws-ai-formula-name {
  font-size: 12px;
  font-weight: 400;
  color: #08979C;
}
.ws-ai-formula-name.active {
  font-weight: 600;
  color: var(--primary);
}

.ws-patient-bar .ws-field {
  margin-bottom: 3px;
}

.ws-patient-bar .ws-field label {
  font-size: 10px;
  color: var(--text-muted);
  font-weight: 500;
}

.ws-patient-bar .ws-field span {
  font-size: 12px;
  color: var(--text-primary);
  font-weight: 500;
}

.ws-patient-bar .ws-card-head h3 {
  font-size: 11px;
}

@media (max-width: 1100px) {
  .ws-body {
    flex-direction: column;
    overflow-y: auto;
  }
  .ws-left, .ws-center {
    flex: none;
    width: 100%;
  }
}
</style>
