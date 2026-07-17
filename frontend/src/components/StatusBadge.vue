<template>
  <span class="status-badge" :class="type">
    <span v-if="showDot" class="dot" />
    {{ label }}
  </span>
</template>

<script setup lang="ts">
import { computed } from 'vue'

const props = defineProps<{
  status: 'pending' | 'approved' | 'rejected'
  showDot?: boolean
}>()

const typeMap = {
  pending: 'warning',
  approved: 'success',
  rejected: 'danger',
}

const labelMap = {
  pending: '待审',
  approved: '通过',
  rejected: '驳回',
}

const type = computed(() => typeMap[props.status])
const label = computed(() => labelMap[props.status])
</script>

<style scoped>
.status-badge {
  display: inline-flex;
  align-items: center;
  gap: 4px;
  font-size: 12px;
  font-weight: 500;
  padding: 1px 8px;
  border-radius: 100px;
}

.status-badge.warning {
  color: var(--warning);
  background: #FFF8E6;
}

.status-badge.success {
  color: var(--success);
  background: #F0FFF4;
}

.status-badge.danger {
  color: var(--danger);
  background: #FFF0F0;
}

.dot {
  width: 6px;
  height: 6px;
  border-radius: 50%;
  background: currentColor;
}
</style>
