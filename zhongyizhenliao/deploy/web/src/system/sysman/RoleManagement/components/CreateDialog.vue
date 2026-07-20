<script lang="ts" setup>
import { ref, watch, computed } from 'vue'

const props = defineProps({
  visible: {
    type: Boolean,
    default: false
  },
  editData: {
    type: Object,
    default: null
  }
})

const emit = defineEmits(['update:visible', 'confirm'])

const isEdit = computed(() => !!props.editData)

const dialogTitle = computed(() => isEdit.value ? '修改角色' : '新增角色')

const formData = ref({
  roleId: '',
  name: '',
  sort: null,
  remark: ''
})

const rules = {
  roleId: [
    { required: true, message: '请输入角色id', trigger: 'blur' }
  ],
  name: [
    { required: true, message: '请输入名称', trigger: 'blur' }
  ],
  sort: [
    { required: true, message: '请输入排序', trigger: 'blur' }
  ]
}

const formRef = ref()

const handleClose = () => {
  emit('update:visible', false)
}

const handleConfirm = async () => {
  if (!formRef.value) return
  
  try {
    await formRef.value.validate()
    emit('confirm', { ...formData.value, isEdit: isEdit.value })
    handleClose()
  } catch (error) {
    console.log('表单验证失败:', error)
  }
}

const resetForm = () => {
  if (props.editData) {
    formData.value = {
      roleId: props.editData.roleId || '',
      name: props.editData.name || '',
      sort: props.editData.sort || null,
      remark: props.editData.remark || ''
    }
  } else {
    formData.value = {
      roleId: '',
      name: '',
      sort: null,
      remark: ''
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
})
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
      <el-form-item label="角色id" prop="roleId">
        <el-input
          v-model="formData.roleId"
          placeholder="请输入角色id"
          :disabled="isEdit"
          clearable
        />
      </el-form-item>

      <el-form-item label="名称" prop="name">
        <el-input
          v-model="formData.name"
          placeholder="请输入名称"
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
