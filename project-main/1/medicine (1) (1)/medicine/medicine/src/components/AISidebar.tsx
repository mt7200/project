import { useState, useRef, useEffect } from 'react'
import './AISidebar.css'

interface Message {
  role: 'assistant' | 'user'
  content: string
}

export default function AISidebar() {
  const [collapsed, setCollapsed] = useState(true)
  const [messages, setMessages] = useState<Message[]>([
    { role: 'assistant', content: '您好！我是AI开方审方助手。您可以向我咨询方剂配伍建议、剂量参考、药物相互作用等问题，我会基于中医药知识库为您提供参考意见。' }
  ])
  const [input, setInput] = useState('')
  const [suggestions] = useState([
    '常见感冒方剂推荐',
    '高血压中药配伍禁忌',
    '儿童用药剂量参考',
    '糖尿病辅助方剂建议'
  ])
  const messagesEndRef = useRef<HTMLDivElement>(null)

  useEffect(() => {
    messagesEndRef.current?.scrollIntoView({ behavior: 'smooth' })
  }, [messages])

  const handleSend = () => {
    if (!input.trim()) return
    const userMsg: Message = { role: 'user', content: input }
    setMessages((prev) => [...prev, userMsg])
    setInput('')

    setTimeout(() => {
      const aiMsg: Message = {
        role: 'assistant',
        content: '根据中医理论，建议在辨证论治基础上选用合适方剂。具体配伍需结合患者体质、证型及现有症状综合判断。建议：\n\n1. **主方选择**：根据证候辨证结果确定核心方剂\n2. **加减配伍**：随证加减，注意药物间的相须、相使关系\n3. **剂量把控**：参考《中国药典》规定用量范围\n4. **风险提示**：注意十八反、十九畏等配伍禁忌\n\n请提供更具体的证型信息，我可以给出更精准的建议。'
      }
      setMessages((prev) => [...prev, aiMsg])
    }, 800)
  }

  return (
    <div className={`ai-sidebar ${collapsed ? 'collapsed' : ''}`}>
      <button className="ai-toggle" onClick={() => setCollapsed(!collapsed)}>
        <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round">
          {collapsed ? (
            <>
              <path d="M21 15a2 2 0 0 1-2 2H7l-4 4V5a2 2 0 0 1 2-2h14a2 2 0 0 1 2 2z" />
              <line x1="12" y1="8" x2="12" y2="13" />
              <line x1="10" y1="10.5" x2="14" y2="10.5" />
            </>
          ) : (
            <>
              <path d="M21 15a2 2 0 0 1-2 2H7l-4 4V5a2 2 0 0 1 2-2h14a2 2 0 0 1 2 2z" />
              <line x1="9" y1="13" x2="15" y2="5" />
            </>
          )}
        </svg>
        {collapsed && <span className="toggle-label">AI</span>}
      </button>
      {!collapsed && (
        <>
          <div className="ai-header">
            <div className="ai-header-left">
              <div className="ai-avatar">
                <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round">
                  <path d="M12 2a4 4 0 0 1 4 4v2a4 4 0 0 1-8 0V6a4 4 0 0 1 4-4z" />
                  <path d="M16 14H8" />
                  <path d="M12 10v8" />
                  <circle cx="12" cy="12" r="10" />
                </svg>
              </div>
              <div>
                <div className="ai-title">AI 开方审方助手</div>
                <div className="ai-status">在线</div>
              </div>
            </div>
            <button className="ai-close" onClick={() => setCollapsed(true)}>
              <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round">
                <line x1="18" y1="6" x2="6" y2="18" />
                <line x1="6" y1="6" x2="18" y2="18" />
              </svg>
            </button>
          </div>
          <div className="ai-messages scrollbar">
            {messages.map((msg, i) => (
              <div key={i} className={`ai-msg ${msg.role}`}>
                {msg.role === 'assistant' && (
                  <div className="ai-msg-avatar">
                    <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="var(--primary)" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round">
                      <circle cx="12" cy="12" r="10" />
                      <path d="M12 16v-4" />
                      <path d="M12 8h.01" />
                    </svg>
                  </div>
                )}
                <div
                  className="ai-msg-bubble"
                  dangerouslySetInnerHTML={{
                    __html: msg.content.replace(/\n/g, '<br/>').replace(/\*\*(.*?)\*\*/g, '<strong>$1</strong>')
                  }}
                />
              </div>
            ))}
            <div ref={messagesEndRef} />
          </div>
          <div className="ai-suggestions">
            {suggestions.map((s, i) => (
              <button key={i} className="ai-suggestion-tag" onClick={() => setInput(s)}>
                {s}
              </button>
            ))}
          </div>
          <div className="ai-input-area">
            <textarea
              className="ai-input scrollbar"
              placeholder="输入您的问题..."
              value={input}
              onChange={(e) => setInput(e.target.value)}
              onKeyDown={(e) => {
                if (e.key === 'Enter' && !e.shiftKey) {
                  e.preventDefault()
                  handleSend()
                }
              }}
              rows={2}
            />
            <button className="ai-send" onClick={handleSend} disabled={!input.trim()}>
              <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round">
                <line x1="22" y1="2" x2="11" y2="13" />
                <polygon points="22 2 15 22 11 13 2 9 22 2" />
              </svg>
            </button>
          </div>
        </>
      )}
    </div>
  )
}
