<template>
  <ss:HViewPort class="view-port-box">
    <div class="h-full flex gap-4">
      <!-- 左侧：角色列表 -->
      <ss:HCard class="h-full flex-1" shadow="never">
        <template #header>
          <div class="card-header">
            <span>角色列表</span>
          </div>
        </template>
        <div class="h-full flex flex-col">
          <div class="flex-1 h-0">
            <ss:HGridPanel
              :data="roleList"
              highlight-current-row
              @row-click="handleRoleClick"
              :current-row-key="selectedRole?.role_id"
              v-loading="roleTableLoading"
              border
              style="height: 100%;"
              ref="roleTableRef"
            >
              <ss:HGridColumn
                prop="role_code"
                label="角色代码"
                show-overflow-tooltip
              />
              <ss:HGridColumn
                prop="role_name"
                label="角色名"
                show-overflow-tooltip
              />

              <template #paging>
                <ss:HGridPaging
                  :dataUrl="`${VITE_API_URL}/data/SystemRolePage.json?scope=assignment&role_id=&role_name=`"
                  :pagesize="rolePageInfo.pageSize"
                  :currentPage="rolePageInfo.currentPage"
                  ref="rolePagRef"
                />
              </template>
            </ss:HGridPanel>
          </div>
        </div>
      </ss:HCard>

      <!-- 中间：已获得角色的用户 -->
      <ss:HCard class="h-full flex-1" shadow="never">
        <template #header>
          <div class="card-header">
            <span>已获得此角色的用户</span>
          </div>
        </template>
        <div class="h-full flex flex-col">
          <div class="flex justify-between items-center">
            <div class="flex-1 flex">
              <ss:HInput
                placeholder="用户账号"
                clearable
                v-model="assignedUsersForm.account"
                class="max-w-[200px] mr-2.5"
              />
              <ss:HInput
                placeholder="用户名称"
                clearable
                v-model="assignedUsersForm.user_name"
                class="max-w-[200px] mr-2.5"
              />
              <ss:HButton type="primary" @click="handleAssignedSizeChange">
                <ss:HIcon><Search /></ss:HIcon>
                查询
              </ss:HButton>
              <ss:HButton @click="resetAssignedSearch">
                <ss:HIcon><RefreshLeft /></ss:HIcon>
                重置
              </ss:HButton>
            </div>
          </div>
          <div class="flex-1 h-0 flex flex-col mt-1">
            <div class="flex-1 h-0">
              <ss:HGridPanel
                :data="assignedUsers"
                style="height: 100%;"
                :border="false"
                v-loading="assignedTableLoading"
                :row-key="(user) => user.account"
                @selection-change="assignedUserTableSelectionChange"
                ref="assignedTableRef"
              >
                <ss:HGridColumn
                  type="selection"
                  width="40"
                  reserve-selection
                />
                <ss:HGridColumn
                  prop="account"
                  label="用户账号"
                  show-overflow-tooltip
                />
                <ss:HGridColumn
                  prop="user_name"
                  label="用户名称"
                  show-overflow-tooltip
                />

                <template #paging>
                  <ss:HGridPaging
                    :dataUrl="`${VITE_API_URL}/data/SystemRoleUserPage.json?mode=assigned&role_id=${selectedRole?.role_id}&user_name=${assignedUsersForm.user_name}&account=${assignedUsersForm.account}`"
                    :pagesize="assignedPageInfo.pageSize"
                    :currentPage="assignedPageInfo.currentPage"
                    ref="assignedPagRef"
                  />
                </template>
              </ss:HGridPanel>
            </div>
          </div>
        </div>
      </ss:HCard>

      <div class="h-full flex flex-col items-center justify-center gap-3">
        <div>
          <ss:HButton @click="handleRemoveUsers" :loading="removeUsersLoading">
            <ss:HIcon size="18"><ArrowRightBold /></ss:HIcon>
          </ss:HButton>
        </div>
        <div>
          <ss:HButton @click="handleAddUsers" :loading="addUsersLoading">
            <ss:HIcon size="18"><ArrowLeftBold /></ss:HIcon>
          </ss:HButton>
        </div>
      </div>

      <!-- 右侧：未获得角色的用户 -->
      <ss:HCard class="h-full flex-1" shadow="never">
        <template #header>
          <div class="card-header">
            <span>未获得此角色的用户</span>
          </div>
        </template>
        <div class="h-full flex flex-col">
          <div class="flex justify-between items-center">
            <div class="flex-1 flex">
              <ss:HInput
                placeholder="用户账号"
                clearable
                v-model="unassignedUsersForm.account"
                class="max-w-[200px] mr-2.5"
              />
              <ss:HInput
                placeholder="用户名称"
                clearable
                v-model="unassignedUsersForm.user_name"
                class="max-w-[200px] mr-2.5"
              />
              <ss:HButton type="primary" @click="handleUnassignedSizeChange">
                <ss:HIcon><Search /></ss:HIcon>
                查询
              </ss:HButton>
              <ss:HButton @click="resetUnassignedSearch">
                <ss:HIcon><RefreshLeft /></ss:HIcon>
                重置
              </ss:HButton>
            </div>
          </div>
          <div class="flex-1 h-0 flex flex-col mt-1">
            <div class="flex-1 h-0">
              <ss:HGridPanel
                :data="unassignedUsers"
                style="height: 100%;"
                :border="false"
                v-loading="unassignedTableLoading"
                :row-key="(user) => user.account"
                @selection-change="unassignedUserTableSelectionChange"
                ref="unassignedTableRef"
              >
                <ss:HGridColumn
                  type="selection"
                  width="40"
                  reserve-selection
                />
                <ss:HGridColumn
                  prop="account"
                  label="用户账号"
                  show-overflow-tooltip
                />
                <ss:HGridColumn
                  prop="user_name"
                  label="用户名称"
                  show-overflow-tooltip
                />

                <template #paging>
                  <ss:HGridPaging
                    :dataUrl="`${VITE_API_URL}/data/SystemRoleUserPage.json?mode=unassigned&role_id=${selectedRole?.role_id}&user_name=${unassignedUsersForm.user_name}&account=${unassignedUsersForm.account}`"
                    :pagesize="unassignedPageInfo.pageSize"
                    :currentPage="unassignedPageInfo.currentPage"
                    ref="unassignedPagRef"
                  />
                </template>
              </ss:HGridPanel>
            </div>
          </div>
        </div>
      </ss:HCard>
    </div>
  </ss:HViewPort>
</template>

<script setup lang="ts">
import { ref, onMounted, nextTick } from "vue";
import { ElMessage } from "element-plus";
import { ArrowLeftBold, ArrowRightBold, RefreshLeft, Search } from "@element-plus/icons-vue";
import type { Role, User, PageInfo, HGridPagingInstance, HGridPanelInstance } from "./type";
import api from "@/utils/http";

const { VITE_API_URL } = import.meta.env;

// 分页组件引用
const rolePagRef = ref<HGridPagingInstance | null>(null);
const assignedPagRef = ref<HGridPagingInstance | null>(null);
const unassignedPagRef = ref<HGridPagingInstance | null>(null);

// 角色列表
const roleList = ref<Role[]>([]);

// 角色表格引用
const roleTableRef = ref<HGridPanelInstance | null>(null);

// 表格加载状态
const roleTableLoading = ref(false);
const assignedTableLoading = ref(false);
const unassignedTableLoading = ref(false);
const removeUsersLoading = ref(false);
const addUsersLoading = ref(false);

// 已获得角色的用户
const assignedUsers = ref<User[]>([]);

// 选中的已分配用户
const selectedAssignedUsers = ref<User[]>([]);

// 未获得角色的用户
const unassignedUsers = ref<User[]>([]);

// 选中的未分配用户
const selectedUnassignedUsers = ref<User[]>([]);

// 选中的角色
const selectedRole = ref<Role | null>(null);

// 分页信息
const rolePageInfo = ref<PageInfo>({
  total: 0,
  pageSize: 15,
  currentPage: 1,
});

const assignedPageInfo = ref<PageInfo>({
  total: 0,
  pageSize: 15,
  currentPage: 1,
});

const unassignedPageInfo = ref<PageInfo>({
  total: 0,
  pageSize: 15,
  currentPage: 1,
});

// 表格引用
const unassignedTableRef = ref<HGridPanelInstance | null>(null);
const assignedTableRef = ref<HGridPanelInstance | null>(null);

// 未获得此角色的用户搜索表单
const unassignedUsersForm = ref({
  account: "",
  user_name: "",
});

// 已获得此角色的用户搜索表单
const assignedUsersForm = ref({
  account: "",
  user_name: "",
});

/**
 * 处理角色点击
 * @description 当用户点击左侧角色列表时，刷新中间和右侧的用户表格
 * @param row 角色信息
 */
const handleRoleClick = (row: Role) => {
  selectedRole.value = row;
  handleAssignedSizeChange();
  handleUnassignedSizeChange();
};

/**
 * 获取角色列表
 * @description 从服务器获取角色列表数据
 */
const getRoleList = async () => {
  roleTableLoading.value = true;
  const params = {
    scope: "assignment",
    role_id: "",
    role_name: "",
    start: rolePageInfo.value.currentPage,
    limit: rolePageInfo.value.pageSize,
  };
  await rolePagRef.value?.reload(`${VITE_API_URL}/data/SystemRolePage.json`, params);
  roleTableLoading.value = false;
  
  if (roleTableRef.value?.tableData?.length) {
    selectedRole.value = roleTableRef.value.tableData[0];
    handleRoleClick(roleTableRef.value.tableData[0]);
      // 滚动到顶部
      nextTick(() => {
        if (roleTableRef.value) {
          roleTableRef.value?.tableRef?.setCurrentRow(roleTableRef.value.tableData[0]);
        }
      });
  }
};

/**
 * 获取已获得角色的用户列表
 * @description 根据选中的角色获取已分配的用户列表
 */
const getAssignedUsers = async () => {
  if (!selectedRole.value) return;

  assignedTableLoading.value = true;
  const params = {
    mode: "assigned",
    role_id: selectedRole.value.role_id,
    user_name: assignedUsersForm.value.user_name,
    account: assignedUsersForm.value.account,
    start: assignedPageInfo.value.currentPage,
    limit: assignedPageInfo.value.pageSize,
  };
  await assignedPagRef.value?.reload(`${VITE_API_URL}/data/SystemRoleUserPage.json`, params);
  assignedTableLoading.value = false;
};

/**
 * 处理未分配用户表格选择变化
 * @description 当用户在未分配用户表格中选择或取消选择用户时，更新选中用户列表
 * @param selection 选中的用户列表
 */
const unassignedUserTableSelectionChange = (selection: User[]) => {
  selectedUnassignedUsers.value = selection;
};

/**
 * 处理已分配用户表格选择变化
 * @description 当用户在已分配用户表格中选择或取消选择用户时，更新选中用户列表
 * @param selection 选中的用户列表
 */
const assignedUserTableSelectionChange = (selection: User[]) => {
  selectedAssignedUsers.value = selection;
};

/**
 * 获取未获得角色的用户列表
 * @description 根据选中的角色获取未分配的用户列表
 */
const getUnassignedUsers = async () => {
  if (!selectedRole.value) return;

  unassignedTableLoading.value = true;
  const params = {
    mode: "unassigned",
    role_id: selectedRole.value.role_id,
    user_name: unassignedUsersForm.value.user_name,
    account: unassignedUsersForm.value.account,
    start: unassignedPageInfo.value.currentPage,
    limit: unassignedPageInfo.value.pageSize,
  };
  await unassignedPagRef.value?.reload(`${VITE_API_URL}/data/SystemRoleUserPage.json`, params);
  unassignedTableLoading.value = false;
};

/**
 * 处理角色列表每页大小变化
 * @description 当角色列表每页显示数量改变时，重置页码为1并重新获取数据
 */
const handleRoleSizeChange = () => {
  rolePageInfo.value.currentPage = 1;
  getRoleList();
};

/**
 * 处理已分配用户列表每页大小变化
 * @description 当已分配用户列表每页显示数量改变时，重置页码为1并重新获取数据
 */
const handleAssignedSizeChange = () => {
  assignedPageInfo.value.currentPage = 1;
  if (assignedTableRef.value) {
    assignedTableRef.value?.tableRef?.clearSelection();
  }
  getAssignedUsers();
};

/**
 * 重置已分配用户搜索表单
 * @description 清空已分配用户搜索表单中的账号和名称字段，并刷新已分配用户列表
 */
const resetAssignedSearch = () => {
  assignedUsersForm.value.account = "";
  assignedUsersForm.value.user_name = "";
  handleAssignedSizeChange();
};

/**
 * 处理未分配用户列表每页大小变化
 * @description 当未分配用户列表每页显示数量改变时，重置页码为1并重新获取数据
 */
const handleUnassignedSizeChange = () => {
  unassignedPageInfo.value.currentPage = 1;
  if (unassignedTableRef.value) {
    unassignedTableRef.value?.tableRef?.clearSelection();
  }
  getUnassignedUsers();
};

/**
 * 重置未分配用户搜索表单
 * @description 清空未分配用户搜索表单中的账号和名称字段，并刷新未分配用户列表
 */
const resetUnassignedSearch = () => {
  unassignedUsersForm.value.account = "";
  unassignedUsersForm.value.user_name = "";
  handleUnassignedSizeChange();
};

/**
 * 添加用户到角色
 * @description 将右侧选中的用户添加到当前角色，并从右侧列表移除
 */
const handleAddUsers = async () => {
  if (
    !selectedUnassignedUsers.value ||
    selectedUnassignedUsers.value.length === 0
  ) {
    ElMessage.warning("请先选择要添加的用户");
    return;
  }
  if (!selectedRole.value) {
    ElMessage.warning("请先选择一个角色");
    return;
  }
  addUsersLoading.value = true;
  const datas = selectedUnassignedUsers.value.map((user: User) => ({
    role_id: selectedRole.value?.role_id,
    user_id: user.user_id,
  }));
  addUsersLoading.value = false;
  const res = await api.post({
    url: "/json/UpdateRoleUsers.json",
    data: {
      action: "add",
      data: datas,
    },
  });

  if (res) {
    ElMessage.success("添加成功");
    handleRoleClick(selectedRole.value);

    // 清空选择
    nextTick(() => {
      if (unassignedTableRef.value) {
        unassignedTableRef.value?.tableRef?.clearSelection();
      }
    });
  }
};

/**
 * 取消角色（移除用户）
 * @description 将中间选中的用户从当前角色移除
 */
const handleRemoveUsers = async () => {
  if (
    !selectedAssignedUsers.value ||
    selectedAssignedUsers.value.length === 0
  ) {
    ElMessage.warning("请先选择要移除的用户");
    return;
  }
  if (!selectedRole.value) {
    ElMessage.warning("请先选择一个角色");
    return;
  }
  removeUsersLoading.value = true;
  const datas = selectedAssignedUsers.value.map((user: User) => ({
    role_id: selectedRole.value?.role_id,
    user_id: user.user_id,
  }));
  removeUsersLoading.value = false;
  const res = await api.post({
    url: "/json/UpdateRoleUsers.json",
    data: {
      action: "remove",
      data: datas,
    },
  });

  if (res) {
    ElMessage.success("移除成功");
    handleRoleClick(selectedRole.value);

    // 清空选择
    nextTick(() => {
      if (assignedTableRef.value) {
        assignedTableRef.value?.tableRef?.clearSelection();
      }
    });
  }
};

// 页面加载时获取角色列表
onMounted(() => {
  getRoleList();
});
</script>

<style scoped>
:deep(.el-card__body) {
  height: 100%;
}

.view-port-box > :deep(.h-panel-body) {
  display: flex;
  flex-direction: column;

  .h-layout-border {
    flex: 1;
  }
}
</style>
