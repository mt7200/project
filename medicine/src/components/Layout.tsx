import { useState } from 'react'
import { Outlet, NavLink, useLocation } from 'react-router-dom'
import AISidebar from './AISidebar'
import './Layout.css'

const memberBMenus = [
  {
    path: '/prescription',
    label: '智能开方',
    icon: (
      <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round">
        <path d="M9 5H7a2 2 0 0 0-2 2v12a2 2 0 0 0 2 2h10a2 2 0 0 0 2-2V7a2 2 0 0 0-2-2h-2" />
        <rect x="9" y="3" width="6" height="4" rx="1" />
        <path d="M12 11v3" />
        <path d="M9 12.5h6" />
      </svg>
    )
  },
  {
    path: '/herb-dosage',
    label: '配伍与剂量',
    icon: (
      <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round">
        <path d="M12 2v4" />
        <path d="M12 18v4" />
        <path d="M4.93 4.93l2.83 2.83" />
        <path d="M16.24 16.24l2.83 2.83" />
        <path d="M2 12h4" />
        <path d="M18 12h4" />
        <path d="M4.93 19.07l2.83-2.83" />
        <path d="M16.24 7.76l2.83-2.83" />
        <circle cx="12" cy="12" r="3" />
      </svg>
    )
  },
  {
    path: '/review',
    label: '处方审核',
    icon: (
      <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round">
        <path d="M9 11l3 3L22 4" />
        <path d="M21 12v7a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2h11" />
      </svg>
    )
  },
  {
    path: '/emr',
    label: '电子病历',
    icon: (
      <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round">
        <path d="M14 2H6a2 2 0 0 0-2 2v16a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V8z" />
        <polyline points="14 2 14 8 20 8" />
        <line x1="16" y1="13" x2="8" y2="13" />
        <line x1="16" y1="17" x2="8" y2="17" />
        <line x1="10" y1="9" x2="8" y2="9" />
      </svg>
    )
  },
  {
    path: '/history',
    label: '历史诊疗',
    icon: (
      <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round">
        <circle cx="12" cy="12" r="10" />
        <polyline points="12 6 12 12 16 14" />
      </svg>
    )
  },
  {
    path: '/statistics',
    label: '数据统计',
    icon: (
      <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round">
        <line x1="18" y1="20" x2="18" y2="4" />
        <line x1="12" y1="20" x2="12" y2="10" />
        <line x1="6" y1="20" x2="6" y2="14" />
      </svg>
    )
  }
]

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
            <span className="header-subtitle">开方审方工作台</span>
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
            <div className="sidebar-label">开方审方</div>
            {memberBMenus.map((menu) => (
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
            <div className="sidebar-label">诊疗辅助</div>
            <NavLink
              to="/prescription"
              className="sidebar-item"
              onClick={(e) => { e.preventDefault(); setSidebarOpen(false) }}
            >
              <span className="sidebar-icon">
                <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round">
                  <path d="M21 15a2 2 0 0 1-2 2H7l-4 4V5a2 2 0 0 1 2-2h14a2 2 0 0 1 2 2z" />
                </svg>
              </span>
              <span>AI 助手</span>
            </NavLink>
          </div>
        </nav>
        {sidebarOpen && <div className="sidebar-overlay" onClick={() => setSidebarOpen(false)} />}
        <main className="layout-main">
          <div className="main-content">
            <Outlet />
          </div>
          {location.pathname !== '/statistics' && (
            <AISidebar />
          )}
        </main>
      </div>
    </div>
  )
}
