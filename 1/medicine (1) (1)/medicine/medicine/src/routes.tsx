import { RouteObject } from 'react-router-dom'
import Layout from './components/Layout'
import DiagnosisFlow from './pages/DiagnosisFlow'
import PrescriptionFlow from './pages/PrescriptionFlow'
import EMRViewEdit from './pages/EMRViewEdit'
import HistoryRecords from './pages/HistoryRecords'
import Statistics from './pages/Statistics'
import Login from './pages/Login'

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
        element: <DiagnosisFlow />
      },
      {
        path: 'diagnosis-flow',
        element: <DiagnosisFlow />
      },
      {
        path: 'prescription-flow',
        element: <PrescriptionFlow />
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
