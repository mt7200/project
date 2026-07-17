<script setup lang="ts">
import { ref, watch, nextTick } from 'vue'

interface Message {
  role: 'assistant' | 'user'
  content: string
}

const collapsed = ref(true)
const messages = ref<Message[]>([
  { role: 'assistant', content: '您好！我是AI开方审方助手。您可以向我咨询方剂配伍建议、剂量参考、药物相互作用等问题，我会基于中医药知识库为您提供参考意见。' }
])
const input = ref('')
const suggestions = ref([
  '常见感冒方剂推荐',
  '高血压中药配伍禁忌',
  '儿童用药剂量参考',
  '糖尿病辅助方剂建议'
])
const messagesEndRef = ref<HTMLDivElement | null>(null)

const formatContent = (content: string) =>
  content.replace(/\n/g, '<br/>').replace(/\*\*(.*?)\*\*/g, '<strong>$1</strong>')

watch(messages, () => {
  nextTick(() => {
    messagesEndRef.value?.scrollIntoView({ behavior: 'smooth' })
  })
}, { deep: true })

const handleSend = () => {
  if (!input.value.trim()) return
  const userMsg: Message = { role: 'user', content: input.value }
  messages.value.push(userMsg)
  input.value = ''

  setTimeout(() => {
    const aiMsg: Message = {
      role: 'assistant',
      content: '根据中医理论，建议在辨证论治基础上选用合适方剂。具体配伍需结合患者体质、证型及现有症状综合判断。建议：\n\n1. **主方选择**：根据证候辨证结果确定核心方剂\n2. **加减配伍**：随证加减，注意药物间的相须、相使关系\n3. **剂量把控**：参考《中国药典》规定用量范围\n4. **风险提示**：注意十八反、十九畏等配伍禁忌\n\n请提供更具体的证型信息，我可以给出更精准的建议。'
    }
    messages.value.push(aiMsg)
  }, 800)
}

const toggleCollapsed = () => {
  collapsed.value = !collapsed.value
}

const selectSuggestion = (s: string) => {
  input.value = s
}

const onKeydown = (e: KeyboardEvent) => {
  if (e.key === 'Enter' && !e.shiftKey) {
    e.preventDefault()
    handleSend()
  }
}
</script>

<template>
  <div class="ai-sidebar" :class="{ collapsed: collapsed }">
    <button class="ai-toggle" @click="toggleCollapsed">
      <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
        <template v-if="collapsed">
          <path d="M21 15a2 2 0 0 1-2 2H7l-4 4V5a2 2 0 0 1 2-2h14a2 2 0 0 1 2 2z" />
          <line x1="12" y1="8" x2="12" y2="13" />
          <line x1="10" y1="10.5" x2="14" y2="10.5" />
        </template>
        <template v-else>
          <path d="M21 15a2 2 0 0 1-2 2H7l-4 4V5a2 2 0 0 1 2-2h14a2 2 0 0 1 2 2z" />
          <line x1="9" y1="13" x2="15" y2="5" />
        </template>
      </svg>
      <span v-if="collapsed" class="toggle-label">AI</span>
    </button>
    <template v-if="!collapsed">
      <div class="ai-header">
        <div class="ai-header-left">
          <div class="ai-avatar">
            <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
              <path d="M12 2a4 4 0 0 1 4 4v2a4 4 0 0 1-8 0V6a4 4 0 0 1 4-4z" />
              <path d="M16 14H8" />
              <path d="M12 10v8" />
              <circle cx="12" cy="12" r="10" />
            </svg>
          </div>
          <div>
            <div class="ai-title">AI 开方审方助手</div>
            <div class="ai-status">在线</div>
          </div>
        </div>
        <button class="ai-close" @click="collapsed = true">
          <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
            <line x1="18" y1="6" x2="6" y2="18" />
            <line x1="6" y1="6" x2="18" y2="18" />
          </svg>
        </button>
      </div>
      <div class="ai-messages scrollbar">
        <div
          v-for="(msg, i) in messages"
          :key="i"
          class="ai-msg"
          :class="msg.role"
        >
          <div v-if="msg.role === 'assistant'" class="ai-msg-avatar">
            <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="var(--primary)" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
              <circle cx="12" cy="12" r="10" />
              <path d="M12 16v-4" />
              <path d="M12 8h.01" />
            </svg>
          </div>
          <div class="ai-msg-bubble" v-html="formatContent(msg.content)"></div>
        </div>
        <div ref="messagesEndRef" />
      </div>
      <div class="ai-suggestions">
        <button
          v-for="(s, i) in suggestions"
          :key="i"
          class="ai-suggestion-tag"
          @click="selectSuggestion(s)"
        >
          {{ s }}
        </button>
      </div>
      <div class="ai-input-area">
        <textarea
          class="ai-input scrollbar"
          placeholder="输入您的问题..."
          v-model="input"
          @keydown="onKeydown"
          rows="2"
        ></textarea>
        <button class="ai-send" @click="handleSend" :disabled="!input.trim()">
          <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
            <line x1="22" y1="2" x2="11" y2="13" />
            <polygon points="22 2 15 22 11 13 2 9 22 2" />
          </svg>
        </button>
      </div>
    </template>
  </div>
</template>

<style scoped>
.ai-sidebar {
  position: relative;
  width: 360px;
  min-width: 360px;
  background: var(--bg-white);
  border-left: 1px solid var(--border);
  display: flex;
  flex-direction: column;
  transition: all 0.3s ease;
  overflow: hidden;
}

.ai-sidebar.collapsed {
  width: 48px;
  min-width: 48px;
}

.ai-toggle {
  position: absolute;
  top: 12px;
  left: 12px;
  width: 36px;
  height: 36px;
  display: flex;
  align-items: center;
  justify-content: center;
  background: var(--primary);
  color: #fff;
  border-radius: 50%;
  cursor: pointer;
  z-index: 10;
  transition: var(--transition);
  flex-direction: column;
  gap: 0;
}

.ai-toggle:hover {
  background: var(--primary-dark);
  transform: scale(1.05);
}

.toggle-label {
  font-size: 10px;
  font-weight: 700;
  line-height: 1;
  margin-top: -2px;
}

.ai-header {
  display: flex;
  align-items: center;
  justify-content: space-between;
  padding: 14px 16px;
  border-bottom: 1px solid var(--border-light);
  background: var(--bg-page);
}

.ai-header-left {
  display: flex;
  align-items: center;
  gap: 10px;
}

.ai-avatar {
  width: 36px;
  height: 36px;
  border-radius: 50%;
  background: var(--primary-bg);
  color: var(--primary);
  display: flex;
  align-items: center;
  justify-content: center;
}

.ai-title {
  font-size: 14px;
  font-weight: 600;
  color: var(--text-primary);
}

.ai-status {
  font-size: 11px;
  color: var(--success);
  display: flex;
  align-items: center;
  gap: 4px;
}

.ai-status::before {
  content: '';
  width: 6px;
  height: 6px;
  border-radius: 50%;
  background: var(--success);
}

.ai-close {
  width: 28px;
  height: 28px;
  display: flex;
  align-items: center;
  justify-content: center;
  background: none;
  color: var(--text-muted);
  border-radius: var(--radius-sm);
}

.ai-close:hover {
  background: var(--border-light);
}

.ai-messages {
  flex: 1;
  padding: 12px 16px;
  overflow-y: auto;
  display: flex;
  flex-direction: column;
  gap: 12px;
}

.ai-msg {
  display: flex;
  gap: 8px;
  max-width: 100%;
}

.ai-msg.user {
  justify-content: flex-end;
}

.ai-msg.user .ai-msg-bubble {
  background: var(--primary);
  color: #fff;
  border-radius: 12px 4px 12px 12px;
}

.ai-msg.assistant .ai-msg-bubble {
  background: var(--bg-page);
  color: var(--text-primary);
  border-radius: 4px 12px 12px 12px;
}

.ai-msg-avatar {
  width: 28px;
  height: 28px;
  border-radius: 50%;
  background: var(--primary-bg);
  display: flex;
  align-items: center;
  justify-content: center;
  flex-shrink: 0;
  margin-top: 2px;
}

.ai-msg-bubble {
  padding: 10px 14px;
  font-size: 13px;
  line-height: 1.7;
  max-width: 85%;
}

.ai-msg-bubble strong {
  font-weight: 600;
}

.ai-suggestions {
  padding: 8px 16px;
  display: flex;
  flex-wrap: wrap;
  gap: 6px;
}

.ai-suggestion-tag {
  padding: 4px 10px;
  font-size: 11px;
  color: var(--primary);
  background: var(--primary-bg);
  border: 1px solid transparent;
  border-radius: 100px;
  transition: var(--transition);
}

.ai-suggestion-tag:hover {
  border-color: var(--primary);
  background: #fff;
}

.ai-input-area {
  padding: 10px 16px;
  border-top: 1px solid var(--border-light);
  display: flex;
  gap: 8px;
  align-items: flex-end;
}

.ai-input {
  flex: 1;
  padding: 8px 12px;
  border: 1px solid var(--border);
  border-radius: var(--radius);
  resize: none;
  font-size: 13px;
  line-height: 1.5;
  background: var(--bg-page);
  color: var(--text-primary);
  transition: var(--transition);
}

.ai-input:focus {
  border-color: var(--primary);
  background: var(--bg-white);
  box-shadow: 0 0 0 2px var(--primary-bg);
}

.ai-send {
  width: 36px;
  height: 36px;
  display: flex;
  align-items: center;
  justify-content: center;
  background: var(--primary);
  color: #fff;
  border-radius: var(--radius);
  flex-shrink: 0;
  transition: var(--transition);
}

.ai-send:hover:not(:disabled) {
  background: var(--primary-dark);
}

.ai-send:disabled {
  opacity: 0.4;
  cursor: not-allowed;
}

@media (max-width: 1200px) {
  .ai-sidebar {
    width: 320px;
    min-width: 320px;
  }
}

@media (max-width: 900px) {
  .ai-sidebar {
    position: fixed;
    right: 0;
    top: 56px;
    bottom: 0;
    width: 340px;
    min-width: 340px;
    z-index: 80;
    box-shadow: var(--shadow-lg);
    transition: right 0.3s ease;
  }
  .ai-sidebar.collapsed {
    right: -340px;
    width: 48px;
    min-width: 48px;
  }
  .ai-sidebar.collapsed .ai-toggle {
    left: auto;
    right: 8px;
    top: 8px;
  }
}
</style>
