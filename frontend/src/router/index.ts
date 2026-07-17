import { createRouter, createWebHistory } from 'vue-router'
import type { RouteRecordRaw } from 'vue-router'

const routes: RouteRecordRaw[] = [
  {
    path: '/login',
    name: 'Login',
    component: () => import('@/views/Login.vue'),
  },
  {
    path: '/',
    component: () => import('@/components/Layout.vue'),
    children: [
      { path: '', redirect: '/workspace' },
      { path: 'workspace', name: 'Workspace', component: () => import('@/views/Workspace.vue') },
      { path: 'diagnosis-flow', name: 'DiagnosisFlow', component: () => import('@/views/DiagnosisFlow.vue') },
      { path: 'prescription-flow', name: 'PrescriptionFlow', component: () => import('@/views/PrescriptionFlow.vue') },
      { path: 'prescription-review', name: 'PrescriptionReview', component: () => import('@/views/PrescriptionReview.vue') },
      { path: 'emr', name: 'EMRViewEdit', component: () => import('@/views/EMRViewEdit.vue') },
      { path: 'statistics', name: 'Statistics', component: () => import('@/views/Statistics.vue') },
      { path: 'patient-entry', name: 'PatientEntry', component: () => import('@/views/PatientEntry.vue') },
    ],
  },
]

const router = createRouter({
  history: createWebHistory(),
  routes,
})

export default router
