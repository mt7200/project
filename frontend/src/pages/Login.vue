<template>
  <div class="login-container">
    <div class="login-left">
      <div class="login-brand">
        <div class="brand-logo">
          <svg viewBox="0 0 50 50" class="logo-icon">
            <circle cx="25" cy="25" r="20" fill="#1890ff" opacity="0.2"/>
            <path d="M25 10 L35 25 L25 40 L15 25 Z" fill="#1890ff"/>
            <circle cx="25" cy="25" r="5" fill="#fff"/>
          </svg>
        </div>
        <h1>智能中医诊断系统</h1>
        <p>Traditional Chinese Medicine Intelligent Diagnosis</p>
      </div>
      <div class="login-features">
        <div class="feature-item">
          <span class="feature-icon">◇</span>
          <span>四诊合参 · 精准辨证</span>
        </div>
        <div class="feature-item">
          <span class="feature-icon">◇</span>
          <span>AI辅助 · 智能推荐</span>
        </div>
        <div class="feature-item">
          <span class="feature-icon">◇</span>
          <span>病历管理 · 数据分析</span>
        </div>
      </div>
    </div>

    <div class="login-right">
      <div class="login-card">
        <div class="login-header">
          <h2>用户登录</h2>
          <p>请输入您的账号信息</p>
        </div>

        <form @submit.prevent="handleSubmit" class="login-form">
          <div v-if="errorMsg" class="login-error">
            <span>⚠ {{ errorMsg }}</span>
          </div>

          <div class="form-group">
            <label for="username">用户名 / 手机号</label>
            <div class="input-wrapper">
              <span class="input-icon">👤</span>
              <input
                type="text"
                id="username"
                v-model="username"
                placeholder="请输入用户名或手机号"
              />
            </div>
          </div>

          <div class="form-group">
            <label for="password">密码</label>
            <div class="input-wrapper">
              <span class="input-icon">🔒</span>
              <input
                type="password"
                id="password"
                v-model="password"
                placeholder="请输入密码"
              />
            </div>
          </div>

          <div class="form-options">
            <label class="remember-me">
              <input type="checkbox" v-model="rememberMe" />
              <span>记住我</span>
            </label>
            <a href="#" class="forgot-password">忘记密码？</a>
          </div>

          <button type="submit" class="login-button" :disabled="loading">
            {{ loading ? '登录中...' : '登 录' }}
          </button>
        </form>

        <div class="login-footer">
          <p>还没有账号？<a href="#">立即注册</a></p>
        </div>
      </div>

      <div class="login-tips">
        <p>演示账号: admin / 123456</p>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref } from 'vue'
import { useRouter } from 'vue-router'
import { useUserStore } from '@/store/modules/user'

const router = useRouter()
const userStore = useUserStore()
const username = ref('')
const password = ref('')
const rememberMe = ref(false)
const errorMsg = ref('')
const loading = ref(false)

const handleSubmit = async () => {
  errorMsg.value = ''
  if (!username.value.trim() || !password.value) {
    errorMsg.value = '请输入用户名和密码'
    return
  }
  loading.value = true
  try {
    await userStore.login({
      username: username.value.trim(),
      password: password.value,
      rememberMe: rememberMe.value,
    })
    router.push('/')
  } catch (e: any) {
    const detail = e?.response?.data?.detail
    if (typeof detail === 'string') {
      errorMsg.value = detail
    } else if (Array.isArray(detail) && detail.length > 0) {
      errorMsg.value = detail.map((d: any) => d?.msg || '').filter(Boolean).join('；')
    } else if (e?.response?.status === 401) {
      errorMsg.value = '用户名或密码错误'
    } else if (e?.message) {
      errorMsg.value = e.message
    } else {
      errorMsg.value = '登录失败，请稍后重试'
    }
  } finally {
    loading.value = false
  }
}
</script>

<style scoped>
.login-container {
  display: flex;
  min-height: 100vh;
  background: linear-gradient(135deg, #e3f2fd 0%, #bbdefb 100%);
}

.login-left {
  flex: 1;
  display: flex;
  flex-direction: column;
  justify-content: center;
  align-items: center;
  padding: 60px;
  background: linear-gradient(135deg, #1890ff 0%, #096dd9 100%);
  color: white;
}

.login-brand {
  text-align: center;
  margin-bottom: 60px;
}

.brand-logo {
  margin-bottom: 30px;
}

.logo-icon {
  width: 100px;
  height: 100px;
}

.brand-logo h1 {
  font-size: 32px;
  font-weight: 600;
  margin-bottom: 10px;
}

.brand-logo p {
  font-size: 14px;
  opacity: 0.8;
  letter-spacing: 1px;
}

.login-features {
  display: flex;
  flex-direction: column;
  gap: 20px;
}

.feature-item {
  display: flex;
  align-items: center;
  gap: 15px;
  font-size: 18px;
  opacity: 0.9;
}

.feature-icon {
  font-size: 12px;
  color: #ffd666;
}

.login-right {
  width: 500px;
  display: flex;
  flex-direction: column;
  justify-content: center;
  align-items: center;
  padding: 40px;
}

.login-card {
  width: 100%;
  max-width: 400px;
  background: white;
  border-radius: 16px;
  padding: 48px 40px;
  box-shadow: 0 10px 40px rgba(0, 0, 0, 0.1);
}

.login-header {
  text-align: center;
  margin-bottom: 40px;
}

.login-header h2 {
  font-size: 28px;
  color: #333;
  margin-bottom: 8px;
}

.login-header p {
  color: #999;
  font-size: 14px;
}

.login-form {
  display: flex;
  flex-direction: column;
  gap: 24px;
}

.login-error {
  padding: 10px 14px;
  background: #fff1f0;
  border: 1px solid #ffa39e;
  border-radius: 8px;
  color: #cf1322;
  font-size: 13px;
}

.form-group {
  display: flex;
  flex-direction: column;
  gap: 8px;
}

.form-group label {
  font-size: 14px;
  color: #666;
  font-weight: 500;
}

.input-wrapper {
  display: flex;
  align-items: center;
  border: 1px solid #e8e8e8;
  border-radius: 8px;
  padding: 0 16px;
  transition: border-color 0.3s;
}

.input-wrapper:focus-within {
  border-color: #1890ff;
}

.input-icon {
  font-size: 18px;
  margin-right: 12px;
}

.input-wrapper input {
  flex: 1;
  border: none;
  outline: none;
  padding: 14px 0;
  font-size: 15px;
  background: transparent;
}

.input-wrapper input::placeholder {
  color: #bbb;
}

.form-options {
  display: flex;
  justify-content: space-between;
  align-items: center;
}

.remember-me {
  display: flex;
  align-items: center;
  gap: 8px;
  cursor: pointer;
  font-size: 14px;
  color: #666;
}

.remember-me input {
  width: 16px;
  height: 16px;
  cursor: pointer;
}

.forgot-password {
  font-size: 14px;
  color: #1890ff;
  text-decoration: none;
}

.forgot-password:hover {
  text-decoration: underline;
}

.login-button {
  width: 100%;
  padding: 14px;
  background: linear-gradient(135deg, #1890ff 0%, #096dd9 100%);
  color: white;
  border: none;
  border-radius: 8px;
  font-size: 16px;
  font-weight: 500;
  cursor: pointer;
  transition: transform 0.2s, box-shadow 0.2s;
}

.login-button:hover {
  transform: translateY(-2px);
  box-shadow: 0 4px 20px rgba(24, 144, 255, 0.4);
}

.login-button:active {
  transform: translateY(0);
}

.login-footer {
  margin-top: 30px;
  text-align: center;
  font-size: 14px;
  color: #999;
}

.login-footer a {
  color: #1890ff;
  text-decoration: none;
}

.login-footer a:hover {
  text-decoration: underline;
}

.login-tips {
  margin-top: 20px;
  padding: 12px 20px;
  background: rgba(24, 144, 255, 0.1);
  border-radius: 8px;
  font-size: 13px;
  color: #1890ff;
}
</style>
