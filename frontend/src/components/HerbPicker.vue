<template>
  <div class="herb-picker">
    <input
      class="herb-search"
      v-model="searchText"
      placeholder="搜索药名、类别、功效..."
    />
    <div class="herb-list scrollbar">
      <div
        v-for="herb in filteredHerbs"
        :key="herb.id"
        class="herb-item"
        :class="{ selected: isSelected(herb.id) }"
        @click="$emit('select', herb)"
      >
        <div class="herb-info">
          <span class="herb-name">{{ herb.name }}</span>
          <span class="herb-nature">{{ herb.nature }}，{{ herb.taste }} · 归 {{ herb.meridian }}</span>
        </div>
        <span class="herb-dosage">{{ herb.minDosage }}-{{ herb.maxDosage }}{{ herb.unit }}</span>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref, computed } from 'vue'
import type { Herb } from '@/types/herb'

const props = defineProps<{
  herbs: Herb[]
  selectedIds: number[]
}>()

defineEmits<{
  select: [herb: Herb]
}>()

const searchText = ref('')

const filteredHerbs = computed(() => {
  const t = searchText.value.toLowerCase()
  return props.herbs.filter(h =>
    h.name.includes(t) || h.category.includes(t) || h.functions.some(f => f.includes(t))
  )
})

function isSelected(id: number): boolean {
  return props.selectedIds.includes(id)
}
</script>

<style scoped>
.herb-picker {
  display: flex;
  flex-direction: column;
  gap: 4px;
}

.herb-search {
  width: 100%;
  padding: 4px 8px;
  border: 1px solid var(--border);
  border-radius: 5px;
  font-size: 11px;
}

.herb-search:focus {
  outline: none;
  border-color: var(--primary);
}

.herb-list {
  max-height: 200px;
  overflow-y: auto;
  display: flex;
  flex-direction: column;
  gap: 2px;
}

.herb-item {
  display: flex;
  align-items: center;
  justify-content: space-between;
  padding: 6px 10px;
  border-radius: var(--radius-sm);
  cursor: pointer;
  transition: var(--transition);
  border: 1px solid transparent;
}

.herb-item:hover {
  background: var(--primary-bg);
  border-color: var(--primary-light);
}

.herb-item.selected {
  background: var(--primary-bg);
  border-color: var(--primary);
}

.herb-info {
  display: flex;
  flex-direction: column;
  gap: 1px;
}

.herb-name {
  font-size: 13px;
  font-weight: 500;
  color: var(--text-primary);
}

.herb-nature {
  font-size: 10px;
  color: var(--text-muted);
}

.herb-dosage {
  font-size: 10px;
  color: var(--primary);
  white-space: nowrap;
}
</style>
