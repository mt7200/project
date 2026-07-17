<template>
  <div class="layout">
    <header class="layout-header">
      <div class="header-top">
        <div class="header-brand">
          <span class="header-logo">🏥</span>
          <div>
            <h1 class="header-title">基层中医智慧诊疗系统</h1>
            <span class="header-subtitle">智能诊疗工作台</span>
          </div>
        </div>
        <div class="header-actions">
          <div class="header-doctor">
            <div class="doctor-avatar">张</div>
            <div class="doctor-info">
              <span class="doctor-name">张仲景</span>
              <span class="doctor-title">主治医师</span>
            </div>
          </div>
        </div>
      </div>
      <nav class="header-nav">
        <template v-for="cat in categories" :key="cat.label">
          <router-link
            v-for="menu in cat.menus"
            :key="menu.path"
            :to="menu.path"
            class="header-nav-item"
            :class="{ active: isActive(menu.path) }"
            :style="{ '--cat-color': cat.color }"
          >
            <span class="header-nav-icon" v-html="menu.icon"></span>
            <span>{{ menu.label }}</span>
          </router-link>
        </template>
      </nav>
    </header>
    <div class="layout-body">
      <main class="layout-main">
        <div class="main-content">
          <router-view />
        </div>
      </main>
    </div>
  </div>
</template>

<script setup lang="ts">
import { useRoute } from 'vue-router'

const route = useRoute()

const categories = [
  {
    label: '诊疗工作台',
    color: '#4A90D9',
    menus: [
      {
        path: '/workspace',
        label: '诊疗工作台',
        icon: '<svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><rect x="3" y="3" width="7" height="7" rx="1" /><rect x="14" y="3" width="7" height="7" rx="1" /><rect x="3" y="14" width="7" height="7" rx="1" /><rect x="14" y="14" width="7" height="7" rx="1" /></svg>',
      },
    ],
  },
  {
    label: '病历管理',
    color: '#52C41A',
    menus: [
      {
        path: '/emr',
        label: '电子病历',
        icon: '<svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M14 2H6a2 2 0 0 0-2 2v16a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V8z" /><polyline points="14 2 14 8 20 8" /><line x1="16" y1="13" x2="8" y2="13" /><line x1="16" y1="17" x2="8" y2="17" /><line x1="10" y1="9" x2="8" y2="9" /></svg>',
      },
      {
        path: '/statistics',
        label: '数据统计',
        icon: '<svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><line x1="18" y1="20" x2="18" y2="4" /><line x1="12" y1="20" x2="12" y2="10" /><line x1="6" y1="20" x2="6" y2="14" /></svg>',
      },
    ],
  },
]

function isActive(path: string): boolean {
  return route.path === path
}
</script>

<style scoped>
.layout {
  display: flex;
  flex-direction: column;
  height: 100vh;
  overflow: hidden;
}

.layout-header {
  background: var(--bg-white);
  border-bottom: 1px solid var(--border);
  box-shadow: var(--shadow-sm);
  position: sticky;
  top: 0;
  z-index: 100;
}

.header-top {
  display: flex;
  align-items: center;
  height: 52px;
  padding: 0 20px;
  gap: 16px;
}

.header-brand {
  display: flex;
  align-items: center;
  gap: 10px;
}

.header-logo {
  font-size: 28px;
}

.header-title {
  font-size: 16px;
  font-weight: 600;
  color: var(--text-primary);
  line-height: 1.2;
}

.header-subtitle {
  font-size: 11px;
  color: var(--text-muted);
}

.header-actions {
  margin-left: auto;
  display: flex;
  align-items: center;
  gap: 12px;
}

.header-doctor {
  display: flex;
  align-items: center;
  gap: 10px;
  padding: 4px 12px;
  border-radius: var(--radius);
  cursor: pointer;
  transition: var(--transition);
}

.header-doctor:hover {
  background: var(--bg-page);
}

.doctor-avatar {
  width: 32px;
  height: 32px;
  border-radius: 50%;
  background: var(--primary);
  color: #fff;
  display: flex;
  align-items: center;
  justify-content: center;
  font-size: 13px;
  font-weight: 600;
}

.doctor-info {
  display: flex;
  flex-direction: column;
  line-height: 1.3;
}

.doctor-name {
  font-size: 13px;
  font-weight: 500;
  color: var(--text-primary);
}

.doctor-title {
  font-size: 11px;
  color: var(--text-muted);
}

.header-nav {
  display: flex;
  align-items: center;
  gap: 0;
  padding: 0 20px;
  border-top: 1px solid var(--border-light);
  background: var(--bg-white);
}

.header-nav-item {
  display: flex;
  align-items: center;
  gap: 6px;
  padding: 8px 14px;
  border-radius: var(--radius-sm);
  color: var(--text-secondary);
  font-size: 13px;
  font-weight: 500;
  transition: var(--transition);
  text-decoration: none;
  white-space: nowrap;
}

.header-nav-item:hover {
  background: var(--primary-bg);
  color: var(--primary);
}

.header-nav-item.active {
  background: var(--primary-bg);
  color: var(--primary);
  font-weight: 600;
}

.header-nav-icon {
  display: flex;
  align-items: center;
  justify-content: center;
  width: 18px;
  height: 18px;
  flex-shrink: 0;
}

.layout-body {
  display: flex;
  flex: 1;
  min-height: 0;
  overflow: hidden;
}

.layout-main {
  flex: 1;
  display: flex;
  min-width: 0;
  min-height: 0;
  overflow: hidden;
}

.main-content {
  flex: 1;
  overflow-y: auto;
  display: flex;
  flex-direction: column;
}

@media (max-width: 768px) {
  .header-nav {
    overflow-x: auto;
    -webkit-overflow-scrolling: touch;
  }

  .header-nav-item {
    padding: 6px 10px;
    font-size: 12px;
  }
}
</style>
