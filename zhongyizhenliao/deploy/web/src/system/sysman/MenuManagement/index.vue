<template>
  <div class="art-full-height">
    <el-card class="h-full">
      <!-- 工具栏 -->
      <div class="flex items-center justify-between">
        <div class="flex-1 flex items-center">
          <el-input
            clearable
            v-model="searchForm.text"
            placeholder="请输入菜单名称"
            class="max-w-[200px] mr-2.5"
          />
          <el-button type="primary" @click="handleSearch">
            <el-icon><Search /></el-icon>
            查询
          </el-button>
          <el-button @click="resetSearch">
            <el-icon><RefreshLeft /></el-icon>
            重置
          </el-button>
        </div>
        <div>
          <el-button type="primary" @click="handleAdd">
            <el-icon><Plus /></el-icon>
            新增
          </el-button>
        </div>
      </div>

      <!-- 表格 -->
      <div class="flex-1 h-0 mt-5">
        <el-table
          :data="menuList"
          height="100%"
          row-key="data.id"
          :tree-props="{ children: 'children' }"
          v-loading="tableLoading"
          class="menu-tree-table"
          highlight-current-row
        >
          <el-table-column label="名称">
            <template #default="{ row: { data } }">
              <span>
                <el-icon :size="16" class="mr-1 relative top-1">
                  <component :is="data.iconcls" />
                </el-icon>
                <span>{{ data.text }}</span>
              </span>
            </template>
          </el-table-column>
          <el-table-column prop="data.resource_code" label="权限标识" show-overflow-tooltip />
          <el-table-column prop="data.component_path" label="路径" show-overflow-tooltip />
          <el-table-column label="是否显示" width="100">
            <template #default="{ row: { data } }">
              <span>{{ data.is_hide === 0 ? '是' : '否' }}</span>
            </template>
          </el-table-column>
          <el-table-column label="是否外部链接" width="120">
            <template #default="{ row: { data } }">
              <span>{{ data.is_link === 1 ? '是' : '否' }}</span>
            </template>
          </el-table-column>
          <el-table-column label="权限类型" width="120">
            <template #default="{ row: { data } }">
              <span>{{
                data.resource_type == 0 ? '菜单' : (data.resource_type == 1 ? '接口' : '按钮')
              }}</span>
            </template>
          </el-table-column>
          <el-table-column prop="data.sequence" label="排序" width="100" />
          <el-table-column label="操作" width="130">
            <template #default="{ row }">
              <el-text type="primary" @click="handleEdit(row)" class="cursor-pointer">
                修改
              </el-text>
              <el-text text type="danger" @click="handleDelete(row)" class="!ml-3 cursor-pointer">
                删除
              </el-text>
            </template>
          </el-table-column>
        </el-table>
      </div>
    </el-card>

    <MenuDialog
      v-if="dialogVisible"
      v-model:visible="dialogVisible"
      :title="dialogTitle"
      :data="dialogData"
      :menuList="menuList"
      @save="handleSave"
    />
  </div>
</template>

<script setup lang="ts">
  import { ref, onMounted } from 'vue'
  import { Plus, Search, RefreshLeft } from '@element-plus/icons-vue'
  import { ElMessage, ElMessageBox, ElTable } from 'element-plus'
  import type { MenuNode, FormData } from './type'
  import MenuDialog from './components/MenuDialog.vue'
  import api from '@/utils/http'

  const menuList = ref<MenuNode[]>([])
  const tableLoading = ref(false)
  const dialogVisible = ref(false)
  const dialogTitle = ref('新增菜单')
  const dialogData = ref<Partial<FormData>>({})

  const searchForm = ref({
    text: ''
  })

  const handleAdd = () => {
    dialogTitle.value = '新增菜单'

    let belongto = ''
    let belongto_name = ''
    let grade = 1

    dialogData.value = {
      belongto,
      belongto_name,
      grade
    }
    dialogVisible.value = true
  }

  const handleEdit = (row: MenuNode) => {
    dialogTitle.value = '修改菜单'
    dialogData.value = { ...row.data }
    dialogVisible.value = true
  }

  const handleDelete = async (row: MenuNode) => {
    if (row.children.length > 0) {
      ElMessage.warning('不能删除含有子菜单的菜单')
      return
    }
    ElMessageBox.confirm(`确定要删除菜单「${row.text}」吗？`, '提示', {
      confirmButtonText: '确定',
      cancelButtonText: '取消',
      type: 'warning'
    }).then(async () => {
      tableLoading.value = true
      const res = await api.get({
        url: '/data/DeleteMenu.json',
        params: {
          id: row.data.id
        }
      })
      tableLoading.value = false
      if (res) {
        ElMessage.success('删除成功')
        getMenuList()
      }
    })
  }

  const handleSave = async (data: FormData) => {
    tableLoading.value = true
    const formData = { ...data }
    const res = await api.post({
      url: formData.id ? '/json/UpdateMenu.json' : '/json/InsertMenu.json',
      data: {
        data: {
          ...formData
        }
      }
    })
    tableLoading.value = false
    if (typeof res === 'string') {
      ElMessage.success(dialogTitle.value === '修改菜单' ? '修改成功' : '新增成功')
      dialogVisible.value = false
      getMenuList()
    }
  }

  const getMenuList = async () => {
    tableLoading.value = true
    const res = await api.get<MenuNode[]>({
      url: '/data/SelectMenuByTree.json'
    })
    tableLoading.value = false
    if (res && Array.isArray(res)) {
      menuList.value = res
    }
  }

  const handleSearch = async () => {
    if (!searchForm.value.text) {
      getMenuList()
      return
    }
    tableLoading.value = true
    const res = await api.get<MenuNode[]>({
      url: '/data/SelectMenuByTree.json',
      params: {
        text: searchForm.value.text
      }
    })
    tableLoading.value = false
    if (res && Array.isArray(res)) {
      menuList.value = res
    }
  }

  const resetSearch = () => {
    searchForm.value.text = ''
    getMenuList()
  }

  onMounted(() => {
    getMenuList()
  })
</script>

<style scoped>
  :deep(.el-card__body) {
    height: 100%;
    display: flex;
    flex-direction: column;
  }

  /* :deep(.menu-tree-table .cell:has(.el-table__expand-icon)) {
  display: flex;
  align-items: center;
} */
</style>
