<template>
  <div class="art-full-height">
    <el-card class="h-full">
      <!-- 搜索栏 -->
      <div class="flex items-center">
        <el-input clearable placeholder="单位" v-model="searchForm.unit" class="max-w-50 mr-2.5" />
        <!-- <el-input
          clearable
          placeholder="操作人"
          v-model="searchForm.operator"
          class="max-w-50 mr-2.5"
        /> -->
        <el-input
          clearable
          placeholder="账号"
          v-model="searchForm.account"
          class="max-w-50 mr-2.5"
        />
        <el-select
          clearable
          v-model="searchForm.logType"
          placeholder="日志分类"
          class="max-w-50 mr-2.5"
        >
          <el-option v-for="item in logTypes" :key="item.code" :label="item.name" :value="item.code" />
        </el-select>
        <el-date-picker
          v-model="searchForm.startTime"
          type="datetime"
          placeholder="开始时间"
          class="max-w-55 mr-2.5"
          value-format="YYYY-MM-DD HH:mm:ss"
        />
        <el-date-picker
          v-model="searchForm.endTime"
          type="datetime"
          placeholder="结束时间"
          class="max-w-55 mr-2.5"
          value-format="YYYY-MM-DD HH:mm:ss"
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

      <!-- 表格 -->
      <div class="flex-1 h-0 mt-5">
        <el-table :data="logList" height="100%" v-loading="tableLoading">
          <el-table-column prop="log_type" label="日志分类" show-overflow-tooltip>
            <template #default="scope">
              {{ logTypes.find(item => item.code === scope.row.log_type)?.name || '-' }}
            </template>
          </el-table-column>
          <el-table-column prop="unit" label="单位" show-overflow-tooltip />
          <el-table-column prop="ip" label="ip" show-overflow-tooltip />
          <el-table-column prop="content" label="内容" show-overflow-tooltip />
          <el-table-column prop="user_name" label="操作人" show-overflow-tooltip />
          <el-table-column prop="account" label="账号" show-overflow-tooltip />
          <el-table-column prop="create_time" label="操作时间" show-overflow-tooltip />
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
          @update:current-page="handleCurrentChange"
        />
      </div>
    </el-card>
  </div>
</template>

<script setup lang="ts">
  import { ref, onMounted } from 'vue'
  import { Search, RefreshLeft } from '@element-plus/icons-vue'
  import type { Log, SearchForm, PageInfo, GeneralListResponse } from './type'
  // @ts-ignore 在编译后的文件里是正常的
  import dayjs from 'dayjs'
  import api from "@/utils/http"

  const logTypes = [
    {
      code: 0,
      name: '访问日志'
    },
    {
      code: 1,
      name: '审计日志'
    },
    {
      code: 2,
      name: '异常日志'

    }
  ]

  const searchForm = ref<SearchForm>({
    unit: '',
    operator: '',
    account: '',
    logType: '',
    startTime: '',
    endTime: ''
  })

  const tableLoading = ref(false)

  const logList = ref<Log[]>([])

  const pageInfo = ref<PageInfo>({
    total: 0,
    pageSize: 15,
    currentPage: 1
  })

  /**
   * 处理每页大小变化
   * @description 当每页显示数量改变时，重置页码并重新查询
   */
  const handleSizeChange = () => {
    pageInfo.value.currentPage = 1
    getLogList()
  }

  /**
   * 处理页码变化
   * @description 当页码改变时，重新查询对应页的数据
   */
  const handleCurrentChange = () => {
    getLogList()
  }

  /**
   * 重置搜索条件
   * @description 清空所有搜索条件，重置页码为1，并重新查询
   */
  const resetSearch = () => {
    searchForm.value.unit = ''
    searchForm.value.operator = ''
    searchForm.value.account = ''
    searchForm.value.logType = ''
    searchForm.value.startTime = ''
    searchForm.value.endTime = ''
    pageInfo.value.currentPage = 1
    getLogList()
  }

  /**
   * 获取日志列表
   * @description 根据当前搜索条件和分页信息查询日志数据
   */
  const getLogList = async () => {
    tableLoading.value = true
    const res = await api.get<GeneralListResponse<Log>>({
      url: '/data/SystemAuditLogPage.json',
      params: {
        unit: searchForm.value.unit,
        user_name: searchForm.value.operator,
        account: searchForm.value.account,
        log_type: searchForm.value.logType,
        start_time: searchForm.value.startTime,
        end_time: searchForm.value.endTime,
        start: pageInfo.value.currentPage,
        limit: pageInfo.value.pageSize
      }
    })
    tableLoading.value = false
    if (res?.data) {
      logList.value = res.data
      logList.value.forEach(item => {
        if (item.create_time) {
          item.create_time = dayjs(item.create_time).format('YYYY-MM-DD HH:mm:ss')
        }
      })
      pageInfo.value.total = res.count || 0
    }
  }

  onMounted(() => {
    getLogList()
  })
</script>

<style scoped>
  :deep(.el-card__body) {
    height: 100%;
    display: flex;
    flex-direction: column;
  }
</style>
