---
name: workflow-generator
description: 生成工作流、作业流和审批流的 JSON 格式定义文件（.fix 文件）。当用户提到创建或生成工作流、作业流、审批流、流程或任何类型的业务流程自动化时使用此技能。当用户想要定义流程结构、创建流程定义或生成工作流定义时也会触发。此技能将用户需求转换为 JSON 工作流定义文件，并可以在请求时通过 HTTP API 发布到服务器。
---

# 工作流生成器

此技能将用户的工作流需求转换为 JSON 工作流定义文件（.fix 格式），并可以通过 HTTP API 发布到服务器。

## 使用场景

当用户要求以下内容时使用此技能：
- 创建或生成工作流、作业流、审批流或其他流程
- 定义业务流程结构或流程定义
- 为业务流程管理系统生成代码
- 创建包含步骤、分支或审批节点的工作流模板

## 工作流类型

此技能支持四种类型的工作流：

### 1. 顺序工作流
步骤按定义的顺序依次执行。

### 2. 条件分支工作流
包含决策点，根据条件选择不同的执行路径。

### 3. 并行工作流
多个步骤同时执行，所有并行分支完成后继续执行。

### 4. 审批工作流
包含需要人工审批才能继续的审批节点。

## 工作流定义结构

所有工作流都使用 JSON 定义，结构如下：

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
- `id`: 数据库主键（可选，用于存储）
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

## 节点类型

- **start**: 工作流的入口点
- **end**: 工作流的终止点
- **job**: 执行作业的节点，通常用于长时间运行的后台任务
- **task**: 执行特定操作的任务节点
- **fork**: 将执行分割到多个分支的分支节点
- **join**: 等待多个分支完成后继续执行的聚合节点
- **or**: 选择性分支节点，根据条件选择一个分支执行
- **subprocess**: 调用子流程的节点，可以复用已定义的工作流
- **custom**: 自定义节点类型，用于扩展特定业务逻辑

## 生成工作流定义

生成工作流定义时：

1. 首先理解用户需求，如有需要通过提问澄清：
   - 他们需要什么类型的工作流？
   - 主要步骤或阶段是什么？
   - 是否有条件或分支？
   - 是否有审批节点？谁审批什么？
   - 节点之间需要传递什么数据？

2. 创建捕获工作流结构的 JSON 工作流定义：
   - 为工作流使用唯一的 uniquekey（英文标识符）
   - 包含描述性的名称和描述
   - 使用适当的类型和配置定义所有节点
   - **节点名称必须使用中文**
   - 为每个节点设置 key、left、top、width、height 属性以支持可视化编辑器
   - 定义连接节点的 lines（替代 edges）
   - 对于条件工作流，在连线的 expr 字段中包含条件表达式（JSON 字符串格式）
   - 对于并行工作流，确保所有并行分支正确收敛
   - 为连线设置 lp（位置点）以优化可视化效果
   - **设置 initNum 字段为当前节点编号的最大值（不是节点总数，也不是 0）**

3. 将工作流定义保存为 .fix 文件：
   - 文件名应具有描述性（例如："leave-request-approval.fix"）
   - 保存到项目的工作流定义目录（例如：`./FLOW.m/` 或 `./`）
   - 使用正确的 JSON 格式和缩进
   - 如需要在 JSON 中包含注释（使用 // 或 /* */）

4. 如果用户想要将工作流发布到服务器：
   - 调用 HTTP API 发布工作流定义
   - 使用服务器的 API 端点进行工作流创建/更新
   - 包含适当的身份验证（API 密钥、令牌等）
   - 处理错误并向用户提供反馈

## 发布工作流

当用户说"发布到系统"、"部署到服务器"或提供 .fix 文件时，你应该：

1. **必须优先使用本技能内置的 publish-workflow.js 脚本**：
   - 脚本位于技能目录的 `scripts/publish-workflow.js`
   - 这是本技能自带的发布工具，无需创建新的发布脚本
   - 这是首选的发布方法，提供完整的验证和错误处理
   - 自动判断是新增还是更新操作（根据 fix 文件中是否存在 id 字段）
   - 使用正确的 Content-Type 和字符编码
   - 自动将服务器返回的 id 值更新到 fix 文件
   - 支持环境变量和配置文件配置

2. 执行发布操作：
   - 运行命令：`node scripts/publish-workflow.js <workflow-file.fix>`
   - 脚本会自动验证工作流结构
   - 脚本会根据 fix 文件中是否存在 id 字段自动选择创建或更新操作
   - 脚本会处理 API 调用并更新 fix 文件中的 id 字段

3. 只有在脚本执行失败的情况下，才考虑手动调用 API：
   - 从 .fix 文件读取工作流定义
   - **自动判断操作类型**：
     - 检查工作流定义中是否包含 `id` 字段
     - **如果存在 `id` 字段**：使用 **PUT** 方法更新现有工作流
     - **如果不存在 `id` 字段**：使用 **POST** 方法创建新工作流
   - 调用 HTTP API 发布工作流
   - 使用适当的 API 端点和方法：
     - **POST** `/das-pm/pm/definition` - 创建新工作流（请求体不包含 id 字段）
     - **PUT** `/das-pm/pm/definition` - 更新现有工作流（请求体包含 id 字段）
   - 构建请求体，包含以下字段：
     - `id`: 数据库主键（仅更新时需要，**新建流程时不包含此字段**）
     - `uniquekey`: 流程定义唯一标识符（必需）
     - `name`: 流程定义名称（必需）
     - `description`: 流程定义描述
     - `version`: 流程定义版本，默认为 1
     - `code`: 流程定义分类编码
     - `type`: 流程定义分类名称
     - `content`: 完整的流程定义数据（fix 文件内容的 JSON 字符串）
     - `state`: 流程定义状态（0-禁用、1-启用，默认为 1）
     - `params`: 外部 JSON 键值对参数
   - 在请求头中包含适当的身份验证：
     - `Authorization: Bearer {apiKey}` 或 `Authorization: Token {apiKey}`
     - 或使用服务器要求的其他身份验证方法
   - 将 Content-Type 头设置为 `application/json; charset=UTF-8`
   - 将请求体发送到服务器
   - 处理响应：
     - 如果成功，通知用户并显示响应，**并将服务器返回的 id 值更新到 .fix 文件的 id 字段**
     - 如果失败，显示错误消息并建议故障排除步骤

## 使用 publish-workflow.js 脚本

**必须优先使用本技能内置的 publish-workflow.js 脚本进行发布和更新操作**，该脚本是技能自带的发布工具，具有以下特性：

- 自动判断是新增还是更新操作（根据 fix 文件中是否存在 id 字段）
- 使用正确的 Content-Type 和字符编码（`application/json; charset=UTF-8`）
- 自动将服务器返回的 id 值更新到 fix 文件
- 支持环境变量配置（HEARKEN_PM_HOST_IP、HEARKEN_PM_HOST_WEB_PORT、WORKFLOW_API_KEY）
- 完整的工作流验证和错误处理

**使用示例：**

```bash
# 设置环境变量
export HEARKEN_PM_HOST_IP=127.0.0.1
export HEARKEN_PM_HOST_WEB_PORT=8585
export WORKFLOW_API_KEY=your-api-key-here

# 发布工作流（自动判断新增或更新）
node scripts/publish-workflow.js examples/employee-leave-approval.fix

# 或使用配置文件
# 编辑 scripts/.workflow-config.json
{
  "serverUrl": "http://localhost:8585",
  "apiKey": "your-api-key-here",
  "timeout": 30000
}

# 发布工作流
node scripts/publish-workflow.js examples/employee-leave-approval.fix
```

**脚本输出示例：**

```
Server URL: http://localhost:8585
Timeout: 30000ms

Validating workflow: employee-leave-approval-flow
✓ Workflow is valid

Detected workflow ID: 206241821532229632
Mode: Update existing workflow (PUT)

Updating workflow at: http://localhost:8585/das-pm/pm/definition
Method: PUT
Unique Key: employee-leave-approval-flow
Database ID: 206241821532229632

✓ Workflow updated successfully!
Response: {
  "status": 1,
  "code": null,
  "msg": "流更新成功!",
  "count": 0,
  "data": "206241821532229632",
  "ok": true
}
✓ Updated workflow file with ID: 206241821532229632

=== Operation Complete ===
```

## 使用 curl 的 API 调用示例（不推荐，仅供参考）
```bash
# 创建新工作流（POST，不包含 id）
curl -X POST http://127.0.0.1:8585/das-pm/pm/definition \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer your-api-key" \
  -d '{
    "uniquekey": "leave-request-approval-flow",
    "name": "Leave Request Approval",
    "description": "A workflow for approving leave requests",
    "version": "1",
    "code": "LEAVE",
    "type": "approval",
    "content": "{\"id\":1,\"uniquekey\":\"leave-request-approval-flow\",\"name\":\"Leave Request Approval\",\"nodes\":{...},\"lines\":{...},\"areas\":{},\"config\":{...}}",
    "state": 1,
    "params": {}
  }'

# 更新现有工作流（PUT，包含 id）
curl -X PUT http://127.0.0.1:8585/das-pm/pm/definition \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer your-api-key" \
  -d '{
    "id": 123,
    "uniquekey": "leave-request-approval-flow",
    "name": "Leave Request Approval",
    "description": "A workflow for approving leave requests",
    "version": "1",
    "code": "LEAVE",
    "type": "approval",
    "content": "{\"id\":1,\"uniquekey\":\"leave-request-approval-flow\",\"name\":\"Leave Request Approval\",\"nodes\":{...},\"lines\":{...},\"areas\":{},\"config\":{...}}",
    "state": 1,
    "params": {}
  }'
```

使用 JavaScript 的 API 调用示例：
```javascript
// 创建新工作流（POST）
const workflowDefinition = JSON.parse(fs.readFileSync('leave-request-approval.fix', 'utf8'));
const response = await fetch('http://127.0.0.1:8585/das-pm/pm/definition', {
  method: 'POST',
  headers: {
    'Content-Type': 'application/json',
    'Authorization': `Bearer ${apiKey}`
  },
  body: JSON.stringify({
    uniquekey: workflowDefinition.uniquekey,
    name: workflowDefinition.name,
    description: workflowDefinition.description || '',
    version: workflowDefinition.version || '1',
    code: workflowDefinition.code || '',
    type: workflowDefinition.type || '',
    content: JSON.stringify(workflowDefinition),
    state: workflowDefinition.state !== undefined ? workflowDefinition.state : 1,
    params: workflowDefinition.params || {}
  })
});

// 更新现有工作流（PUT）
const workflowDefinition = JSON.parse(fs.readFileSync('leave-request-approval.fix', 'utf8'));
const response = await fetch('http://127.0.0.1:8585/das-pm/pm/definition', {
  method: 'PUT',
  headers: {
    'Content-Type': 'application/json',
    'Authorization': `Bearer ${apiKey}`
  },
  body: JSON.stringify({
    id: workflowDefinition.id,
    uniquekey: workflowDefinition.uniquekey,
    name: workflowDefinition.name,
    description: workflowDefinition.description || '',
    version: workflowDefinition.version || '1',
    code: workflowDefinition.code || '',
    type: workflowDefinition.type || '',
    content: JSON.stringify(workflowDefinition),
    state: workflowDefinition.state !== undefined ? workflowDefinition.state : 1,
    params: workflowDefinition.params || {}
  })
});

if (!response.ok) {
  throw new Error(`Failed to publish workflow: ${response.statusText}`);
}

return await response.json();
```

## 输出格式

始终生成带有 .fix 扩展名的 JSON 工作流定义文件，包含：
1. 包含所有必需字段的完整工作流定义
2. 正确格式化的 JSON 和缩进
3. 描述性的节点 ID 和名称
4. 每个节点的清晰描述
5. 连接所有节点的适当边
6. 有效的工作流结构（单个开始和结束节点）

文件命名约定：
- 使用 kebab-case（小写字母和连字符）
- 反映工作流用途的描述性名称
- 示例：`leave-request-approval.fix`、`order-processing.fix`、`document-approval.fix`

文件存储位置：
- 如果存在，保存到 `./FLOW.m/` 目录
- 否则保存到 `./` 目录
- 如果两者都不存在，保存到项目根目录
- 始终通知用户文件保存的位置

## 工作流定义示例

这是一个简单审批工作流的示例：

```json
{
  "id": 1,
  "uniquekey": "document-approval-flow",
  "name": "Document Approval Flow",
  "description": "A workflow for approving documents",
  "initNum": 0,
  "nodes": {
    "HKFlow_node_1": {
      "key": "HKFlow_node_1",
      "name": "开始",
      "left": 100,
      "top": 200,
      "type": "start",
      "width": 60,
      "height": 48,
      "alt": true
    },
    "HKFlow_node_2": {
      "key": "HKFlow_node_2",
      "name": "Manager Approval",
      "left": 300,
      "top": 200,
      "type": "task",
      "width": 60,
      "height": 48,
      "alt": true
    },
    "HKFlow_node_3": {
      "key": "HKFlow_node_3",
      "name": "结束",
      "left": 500,
      "top": 200,
      "type": "end",
      "width": 60,
      "height": 48,
      "alt": true
    }
  },
  "lines": {
    "HKFlow_line_1": {
      "type": "sl",
      "from": "HKFlow_node_1",
      "to": "HKFlow_node_2",
      "name": "",
      "lp": "200,200",
      "mode": "common"
    },
    "HKFlow_line_2": {
      "type": "sl",
      "from": "HKFlow_node_2",
      "to": "HKFlow_node_3",
      "name": "",
      "lp": "400,200",
      "mode": "common",
      "expr": "{\"type\":\"expression\",\"value\":\"approved==true\"}"
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

## 最佳实践

- 为节点使用清晰、描述性的 ID 和名称（kebab-case）
- 为每个节点提供有用的描述
- 保存前验证工作流结构
- 确保所有路径都通向结束节点
- 对于条件工作流，提供清晰的条件表达式
- 对于审批工作流，指定审批人和审批要求
- 使用正确的 JSON 格式和 2 空格缩进
- 在工作流定义中包含版本号
- 发布前测试工作流定义
- 将工作流定义纳入版本控制
- 为 .fix 文件使用有意义的文件名
- 记录节点中使用的任何自定义配置字段

## 常见模式

### 顺序模式
```
start → task1 → task2 → task3 → end
```

### 条件模式（使用 OR 节点）
```
start → or → task1 (if condition A) → end
            → task2 (if condition B) → end
            → task3 (if condition C) → end
```

### 并行模式（使用 Fork 和 Join 节点）
```
start → fork → task1 → join → end
              → task2 →
              → task3 →
```

### 子流程模式
```
start → task1 → subprocess (调用其他工作流) → task2 → end
```

### 混合模式（组合多种节点类型）
```
start → task → fork → task1 → join → subprocess → custom → end
                      → task2 →
```

## 工作流验证

发布工作流之前，验证：
1. 工作流有且仅有一个 start 类型节点
2. 工作流有且仅有一个 end 类型节点
3. 所有节点的 key 都是唯一的
4. 所有连线都引用有效的节点 key
5. 所有节点都可以从开始节点到达
6. 所有路径都通向结束节点
7. Fork 节点必须有对应的 Join 节点
8. OR 节点的所有出边都必须有 expr 条件表达式
9. Subprocess 节点必须引用有效的工作流 uniquekey
10. Custom 节点必须指定实现类
11. Job 节点应该有超时配置（适用于长时间运行的任务）
12. 每个节点都必须有 left、top、width、height 属性
13. 连线的 lp 坐标应该合理（在源节点和目标节点之间）

## 服务器配置

发布工作流时，您可能需要配置：

- **服务器 IP**: 服务器 IP 地址（环境变量：`HEARKEN_PM_HOST_IP`）
- **服务器端口**: 服务器 Web 端口（环境变量：`HEARKEN_PM_HOST_WEB_PORT`）
- **API 密钥**: 用于 API 访问的身份验证令牌（环境变量：`WORKFLOW_API_KEY`）
- **超时**: 请求超时持续时间（环境变量：`WORKFLOW_TIMEOUT`）

服务器配置示例：

```bash
# 优先使用以下环境变量
HEARKEN_PM_HOST_IP=127.0.0.1
HEARKEN_PM_HOST_WEB_PORT=8585
WORKFLOW_API_KEY=your-api-key-here
WORKFLOW_TIMEOUT=30000
```

或者使用配置文件：

```json
{
  "serverUrl": "http://127.0.0.1:8585",
  "apiKey": "your-api-key-here",
  "timeout": 30000
}
```
