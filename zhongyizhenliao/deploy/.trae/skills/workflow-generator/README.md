# Workflow Generator

将用户需求转换为 JSON 格式的流程定义文件（.fix 后缀），并支持通过 HTTP API 发布到服务器。

## 功能特性

- ✅ 将自然语言需求转换为结构化的 JSON 工作流定义
- ✅ 支持四种工作流类型：顺序、条件分支、并行、审批
- ✅ 生成 .fix 格式的 JSON 文件
- ✅ 自动验证工作流结构
- ✅ 支持通过 HTTP API 发布到服务器
- ✅ 灵活的配置方式（环境变量或配置文件）

## 工作流类型

### 1. 顺序工作流 (Sequential)
步骤按定义的顺序依次执行。

### 2. 条件分支工作流 (Conditional)
包含决策点，根据条件选择不同的执行路径。

### 3. 并行工作流 (Parallel)
多个步骤同时执行，所有并行分支完成后继续。

### 4. 审批工作流 (Approval)
包含需要人工审批的节点。

## 使用方法

### 生成工作流定义

当用户描述工作流需求时，技能会自动：

1. 分析需求，理解工作流类型和步骤
2. 创建 JSON 格式的工作流定义
3. 保存为 .fix 文件到指定目录
4. 验证工作流结构的完整性

示例：
```
用户：创建一个请假审批流程，需要经理和部门主管审批
系统：生成 leave-request-approval.fix 文件
```

### 发布到服务器

当用户说"发布到系统"或"部署到服务器"时，技能会：

1. **优先使用本技能内置的 publish-workflow.js 脚本**：
   - 脚本位于技能目录的 `scripts/publish-workflow.js`
   - 这是本技能自带的发布工具，无需创建新的发布脚本
   - 这是首选的发布方法，提供完整的验证和错误处理
   - 自动判断是新增还是更新操作（根据 fix 文件中是否存在 id 字段）

2. 执行发布操作：
   - 运行命令：`node scripts/publish-workflow.js <workflow-file.fix>`
   - 脚本会自动验证工作流结构
   - 脚本会根据 fix 文件中是否存在 id 字段自动选择创建或更新操作
   - 脚本会处理 API 调用并更新 fix 文件中的 id 字段

示例命令：
```bash
# 设置环境变量
export HEARKEN_PM_HOST_IP=127.0.0.1
export HEARKEN_PM_HOST_WEB_PORT=8585
export WORKFLOW_API_KEY=your-api-key-here

# 发布工作流（自动判断新增或更新）
node scripts/publish-workflow.js examples/leave-request-approval.fix

# 或使用配置文件
# 编辑 scripts/.workflow-config.json
# {
#   "serverUrl": "http://localhost:8585",
#   "apiKey": "your-api-key-here",
#   "timeout": 30000
# }

# 发布工作流
node scripts/publish-workflow.js examples/leave-request-approval.fix
```

## 文件结构

```
workflow-generator/
├── SKILL.md                          # 技能定义文件
├── examples/                           # 示例工作流
│   ├── leave-request-approval.fix         # 请假审批流程
│   └── order-processing.fix             # 订单处理流程
├── scripts/                            # 工具脚本
│   └── publish-workflow.js              # 发布脚本
└── .workflow-config.example.json         # 配置文件示例
```

## 工作流定义格式

### 基本结构

```json
{
  "id": "database-primary-key",
  "uniquekey": "workflow-unique-identifier",
  "name": "Workflow Name",
  "description": "Workflow description",
  "initNum": 0,
  "nodes": {
    "node-key-1": {
      "key": "node-key-1",
      "name": "Node Name",
      "type": "start|end|job|task|fork|join|or|subprocess|custom",
      "left": 100,
      "top": 200,
      "width": 60,
      "height": 48,
      "alt": true
    }
  },
  "lines": {
    "line-key-1": {
      "type": "sl",
      "from": "node-key-1",
      "to": "node-key-2",
      "name": "",
      "lp": "150,200",
      "mode": "common",
      "expr": "{\"type\":\"expression\",\"value\":\"condition\"}"
    }
  },
  "areas": {},
  "config": {
    "completeStatus": 1,
    "completeCallback": 2,
    "selectedNodes": []
  }
}
```

### 字段说明

**工作流级别字段：**
- `id`: 数据库主键（可选，用于存储，**新建流程时不设置此字段**）
- `uniquekey`: 工作流的唯一标识符（英文，必需）
- `name`: 工作流名称（必需）
- `description`: 工作流描述
- `initNum`: 流程定义节点创建时的起始编号（必需）。该值应该等于当前节点编号的最大值。每新添加了一个节点，该值会自动增加 1。删除或减少节点不影响该值。

**节点级别字段：**
- `key`: 节点的唯一标识符（必需）
- `name`: 节点名称（必需，**必须使用中文**）
- `type`: 节点类型（必需）
- `left`: 节点在可视化编辑器中的左边距（像素，必需）
- `top`: 节点在可视化编辑器中的上边距（像素，必需）
- `width`: 节点宽度（像素，必需）
- `height`: 节点高度（像素，必需）
- `alt`: 可选属性

**连线级别字段：**
- `type`: 连线类型（如 "sl" 表示直线）
- `from`: 源节点的 key（必需）
- `to`: 目标节点的 key（必需）
- `name`: 连线名称
- `lp`: 连线位置点（格式："x,y"）
- `mode`: 连线模式（如 "common"）
- `expr`: 条件表达式（JSON 字符串格式，用于条件分支）

### 节点类型

- **start**: 工作流入口点
- **end**: 工作流终止点
- **job**: 执行作业的节点，通常用于长时间运行的后台任务
- **task**: 执行特定操作的任务节点
- **fork**: 将执行分割到多个分支的分支节点
- **join**: 等待多个分支完成后继续执行的聚合节点
- **or**: 选择性分支节点，根据条件选择一个分支执行
- **subprocess**: 调用子流程的节点，可以复用已定义的工作流
- **custom**: 自定义节点类型，用于扩展特定业务逻辑

### 连线 (Lines)

连接节点的有向边，可以包含条件表达式：

```json
{
  "type": "sl",
  "from": "HKFlow_node_1",
  "to": "HKFlow_node_2",
  "name": "",
  "lp": "150,200",
  "mode": "common",
  "expr": "{\"type\":\"expression\",\"value\":\"amount>10000\"}"
}
```

## 配置

### 环境变量

```bash
# 优先使用以下环境变量
HEARKEN_PM_HOST_IP=127.0.0.1
HEARKEN_PM_HOST_WEB_PORT=8585
WORKFLOW_API_KEY=your-api-key-here
WORKFLOW_TIMEOUT=30000
```

### 配置文件

创建 `.workflow-config.json` 文件：

```json
{
  "serverUrl": "http://127.0.0.1:8585",
  "apiKey": "your-api-key-here",
  "timeout": 30000
}
```

## API 端点

- **POST** `/das-pm/pm/definition` - 创建新工作流（请求体不包含 id 字段）
- **PUT** `/das-pm/pm/definition` - 更新现有工作流（请求体包含 id 字段）

### 请求体结构

```json
{
  "id": "数据库主键（仅更新时需要）",
  "uniquekey": "流程定义唯一标识符（必需）",
  "name": "流程定义名称（必需）",
  "description": "流程定义描述",
  "version": "流程定义版本，默认为 1",
  "code": "流程定义分类编码",
  "type": "流程定义分类名称",
  "content": "完整的流程定义数据（fix 文件内容的 JSON 字符串）",
  "state": "流程定义状态（0-禁用、1-启用，默认为 1）",
  "params": "外部 JSON 键值对参数"
}
```

**说明：**
- `content` 字段包含完整的 fix 文件内容的 JSON 字符串
- POST 请求不包含 `id` 字段，用于创建新工作流
- PUT 请求包含 `id` 字段，用于更新现有工作流
- 服务器根据请求体中是否存在 `id` 字段来判断是新增还是修改操作
- **新建流程时**：fix 文件中的 `id` 字段不设置或为空
- **发布后**：服务器返回的 `id` 值会自动更新到 fix 文件的 `id` 字段中

## 示例

### 请假审批流程

查看 [examples/leave-request-approval.fix](examples/leave-request-approval.fix)

特性：
- 多级审批（经理 → 部门主管 → HR）
- 条件分支（请假 > 3 天需要部门主管审批）
- 自动更新请假余额
- 多渠道通知

### 订单处理流程

查看 [examples/order-processing.fix](examples/order-processing.fix)

特性：
- 根据优先级（高/中/低）进行不同处理
- 不同的 SLA 和升级策略
- 自动库存更新

## 验证规则

发布前会验证：

1. ✅ 工作流有且仅有一个 start 类型节点
2. ✅ 工作流有且仅有一个 end 类型节点
3. ✅ 所有节点的 key 都是唯一的
4. ✅ 所有连线都引用有效的节点 key
5. ✅ 所有节点都可以从开始节点到达
6. ✅ 所有路径都通向结束节点
7. ✅ Fork 节点必须有对应的 Join 节点
8. ✅ OR 节点的所有出边都必须有 expr 条件表达式
9. ✅ Subprocess 节点必须引用有效的工作流 uniquekey
10. ✅ Custom 节点必须指定实现类
11. ✅ Job 节点应该有超时配置（适用于长时间运行的任务）
12. ✅ 每个节点都必须有 left、top、width、height 属性
13. ✅ 连线的 lp 坐标应该合理（在源节点和目标节点之间）

## 最佳实践

- 使用清晰、描述性的节点 ID（kebab-case）
- **节点名称必须使用中文**
- 为每个节点提供有用的描述
- 保存前验证工作流结构
- 确保所有路径都通向结束节点
- 对于条件工作流，提供清晰的条件表达式
- 对于审批工作流，指定审批人和审批要求
- 使用正确的 JSON 格式（2 空格缩进）
- 在工作流定义中包含版本号
- 发布前测试工作流定义
- 将工作流定义纳入版本控制
- 为 .fix 文件使用有意义的文件名
- 记录节点中使用的任何自定义配置字段

## 命令行工具

### 发布工作流

```bash
node scripts/publish-workflow.js <command> <workflow-file.fix>
```

命令：
- `create` - 创建新工作流（使用 POST 方法）
- `update` - 更新现有工作流（使用 PUT 方法）

示例：
```bash
# 创建新工作流
node scripts/publish-workflow.js create examples/leave-request-approval.fix

# 更新现有工作流
node scripts/publish-workflow.js update examples/order-processing.fix
```

## 故障排除

### 常见错误

**错误：Workflow file not found**
- 检查文件路径是否正确
- 确保文件存在

**错误：Invalid workflow: missing required fields**
- 检查工作流定义是否包含 id、name、type 字段

**错误：HTTP 401 Unauthorized**
- 检查 API 密钥是否正确
- 验证认证头格式

**错误：Request timeout**
- 增加 timeout 配置值
- 检查网络连接

## 许可证

MIT License
