<template>
  <div class="tag-selector">
    <div v-for="section in sections" :key="section.label" class="tag-section">
      <span class="tag-section-label">{{ section.label }}</span>
      <div class="tag-list">
        <span
          v-for="tag in section.tags"
          :key="tag"
          class="tag-item"
          :class="{ selected: selected.includes(tag) }"
          @click="toggleTag(tag)"
        >{{ tag }}</span>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
interface TagSection {
  label: string
  tags: string[]
}

const props = defineProps<{
  sections: TagSection[]
  selected: string[]
}>()

const emit = defineEmits<{
  'update:selected': [tags: string[]]
  select: [tag: string]
}>()

function toggleTag(tag: string) {
  emit('select', tag)
}
</script>

<style scoped>
.tag-selector {
  display: flex;
  flex-direction: column;
  gap: 6px;
}

.tag-section {
  display: flex;
  flex-direction: column;
  gap: 3px;
}

.tag-section-label {
  font-size: 10px;
  font-weight: 600;
  color: var(--text-secondary);
}

.tag-list {
  display: flex;
  flex-wrap: wrap;
  gap: 3px;
}

.tag-item {
  padding: 2px 7px;
  border-radius: 100px;
  font-size: 10px;
  background: var(--bg-page);
  color: var(--text-primary);
  border: 1px solid var(--border-light);
  cursor: pointer;
  transition: all 0.15s;
  user-select: none;
}

.tag-item:hover {
  background: var(--primary-bg);
  border-color: var(--primary);
  color: var(--primary);
}

.tag-item.selected {
  background: var(--primary);
  border-color: var(--primary);
  color: #fff;
}
</style>
