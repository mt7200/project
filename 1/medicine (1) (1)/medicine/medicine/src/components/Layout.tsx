import { useState } from 'react'
import { Outlet, NavLink, useLocation } from 'react-router-dom'
import AISidebar from './AISidebar'
import { workspaceMenus, recordMenus } from '../menus'
import './Layout.css'

export default function Layout() {
  const location = useLocation()

  const categories = [
    { label: '诊疗工作台', menus: workspaceMenus, color: '#4A90D9' },
    { label: '病历管理', menus: recordMenus, color: '#52C41A' },
  ]

  return (
    <div className="layout">
      <header className="layout-header">
        <div className="header-top">
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
        </div>
        <nav className="header-nav">
          {categories.map((cat) =>
            cat.menus.map((menu) => (
              <NavLink
                key={menu.path}
                to={menu.path}
                className={({ isActive }) => `header-nav-item ${isActive ? 'active' : ''}`}
                style={{ '--cat-color': cat.color } as React.CSSProperties}
              >
                <span className="header-nav-icon">{menu.icon}</span>
                <span>{menu.label}</span>
              </NavLink>
            ))
          )}
        </nav>
      </header>
      <div className="layout-body">
        <main className="layout-main">
          <div className="main-content">
            <Outlet />
          </div>
          {!['/statistics', '/login', '/workspace'].includes(location.pathname) && (
            <AISidebar />
          )}
        </main>
      </div>
    </div>
  )
}
