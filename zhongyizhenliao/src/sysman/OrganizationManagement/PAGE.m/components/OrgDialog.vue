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
  <ss:HDialog :model-value="modelValue" :title="title" width="520px" @close="handleClose" destroy-on-close>
    <ss:HForm ref="formRef" :model="form" :rules="rules" label-width="90px">
      <ss:HFormItem label="父节点">
        <ss:HTreeSelect v-model="form.belongto" :data="treeData" :props="treeProps" node-key="id" check-strictly clearable
          filterable :disabled="modelType === 'edit'" placeholder="请选择父节点" style="width: 100%;" />
      </ss:HFormItem>

      <ss:HFormItem label="组织名称" prop="text">
        <ss:HInput v-model="form.text" />
      </ss:HFormItem>

      <ss:HFormItem label="电话">
        <ss:HInput v-model="form.tel" />
      </ss:HFormItem>

      <ss:HFormItem label="邮箱">
        <ss:HInput v-model="form.email" />
      </ss:HFormItem>

      <ss:HFormItem label="排序">
        <ss:HInput v-model.number="form.sequence" type="number" />
      </ss:HFormItem>

      <ss:HFormItem label="地址">
        <ss:HInput v-model="form.address" />
      </ss:HFormItem>

      <ss:HFormItem label="备注">
        <ss:HInput v-model="form.memo" />
      </ss:HFormItem>
    </ss:HForm>

    <template #footer>
      <ss:HButton @click="handleClose">取消</ss:HButton>
      <ss:HButton type="primary" @click="handleConfirm">确定</ss:HButton>
    </template>
  </ss:HDialog>
</template>

<style scoped>

.el-form-item {
  width: 100%;
}
</style>