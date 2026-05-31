import { RouteObject } from 'react-router-dom'
import Layout from './components/Layout.merged'
import IntelligentPrescription from './pages/IntelligentPrescription'
import PrescriptionReview from './pages/PrescriptionReview'
import EMRViewEdit from './pages/EMRViewEdit'
import HistoryRecords from './pages/HistoryRecords'
import Statistics from './pages/Statistics'
import Login from './pages/Login'
import PatientEntry from './pages/PatientEntry'
import Diagnosis from './pages/Diagnosis'

export const routes: RouteObject[] = [
  {
    path: '/login',
    element: <Login />
  },
  {
    path: '/',
    element: <Layout />,
    children: [
      {
        index: true,
        element: <PatientEntry />
      },
      {
        path: 'patient-entry',
        element: <PatientEntry />
      },
      {
        path: 'diagnosis',
        element: <Diagnosis />
      },
      {
        path: 'prescription',
        element: <IntelligentPrescription />
      },
      {
        path: 'review',
        element: <PrescriptionReview />
      },
      {
        path: 'emr',
        element: <EMRViewEdit />
      },
      {
        path: 'history',
        element: <HistoryRecords />
      },
      {
        path: 'statistics',
        element: <Statistics />
      }
    ]
  }
]
