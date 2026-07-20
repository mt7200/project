<template>
  <ss:HViewPort class="view-port-box">
    <template #north>
      <!-- 搜索栏 -->
      <div class="w-full flex items-center" :attrs="{ height: 56 }">
        <ss:HInput
          clearable
          placeholder="单位"
          v-model="searchForm.unit"
          class="max-w-50 mr-2.5"
        />
        <ss:HInput
          clearable
          placeholder="账号"
          v-model="searchForm.account"
          class="max-w-50 mr-2.5"
        />
        <ss:HSelect
          clearable
          v-model="searchForm.logType"
          placeholder="日志分类"
          class="max-w-50 mr-2.5"
        >
          <el-option
            v-for="item in logTypes"
            :key="item.code"
            :label="item.name"
            :value="item.code"
          />
        </ss:HSelect>
        <ss:HDatePicker
          v-model="searchForm.startTime"
          type="datetime"
          placeholder="开始时间"
          class="max-w-55 mr-2.5"
          value-format="YYYY-MM-DD HH:mm:ss"
        />
        <ss:HDatePicker
          v-model="searchForm.endTime"
          type="datetime"
          placeholder="结束时间"
          class="max-w-55 mr-2.5"
          value-format="YYYY-MM-DD HH:mm:ss"
        />
        <div>
          <el-button type="primary" @click="handleSizeChange">
            <ss:HIcon>
              <Search />
            </ss:HIcon>
            查询
          </el-button>
          <el-button @click="resetSearch">
            <ss:HIcon>
              <RefreshLeft />
            </ss:HIcon>
            重置
          </el-button>
        </div>
      </div>
    </template>

    <template #center>
      <!-- 表格 -->
      <ss:HGridPanel :data="logList" height="100%" v-loading="tableLoading" border>
        <ss:HGridColumn prop="log_type" label="日志分类" show-overflow-tooltip>
          <template #default="{ row }">
            {{
              logTypes.find((item) => item.code === row.log_type)?.name || "-"
            }}
          </template>
        </ss:HGridColumn>
        <ss:HGridColumn prop="unit" label="单位" show-overflow-tooltip />
        <ss:HGridColumn prop="ip" label="ip" show-overflow-tooltip />
        <ss:HGridColumn prop="content" label="内容" show-overflow-tooltip />
        <ss:HGridColumn prop="user_name" label="操作人" show-overflow-tooltip />
        <ss:HGridColumn prop="account" label="账号" show-overflow-tooltip />
        <ss:HGridColumn
          prop="create_time"
          label="操作时间"
          show-overflow-tooltip
        />

        <template #paging>
          <ss:HGridPaging
            :dataUrl="`${VITE_API_URL}/data/SystemAuditLogPage.json?unit=${searchForm.unit}&account=${searchForm.account}&log_type=${searchForm.logType}&start_time=${searchForm.startTime}&end_time=${searchForm.endTime}`"
            :pagesize="pageInfo.pageSize"
            :currentPage="pageInfo.currentPage"
            ref="pagRef"
          />
        </template>
      </ss:HGridPanel>
    </template>
  </ss:HViewPort>
</template>

<script setup lang="ts">
import { ref, onMounted } from "vue";
import { Search, RefreshLeft } from "@element-plus/icons-vue";
import type { Log, SearchForm, PageInfo, HGridPagingInstance } from "./type";
const pagRef = ref<HGridPagingInstance | null>(null);
const { VITE_API_URL } = import.meta.env

const logTypes = [
  {
    code: 0,
    name: "访问日志",
  },
  {
    code: 1,
    name: "审计日志",
  },
  {
    code: 2,
    name: "异常日志",
  },
];

const searchForm = ref<SearchForm>({
  unit: "",
  operator: "",
  account: "",
  logType: "",
  startTime: "",
  endTime: "",
});

const tableLoading = ref(false);

const logList = ref<Log[]>([]);

const pageInfo = ref<PageInfo>({
  total: 0,
  pageSize: 15,
  currentPage: 1,
});

/**
 * 处理每页大小变化
 * @description 当每页显示数量改变时，重置页码并重新查询
 */
const handleSizeChange = () => {
  pageInfo.value.currentPage = 1;
  getLogList();
};

/**
 * 重置搜索条件
 * @description 清空所有搜索条件，重置页码为1，并重新查询
 */
const resetSearch = () => {
  searchForm.value.unit = "";
  searchForm.value.operator = "";
  searchForm.value.account = "";
  searchForm.value.logType = "";
  searchForm.value.startTime = "";
  searchForm.value.endTime = "";
  pageInfo.value.currentPage = 1;
  getLogList();
};

/**
 * 获取日志列表
 * @description 根据当前搜索条件和分页信息查询日志数据
 */
const getLogList = async () => {
  tableLoading.value = true;
  const params = {
    unit: searchForm.value.unit,
    user_name: searchForm.value.operator,
    account: searchForm.value.account,
    log_type: searchForm.value.logType,
    start_time: searchForm.value.startTime,
    end_time: searchForm.value.endTime,
    start: pageInfo.value.currentPage,
    limit: pageInfo.value.pageSize,
  };
  await pagRef.value?.reload(`${VITE_API_URL}/data/SystemAuditLogPage.json`, params);
  tableLoading.value = false;
};

onMounted(() => {
  // getLogList();
});
</script>

<style scoped>
.view-port-box > :deep(.h-panel-body) {
  display: flex;
  flex-direction: column;

  .h-layout-border {
    flex: 1;
  }
}
</style>
