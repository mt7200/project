import { useState } from 'react'
import { useLocation, useNavigate } from 'react-router-dom'
import { Bell, ChevronDown, MessageCircle, Minus, Square, X } from 'lucide-react'

const navItems = [
  { path: '/', label: '工作台', icon: '⊞' },
  { path: '/registration', label: '挂号预约', icon: '⊟' },
  { path: '/outpatient', label: '门诊', icon: '⊡' },
  { path: '/billing', label: '收费', icon: '⊠' },
  { path: '/pharmacy', label: '药房', icon: '⊣' },
  { path: '/execution', label: '执行', icon: '⊢' },
  { path: '/examination', label: '检查', icon: '⊤' },
  { path: '/admin', label: '管理', icon: '⊥' },
  { path: '/mall', label: '商城', icon: '⊧' },
]

export default function TopNavbar() {
  const location = useLocation()
  const navigate = useNavigate()
  const [showUserMenu, setShowUserMenu] = useState(false)

  const currentPath = '/' + location.pathname.split('/')[1]

  return (
    <header className="h-12 bg-[#165DFF] flex items-center px-4 text-white text-sm shrink-0 z-50">
      <div className="flex items-center gap-1.5 mr-6">
        <span className="font-bold text-lg tracking-wider">ABC</span>
        <span className="text-white/60 text-[10px]">基层中医智慧诊疗</span>
      </div>
      <nav className="flex items-center flex-1 gap-0.5">
        {navItems.map((item) => {
          const isActive = currentPath === item.path || (item.path === '/' && currentPath === '/')
          return (
            <button
              key={item.path}
              onClick={() => navigate(item.path)}
              className={`px-4 h-12 flex items-center gap-1.5 text-sm transition-colors relative ${
                isActive ? 'bg-[#4080FF] font-medium' : 'hover:bg-[#4080FF]/70'
              }`}
            >
              <span className="text-base">{item.icon}</span>
              <span>{item.label}</span>
              {isActive && <span className="absolute bottom-0 left-2 right-2 h-0.5 bg-white rounded-full" />}
            </button>
          )
        })}
      </nav>
      <div className="flex items-center gap-2">
        <button className="w-8 h-8 flex items-center justify-center rounded hover:bg-[#4080FF]/70">
          <MessageCircle size={18} />
        </button>
        <button className="w-8 h-8 flex items-center justify-center rounded hover:bg-[#4080FF]/70">
          <Minus size={16} />
        </button>
        <button className="w-8 h-8 flex items-center justify-center rounded hover:bg-[#4080FF]/70">
          <Square size={14} />
        </button>
        <button className="w-8 h-8 flex items-center justify-center rounded hover:bg-[#4080FF]/70">
          <X size={16} />
        </button>
        <div className="relative">
          <button className="w-8 h-8 flex items-center justify-center rounded hover:bg-[#4080FF]/70 relative">
            <Bell size={18} />
            <span className="absolute -top-0.5 -right-0.5 w-4 h-4 bg-[#F53F3F] rounded-full text-[10px] flex items-center justify-center font-medium">3</span>
          </button>
        </div>
        <div className="relative">
          <button
            className="flex items-center gap-1.5 pl-2 pr-1 h-8 rounded hover:bg-[#4080FF]/70"
            onClick={() => setShowUserMenu(!showUserMenu)}
          >
            <div className="w-6 h-6 rounded-full bg-[#FFB020] text-[#1D2129] flex items-center justify-center text-xs font-bold">
              张
            </div>
            <ChevronDown size={14} className="text-white/70" />
          </button>
          {showUserMenu && (
            <div className="absolute top-full right-0 mt-1 bg-white rounded shadow-lg border text-gray-700 py-1 min-w-[160px] z-50">
              <div className="px-3 py-2 text-xs text-gray-400 border-b">张仲景 · 主治医师</div>
              <div className="px-3 py-2 hover:bg-gray-50 cursor-pointer text-sm">个人中心</div>
              <div className="px-3 py-2 hover:bg-gray-50 cursor-pointer text-sm">系统设置</div>
              <div className="px-3 py-2 hover:bg-gray-50 cursor-pointer text-sm text-red-500 border-t">退出登录</div>
            </div>
          )}
        </div>
      </div>
    </header>
  )
}
