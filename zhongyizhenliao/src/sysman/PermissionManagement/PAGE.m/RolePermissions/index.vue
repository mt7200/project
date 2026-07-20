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
          <!-- 搜索栏 -->
          <div class="flex items-center">
            <ss:HInput
              clearable
              placeholder="角色id"
              v-model="searchForm.roleId"
              class="max-w-50 mr-2.5"
            />
            <ss:HInput
              clearable
              placeholder="名称"
              v-model="searchForm.name"
              class="max-w-50 mr-2.5"
            />
            <div>
              <ss:HButton type="primary" @click="handleSearch">
                <ss:HIcon>
                  <Search />
                </ss:HIcon>
                查询
              </ss:HButton>
              <ss:HButton @click="resetSearch">
                <ss:HIcon>
                  <RefreshLeft />
                </ss:HIcon>
                重置
              </ss:HButton>
            </div>
          </div>

          <!-- 表格 -->
          <div class="flex-1 h-0 mt-5">
            <ss:HGridPanel
              :data="roleList"
              highlight-current-row
              @row-click="handleRoleClick"
              :current-row-key="selectedRole?.role_id"
              :loading="tableLoading"
              style="height: 100%;"
              border
            >
              <ss:HGridColumn
                prop="role_id"
                label="角色id"
                show-overflow-tooltip
              />
              <ss:HGridColumn
                prop="role_name"
                label="名称"
                show-overflow-tooltip
              />
              <ss:HGridColumn prop="sort" label="排序" show-overflow-tooltip />
              <ss:HGridColumn
                prop="remark"
                label="备注"
                show-overflow-tooltip
              />

              <template #paging>
                <ss:HGridPaging
                  :dataUrl="`${VITE_API_URL}/data/SystemRolePage.json?scope=permission&role_id=${searchForm.roleId}&role_name=${searchForm.name}`"
                  :pagesize="rolePageInfo.pageSize"
                  :currentPage="rolePageInfo.currentPage"
                  ref="pagRef"
                />
              </template>
            </ss:HGridPanel>
          </div>
        </div>
      </ss:HCard>

      <!-- 右侧：模块树 -->
      <ss:HCard class="h-full flex-1" shadow="never">
        <template #header>
          <div class="card-header">
            <span>模块树</span>
          </div>
        </template>
        <div class="flex flex-col h-full">
          <div>
            <ss:HButton
              type="primary"
              @click="handleSave"
              :loading="saveLoading"
            >
              <ss:HIcon><DocumentAdd /></ss:HIcon>
              保存
            </ss:HButton>
          </div>
          <div class="flex-1 mt-4 overflow-auto">
            <ss:HTree
              ref="moduleTreeRef"
              :data="moduleTree"
              :props="treeProps"
              show-checkbox
              node-key="id"
              :default-expand-all="true"
            />
          </div>
        </div>
      </ss:HCard>
    </div>
  </ss:HViewPort>
</template>

<script setup lang="ts">
import { ref, onMounted, nextTick } from "vue";
import { Search, RefreshLeft, DocumentAdd } from "@element-plus/icons-vue";
import { ElMessage } from "element-plus";
import type {
  Role,
  ModuleNode,
  SearchForm,
  PageInfo,
  GeneralListResponse,
  HGridPagingInstance,
} from "./type";
import api from "@/utils/http";

const { VITE_API_URL } = import.meta.env;
const pagRef = ref<HGridPagingInstance | null>(null);

// 角色列表（只显示启用状态的角色）
const roleList = ref<Role[]>([]);

// 模块树数据
const moduleTree = ref<ModuleNode[]>([]);

// 树配置
const treeProps = {
  children: "children",
  label: "text",
};

// 选中的角色
const selectedRole = ref<Role | null>(null);

// 表格引用
const moduleTreeRef = ref();

// 搜索表单
const searchForm = ref<SearchForm>({
  roleId: "",
  name: "",
});

// 分页信息
const rolePageInfo = ref<PageInfo>({
  total: 0,
  pageSize: 15,
  currentPage: 1,
});

// 表格加载状态
const tableLoading = ref(false);

// 保存加载状态
const saveLoading = ref(false);

/**
 * 获取模块树数据
 * @description 从接口获取模块树结构数据
 */
const getModuleTree = async () => {
  const res = await api.get<ModuleNode[]>({
    url: "/data/SystemPermissionTree.json",
  });
  console.log("模块树", res);
  if (res && Array.isArray(res)) {
    moduleTree.value = res;
  }
};

// 根据id从目录树中查找对应的节点
const findNodeById = (tree: ModuleNode[], id: string): ModuleNode | null => {
  const node = tree.find((item) => item.id === id);
  if (node) {
    return node;
  }
  for (let i = 0; i < tree.length; i++) {
    const childNode = findNodeById(tree[i].children || [], id);
    if (childNode) {
      return childNode;
    }
  }
  return null;
};

/**
 * 处理角色点击
 * @description 当用户点击左侧角色列表时，刷新右侧模块树并显示该角色已授权的模块
 * @param row 角色信息
 */
const handleRoleClick = async (row: Role) => {
  selectedRole.value = row;

  // 清空之前的勾选状态
  if (moduleTreeRef.value) {
    moduleTreeRef.value.setCheckedKeys([]);
  }

  // 获取该角色已授权的模块ID
  const res = await api.get<GeneralListResponse<Role>>({
    url: "/data/SystemPermissionList.json",
    params: {
      principalType: "role",
      principalId: row.role_code,
    },
  });
  if (res && Array.isArray(res)) {
    const moduleIds = res.map((item) => item.id); // id字段对应resource_id字段
    // 通过在模块树中查找id字段相同的数据，如果是非叶子节点，就从moduleIds中去除
    const filterModuleIds: string[] = [];
    moduleIds.forEach((id) => {
      const node = findNodeById(moduleTree.value, id);
      if (node?.leaf) {
        filterModuleIds.push(id);
      }
    });

    nextTick(() => {
      if (moduleTreeRef.value) {
        moduleTreeRef.value.setCheckedKeys(filterModuleIds);
      }
    });
  }
};

/**
 * 查询角色列表
 * @description 根据搜索条件查询角色列表
 */
const handleSearch = () => {
  rolePageInfo.value.currentPage = 1;
  getRoleList();
};

/**
 * 查询角色列表
 * @description 根据搜索条件查询角色列表
 */
const getRoleList = async () => {
  tableLoading.value = true;
  const params = {
    scope: "permission",
    role_id: searchForm.value.roleId || "",
    role_name: searchForm.value.name || "",
    start: rolePageInfo.value.currentPage,
    limit: rolePageInfo.value.pageSize,
  };
  await pagRef.value?.reload(`${VITE_API_URL}/data/SystemRolePage.json`, params);
  tableLoading.value = false;
};

/**
 * 重置搜索条件
 * @description 清空所有搜索条件并重置页码为1
 */
const resetSearch = () => {
  searchForm.value.roleId = "";
  searchForm.value.name = "";
  rolePageInfo.value.currentPage = 1;
  handleSearch();
};

/**
 * 保存角色权限配置
 * @description 将角色勾选的模块权限保存到系统
 */
const handleSave = async () => {
  if (!selectedRole.value) {
    ElMessage.warning("请先选择一个角色");
    return;
  }

  if (!moduleTreeRef.value) return;
  const checkedKeys = moduleTreeRef.value.getCheckedKeys();
  const halfCheckedKeys = moduleTreeRef.value.getHalfCheckedKeys();
  let list = [];
  if (!checkedKeys.length && !halfCheckedKeys.length) {
    list = [
      {
        role_code: selectedRole.value.role_code,
      },
    ];
  } else {
    list = [...checkedKeys, ...halfCheckedKeys].map((item: string) => ({
      resource_id: item,
      role_code: selectedRole.value?.role_code || "",
    }));
  }

  saveLoading.value = true;
  const res = await api.post({
    url: "/json/InsertByRoleCode.json",
    data: {
      data: list,
    },
  });
  saveLoading.value = false;
  if (res) {
    ElMessage.success("保存成功");
  }
};

// 页面加载
onMounted(() => {
  getRoleList();
  getModuleTree();
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
