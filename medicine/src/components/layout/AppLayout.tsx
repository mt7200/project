import { Outlet } from 'react-router-dom'
import TopNavbar from './TopNavbar'

export default function AppLayout() {
  return (
    <div className="h-screen flex flex-col">
      <TopNavbar />
      <div className="flex flex-1 overflow-hidden">
        <main className="flex-1 overflow-y-auto bg-[#F2F3F5]">
          <Outlet />
        </main>
      </div>
    </div>
  )
}
