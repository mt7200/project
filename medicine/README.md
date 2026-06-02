# ABC 基层中医智慧诊疗系统

基于 React 18 + TypeScript + Tailwind CSS v3 构建的医疗门诊管理系统前端。

## 截图参考

UI 设计参照 ABC 门诊管理系统，1:1 还原了核心功能页面的视觉风格和交互逻辑。

## 技术栈

- **框架**: React 18 + TypeScript
- **构建工具**: Vite 8
- **样式方案**: Tailwind CSS v3 + CSS Variables
- **图标库**: Lucide React
- **路由**: React Router v6
- **组件基础**: Radix UI Primitives

## 目录结构

```
src/
├── components/
│   ├── layout/
│   │   ├── AppLayout.tsx      # 整体布局（导航栏+侧边栏+内容区）
│   │   ├── TopNavbar.tsx       # 顶部全局导航栏
│   │   └── RightSidebar.tsx    # 右侧全局侧边栏
│   └── ui/                    # shadcn/ui 组件（按需扩展）
├── pages/
│   ├── Dashboard/             # 工作台（系统通知+今日待办+看板）
│   ├── Registration/          # 挂号预约（日历+医生+挂号记录）
│   ├── Outpatient/            # 门诊接诊（患者列表+病历+处方）
│   ├── Billing/               # 收费管理（收费单+项目+支付详情）
│   └── Admin/                 # 管理-模板设置（模板树+方剂信息）
├── mock/
│   └── index.ts               # 模拟数据（预留接口替换位置）
├── types/
│   └── index.ts               # TypeScript 类型定义
├── lib/
│   └── utils.ts               # 工具函数（cn）
├── App.tsx                    # 路由配置
├── main.tsx                   # 入口文件
└── index.css                  # 全局样式 + Tailwind 指令
```

## 快速启动

```bash
# 进入项目目录
cd project/medicine

# 安装依赖
npm install

# 启动开发服务器
npm run dev

# 构建生产版本
npm run build
```

## 页面功能

| 页面 | 路由 | 功能描述 |
|------|------|----------|
| **工作台** | `/` | 系统通知、今日工作统计、今日患者看板 |
| **挂号预约** | `/registration` | 日历选择、医生列表、挂号记录管理 |
| **门诊** | `/outpatient` | 接诊列表、病历编辑、诊疗项目、处方开具 |
| **收费** | `/billing` | 收费单列表、收费项目、支付详情 |
| **管理** | `/admin` | 处方模板分类、方剂详情查看 |

## 设计规范

- **主色**: `#165DFF` (导航栏、选中态)
- **成功色**: `#00B42A` (主按钮)
- **危险色**: `#F53F3F` (删除、高风险)
- **警告色**: `#FF7D00` (待办提醒)
- **背景**: `#F2F3F5` (页面背景)
- **卡片**: 白色圆角卡片 + `#E5E6E8` 边框
- **字体**: 14px 基础字号，PingFang SC / Microsoft YaHei

## 数据对接

所有模拟数据集中在 `src/mock/index.ts`，类型定义在 `src/types/index.ts`。

对接后端接口时，只需：
1. 替换 `mock/index.ts` 中的数据和导出函数为 API 调用
2. 类型定义可按需扩展
3. 每页的数据获取逻辑在各自页面的 index.tsx 中

## 浏览器支持

- Chrome 90+
- Firefox 90+
- Edge 90+
- 分辨率 1366×768 及以上
