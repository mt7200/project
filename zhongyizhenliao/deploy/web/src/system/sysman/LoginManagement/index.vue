<!-- 登录页面 -->
<template>
  <div class="flex w-full h-screen">
    <div class="w-[65vw] hidden md:block">
      <LoginLeftView />
    </div>
  <div class="divider"></div>
    <div class="w-full md:w-[35vw] relative">
      <!-- <AuthTopBar /> -->

      <div class="auth-right-wrap">
        <div class="form">
          <h3 class="title">{{ $t('login.title') }}</h3>
          <p class="sub-title">{{ $t('login.subTitle') }}</p>
          <ElForm ref="formRef" :model="formData" :rules="rules" :key="formKey" @keyup.enter="handleSubmit"
            style="margin-top: 25px">
            <ElFormItem prop="username">
              <ElInput class="custom-height" :placeholder="$t('login.placeholder.username')"
                v-model.trim="formData.username" />
            </ElFormItem>
            <ElFormItem prop="password">
              <ElInput class="custom-height" :placeholder="$t('login.placeholder.password')"
                v-model.trim="formData.password" type="password" autocomplete="off" show-password />
            </ElFormItem>
            
                        <!-- 推拽验证 -->
            <div class="relative pb-5 mt-6">
              <div
                class="relative z-[2] overflow-hidden select-none rounded-lg border border-transparent tad-300"
                :class="{ '!border-[#FF4E4F]': !isPassing && isClickPass }"
              >
                <ArtDragVerify
                  ref="dragVerify"
                  v-model:value="isPassing"
                  :text="$t('login.sliderText')"
                  textColor="var(--art-gray-700)"
                  :successText="$t('login.sliderSuccessText')"
                  :progressBarBg="getCssVar('--el-color-primary')"
                  :background="isDark ? '#26272F' : '#F1F1F4'"
                  handlerBg="var(--default-box-color)"
                />
              </div>
              <p
                class="absolute top-0 z-[1] px-px mt-2 text-xs text-[#f56c6c] tad-300"
                :class="{ 'translate-y-10': !isPassing && isClickPass }"
              >
                {{ $t('login.placeholder.slider') }}
              </p>
            </div>

            <div class="flex-cb mt-2 text-sm">
              <ElCheckbox v-model="formData.rememberPassword">{{
                $t('login.rememberPwd')
              }}</ElCheckbox>
            </div>

            <div style="margin-top: 30px">
              <ElButton class="w-full custom-height" type="primary" @click="handleSubmit" :loading="loading" v-ripple>
                {{ $t('login.btnText') }}
              </ElButton>
            </div>

          </ElForm>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import AppConfig from '@/config'
import { useUserStore } from '@/store/modules/user'
import { getCssVar } from '@/utils/ui'
import { useI18n } from 'vue-i18n'
import { HttpError } from '@/utils/http/error'
import { fetchLogin } from '@/api/auth'
import { ElNotification, type FormInstance, type FormRules } from 'element-plus'
import { useSettingStore } from '@/store/modules/setting'
import LoginLeftView from './components/LoginLeftView.vue'

defineOptions({ name: 'Login' })

const settingStore = useSettingStore()
const { isDark } = storeToRefs(settingStore)
const { t, locale } = useI18n()
const formKey = ref(0)

// 监听语言切换，重置表单
watch(locale, () => {
  formKey.value++
})

type AccountKey = 'super' | 'admin' | 'user'

export interface Account {
  key: AccountKey
  label: string
  userName: string
  password: string
  roles: string[]
}

const accounts = computed<Account[]>(() => [
  {
    key: 'super',
    label: t('login.roles.super'),
    userName: 'super',
    password: '100200',
    roles: ['R_SUPER']
  },
  {
    key: 'admin',
    label: t('login.roles.admin'),
    userName: 'admin',
    password: '100200',
    roles: ['R_ADMIN']
  },
  {
    key: 'user',
    label: t('login.roles.user'),
    userName: 'user',
    password: '100200',
    roles: ['R_USER']
  }
])

const dragVerify = ref()

const userStore = useUserStore()
const router = useRouter()
const route = useRoute()
  const isPassing = ref(false)
const isClickPass = ref(false)

const systemName = AppConfig.systemInfo.name
const formRef = ref<FormInstance>()

const formData = reactive({
  account: '',
  username: '',
  password: '',
  rememberPassword: true
})

const rules = computed<FormRules>(() => ({
  username: [{ required: true, message: t('login.placeholder.username'), trigger: 'blur' }],
  password: [{ required: true, message: t('login.placeholder.password'), trigger: 'blur' }]
}))

const loading = ref(false)

onMounted(() => {
  setupAccount('admin')
})

// 设置账号
const setupAccount = (key: AccountKey) => {
  const selectedAccount = accounts.value.find((account: Account) => account.key === key)
  formData.account = key
  formData.username = selectedAccount?.userName ?? ''
  formData.password = selectedAccount?.password ?? ''
}

// 登录
const handleSubmit = async () => {
  if (!formRef.value) return

  try {
    // 表单验证
    const valid = await formRef.value.validate()
    if (!valid) return

     // 拖拽验证
      if (!isPassing.value) {
        isClickPass.value = true
        return
      }
      
    loading.value = true

    // 登录请求
    const { username, password } = formData

    const { token, refreshToken } = await fetchLogin({
      userName: username,
      password
    })

    // 验证token
    if (!token) {
      throw new Error('Login failed - no token received')
    }

    // 存储 token 和登录状态
    userStore.setToken(token, refreshToken)
    userStore.setLoginStatus(true)

    // 登录成功处理
    showLoginSuccessNotice()

    // 获取 redirect 参数，如果存在则跳转到指定页面，否则跳转到首页
    const redirect = route.query.redirect as string
    router.push(redirect || '/')
  } catch (error) {
    // 处理 HttpError
    if (error instanceof HttpError) {
      // console.log(error.code)
    } else {
      // 处理非 HttpError
      // ElMessage.error('登录失败，请稍后重试')
      console.error('[Login] Unexpected error:', error)
    }
  } finally {
    loading.value = false
    resetDragVerify()
  }
}

// 重置拖拽验证
const resetDragVerify = () => {
  dragVerify.value.reset()
}

// 登录成功提示
const showLoginSuccessNotice = () => {
  setTimeout(() => {
    ElNotification({
      title: t('login.success.title'),
      type: 'success',
      duration: 2500,
      zIndex: 10000,
      message: `${t('login.success.message')}, ${systemName}!`
    })
  }, 1000)
}
</script>

<style lang="scss" scoped>
.auth-right-wrap {
  position: absolute;
  inset: 0;
  width: 440px;
  height: 650px;
  margin: auto;
  padding-top: 5px;
  overflow: hidden;
  animation: slideInRight 0.6s cubic-bezier(0.25, 0.46, 0.45, 0.94) forwards;
}

.form {
  height: 100%;
  padding: 40px 0;
}

.title {
  font-size: 2.5rem;
  font-weight: 600;
  color: var(--el-text-color-primary);
}

.sub-title {
  margin-top: 10px;
  color: var(--el-text-color-secondary);
  font-size: 0.875rem;
}

.custom-height {
  height: 40px !important;
}

:deep(.el-select__wrapper) {
  height: 40px !important;
}

@media (max-width: 768px) {
  .auth-right-wrap {
    position: relative;
    width: 100%;
    height: auto;
    padding: 0 1.75rem;
    animation: none;
  }

  .title {
    font-size: 1.875rem;
  }
}

@keyframes slideInRight {
  from {
    opacity: 0;
    transform: translateX(30px);
  }

  to {
    opacity: 1;
    transform: translateX(0);
  }
}
</style>
