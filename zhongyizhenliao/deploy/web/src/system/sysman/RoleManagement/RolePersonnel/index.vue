<template>
  <div class="art-full-height">
    <el-card class="h-full">
      <div class="h-full flex gap-4">
        <!-- 左侧：角色列表 -->
        <el-card class="h-full flex-1" shadow="never">
          <template #header>
            <span class="font-medium text-[#333]">角色列表</span>
          </template>
          <div class="h-full flex flex-col">
            <div class="flex-1 h-0">
              <el-table
                :data="roleList"
                height="100%"
                highlight-current-row
                @row-click="handleRoleClick"
                :current-row-key="selectedRole?.role_id"
                v-loading="roleTableLoading"
                ref="roleTableRef"
              >
                <el-table-column
                  prop="role_code"
                  label="角色代码"
                  show-overflow-tooltip
                />
                <el-table-column
                  prop="role_name"
                  label="角色名"
                  show-overflow-tooltip
                />
              </el-table>
            </div>
            <div class="mt-5 flex justify-center align-center">
              <el-pagination
                v-model:current-page="rolePageInfo.currentPage"
                v-model:page-size="rolePageInfo.pageSize"
                layout="total, prev, pager, next"
                :pager-count="5"
                :total="rolePageInfo.total"
                @update:page-size="handleRoleSizeChange"
                @update:current-page="getRoleList"
              />
            </div>
          </div>
        </el-card>

        <!-- 中间：已获得角色的用户 -->
        <el-card class="h-full flex-1" shadow="never">
          <template #header>
            <span class="font-medium text-[#333]">已获得此角色的用户</span>
          </template>
          <div class="h-full flex flex-col">
            <div class="flex justify-between items-center">
              <div class="flex-1 flex">
                <el-input
                  placeholder="用户账号"
                  clearable
                  v-model="assignedUsersForm.account"
                  class="max-w-[200px] mr-2.5"
                />
                <el-input
                  placeholder="用户名称"
                  clearable
                  v-model="assignedUsersForm.user_name"
                  class="max-w-[200px] mr-2.5"
                />
                <el-button type="primary" @click="handleAssignedSizeChange">
                  <el-icon><Search /></el-icon>
                  查询
                </el-button>
                <el-button @click="resetAssignedSearch">
                  <el-icon><RefreshLeft /></el-icon>
                  重置
                </el-button>
              </div>
              <!-- <div>
                <el-button
                  type="danger"
                  @click="handleRemoveUsers"
                  :disabled="!selectedRole"
                >
                  <el-icon><CloseBold /></el-icon>
                  取消角色
                </el-button>
              </div> -->
            </div>
            <div class="flex-1 h-0 flex flex-col mt-1">
              <div class="flex-1 h-0">
                <el-table
                  :data="assignedUsers"
                  height="100%"
                  :border="false"
                  ref="assignedTableRef"
                  v-loading="assignedTableLoading"
                  :row-key="(user) => user.account"
                  @selection-change="assignedUserTableSelectionChange"
                >
                  <el-table-column
                    type="selection"
                    width="40"
                    reserve-selection
                  />
                  <el-table-column
                    prop="account"
                    label="用户账号"
                    show-overflow-tooltip
                  />
                  <el-table-column
                    prop="user_name"
                    label="用户名称"
                    show-overflow-tooltip
                  />
                </el-table>
              </div>
              <div class="mt-5 flex justify-center align-center">
                <el-pagination
                  v-model:current-page="assignedPageInfo.currentPage"
                  v-model:page-size="assignedPageInfo.pageSize"
                  layout="total, prev, pager, next"
                  :pager-count="5"
                  :total="assignedPageInfo.total"
                  @update:page-size="handleAssignedSizeChange"
                  @update:current-page="getAssignedUsers"
                />
              </div>
            </div>
          </div>
        </el-card>

        <div class="h-full flex flex-col items-center justify-center gap-3">
          <div>
            <el-button @click="handleRemoveUsers" :loading="removeUsersLoading"
              ><el-icon size="18"><ArrowRightBold /></el-icon
            ></el-button>
          </div>
          <div>
            <el-button @click="handleAddUsers" :loading="addUsersLoading"
              ><el-icon size="18"><ArrowLeftBold /></el-icon
            ></el-button>
          </div>
        </div>

        <!-- 右侧：未获得角色的用户 -->
        <el-card class="h-full flex-1" shadow="never">
          <template #header>
            <span class="font-medium text-[#333]">未获得此角色的用户</span>
          </template>
          <div class="h-full flex flex-col">
            <div class="flex justify-between items-center">
              <div class="flex-1 flex">
                <el-input
                  placeholder="用户账号"
                  clearable
                  v-model="unassignedUsersForm.account"
                  class="max-w-[200px] mr-2.5"
                />
                <el-input
                  placeholder="用户名称"
                  clearable
                  v-model="unassignedUsersForm.user_name"
                  class="max-w-[200px] mr-2.5"
                />
                <el-button type="primary" @click="handleUnassignedSizeChange">
                  <el-icon><Search /></el-icon>
                    查询
                </el-button>
                <el-button @click="resetUnassignedSearch">
                  <el-icon><RefreshLeft /></el-icon>
                  重置
                </el-button>
              </div>
              <!-- <div>
                <el-button
                  type="primary"
                  @click="handleAddUsers"
                  :disabled="!selectedRole"
                >
                  <el-icon><Plus /></el-icon>
                  添加到角色
                </el-button>
              </div> -->
            </div>
            <div class="flex-1 h-0 flex flex-col mt-1">
              <div class="flex-1 h-0">
                <el-table
                  :data="unassignedUsers"
                  height="100%"
                  :border="false"
                  ref="unassignedTableRef"
                  v-loading="unassignedTableLoading"
                  :row-key="(user) => user.account"
                  @selection-change="unassignedUserTableSelectionChange"
                >
                  <el-table-column
                    type="selection"
                    width="40"
                    reserve-selection
                  />
                  <el-table-column
                    prop="account"
                    label="用户账号"
                    show-overflow-tooltip
                  />
                  <el-table-column
                    prop="user_name"
                    label="用户名称"
                    show-overflow-tooltip
                  />
                </el-table>
              </div>
              <div class="mt-5 flex justify-center align-center">
                <el-pagination
                  v-model:current-page="unassignedPageInfo.currentPage"
                  v-model:page-size="unassignedPageInfo.pageSize"
                  layout="total, prev, pager, next"
                  :pager-count="5"
                  :total="unassignedPageInfo.total"
                  @update:page-size="handleUnassignedSizeChange"
                  @update:current-page="getUnassignedUsers"
                />
              </div>
            </div>
          </div>
        </el-card>
      </div>
    </el-card>
  </div>
</template>

<script setup lang="ts">
import { ref, onMounted, nextTick } from "vue";
import { ElMessage, ElTable } from "element-plus";
import { ArrowLeftBold, ArrowRightBold, RefreshLeft, Search } from "@element-plus/icons-vue";
import type { Role, User, PageInfo, GeneralListResponse } from "./type";
import api from "@/utils/http";

// 角色列表
const roleList = ref<Role[]>([]);

// 角色表格引用
const roleTableRef = ref<InstanceType<typeof ElTable>>();

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
const unassignedTableRef = ref<InstanceType<typeof ElTable>>();
const assignedTableRef = ref<InstanceType<typeof ElTable>>();

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
  const res = await api.get<GeneralListResponse<Role>>({
    url: "/data/SystemRolePage.json",
    params: {
      scope: "assignment",
      role_id: "",
      role_name: "",
      start: rolePageInfo.value.currentPage,
      limit: rolePageInfo.value.pageSize,
    },
  });
  roleTableLoading.value = false;
  if (res?.data) {
    roleList.value = res.data;
    rolePageInfo.value.total = res.count || 0;

    if (roleList.value.length > 0) {
      // 默认选中第一个角色
      selectedRole.value = roleList.value[0];
      handleRoleClick(roleList.value[0]);
      // 滚动到顶部
      nextTick(() => {
        if (roleTableRef.value) {
          roleTableRef.value.setCurrentRow(roleList.value[0]);
        }
      });
    }
  }
};

/**
 * 获取已获得角色的用户列表
 * @description 根据选中的角色获取已分配的用户列表
 */
const getAssignedUsers = async () => {
  if (!selectedRole.value) return;

  assignedTableLoading.value = true;
  const res = await api.get<GeneralListResponse<User>>({
    url: "/data/SystemRoleUserPage.json",
    params: {
      mode: "assigned",
      role_id: selectedRole.value.role_id,
      user_name: assignedUsersForm.value.user_name,
      account: assignedUsersForm.value.account,
      start: assignedPageInfo.value.currentPage,
      limit: assignedPageInfo.value.pageSize,
    },
  });
  assignedTableLoading.value = false;
  if (res?.data) {
    assignedUsers.value = res.data;
    assignedPageInfo.value.total = res.count || 0;
  }
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
  const res = await api.get<GeneralListResponse<User>>({
    url: "/data/SystemRoleUserPage.json",
    params: {
      mode: "unassigned",
      role_id: selectedRole.value.role_id,
      user_name: unassignedUsersForm.value.user_name,
      account: unassignedUsersForm.value.account,
      start: unassignedPageInfo.value.currentPage,
      limit: unassignedPageInfo.value.pageSize,
    },
  });
  unassignedTableLoading.value = false;
  if (res?.data) {
    unassignedUsers.value = res.data;
    unassignedPageInfo.value.total = res.count || 0;
  }
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
        unassignedTableRef.value.clearSelection();
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
        assignedTableRef.value.clearSelection();
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
  padding: 12px;
}
</style>
