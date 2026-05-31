import { Routes, Route, Navigate } from 'react-router-dom'
import Layout from './components/Layout'
import IntelligentPrescription from './pages/IntelligentPrescription'
import HerbDosage from './pages/HerbDosage'
import PrescriptionReview from './pages/PrescriptionReview'
import EMRViewEdit from './pages/EMRViewEdit'
import HistoryRecords from './pages/HistoryRecords'
import Statistics from './pages/Statistics'

function App() {
  return (
    <Routes>
      <Route path="/" element={<Layout />}>
        <Route index element={<Navigate to="/prescription" replace />} />
        <Route path="prescription" element={<IntelligentPrescription />} />
        <Route path="herb-dosage" element={<HerbDosage />} />
        <Route path="review" element={<PrescriptionReview />} />
        <Route path="emr" element={<EMRViewEdit />} />
        <Route path="history" element={<HistoryRecords />} />
        <Route path="statistics" element={<Statistics />} />
      </Route>
    </Routes>
  )
}

export default App
