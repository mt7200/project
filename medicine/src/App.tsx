import { Routes, Route, Navigate } from 'react-router-dom'
import AppLayout from './components/layout/AppLayout'
import DashboardPage from './pages/Dashboard'
import RegistrationPage from './pages/Registration'
import OutpatientPage from './pages/Outpatient'
import BillingPage from './pages/Billing'
import ExecutionPage from './pages/Execution'
import AdminPage from './pages/Admin'

export default function App() {
  return (
    <Routes>
      <Route path="/" element={<AppLayout />}>
        <Route index element={<DashboardPage />} />
        <Route path="registration" element={<RegistrationPage />} />
        <Route path="outpatient" element={<OutpatientPage />} />
        <Route path="billing" element={<BillingPage />} />
        <Route path="execution" element={<ExecutionPage />} />
        <Route path="admin" element={<AdminPage />} />
        <Route path="*" element={<Navigate to="/" replace />} />
      </Route>
    </Routes>
  )
}
