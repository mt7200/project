<script lang="ts" setup>
import { reactive, ref, computed, watch } from 'vue'
import { ElMessage, type FormInstance } from 'element-plus'
import { type User, type DepartmentItem, type RoleItem } from '../../type'
import { insertUser, updateUser } from '../../api'

const props = defineProps<{
    visible: boolean
    title: string
    departmentTree: DepartmentItem[]
    editData?: User | null
}>()

const formRef = ref<FormInstance>()

const emit = defineEmits<{
    (e: 'update:visible', value: boolean): void
    (e: 'success'): void
}>()

const rules = {
    user_name: [
        { required: true, message: '请输入姓名', trigger: 'blur' }
    ],
    account: [
        { required: true, message: '请输入账号', trigger: 'blur' }
    ],
    department_id: [
        { required: true, message: '请选择所属单位', trigger: 'change' }
    ]
}

const treeProps = {
    value: 'id',
    label: 'text',
    children: 'children'
}

const userForm = reactive({
    user_name: '',
    account: '',
    department_id: undefined as number | undefined,
    phone: '',
    remark: '',
    password: '',
    confirmPassword: '',
})

const initForm = () => {
    if (props.editData) {
        userForm.user_name = props.editData.user_name || ''
        userForm.account = props.editData.account || ''
        userForm.department_id =
            props.editData.department_id || undefined
        userForm.phone = props.editData.phone || ''
        userForm.remark = props.editData.remark || ''
        userForm.password = ''
        userForm.confirmPassword = ''
    } else {
        userForm.user_name = ''
        userForm.account = ''
        userForm.department_id = undefined
        userForm.phone = ''
        userForm.remark = ''
        userForm.password = ''
        userForm.confirmPassword = ''
    }
}

watch(
    () => props.visible,
    (val) => {
        if (val) {
            initForm()
        }
    }
)


const handleClose = () => {
    emit('update:visible', false)
}

const handleSave = async () => {
    if (!userForm.user_name) {
        ElMessage.error('请输入姓名')
        return
    }

    if (!userForm.account) {
        ElMessage.error('请输入账号')
        return
    }

    if (!userForm.department_id) {
        ElMessage.error('请选择所属单位')
        return
    }

    try {
        let res
        if (props.editData) {
            if (userForm.password || userForm.confirmPassword) {
                if (userForm.password !== userForm.confirmPassword) {
                    ElMessage.error('两次密码输入不一致')
                    return
                }
            }
            const params: any = {
                user_id: props.editData.user_id,
                user_name: userForm.user_name,
                account: userForm.account,
                department_id: userForm.department_id,
                phone: userForm.phone,
                remark: userForm.remark || ''
            }
            if (userForm.password) {
                params.password = userForm.password
            }

            res = await updateUser(params)
        } else {
            res = await insertUser({
                user_name: userForm.user_name,
                account: userForm.account,
                department_id: userForm.department_id,
                phone: userForm.phone,
                remark: userForm.remark || ''
            })
        }

        if (res) {
            ElMessage.success(props.editData ? '更新成功' : '新增成功')
            emit('success')
            handleClose()
        } else {
            ElMessage.error(props.editData ? '更新失败' : '新增失败')
        }
    } catch (e) {
        ElMessage.error('请求异常')
    }
}
</script>

<template>
    <ss:HDialog :model-value="visible" :title="title" width="520px" @close="handleClose">
        <ss:HForm ref="formRef" :model="userForm" :rules="rules" label-width="80px">

            <ss:HFormItem label="姓名" prop="user_name">
                <ss:HInput v-model="userForm.user_name" placeholder="请输入姓名" />
            </ss:HFormItem>

            <ss:HFormItem label="账号" prop="account">
                <ss:HInput v-model="userForm.account" placeholder="请输入账号" />
            </ss:HFormItem>


            <ss:HFormItem label="密码" v-if="props.editData">
                <ss:HInput v-model="userForm.password" type="password" placeholder="不修改可留空" />
            </ss:HFormItem>
            <ss:HFormItem label="确认密码" v-if="props.editData">
                <ss:HInput v-model="userForm.confirmPassword" type="password" placeholder="不修改可留空" />
            </ss:HFormItem>

            <ss:HFormItem label="所属单位" prop="department_id">
                <ss:HTreeSelect v-model="userForm.department_id" :data="departmentTree" :props="treeProps"
                    placeholder="请选择所属单位" check-strictly clearable style="width: 100%" />
            </ss:HFormItem>

            <ss:HFormItem label="电话">
                <ss:HInput v-model="userForm.phone" placeholder="请输入电话" />
            </ss:HFormItem>

            <ss:HFormItem label="备注">
                <ss:HInput v-model="userForm.remark" placeholder="请输入备注" />
            </ss:HFormItem>

        </ss:HForm>

        <template #footer>
            <ss:HButton @click="handleClose">
                取消
            </ss:HButton>

            <ss:HButton type="primary" @click="handleSave">
                确定
            </ss:HButton>
        </template>
    </ss:HDialog>
</template>

<style scoped>
.department-select-wrapper {
    position: relative;
    width: 100%;
}

.department-tree-dropdown {
    position: absolute;
    top: 100%;
    left: 0;
    right: 0;
    z-index: 100;
    background: #fff;
    border: 1px solid #dcdfe6;
    border-radius: 6px;
    padding: 8px;
}
.el-form-item {
  width: 100%;
}
</style>