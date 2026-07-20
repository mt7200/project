<template>
  <el-dialog :title="title" :model-value="visible" width="600px" @close="handleClose">
    <div style="height: 500px; overflow: auto">
      <el-form ref="formRef" :model="formData" :rules="rules" label-width="120px">
        <el-form-item label="父节点" prop="belongto_name">
          <el-tree-select
            :data="menuList"
            v-model="formData.belongto"
            :props="{ label: 'text', children: 'children' }"
            node-key="id"
            :render-after-expand="false"
            clearable
            @node-click="handleNodeClick"
            @clear="handleTreeSelectChange"
          />
        </el-form-item>
        <el-form-item label="模块id" prop="id">
          <el-input v-model="formData.id" clearable disabled />
        </el-form-item>
        <el-form-item label="名称">
          <el-input v-model="formData.text" clearable />
        </el-form-item>
        <el-form-item label="图标">
          <ClIconSelect v-model="formData.iconcls" style="width: 100%" />
        </el-form-item>
        <el-form-item label="权限标识">
          <el-input v-model="formData.resource_name" clearable />
        </el-form-item>
        <el-form-item label="是否显示">
          <el-select v-model="formData.is_hide">
            <el-option label="是" :value="0" />
            <el-option label="否" :value="1" />
          </el-select>
        </el-form-item>
        <el-form-item label="是否为外部链接">
          <el-select v-model="formData.is_link">
            <el-option label="否" :value="0" />
            <el-option label="是" :value="1" />
          </el-select>
        </el-form-item>
        <el-form-item label="权限类型">
          <el-select v-model="formData.resource_type">
            <el-option label="菜单" :value="0" />
            <el-option label="接口" :value="1" />
            <el-option label="按钮" :value="2" />
          </el-select>
        </el-form-item>
        <el-form-item label="排序">
          <el-input-number v-model="formData.sequence" clearable :min="1" />
        </el-form-item>
        <el-form-item :label="resourceTypeDesc" prop="resource_code">
          <el-input v-model="formData.resource_code" clearable />
        </el-form-item>
        <el-form-item label="路径" prop="component_path">
          <el-input v-model="formData.component_path" clearable />
        </el-form-item>
      </el-form>
    </div>

    <template #footer>
      <el-button @click="handleClose">取消</el-button>
      <el-button type="primary" @click="handleSave">保存</el-button>
    </template>
  </el-dialog>
</template>

<script setup lang="ts">
  import { reactive, watch, ref } from 'vue'
  import type { FormData, MenuNode } from '../type'
  import type { FormInstance, FormRules } from 'element-plus'

  interface Props {
    visible: boolean
    title: string
    data?: Partial<FormData>
    menuList: MenuNode[]
  }

  interface Emits {
    (e: 'update:visible', value: boolean): void
    (e: 'save', data: FormData): void
  }

  const props = withDefaults(defineProps<Props>(), {
    visible: false,
    title: '新增菜单',
    data: undefined,
    menuList: () => []
  })

  const emit = defineEmits<Emits>()

  const formRef = ref<FormInstance>()

  const rules = reactive<FormRules>({
    // id: [{ required: true, message: '请输入模块id', trigger: 'blur' }],
    // component_path: [
    //   { required: true, message: "请输入路径url", trigger: "blur" },
    // ],
    // belongto: [{ required: true, message: "请输入父节点", trigger: "blur" }],
    // belongto_name: [{ required: true, message: "请选择父节点", trigger: "blur" }],
    resource_code: [{ required: true, message: '请输入', trigger: 'blur' }]
  })

  const formData = reactive<FormData>({
    id: '',
    belongto: '',
    belongto_name: '',
    component_path: '',
    grade: 1,
    iconcls: '',
    is_hide: 0,
    is_link: 0,
    resource_code: '',
    resource_name: '',
    resource_type: 0,
    sequence: 0,
    text: ''
  })

  const resourceTypeDesc = computed(() => {
    if (formData.resource_type == 0) {
      return '路由'
    }
    if (formData.resource_type == 1) {
      return '接口地址'
    }
    if (formData.resource_type == 2) {
      return '按钮标识'
    }
    return ''
  })

  watch(
    () => props.data,
    (newData) => {
      if (newData) {
        Object.assign(formData, newData)
      }
    },
    { immediate: true }
  )

  const handleTreeSelectChange = () => {
    formData.belongto = ''
    formData.belongto_name = ''
    formData.grade = 1
  }

  const handleNodeClick = (node: MenuNode) => {
    formData.belongto = node.id as string
    formData.belongto_name = node.text
    formData.grade = node.data.grade + 1
  }

  const handleClose = () => {
    emit('update:visible', false)
  }

  const handleSave = async () => {
    if (!formRef.value) return

    await formRef.value.validate((valid) => {
      if (valid) {
        emit('save', { ...formData })
      }
    })
  }
</script>

<style scoped>
  .avatar-uploader {
    border: 1px dashed #d9d9d9;
    border-radius: 6px;
    cursor: pointer;
    position: relative;
    overflow: hidden;
    transition: border-color 0.2s;
  }

  .avatar-uploader:hover {
    border-color: #409eff;
  }

  .avatar-uploader .avatar {
    width: 80px;
    height: 80px;
    display: block;
    object-fit: cover;
  }

  .avatar-uploader .avatar-uploader-icon {
    font-size: 28px;
    color: #8c939d;
    width: 80px;
    height: 80px;
    display: flex;
    align-items: center;
    justify-content: center;
  }
</style>
