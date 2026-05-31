import { useState } from 'react'
import { Outlet, NavLink, useLocation } from 'react-router-dom'
import AISidebar from './AISidebar'
import { diagnosisMenus, prescriptionMenus, recordMenus } from '../menus'
import './Layout.css'

export default function Layout() {
  const [sidebarOpen, setSidebarOpen] = useState(false)
  const location = useLocation()

  return (
    <div className="layout">
      <header className="layout-header">
        <button className="menu-toggle" onClick={() => setSidebarOpen(!sidebarOpen)}>
          <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round">
            <line x1="3" y1="12" x2="21" y2="12" />
            <line x1="3" y1="6" x2="21" y2="6" />
            <line x1="3" y1="18" x2="21" y2="18" />
          </svg>
        </button>
        <div className="header-brand">
          <span className="header-logo">🏥</span>
          <div>
            <h1 className="header-title">基层中医智慧诊疗系统</h1>
            <span className="header-subtitle">智能诊疗工作台</span>
          </div>
        </div>
        <div className="header-actions">
          <div className="header-doctor">
            <div className="doctor-avatar">张</div>
            <div className="doctor-info">
              <span className="doctor-name">张仲景</span>
              <span className="doctor-title">主治医师</span>
            </div>
          </div>
        </div>
      </header>
      <div className="layout-body">
        <nav className={`layout-sidebar ${sidebarOpen ? 'open' : ''}`}>
          <div className="sidebar-section">
            <div className="sidebar-label">诊疗流程</div>
            {diagnosisMenus.map((menu) => (
              <NavLink
                key={menu.path}
                to={menu.path}
                className={({ isActive }) => `sidebar-item ${isActive ? 'active' : ''}`}
                onClick={() => setSidebarOpen(false)}
              >
                <span className="sidebar-icon">{menu.icon}</span>
                <span>{menu.label}</span>
              </NavLink>
            ))}
          </div>
          <div className="sidebar-section">
            <div className="sidebar-label">开方审方</div>
            {prescriptionMenus.map((menu) => (
              <NavLink
                key={menu.path}
                to={menu.path}
                className={({ isActive }) => `sidebar-item ${isActive ? 'active' : ''}`}
                onClick={() => setSidebarOpen(false)}
              >
                <span className="sidebar-icon">{menu.icon}</span>
                <span>{menu.label}</span>
              </NavLink>
            ))}
          </div>
          <div className="sidebar-section">
            <div className="sidebar-label">病历管理</div>
            {recordMenus.map((menu) => (
              <NavLink
                key={menu.path}
                to={menu.path}
                className={({ isActive }) => `sidebar-item ${isActive ? 'active' : ''}`}
                onClick={() => setSidebarOpen(false)}
              >
                <span className="sidebar-icon">{menu.icon}</span>
                <span>{menu.label}</span>
              </NavLink>
            ))}
          </div>
        </nav>
        {sidebarOpen && <div className="sidebar-overlay" onClick={() => setSidebarOpen(false)} />}
        <main className="layout-main">
          <div className="main-content">
            <Outlet />
          </div>
          {location.pathname !== '/statistics' && location.pathname !== '/login' && (
            <AISidebar />
          )}
        </main>
      </div>
    </div>
  )
}
