<template>
  <div class="art-full-height">
    <el-card class="h-full">
      <div class="h-full flex gap-4">
        <!-- 左侧：人员列表 -->
        <el-card class="h-full flex-1" shadow="never">
          <template #header>
            <div class="card-header">
              <span>人员列表</span>
            </div>
          </template>
          <!-- 搜索栏 -->
          <div class="flex items-center">
            <el-input
              clearable
              placeholder="姓名"
              v-model="searchForm.name"
              class="max-w-50 mr-2.5"
            />
            <el-input
              clearable
              placeholder="所属单位"
              v-model="searchForm.unit"
              class="max-w-50 mr-2.5"
            />
            <div>
              <el-button type="primary" @click="handleSearch">
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

          <!-- 表格 -->
          <div class="flex-1 h-0 mt-5">
            <el-table
              :data="userList"
              height="100%"
              highlight-current-row
              @row-click="handleUserClick"
              :current-row-key="selectedUser?.user_id"
              :loading="tableLoading"
            >
              <el-table-column prop="user_name" label="姓名" show-overflow-tooltip />
              <el-table-column
                prop="account"
                label="账号"
                show-overflow-tooltip
              />
              <el-table-column
                prop="department_name"
                label="所属单位"
                show-overflow-tooltip
              />
            </el-table>
          </div>

          <!-- 分页 -->
          <div class="mt-5 flex justify-center items-center">
            <el-pagination
              v-model:current-page="userPageInfo.currentPage"
              v-model:page-size="userPageInfo.pageSize"
              :page-sizes="[15, 30, 45, 60, 90, 100]"
              :pager-count="5"
              layout="total, sizes, prev, pager, next, jumper"
              :total="userPageInfo.total"
              @update:page-size="handleSearch"
              @update:current-page="getUserList"
            />
          </div>
        </el-card>

        <!-- 右侧：模块树 -->
        <el-card class="h-full flex-1" shadow="never">
          <template #header>
            <div class="card-header">
              <span>模块树</span>
            </div>
          </template>
          <div class="flex flex-col h-full">
            <div>
              <el-button
                type="primary"
                @click="handleSave"
                :loading="saveLoading"
              >
                <el-icon><DocumentAdd /></el-icon>
                保存
              </el-button>
            </div>
            <div class="flex-1 mt-4 overflow-auto">
              <el-tree
                ref="moduleTreeRef"
                :data="moduleTree"
                :props="treeProps"
                show-checkbox
                node-key="id"
                :default-expand-all="true"
              />
            </div>
          </div>
        </el-card>
      </div>
    </el-card>
  </div>
</template>

<script setup lang="ts">
import { ref, onMounted, nextTick } from "vue";
import { Search, RefreshLeft, DocumentAdd } from "@element-plus/icons-vue";
import { ElMessage } from "element-plus";
import type {
  User,
  ModuleNode,
  SearchForm,
  PageInfo,
  GeneralListResponse,
} from "./type";
import api from "@/utils/http";

// 人员列表
const userList = ref<User[]>([]);

// 模块树数据
const moduleTree = ref<ModuleNode[]>([]);

// 树配置
const treeProps = {
  children: "children",
  label: "text",
};

// 选中的用户
const selectedUser = ref<User | null>(null);

// 表格引用
const moduleTreeRef = ref();

// 搜索表单
const searchForm = ref<SearchForm>({
  name: "",
  unit: "",
});

// 分页信息
const userPageInfo = ref<PageInfo>({
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
  if (res && Array.isArray(res)) {
    moduleTree.value = res;
  }
};

// 根据id从目录树中查找对应的节点
const findNodeById = (tree: ModuleNode[], id: string) => {
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
 * 处理用户点击
 * @description 当用户点击左侧人员列表时，刷新右侧模块树并显示该用户已授权的模块
 * @param row 用户信息
 */
const handleUserClick = async (row: User) => {
  selectedUser.value = row;

  // 清空之前的勾选状态
  if (moduleTreeRef.value) {
    moduleTreeRef.value.setCheckedKeys([]);
  }

  // 获取该用户已授权的模块ID
  const res = await api.get<GeneralListResponse<User>>({
    url: "/data/SystemPermissionList.json",
    params: {
      principalType: "user",
      principalId: row.user_id,
    },
  });
  if (res && Array.isArray(res)) {
    const moduleIds = res.map((item: any) => item.id); // id字段对应resource_id字

    // 通过在模块树中查找id字段相同的数据，如果是非叶子节点，就从moduleIds中去除
    const filterModuleIds = []
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
 * 查询用户列表
 * @description 根据搜索条件查询人员列表，重置页码为1
 */
const handleSearch = () => {
  userPageInfo.value.currentPage = 1;
  getUserList();
};

/**
 * 查询用户列表
 * @description 根据搜索条件查询人员列表
 */
const getUserList = async () => {
  tableLoading.value = true;
  const res = await api.get<GeneralListResponse<User>>({
    url: "/data/SystemUserPage.json",
    params: {
      scope: "permission",
      department_name: searchForm.value.unit || "",
      user_name: searchForm.value.name || "",
      start: userPageInfo.value.currentPage,
      limit: userPageInfo.value.pageSize,
    },
  });
  tableLoading.value = false;
  if (res?.data) {
    userList.value = res.data;
    userPageInfo.value.total = res.count;
  }
};

/**
 * 重置搜索条件
 * @description 清空所有搜索条件并重置页码为1
 */
const resetSearch = () => {
  searchForm.value.name = "";
  searchForm.value.unit = "";
  userPageInfo.value.currentPage = 1;
  handleSearch();
};

/**
 * 保存用户权限配置
 * @description 将用户勾选的模块权限保存到系统
 */
const handleSave = async () => {
  if (!selectedUser.value) {
    ElMessage.warning("请先选择一个人员");
    return;
  }

  if (!moduleTreeRef.value) return;
  const checkedKeys = moduleTreeRef.value.getCheckedKeys();
  const halfCheckedKeys = moduleTreeRef.value.getHalfCheckedKeys();
  let list = [];
  if (!checkedKeys.length && !halfCheckedKeys.length) {
    list = [
      {
        user_id: selectedUser.value?.user_id || "",
      },
    ];
  } else {
    list = [...checkedKeys, ...halfCheckedKeys].map((item: string) => ({
      resource_id: item,
      user_id: selectedUser.value?.user_id || "",
    }));
  }

  saveLoading.value = true;
  const res = await api.post({
    url: "/json/InsertByUserId.json",
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
  getUserList();
  getModuleTree();
});
</script>

<style scoped>
:deep(.el-card__body) {
  height: 100%;
  display: flex;
  flex-direction: column;
}
</style>
