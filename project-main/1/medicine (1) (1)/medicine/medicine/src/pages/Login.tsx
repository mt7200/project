import React, { useState } from 'react';
import './Login.css';

const Login: React.FC = () => {
  const [username, setUsername] = useState('');
  const [password, setPassword] = useState('');
  const [rememberMe, setRememberMe] = useState(false);

  const handleSubmit = (e: React.FormEvent) => {
    e.preventDefault();
    console.log('Login:', { username, password, rememberMe });
  };

  return (
    <div className="login-container">
      <div className="login-left">
        <div className="login-brand">
          <div className="brand-logo">
            <svg viewBox="0 0 50 50" className="logo-icon">
              <circle cx="25" cy="25" r="20" fill="#1890ff" opacity="0.2"/>
              <path d="M25 10 L35 25 L25 40 L15 25 Z" fill="#1890ff"/>
              <circle cx="25" cy="25" r="5" fill="#fff"/>
            </svg>
          </div>
          <h1>智能中医诊断系统</h1>
          <p>Traditional Chinese Medicine Intelligent Diagnosis</p>
        </div>
        <div className="login-features">
          <div className="feature-item">
            <span className="feature-icon">◇</span>
            <span>四诊合参 · 精准辨证</span>
          </div>
          <div className="feature-item">
            <span className="feature-icon">◇</span>
            <span>AI辅助 · 智能推荐</span>
          </div>
          <div className="feature-item">
            <span className="feature-icon">◇</span>
            <span>病历管理 · 数据分析</span>
          </div>
        </div>
      </div>

      <div className="login-right">
        <div className="login-card">
          <div className="login-header">
            <h2>用户登录</h2>
            <p>请输入您的账号信息</p>
          </div>

          <form onSubmit={handleSubmit} className="login-form">
            <div className="form-group">
              <label htmlFor="username">用户名 / 手机号</label>
              <div className="input-wrapper">
                <span className="input-icon">👤</span>
                <input
                  type="text"
                  id="username"
                  value={username}
                  onChange={(e) => setUsername(e.target.value)}
                  placeholder="请输入用户名或手机号"
                />
              </div>
            </div>

            <div className="form-group">
              <label htmlFor="password">密码</label>
              <div className="input-wrapper">
                <span className="input-icon">🔒</span>
                <input
                  type="password"
                  id="password"
                  value={password}
                  onChange={(e) => setPassword(e.target.value)}
                  placeholder="请输入密码"
                />
              </div>
            </div>

            <div className="form-options">
              <label className="remember-me">
                <input
                  type="checkbox"
                  checked={rememberMe}
                  onChange={(e) => setRememberMe(e.target.checked)}
                />
                <span>记住我</span>
              </label>
              <a href="#" className="forgot-password">忘记密码？</a>
            </div>

            <button type="submit" className="login-button">
              登 录
            </button>
          </form>

          <div className="login-footer">
            <p>还没有账号？<a href="#">立即注册</a></p>
          </div>
        </div>

        <div className="login-tips">
          <p>演示账号: admin / 123456</p>
        </div>
      </div>
    </div>
  );
};

export default Login;
