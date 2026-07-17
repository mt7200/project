# 基层中医智慧诊疗系统

FastAPI + SQLAlchemy 后端 / Vue 3 + TypeScript 前端。

## 目录结构

```
tcm-medical-system/
├── backend/                 # FastAPI + SQLAlchemy
│   ├── main.py              # 应用入口
│   ├── requirements.txt
│   ├── .env
│   ├── core/                # config / database / security
│   ├── models/              # ORM (15 张表)
│   ├── schemas/             # Pydantic
│   ├── routers/             # API 路由
│   ├── services/            # 业务服务层
│   ├── scripts/             # 数据导入脚本
│   └── utils/
├── src/                     # Vue 3 + TypeScript
│   ├── main.ts
│   ├── App.vue
│   ├── router/              # Vue Router 4
│   ├── store/               # Pinia
│   ├── api/                 # Axios 封装
│   ├── types/
│   ├── components/
│   ├── views/
│   ├── assets/
│   └── utils/
├── vite.config.ts
├── tsconfig.json
└── package.json
```

## 开发

### 前端
```bash
npm install
npm run dev      # http://localhost:3000
```

### 后端
```bash
cd backend
pip install -r requirements.txt
uvicorn main:app --reload --port 8000
```

## 说明

当前为框架骨架阶段，业务逻辑后续填充。前端 API 层通过 Vite 代理 `/api` 到 `http://localhost:8000`。
