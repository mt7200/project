<script lang="ts" setup>
import { reactive, watch } from 'vue'
import { ElDialog, ElForm, ElFormItem, ElInput, ElButton, ElTreeSelect } from 'element-plus'
import { type DepartmentItem } from '../type';

const props = defineProps<{
  modelValue: boolean
  modelType: string
  title: string
  formData: DepartmentItem
  treeData: DepartmentItem[]
  loading?: boolean
}>()

const treeProps = {
  children: 'children',
  label: 'text'
}

const emit = defineEmits<{
  (e: 'update:modelValue', val: boolean): void
  (e: 'confirm', val: DepartmentItem): void
}>()

const form = reactive<DepartmentItem>({
  belongto: null,
  text: '',
  tel: '',
  email: '',
  sequence: 1,
  address: '',
  memo: ''
})

watch(
  () => props.formData,
  (val) => {
    Object.assign(form, val)
  },
  { immediate: true, deep: true }
)

const handleClose = () => {
  emit('update:modelValue', false)
}

const formRef = ref()

const handleConfirm = () => {
  formRef.value.validate((valid: any) => {
    if (!valid) return
    emit('confirm', { ...form })
  })
}

const rules = {
  text: [
    { required: true, message: '请输入组织名称', trigger: 'blur' }
  ]
}
</script>

<template>
  <ElDialog :model-value="modelValue" :title="title" width="520px" @close="handleClose" destroy-on-close>
    <ElForm ref="formRef" :model="form" :rules="rules" label-width="90px">
      <ElFormItem label="父节点">
        <ElTreeSelect v-model="form.belongto" :data="treeData" :props="treeProps" node-key="id" check-strictly clearable
          filterable :disabled="modelType === 'edit'" placeholder="请选择父节点" style="width: 100%;" />
      </ElFormItem>

      <ElFormItem label="组织名称" prop="text">
        <ElInput v-model="form.text" />
      </ElFormItem>

      <ElFormItem label="电话">
        <ElInput v-model="form.tel" />
      </ElFormItem>

      <ElFormItem label="邮箱">
        <ElInput v-model="form.email" />
      </ElFormItem>

      <ElFormItem label="排序">
        <ElInput v-model.number="form.sequence" type="number" />
      </ElFormItem>

      <ElFormItem label="地址">
        <ElInput v-model="form.address" />
      </ElFormItem>

      <ElFormItem label="备注">
        <ElInput v-model="form.memo" />
      </ElFormItem>
    </ElForm>

    <template #footer>
      <ElButton @click="handleClose">取消</ElButton>
      <ElButton type="primary" @click="handleConfirm">确定</ElButton>
    </template>
  </ElDialog>
</template>