import { createRouter, createWebHistory } from 'vue-router'
import type { RouteRecordRaw } from 'vue-router'

const routes: RouteRecordRaw[] = [
  {
    path: '/login',
    name: 'Login',
    component: () => import('@/pages/Login.vue'),
  },
  {
    path: '/',
    component: () => import('@/components/Layout.vue'),
    meta: { requiresAuth: true },
    children: [
      { path: '', redirect: '/workspace' },
      { path: 'workspace', name: 'Workspace', component: () => import('@/pages/Workspace.vue') },
      { path: 'diagnosis-flow', name: 'DiagnosisFlow', component: () => import('@/pages/DiagnosisFlow.vue') },
      { path: 'prescription-flow', name: 'PrescriptionFlow', component: () => import('@/pages/PrescriptionFlow.vue') },
      { path: 'prescription-review', name: 'PrescriptionReview', component: () => import('@/pages/PrescriptionReview.vue') },
      { path: 'emr', name: 'EMRViewEdit', component: () => import('@/pages/EMRViewEdit.vue') },
      { path: 'statistics', name: 'Statistics', component: () => import('@/pages/Statistics.vue') },
      { path: 'patient-entry', name: 'PatientEntry', component: () => import('@/pages/PatientEntry.vue') },
    ],
  },
]

const router = createRouter({
  history: createWebHistory(),
  routes,
})

router.beforeEach((to, from, next) => {
  const token = localStorage.getItem('token')
  const requiresAuth = to.meta.requiresAuth

  if (requiresAuth && !token) {
    next('/login')
  } else if (to.path === '/login' && token) {
    next('/')
  } else {
    next()
  }
})

export default router