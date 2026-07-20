<template>
  <ss:HDialog
    :title="dialogTitle"
    :model-value="visible"
    width="800px"
    @close="handleClose"
  >
    <ss:HForm
      ref="formRef"
      :model="formData"
      :rules="rules"
      label-position="right"
    >
      <ss:HRow>
        <ss:HCol :span="12">
          <ss:HTextField
            v-model="formData.role_name"
            label="名称"
            prop="role_name"
            required
            label-width="100px"
            class="!w-full"
          />
        </ss:HCol>
        <ss:HCol :span="12">
          <ss:HTextField
            v-model="formData.role_code"
            label="角色code"
            prop="role_code"
            required
            label-width="100px"
            class="!w-full"
          />
        </ss:HCol>
        <ss:HCol :span="12">
          <ss:HTextField
            v-model="formData.description"
            label="描述"
            label-width="100px"
            class="!w-full"
          />
        </ss:HCol>
        <ss:HCol :span="12">
          <ss:HNumberField
            label="排序"
            label-width="100px"
            prop="sort"
            class="!w-full"
            :min="1"
            v-model="formData.sort"
          />
        </ss:HCol>
        <ss:HCol :span="12">
          <ss:HTextField
            v-model="formData.remark"
            type="textarea"
            :auto-size="{ minRows: 2, maxRows: 4 }"
            label="备注"
            label-width="100px"
            class="!w-full"
            clearable
          />
        </ss:HCol>
      </ss:HRow>
    </ss:HForm>

    <template #footer>
      <ss:HButton @click="handleClose">取消</ss:HButton>
      <ss:HButton type="primary" @click="handleConfirm">确定</ss:HButton>
    </template>
  </ss:HDialog>
</template>

<script setup lang="ts">
import { ref, watch, computed } from "vue";
import type { Role } from "../type";
import type { FormInstance } from "element-plus";

interface Props {
  visible: boolean;
  editData: Role | null;
}

const props = withDefaults(defineProps<Props>(), {
  visible: false,
  editData: null,
});

const emit = defineEmits(["update:visible", "confirm"]);

const isEdit = computed(() => !!props.editData);

const dialogTitle = computed(() => (isEdit.value ? "修改角色" : "新增角色"));

const formData = ref({
  role_name: "",
  sort: 1,
  remark: "",
  role_code: "",
  description: "",
});

const rules = {
  role_name: [{ required: true, message: "请输入名称", trigger: "blur" }],
  role_code: [{ required: true, message: "请输入角色code", trigger: "blur" }],
};

const formRef = ref<FormInstance>();

const handleClose = () => {
  emit("update:visible", false);
};

const handleConfirm = async () => {
  if (!formRef.value) return;

  try {
    await formRef.value.validate();
    emit("confirm", { ...formData.value }, isEdit.value);
    handleClose();
  } catch (error) {
    console.log("表单验证失败:", error);
  }
};

const resetForm = () => {
  if (props.editData) {
    formData.value = {
      ...props.editData,
    };
  } else {
    formData.value = {
      role_name: "",
      sort: 1,
      remark: "",
      role_code: "",
      description: "",
    };
  }
  if (formRef.value) {
    formRef.value.clearValidate();
  }
};

watch(
  () => props.visible,
  (newVal) => {
    if (newVal) {
      resetForm();
    }
  },
  { immediate: true }
);
</script>

<style scoped>
.el-form-item {
  width: 100%;
}
</style>