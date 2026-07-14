import { Routes, Route, Navigate } from 'react-router-dom'
import Layout from './components/Layout'
import Workspace from './pages/Workspace'
import EMRViewEdit from './pages/EMRViewEdit'
import Statistics from './pages/Statistics'

function App() {
  return (
    <Routes>
      <Route path="/" element={<Layout />}>
        <Route index element={<Navigate to="/workspace" replace />} />
        <Route path="workspace" element={<Workspace />} />
        <Route path="emr" element={<EMRViewEdit />} />
        <Route path="statistics" element={<Statistics />} />
      </Route>
    </Routes>
  )
}

export default App
