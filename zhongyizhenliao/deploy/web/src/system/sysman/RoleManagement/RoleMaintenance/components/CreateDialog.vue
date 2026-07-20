<script lang="ts" setup>
import { ref, watch, computed } from 'vue'
import type { Role } from '../type'

const props = defineProps({
  visible: {
    type: Boolean,
    default: false
  },
  editData: {
    type: Object as () => Role | null,
    default: null
  }
})

const emit = defineEmits(['update:visible', 'confirm'])

const isEdit = computed(() => !!props.editData)

const dialogTitle = computed(() => isEdit.value ? '修改角色' : '新增角色')

const formData = ref({
  role_name: '',
  sort: 1,
  remark: '',
  role_code: '',
  description: ''
})

const rules = {
  role_name: [
    { required: true, message: '请输入名称', trigger: 'blur' }
  ],
  role_code: [
    { required: true, message: '请输入角色code', trigger: 'blur' }
  ],
}

const formRef = ref()

const handleClose = () => {
  emit('update:visible', false)
}

const handleConfirm = async () => {
  if (!formRef.value) return
  
  try {
    await formRef.value.validate()
    emit('confirm', { ...formData.value }, isEdit.value)
    handleClose()
  } catch (error) {
    console.log('表单验证失败:', error)
  }
}

const resetForm = () => {
  if (props.editData) {
    formData.value = {
      ...props.editData
    }
  } else {
    formData.value = {
      role_name: '',
      sort: 1,
      remark: '',
      role_code: '',
      description: ''
    }
  }
  if (formRef.value) {
    formRef.value.clearValidate()
  }
}

watch(() => props.visible, (newVal) => {
  if (newVal) {
    resetForm()
  }
}, { immediate: true })
</script>

<template>
  <el-dialog
    :model-value="visible"
    @update:model-value="handleClose"
    :title="dialogTitle"
    width="600px"
    :close-on-click-modal="false"
    :close-on-press-escape="false"
  >
    <el-form
      ref="formRef"
      :model="formData"
      :rules="rules"
      label-width="100px"
      label-position="right"
    >
      <el-form-item label="名称" prop="role_name">
        <el-input
          v-model="formData.role_name"
          clearable
        />
      </el-form-item>

      <el-form-item label="角色code" prop="role_code">
        <el-input
          v-model="formData.role_code"
          clearable
        />
      </el-form-item>

      <el-form-item label="描述" prop="description">
        <el-input
          v-model="formData.description"
          clearable
        />
      </el-form-item>

      <el-form-item label="排序" prop="sort">
        <el-input-number
          v-model="formData.sort"
          :min="1"
          placeholder="请输入排序"
          style="width: 100%"
        />
      </el-form-item>

      <el-form-item label="备注" prop="remark">
        <el-input
          v-model="formData.remark"
          type="textarea"
          :rows="4"
          placeholder="请输入备注"
          clearable
        />
      </el-form-item>
    </el-form>

    <template #footer>
      <el-button @click="handleClose">取消</el-button>
      <el-button type="primary" @click="handleConfirm">确定</el-button>
    </template>
  </el-dialog>
</template>

<style scoped>
:deep(.el-dialog__body) {
  padding: 20px 30px;
}
</style>
