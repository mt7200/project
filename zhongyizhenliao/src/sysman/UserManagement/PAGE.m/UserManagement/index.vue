<script lang="ts" setup>
import { ref, reactive, computed, onMounted, onUnmounted } from 'vue'
import { ElMessageBox, ElMessage, ElForm, ElFormItem, ElInput, ElButton, ElTable, ElTableColumn, ElTree } from 'element-plus'
import { Check, RefreshLeft, Search, Plus } from '@element-plus/icons-vue'
import UserDialog from './components/UserDialog.vue'
import { queryUserList, queryDepartmentTree, deleteUser, toggleUserStatus } from '../api'
import { type User, type UserItem, type DepartmentItem, type PageInfo } from '../type'

const userList = ref<User[]>([])
const departmentTree = ref<DepartmentItem[]>([])

const dialogVisible = ref(false)
const dialogTitle = ref('新增用户')
const currentEditRow = ref<User | null>(null)

const treeProps = {
  value: 'id',
  children: 'children',
  label: 'text'
}

const pageInfo = ref<PageInfo>({
  total: 0,
  pageSize: 15,
  currentPage: 1
})


const userForm = reactive<{
  user_name: string
  account: string
  department_id: number | undefined
}>({
  user_name: '',
  account: '',
  department_id: undefined
})
const formRef = ref<any>(null)
const editingId = ref<number | null>(null)




const loadDepartmentTree = async () => {
  departmentTree.value = await queryDepartmentTree()
}


onMounted(() => {
  loadUserList();
  loadDepartmentTree()
})

const resetForm = () => {
  userForm.user_name = ''
  userForm.account = ''
  userForm.department_id = undefined
  editingId.value = null
}


const getDeptIds = (nodes: DepartmentItem[], id: number): number[] => {
  const result: number[] = []

  const dfs = (list: DepartmentItem[], targetId: number) => {
    for (const node of list) {
      if (node.id === targetId) {
        result.push(node.id)

        if (node.children?.length) {
          collect(node.children)
        }
      } else if (node.children?.length) {
        dfs(node.children, targetId)
      }
    }
  }

  const collect = (list: DepartmentItem[]) => {
    for (const node of list) {
      result.push(node.id)
      if (node.children?.length) {
        collect(node.children)
      }
    }
  }

  dfs(nodes, id)

  return result
}

const handleQuery = () => {
  const departmentIds = userForm.department_id
    ? getDeptIds(departmentTree.value, userForm.department_id)
    : undefined

  loadUserList({
    user_name: userForm.user_name,
    account: userForm.account,
    ...(departmentIds?.length
      ? { departmentIds }
      : {})
  })
}

const handleReset = () => {
  resetForm()
  loadUserList();
}

const handleToggleStatus = async (row: User) => {
  const action = row.userStatus ? '禁用' : '启用'
  const confirmText = `确定要${action}用户"${row.user_name}"吗？`

  try {
    await ElMessageBox.confirm(confirmText, '状态确认', {
      type: 'warning'
    })
    const res = await toggleUserStatus(row.user_id, row.userStatus ? 0 : 1)
    if (res) {
      ElMessage.success(res || `${action}成功`)
    } else {
      ElMessage.error(`${action}失败`)
    }
    // 重新加载列表
    loadUserList()

  } catch {
    ElMessage.info(`已取消${action}`)
  }
}

const handleDelete = async (row: User) => {
  const confirmText = `确定删除用户"${row.user_name}"吗？此操作不可恢复！`
  try {
    await ElMessageBox.confirm(confirmText, '删除确认', {
      type: 'warning'
    })
    const res = await deleteUser(row.user_id)
    if (res) {
      ElMessage.success(res || '删除成功')
      // 如果删除的是当前编辑数据
      if (editingId.value === row.user_id) {
        resetForm()
      }
    } else {
      ElMessage.error('删除失败')
    }
    // 重新加载列表
    loadUserList()

  } catch {
    ElMessage.info('已取消删除')
  }
}

// 初始化加载用户列表
const loadUserList = async (params?: { user_name?: string; account?: string; departmentIds?: number[] }) => {
  const query = {
    user_name: params?.user_name ?? userForm.user_name,
    account: params?.account ?? userForm.account,
    departmentIds: params?.departmentIds ?? undefined,
    start: pageInfo.value.currentPage,
    limit: pageInfo.value.pageSize
  }

  const res = await queryUserList(query)

  userList.value = (res?.data ?? []).map((item: UserItem, index: number) => ({
    id: index + 1,
    ...item,
    user_name: item.user_name || '',
    userStatus: item.user_status == '1' ? true : false,
    department: item.department_name || '',
    department_id: item.department_id || undefined,
    createTime: item.create_time || '',
    remark: item.remark || ''
  }))
  pageInfo.value.total = res?.count || 0
}

const handleAdd = () => {
  currentEditRow.value = null
  dialogTitle.value = '新增用户'
  dialogVisible.value = true
}

const handleEdit = (row: User) => {
  currentEditRow.value = row
  dialogTitle.value = '修改用户'
  dialogVisible.value = true
}

const handleDialogSuccess = () => {
  loadUserList()
}

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
  <div class="organization-manage-page">
    <ss:HCard class="card-header" shadow="hover">

      <!-- 查询/表单区域（统一模板风格） -->
      <ss:HForm :inline="true" :model="userForm" ref="formRef" class="form-layout">

        <div class="form-left">
          <ss:HFormItem class="form-item">
            <ss:HInput v-model="userForm.user_name" placeholder="姓名" clearable />
          </ss:HFormItem>

          <ss:HFormItem class="form-item">
            <ss:HInput v-model="userForm.account" placeholder="账号" clearable />
          </ss:HFormItem>

          <ss:HFormItem class="form-item">
            <ss:HTreeSelect v-model="userForm.department_id" :data="departmentTree" :props="treeProps" placeholder="所属单位"
              clearable filterable style="width: 100%" check-strictly />
          </ss:HFormItem>

          <ss:HFormItem class="form-item">
            <ss:HButton type="primary" @click="handleQuery">
              <ss:HIcon>
                <Search />
              </ss:HIcon>
              查询
            </ss:HButton>

            <ss:HButton @click="handleReset">
              <ss:HIcon>
                <RefreshLeft />
              </ss:HIcon>
              重置
            </ss:HButton>
          </ss:HFormItem>
        </div>

        <div class="form-right">
          <ss:HButton type="primary" @click="handleAdd">
            <ss:HIcon>
              <Plus />
            </ss:HIcon>
            新增
          </ss:HButton>
        </div>

      </ss:HForm>

      <div class="flex-1 h-0 mt-5">
        <ss:HTable :data="userList" height="100%" class="organization-table">
          <ss:HTableColumn prop="user_name" label="姓名" width="120" />
          <ss:HTableColumn prop="account" label="账号" width="120" />
          <ss:HTableColumn prop="department" label="所属单位" min-width="140" />
          <!-- <ss:HTableColumn label="状态" width="110">
            <template #default="{ row }">
              <span :class="['status-label', row.userStatus ? 'status-label--enabled' : 'status-label--disabled']">
                {{ row.userStatus ? '启用' : '禁用' }}
              </span>
            </template>
</ss:HTableColumn> -->
          <ss:HTableColumn prop="remark" label="备注" min-width="200" />
          <ss:HTableColumn prop="createTime" label="创建时间" width="200" />
          <ss:HTableColumn label="操作" width="260" align="center">
            <template #default="{ row }">
              <span style="color:#409eff;cursor:pointer;margin-right:12px;font-size:14px;" @click="handleEdit(row)">
                修改
              </span>
              <span style="color:#f56c6c;cursor:pointer;margin-right:12px;font-size:14px;" @click="handleDelete(row)">
                删除
              </span>
              <!-- <span :style="{
                color: row.userStatus ? '#e6a23c' : '#67c23a',
                cursor: 'pointer',
                fontSize: '14px'
              }" @click="handleToggleStatus(row)">
                {{ row.userStatus ? '禁用' : '启用' }}
              </span> -->
            </template>
          </ss:HTableColumn>

        </ss:HTable>
      </div>

      <div class="mt-5 flex justify-center items-center">
        <ss:HPagination
          v-model:current-page="pageInfo.currentPage" v-model:page-size="pageInfo.pageSize"
          :page-sizes="[15, 30, 45, 60, 90, 100]" layout="total, sizes, prev, pager, next, jumper"
          :total="pageInfo.total" @update:page-size="handleSizeChange" @update:current-page="handleCurrentChange" />
      </div>
    </ss:HCard>
     <UserDialog v-model:visible="dialogVisible" :title="dialogTitle" :department-tree="departmentTree"
    :edit-data="currentEditRow" @success="handleDialogSuccess" />
  </div>
</template>

<style scoped>
.organization-manage-page {
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
}

.form-layout {
  display: flex;
  justify-content: space-between;
  align-items: flex-start;
  flex-wrap: wrap;
}

.form-left {
  display: flex;
  flex-wrap: wrap;
}

.form-right {
  margin-left: auto;
}

.form-item {
  margin-right: 10px !important;
  width: 240px;
  min-width: 180px;
}

.form-max-item {
  width: 300px;
}

.organization-table {
  width: 100%;
  flex: 1;
  min-height: 0;
}


:deep(.el-card__body) {
  flex: 1;
  display: flex;
  flex-direction: column;
  min-height: 0;
  padding: 12px 16px;
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
  color: #67C23A;
  background: #ecf7e5;
}

.status-label--disabled {
  color: #F56C6C;
  background: #fde2e2;
}

.department-select-wrapper {
  position: relative;
  width: 100%;
}

.department-tree-dropdown {
  position: absolute;
  top: 100%;
  left: 0;
  right: 0;
  z-index: 100;
  background: #fff;
  border: 1px solid #dcdfe6;
  border-radius: 6px;
  padding: 8px;
}
</style>
