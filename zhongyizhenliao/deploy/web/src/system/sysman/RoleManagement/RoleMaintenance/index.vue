<template>
  <div class="art-full-height">
    <el-card class="h-full">
      <!-- 搜索栏 -->
      <div class="flex justify-between">
        <div class="flex-1 flex items-center">
          <el-input
            clearable
            placeholder="角色id"
            v-model="searchForm.roleId"
            class="max-w-50 mr-2.5"
          />
          <el-input
            clearable
            placeholder="名称"
            v-model="searchForm.name"
            class="max-w-50 mr-2.5"
          />
          <el-input
            clearable
            placeholder="排序"
            v-model="searchForm.sort"
            class="max-w-50 mr-2.5"
          />
          <div>
            <el-button type="primary" @click="handleSizeChange">
              <el-icon>
                <Search />
              </el-icon>
              查询
            </el-button>
            <el-button @click="resetSearch">
              <el-icon>
                <RefreshLeft />
              </el-icon>
              重置
            </el-button>
          </div>
        </div>
        <div class="add-button-container">
          <el-button type="primary" @click="handleCreate">
            <el-icon>
              <Plus />
            </el-icon>
            新增
          </el-button>
        </div>
      </div>

      <!-- 表格 -->
      <div class="flex-1 h-0 mt-5">
        <el-table :data="tableData" height="100%" v-loading="tableLoading">
          <el-table-column prop="role_id" label="角色id" show-overflow-tooltip />
          <el-table-column prop="role_name" label="名称" show-overflow-tooltip />
          <el-table-column prop="sort" label="排序" show-overflow-tooltip />
          <el-table-column prop="remark" label="备注" show-overflow-tooltip />
          <el-table-column label="操作" show-overflow-tooltip width="200">
            <template #default="{ row }">
              <div class="action-buttons">
                <el-text
                  type="primary"
                  @click="handleEdit(row)"
                  class="cursor-pointer"
                >
                  修改
                </el-text>
                <el-text
                  type="danger"
                  @click="() => handleDelete(row)"
                  class="!ml-3 cursor-pointer"
                >
                  删除
                </el-text>
                <el-text
                  :type="row.enable ? 'danger' : 'primary'"
                  @click="() => handleEnable(row)"
                  class="!ml-3 cursor-pointer"
                >
                  {{ row.enable ? "禁用" : "启用" }}
                </el-text>
              </div>
            </template>
          </el-table-column>
        </el-table>
      </div>

      <!-- 分页 -->
      <div class="mt-5 flex justify-center items-center">
        <el-pagination
          v-model:current-page="pageInfo.currentPage"
          v-model:page-size="pageInfo.pageSize"
          :page-sizes="[15, 30, 45, 60, 90, 100]"
          layout="total, sizes, prev, pager, next, jumper"
          :total="pageInfo.total"
          @update:page-size="handleSizeChange"
          @update:current-page="getRoleList"
        />
      </div>

      <!-- 新增/编辑弹窗 -->
      <CreateDialog
        v-if="createDialogVisible"
        v-model:visible="createDialogVisible"
        :edit-data="editData"
        @confirm="handleCreateConfirm"
      />
    </el-card>
  </div>
</template>

<script setup lang="ts">
import { ref, onMounted } from "vue";
import { Search, RefreshLeft, Plus } from "@element-plus/icons-vue";
import { ElMessageBox, ElMessage } from "element-plus";
import CreateDialog from "./components/CreateDialog.vue";
import type { Role, SearchForm, PageInfo, GeneralListResponse } from "./type";
import api from "@/utils/http";

const searchForm = ref<SearchForm>({
  roleId: "",
  name: "",
  sort: null,
});

const tableLoading = ref(false)

const tableData = ref<Role[]>([]);

const pageInfo = ref<PageInfo>({
  total: 0,
  pageSize: 15,
  currentPage: 1,
});
const createDialogVisible = ref(false);
const editData = ref<Role | null>(null);

/**
 * 处理每页大小变化
 * @description 当每页显示数量改变时，重置页码为1并重新查询
 */
const handleSizeChange = () => {
  pageInfo.value.currentPage = 1;
  getRoleList();
};

/**
 * 重置搜索条件
 * @description 清空所有搜索条件并重置页码为1，然后重新查询
 */
const resetSearch = () => {
  searchForm.value.roleId = "";
  searchForm.value.name = "";
  searchForm.value.sort = null;
  searchForm.value.remark = "";
  pageInfo.value.currentPage = 1;
  getRoleList();
};

/**
 * 获取角色列表
 * @description 根据当前搜索条件和分页信息查询角色数据
 */
const getRoleList = async () => {
  tableLoading.value = true;
  const res = await api.get<GeneralListResponse<Role>>({
    url: '/data/SystemRolePage.json',
    params: {
      scope: 'maintenance',
      role_id: searchForm.value.roleId,
      role_name: searchForm.value.name,
      sort: searchForm.value.sort,
      start: pageInfo.value.currentPage,
      limit: pageInfo.value.pageSize,
    }
  });
  tableLoading.value = false;
  if (res?.data) {
    tableData.value = res.data;
    pageInfo.value.total = res.count || 0;
  }
};

/**
 * 处理新增角色
 * @description 打开新增角色弹窗
 */
const handleCreate = () => {
  editData.value = null;
  createDialogVisible.value = true;
};

/**
 * 处理编辑角色
 * @description 打开编辑角色弹窗并传入当前行数据
 * @param row 角色信息
 */
const handleEdit = (row: Role) => {
  editData.value = { ...row };
  createDialogVisible.value = true;
};

/**
 * 处理新增/编辑确认
 * @description 保存新增或编辑的角色数据后刷新列表
 * @param data 角色表单数据
 */
const handleCreateConfirm = async (data: Role, isEdit: boolean) => {
  createDialogVisible.value = false;
  tableLoading.value = true;
  const res = await api.post({
    url: "/json/SaveRole.json",
    data: {
      data: data,
    },
  });
  tableLoading.value = false;
  if (typeof res === 'string') {
    ElMessage.success(isEdit ? '修改成功' : '新增成功');
    getRoleList();
  }
};

/**
 * 处理删除角色
 * @description 弹出确认对话框并执行删除操作，成功后刷新列表
 * @param row 角色信息
 */
const handleDelete = async (row: Role) => {
  ElMessageBox.confirm(`确定要删除角色"${row.role_name}"吗？`, "确认删除", {
    confirmButtonText: "确定",
    cancelButtonText: "取消",
    type: "warning",
  }).then(async () => {
    // 调用删除接口（如果需要）
    const validRes = await api.post({
      url: "/json/DeleteRole.json",
      data: { 
          type: 0, // 校验角色下是否存在人员
          role_id: row.role_id,
        },
    });
    if (typeof validRes === 'string') {
      // 当前角色下不存在人员
      ElMessage.success('删除成功');
      getRoleList(); 
    } else if (Array.isArray(validRes)) {
      // 当前角色下存在人员
      ElMessageBox.confirm(`当前角色"${row.role_name}"下存在人员，是否继续删除角色？`, "确认删除", {
        confirmButtonText: "确定",
        cancelButtonText: "取消",
        type: "warning",
      }).then(async () => {
        const deleteRes = await api.post({
          url: "/json/DeleteRole.json",
          data: { 
            type: 1, // 删除角色
            role_id: row.role_id,
          },
        });
        if (typeof deleteRes === 'string') {
          ElMessage.success('删除成功');
          if (pageInfo.value.currentPage > 1 && tableData.value.length === 1) {
            pageInfo.value.currentPage -= 1;
          }
          getRoleList(); 
        }
      })
    }
  })
};

/**
 * 处理角色启用/禁用
 * @description 弹出确认对话框并执行启用或禁用操作，成功后刷新列表
 * @param row 角色信息
 */
const handleEnable = async (row: Role) => {
  const action = row.enable === 1 ? "禁用" : "启用";
  ElMessageBox.confirm(
    `确定要${action}角色"${row.role_name}"吗？`,
    `确认${action}`,
    {
      confirmButtonText: "确定",
      cancelButtonText: "取消",
      type: "warning",
    },
  )
    .then(async () => {
      const res = await api.post({
        url: "/json/UpdateRoleEnable.json",
        data: { 
          data: { 
            role_id: row.role_id,
            enable: row.enable === 1 ? 0 : 1,
          },
        },
      });
      console.log("更新角色状态成功:", res)
      if (typeof res === 'string') {
        ElMessage.success(`${action}成功`);
        getRoleList();
      }
    })
    .catch(() => {});
};

/**
 * 组件挂载时初始化数据
 */
onMounted(() => {
  getRoleList();
});
</script>

<style scoped>
:deep(.el-card__body) {
  height: 100%;
  display: flex;
  flex-direction: column;
}
</style>
