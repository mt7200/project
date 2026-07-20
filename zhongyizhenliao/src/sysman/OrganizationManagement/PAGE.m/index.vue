  <script lang="ts" setup>
  import { ref, reactive, computed } from 'vue'
  import { ElMessageBox, ElMessage} from 'element-plus'
  import { Plus, RefreshLeft, Check, Search } from '@element-plus/icons-vue'
  import OrgDialog from './components/OrgDialog.vue'
  import { type DepartmentItem } from './type'
  import { queryDepartmentTree, deleteDepartment, toggleDepartmentStatus, insertDepartment, updateDepartment, adjustDepartmentLevel } from './api'
  import { onMounted } from "vue";

  const allOrgTree = ref<DepartmentItem[]>([])
  const orgTree = ref<DepartmentItem[]>([])

  const orgForm = reactive({
    text: '',
    tel: '',
    belongto: '',
    email: '',
    memo: '',
    address: '',
  })

  const dialogVisible = ref(false)
  const dialogMode = ref<'add' | 'edit'>('add')

  const formData = reactive({
    belongto: null,
    text: '',
    tel: '',
    email: '',
    sequence: 1,
    address: '',
    memo: ''
  })


  const editingId = ref<number | null>(null)
  const adjustDialogVisible = ref(false)
  const adjustTarget = ref<DepartmentItem | null>(null)
  const selectedParent = ref<DepartmentItem | null>(null)
  const treeProps = {
    children: 'children',
    label: 'text'
  }

  const flattenNodes = (nodes: DepartmentItem[], excludeId?: number): DepartmentItem[] => {
    return nodes.reduce<DepartmentItem[]>((acc, node) => {
      if (node.id === excludeId) {
        return acc
      }
      acc.push(node)
      if (node.children?.length) {
        acc.push(...flattenNodes(node.children, excludeId))
      }
      return acc
    }, [])
  }

  const findNode = (
    nodes: DepartmentItem[],
    id: number,
    parent: DepartmentItem | null = null
  ): { node: DepartmentItem | null; parent: DepartmentItem | null } => {
    for (const item of nodes) {
      if (item.id === id) {
        return { node: item, parent }
      }
      if (item.children) {
        const result = findNode(item.children, id, item)
        if (result.node) {
          return result
        }
      }
    }
    return { node: null, parent: null }
  }

  const loadDepartmentTree = async () => {
    const data = await queryDepartmentTree()
    allOrgTree.value = data
    orgTree.value = data
  }

  onMounted(() => {
    loadDepartmentTree()
  })

  const isDescendant = (node: DepartmentItem, id: number): boolean => {
    if (!node.children) {
      return false
    }
    for (const child of node.children) {
      if (child.id === id || isDescendant(child, id)) {
        return true
      }
    }
    return false
  }

  const removeNode = (nodes: DepartmentItem[], id: number): boolean => {
    for (let i = 0; i < nodes.length; i++) {
      if (nodes[i].id === id) {
        nodes.splice(i, 1)
        return true
      }
      if (nodes[i].children && removeNode(nodes[i].children!, id)) {
        if (nodes[i].children!.length === 0) {
          delete nodes[i].children
        }
        return true
      }
    }
    return false
  }

  const resetForm = () => {
    orgForm.text = ''
    orgForm.tel = ''
    orgForm.belongto = ''
    orgForm.email = ''
    orgForm.memo = ''
    orgForm.address = ''
  }

  const handleReset = () => {
    resetForm()
    loadDepartmentTree()
  }

  const handleToggleStatus = async (row: DepartmentItem) => {
    try {
      const res = await toggleDepartmentStatus(row.id || 0, row.enable == 1 ? 0 : 1)
      if (res) {
        ElMessage.success(`${row.enable == 1 ? '禁用' : '启用'}组织成功`)
      }
      else {
        ElMessage.error('操作失败')
      }
      handleSearch()
    } catch {
      ElMessage.error('操作失败')
    }
  }

  const handleDelete = async (row: DepartmentItem) => {
    if (row.children && row.children.length > 0) {
      ElMessage.error('只能删除叶子节点，请先删除子节点')
      return
    }

    try {

      // 先检查组织下是否有人
      const checkParam = {
        department_id: Number(row.id),
        type: 0
      }

      const hasUsers = await deleteDepartment(checkParam)

      const userCount = Array.isArray(hasUsers) ? hasUsers.length : 0

      const confirmText = userCount > 0
        ? `该“${row.text}”下有 ${userCount} 人，删除后关联关系也会清除，确认继续吗？`
        : `确认删除“${row.text}”吗？`

      await ElMessageBox.confirm(confirmText, '删除组织', {
        type: 'warning'
      })

      // 真正执行删除
      const deleteParam = {
        department_id: Number(row.id),
        type: 1
      }

      const res = await deleteDepartment(deleteParam)

      if (res) {
        ElMessage.success(res || '删除成功')
        resetForm()
        loadDepartmentTree()
      } else {
        ElMessage.error('删除失败')
      }

    } catch {
      ElMessage.info('已取消删除')
    }
  }

  const handleAdjustLayer = (row: DepartmentItem) => {
    adjustTarget.value = row
    selectedParent.value = row.belongto !== null ? findNode(orgTree.value, row.belongto || 0).node : null
    adjustDialogVisible.value = true
  }

  const handleSelectParent = (node: DepartmentItem) => {
    if (!adjustTarget.value) {
      return
    }
    if (node.id === adjustTarget.value.id) {
      ElMessage.error('不能选择自身作为父节点')
      return
    }
    if (isDescendant(adjustTarget.value, node.id || 0)) {
      ElMessage.error('不能选择当前节点的子节点作为父节点')
      return
    }
    selectedParent.value = node
  }

  const handleConfirmAdjust = async () => {
    if (!adjustTarget.value) {
      return
    }
    const newbelongto = selectedParent.value ? selectedParent.value.id : null
    if (newbelongto === adjustTarget.value.belongto) {
      adjustDialogVisible.value = false
      ElMessage.info('父节点未发生变化')
      return
    }
    let params = {
      belongto: newbelongto ? Number(newbelongto) : null,
      id: adjustTarget.value.id ? Number(adjustTarget.value.id) : null,
    }
    const res = await adjustDepartmentLevel(params)
    if (res) {
      ElMessage.success('层级调整成功')
    }
    else {
      ElMessage.error('层级调整失败')
    }
    loadDepartmentTree();
    adjustDialogVisible.value = false
  }

  const handleCancelAdjust = () => {
    adjustDialogVisible.value = false
  }

  const handleClearParentSelection = () => {
    selectedParent.value = null
  }

  const openAddDialog = () => {
    dialogMode.value = 'add'
    Object.assign(formData, {
      belongto: null,
      text: '',
      tel: '',
      email: '',
      sequence: 1,
      address: '',
      memo: ''
    })
    dialogVisible.value = true
  }

  const handleEdit = (row: any) => {
    dialogMode.value = 'edit'
    Object.assign(formData, {
      belongto: row?.belongto || '',
      text: row?.text || '',
      tel: row?.tel || '',
      email: row?.email || '',
      sequence: row?.sequence || 1,
      address: row?.address || '',
      memo: row?.memo || ''
    })

    editingId.value = row.id
    dialogVisible.value = true
  }

  const handleSubmit = async (val: any) => {
    if (dialogMode.value === 'edit' && editingId.value) {
      //修改组织
      let data: any = {
        id: editingId.value,
        ...val,
        belongto: val.belongto ? Number(val.belongto) : null
      }
      const res = await updateDepartment(data)
      if (res) {
        ElMessage.success('更新成功')
      }
      else {
        ElMessage.error('更新失败')
      }

    } else {
      //新增组织
      let data: any = {
        ...val,
        belongto: val.belongto ? Number(val.belongto) : null
      }
      const res = await insertDepartment(data)
      if (res) {
        ElMessage.success('新增成功')
      }
      else {
        ElMessage.error('新增失败')
      }
    }

    dialogVisible.value = false
    resetForm()
    loadDepartmentTree()
  }

  const handleSearch = async () => {
    const data = await queryDepartmentTree({
      text: orgForm.text,
      belongto: orgForm.belongto,
      email: orgForm.email,
      memo: orgForm.memo,
      address: orgForm.address,
      tel: orgForm.tel
    })
    orgTree.value = data
  }
</script>

  <template>
    <div class="organization-manage-page art-full-height">
      <ss:HCard class="card-header" shadow="hover" style="margin-bottom: 20px;">
        <div class="flex justify-between">
          <ss:HForm :inline="true" :model="orgForm" ref="formRef" label-width="auto" class="form-layout">
            <div class="form-left">
              <ss:HFormItem class="form-item">
                <ss:HInput v-model="orgForm.text" placeholder="组织名称" clearable />
              </ss:HFormItem>
              <ss:HFormItem class="form-item">
                <ss:HTreeSelect v-model="orgForm.belongto" :data="allOrgTree" :props="treeProps" node-key="id"
                  check-strictly clearable filterable placeholder="请选择父节点" style="width: 100%;" />
              </ss:HFormItem>
              <ss:HFormItem class="form-item">
                <ss:HButton type="primary" @click="handleSearch">
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
              <ss:HButton type="primary" @click="openAddDialog">
                <ss:HIcon>
                  <Plus />
                </ss:HIcon>
                新增
              </ss:HButton>
            </div>
          </ss:HForm>
        </div>

        <div class="flex-1 h-0 mt-5" style="display: flex;">
          <ss:HGridPanel :data="orgTree" row-key="id" class="organization-table" style="height: auto">
            <ss:HGridColumn prop="text" label="组织名称" min-width="180" show-overflow-tooltip />

            <ss:HGridColumn label="电话" width="150" show-overflow-tooltip>
              <template #default="scope">
                {{ scope.row.data?.tel }}
              </template>
            </ss:HGridColumn>

            <ss:HGridColumn label="邮箱" width="200" show-overflow-tooltip>
              <template #default="scope">
                {{ scope.row.data?.email }}
              </template>
            </ss:HGridColumn>

            <ss:HGridColumn label="排序" width="80" show-overflow-tooltip>
              <template #default="scope">
                {{ scope.row.data?.sequence }}
              </template>
            </ss:HGridColumn>

            <ss:HGridColumn label="备注" min-width="240" show-overflow-tooltip>
              <template #default="scope">
                {{ scope.row.data?.memo }}
              </template>
            </ss:HGridColumn>

            <ss:HGridColumn label="状态" width="110" show-overflow-tooltip>
              <template #default="scope">
                <span :class="[
                  'status-label',
                  scope.row.data?.enable == 1
                    ? 'status-label--enabled'
                    : 'status-label--disabled'
                ]">
                  {{ scope.row.data?.enable == 1 ? '启用' : '禁用' }}
                </span>
              </template>
            </ss:HGridColumn>

            <ss:HGridColumn label="操作" width="380" align="center" header-align="center">
              <template #default="scope">
                <span :style="{
                  color: scope.row.data?.enable == 1 ? '#f56c6c' : '#67c23a',
                  cursor: 'pointer',
                  marginRight: '12px',
                  fontSize: '14px'
                }" @click="handleToggleStatus(scope.row.data || {})">
                  {{ scope.row.data?.enable == 1 ? '禁用' : '启用' }}
                </span>

                <span style="color:#409eff;cursor:pointer;margin-right:12px;font-size:14px;"
                  @click="handleEdit(scope.row.data || {})">
                  修改
                </span>

                <span style="color:#f56c6c;cursor:pointer;margin-right:12px;font-size:14px;"
                  @click="handleDelete(scope.row.data || {})">
                  删除
                </span>

                <span style="color:#e6a23c;cursor:pointer;font-size:14px;"
                  @click="handleAdjustLayer(scope.row.data || {})">
                  层级调整
                </span>
              </template>
            </ss:HGridColumn>
          </ss:HGridPanel>
        </div>

        <ss:HDialog title="调整所属父节点" v-model="adjustDialogVisible" width="520px" class="tree-dialog" destroy-on-close>
          <div class="tree-dialog-content">
            <div class="tree-message">
              当前调整节点：<strong>{{ adjustTarget?.text || '未选择' }}</strong>
            </div>
            <div class="tree-message">
              选择后父节点：<strong>{{ selectedParent?.text || '顶层节点' }}</strong>
            </div>
            <div class="tree-box">
              <ss:HTree :data="allOrgTree" :props="treeProps" node-key="id" :current-node="selectedParent"
                default-expand-all highlight-current @node-click="handleSelectParent" />
            </div>
          </div>
          <template #footer>
            <ss:HButton @click="handleClearParentSelection">选择顶层</ss:HButton>
            <ss:HButton @click="handleCancelAdjust">取消</ss:HButton>
            <ss:HButton type="primary" @click="handleConfirmAdjust">确定</ss:HButton>
          </template>
        </ss:HDialog>
      </ss:HCard>
      <OrgDialog v-model="dialogVisible" :modelType="dialogMode" :title="dialogMode === 'add' ? '新增组织' : '编辑组织'"
        :formData="formData" :treeData="allOrgTree" @confirm="handleSubmit" />
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

.form-layout {
  display: flex;
  justify-content: space-between;
  align-items: flex-start;
  flex-wrap: wrap;
  width: 100%;
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
  max-width: 240px;
  min-width: 180px;
}

.form-actions {
  display: flex;
  align-items: center;
  justify-content: center;
  gap: 12px;
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

.organization-table {
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
  color: #67C23A;
  background: #ecf7e5;
}

.status-label--disabled {
  color: #F56C6C;
  background: #fde2e2;
}

.tree-dialog-content {
  display: flex;
  flex-direction: column;
  gap: 12px;
}

.tree-message {
  font-size: 14px;
}

.tree-box {
  max-height: 360px;
  overflow: auto;
  padding: 12px;
  border: 1px solid #e8eef6;
  border-radius: 8px;
  background: #fff;
}

.card-header {
  flex: 1;
  display: flex;
  flex-direction: column;
  min-height: 0;
}

:deep(.el-card) {
  flex: 1;
  display: flex;
  flex-direction: column;
  min-height: 0;
}

:deep(.el-card__body) {
  flex: 1;
  display: flex;
  flex-direction: column;
  min-height: 0;
}

:deep(.el-card__body) {
  padding: 12px 16px;
}

:deep(.el-input__wrapper),
:deep(.el-select__wrapper),
:deep(.el-tree-select__wrapper) {
  height: 32px;
  box-sizing: border-box;
}
</style>
