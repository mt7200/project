<script lang="ts" setup>
  import { ref, reactive, onMounted } from 'vue'
  import {
    ElMessageBox,
    ElMessage,
    ElForm,
    ElFormItem,
    ElInput,
    ElButton,
    ElTable,
    ElTableColumn,
    ElCard
  } from 'element-plus'
  import { Check, RefreshLeft, Search } from '@element-plus/icons-vue'
  import { queryUserList, resetUserPassword, toggleNetWorkStatus } from '../api'
  import { type UserItem, type User, type PageInfo } from '../type'

  const userList = ref<User[]>([])

  const pageInfo = ref<PageInfo>({
    total: 0,
    pageSize: 15,
    currentPage: 1
  })

  const searchForm = reactive({
    user_name: '',
    account: ''
  })

  const formRef = ref<any>(null)

  // 初始化加载用户列表
  const loadUserList = async (params?: { user_name?: string; account?: string }) => {
    const query = {
      user_name: params?.user_name ?? searchForm.user_name,
      account: params?.account ?? searchForm.account,
      start: pageInfo.value.currentPage,
      limit: pageInfo.value.pageSize
    }

    const res = await queryUserList(query)

    userList.value = (res?.data ?? []).map((item: UserItem, index: number) => ({
      id: index + 1,
      ...item,
      user_name: item.user_name || '',
      is_network: String(item.is_network) === '1',
      department: item.department_name || '',
      remark: item.remark || ''
    }))

    pageInfo.value.total = res?.count || 0
  }

  const resetForm = () => {
    searchForm.user_name = ''
    searchForm.account = ''
    // 重置后重新加载数据
    loadUserList()
  }

  const handleQuery = () => {
    // 根据查询条件查询
    loadUserList({
      user_name: searchForm.user_name,
      account: searchForm.account
    })
  }

  const handleAccessChange = async (row: User) => {
    const action = row.is_network ? '禁用' : '启用'
    const confirmText = `确定要${action}用户"${row.user_name}"的入网权限吗？`

    try {
      await ElMessageBox.confirm(confirmText, '入网确认', {
        type: 'warning'
      })
      let isNetWork = row.is_network ? 0 : 1
      const res = await toggleNetWorkStatus(row.user_id, isNetWork)
      if (res) {
        ElMessage.success(res || `${action}成功`)
      } else {
        ElMessage.error(`${action}失败`)
      }
    } catch {
      ElMessage.info(`已取消${action}`)
    }
    handleQuery()
  }

  const handleResetPassword = async (row: User) => {
    const confirmText = `确定要重置用户"${row.user_name}"的密码为"100200"吗？`

    try {
      await ElMessageBox.confirm(confirmText, '重置密码确认', {
        type: 'warning'
      })
      const res = await resetUserPassword(row.user_id)
      if (res) {
        ElMessage.success(res || '密码已重置')
      } else {
        ElMessage.error('密码重置失败')
      }
    } catch {
      ElMessage.info('已取消重置')
    }
    handleQuery()
  }

  // 页面加载时获取用户列表
  onMounted(() => {
    loadUserList()
  })

  /**
   * 处理每页大小变化
   * @description 当每页显示数量改变时，重置页码并重新查询
   */
  const handleSizeChange = () => {
    pageInfo.value.currentPage = 1
    loadUserList()
  }

  /**
   * 处理页码变化
   * @description 当页码改变时，重新查询对应页的数据
   */
  const handleCurrentChange = () => {
    loadUserList()
  }
</script>

<template>
  <div class="user-access-page">
    <ElCard class="card-header" shadow="hover">
      <!-- 查询区域（对齐组织管理页） -->
      <ElForm :inline="true" :model="searchForm" ref="formRef" class="form-layout">
        <ElFormItem class="form-item">
          <ElInput v-model="searchForm.user_name" placeholder="姓名" clearable />
        </ElFormItem>

        <ElFormItem class="form-item">
          <ElInput v-model="searchForm.account" placeholder="账号" clearable />
        </ElFormItem>

        <ElFormItem class="form-item">
          <div class="form-actions">
            <ElButton type="primary" @click="handleQuery">
              <el-icon>
                <Search />
              </el-icon>
              查询
            </ElButton>
            <ElButton @click="resetForm">
              <el-icon>
                <RefreshLeft />
              </el-icon>
              重置
            </ElButton>
          </div>
        </ElFormItem>
      </ElForm>

      <div class="table-wrapper">
        <ElTable :data="userList" row-key="id" stripe class="user-table">
          <ElTableColumn prop="account" label="账号" width="120" />
          <ElTableColumn prop="user_name" label="姓名" width="120" />
          <ElTableColumn prop="department" label="所在单位" min-width="160" />

          <ElTableColumn label="是否入网" width="110">
            <template #default="{ row }">
              <span
                :class="[
                  'status-label',
                  row.is_network == '1' ? 'status-label--enabled' : 'status-label--disabled'
                ]"
              >
                {{ row.is_network == '1' ? '是' : '否' }}
              </span>
            </template>
          </ElTableColumn>

          <ElTableColumn prop="remark" label="备注" min-width="200" />

          <ElTableColumn label="操作" width="220" align="center" header-align="center">
            <template #default="{ row }">
              <span
                :style="{
                  color: row.is_network == '1' ? '#e6a23c' : '#67c23a',
                  cursor: 'pointer',
                  marginRight: '12px',
                  fontSize: '14px'
                }"
                @click="handleAccessChange(row)"
              >
                {{ row.is_network == '1' ? '退网' : '入网' }}
              </span>

              <span
                style="color: #409eff; cursor: pointer; font-size: 14px"
                @click="handleResetPassword(row)"
              >
                重置密码
              </span>
            </template>
          </ElTableColumn>
        </ElTable>
      </div>

      <div class="mt-5 flex justify-center items-center">
        <el-pagination
          v-model:current-page="pageInfo.currentPage"
          v-model:page-size="pageInfo.pageSize"
          :page-sizes="[15, 30, 45, 60, 90, 100]"
          layout="total, sizes, prev, pager, next, jumper"
          :total="pageInfo.total"
          @update:page-size="handleSizeChange"
          @update:current-page="handleCurrentChange"
        />
      </div>
    </ElCard>
  </div>
</template>

<style scoped>
  .user-access-page {
    height: 100%;
    display: flex;
    flex-direction: column;
    padding: 20px;
    background: #fff;
    border-radius: 12px;
  }

  .card-header {
    flex: 1;
    display: flex;
    flex-direction: column;
    min-height: 0;
    overflow: hidden;
  }
  .search-panel {
    flex: 0 0 auto;
    margin-bottom: 20px;
    padding: 0;
    background: transparent;
  }

  /* 表单对齐模板 */
  .form-layout {
    display: flex;
    flex-wrap: wrap;
  }

  .form-item {
    margin-right: 10px !important;
    max-width: 240px;
    min-width: 180px;
  }

  .form-actions {
    display: flex;
    align-items: center;
  }

  .table-panel {
    flex: 1;
    min-height: 0;
    display: flex;
    flex-direction: column;
    padding: 18px;
    background: #fff;
    border-radius: 10px;
  }

  .table-wrapper {
    height: 0;
    flex: 1;
    min-height: 0;
    overflow: hidden;
    display: flex;
  }

  .user-table {
    width: 100%;
    flex: 1;
    min-height: 0;
  }
  .status-label {
    display: inline-block;
    padding: 2px 10px;
    border-radius: 6px;
    border: 1px solid;
    font-size: 12px;
    line-height: 18px;
  }

  .status-label--enabled {
    color: #67c23a;
    background: #ecf7e5;
  }

  .status-label--disabled {
    color: #f56c6c;
    background: #fde2e2;
  }

  :deep(.el-card__body) {
    flex: 1;
    display: flex;
    flex-direction: column;
    min-height: 0;
    padding: 12px 16px;
  }
</style>
