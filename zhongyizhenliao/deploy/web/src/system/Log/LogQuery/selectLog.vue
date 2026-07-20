<script lang="ts" setup>
import { ref, reactive } from 'vue'
import { ElTable, ElTableColumn, ElInput, ElButton, ElForm, ElFormItem } from 'element-plus'

// 查询条件
const searchForm = reactive({
  unit: '',
  operator: '',
  account: ''
})

// 是否展开搜索区域
const isExpanded = ref(true)

// 表格数据
const tableData = ref([
  {
    id: 1,
    content: '用户：管理员账户,新增权限: 模块管理,测试demo2,用户维护,用户入网,部门管理,角色维护,角色人员,人员模块授权,角色模块授权,授权记录,人员portal授权,角色portal授权,',
    operator: '管理员账户',
    account: 'zdc',
    operateTime: '2026-01-09 17:50:16',
    ip: '0:0:0:0:0:0:0:1',
    unit: ''
  },
  {
    id: 2,
    content: '角色：系统管理员,新增权限: 用户维护,用户入网,',
    operator: '管理员账户',
    account: 'zdc',
    operateTime: '2026-01-09 17:49:38',
    ip: '0:0:0:0:0:0:0:1',
    unit: ''
  }
])

// 查询方法
const handleSearch = () => {
  console.log('搜索条件:', searchForm)
  // 这里可以添加实际的查询逻辑
}

// 重置方法
const handleReset = () => {
  searchForm.unit = ''
  searchForm.operator = ''
  searchForm.account = ''
}

// 切换展开/收起
const toggleExpand = () => {
  isExpanded.value = !isExpanded.value
}
</script>

<template>
  <div class="log-query-container">
    <!-- 搜索区域 -->
    <div class="search-panel" :class="{ 'is-collapsed': !isExpanded }">
      <ElForm :model="searchForm" inline class="search-form">
        <ElFormItem label="单位：">
          <ElInput 
            v-model="searchForm.unit" 
            placeholder="请输入单位"
            class="search-input"
          />
        </ElFormItem>
        <ElFormItem label="操作人：">
          <ElInput 
            v-model="searchForm.operator" 
            placeholder="请输入操作人"
            class="search-input"
          />
        </ElFormItem>
        <ElFormItem label="账号：">
          <ElInput 
            v-model="searchForm.account" 
            placeholder="请输入账号"
            class="search-input"
          />
        </ElFormItem>
        <div class="form-actions">
          <ElButton type="primary" @click="handleSearch">查询</ElButton>
          <ElButton @click="handleReset">重置</ElButton>
          <ElButton type="text" @click="toggleExpand">
            {{ isExpanded ? '收起' : '展开' }}
          </ElButton>
        </div>
      </ElForm>
    </div>

    <!-- 表格区域 -->
    <div class="table-panel">
      <ElTable :data="tableData" border stripe class="log-table">
        <ElTableColumn 
          prop="content" 
          label="内容" 
          width="400"
        >
          <template #default="scope">
            <div class="content-cell">{{ scope.row.content }}</div>
          </template>
        </ElTableColumn>
        <ElTableColumn 
          prop="operator" 
          label="操作人" 
          width="120"
        />
        <ElTableColumn 
          prop="account" 
          label="账号" 
          width="100"
        />
        <ElTableColumn 
          prop="operateTime" 
          label="操作时间" 
          width="180"
        />
        <ElTableColumn 
          prop="ip" 
          label="ip" 
          width="150"
        />
        <ElTableColumn 
          prop="unit" 
          label="单位" 
          width="120"
        />
      </ElTable>
    </div>
  </div>
</template>

<style scoped>
.log-query-container {
  padding: 20px;
  background: #fff;
  border-radius: 8px;
  min-height: 400px;
}

.search-panel {
  margin-bottom: 20px;
  padding: 16px;
  background: #fafafa;
  border-radius: 8px;
  transition: all 0.3s ease;
}

.search-panel.is-collapsed {
  padding: 10px 16px;
}

.search-form {
  display: flex;
  align-items: center;
  flex-wrap: wrap;
  gap: 16px;
}

.search-input {
  width: 200px;
}

.form-actions {
  display: flex;
  gap: 10px;
  margin-left: auto;
}

.table-panel {
  overflow: auto;
}

.log-table {
  width: 100%;
}

.content-cell {
  white-space: pre-wrap;
  word-break: break-all;
  line-height: 1.6;
  max-height: 120px;
  overflow: auto;
}
</style>
