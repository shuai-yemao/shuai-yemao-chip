# Shuai Yemao Chip

Claude Code 完整配置备份 — 用于在新电脑上快速恢复开发环境。

## 🏗️ 系统架构

```mermaid
graph TB
    subgraph "Claude Code 配置系统"
        A[CLAUDE.md<br/>全局指令] --> B[SOUL.md<br/>核心身份]
        A --> C[AGENTS.md<br/>Agent 指令]
        A --> D[USER.md<br/>用户配置]
    end

    subgraph "规则体系"
        E[rules/] --> F[security/<br/>安全规则]
        E --> G[workflow/<br/>工作流规则]
        E --> H[embedded/<br/>嵌入式规则]
        E --> I[privacy/<br/>隐私规则]
        E --> J[ecc/<br/>ECC规则]
    end

    subgraph "Agent 系统"
        K[163 专业 Agent] --> L[planner<br/>实现规划]
        K --> M[architect<br/>系统设计]
        K --> N[code-reviewer<br/>代码审查]
        K --> O[security-reviewer<br/>安全检测]
        K --> P[tdd-guide<br/>测试驱动]
    end

    subgraph "插件系统"
        Q[12 插件] --> R[ECC<br/>Agent + Skills]
        Q --> S[Claude HUD<br/>状态栏]
        Q --> T[Superpowers<br/>增强功能]
        Q --> U[官方插件<br/>7 个]
        Q --> V[Claude Mem<br/>记忆管理]
        Q --> W[Understand-Anything<br/>知识图谱]
        Q --> X1[Codex<br/>OpenAI 集成]
    end

    subgraph "Hooks 系统"
        H1[Clawd on Desk] --> H2[桌面宠物状态]
        H3[ECC] --> H4[20+ 质量检查]
        H5[Understand-Anything] --> H6[知识图谱更新]
    end

    B --> X[Agent-First<br/>Test-Driven<br/>Security-First]
    C --> Y[163 Agent + 安全指南<br/>+ 编码风格 + 测试要求]
    J --> Z[ECC 标准规则]
    R --> AA[Agent 编排 + 工作流]
    H1 --> AB[实时状态感知]
    H3 --> AC[代码质量保障]
```

## 📦 仓库关系

```mermaid
graph LR
    A[shuai-yemao-chip<br/>核心配置] --> B[shuai-yemao-chip-skills<br/>技能包]
    A --> C[shuai-yemao-workflow<br/>工作流]

    B --> D[142 技能]
    C --> E[15+ 核心工作流]

    A --> F[ECC 配置<br/>CLAUDE.md / SOUL.md / AGENTS.md]
    A --> G[规则体系<br/>security / workflow / embedded / ecc]
    A --> H[参考文档<br/>EMBEDDED.md / SECURITY.md / WORKFLOWS.md]
    A --> I[插件配置<br/>ECC / HUD / Superpowers / Mem]

    style A fill:#e1f5fe
    style B fill:#f3e5f5
    style C fill:#e8f5e9
```

## 🚀 快速开始

### 一键安装

```bash
# 克隆配置仓库
git clone https://github.com/shuai-yemao/shuai-yemao-chip.git ~/shuai-yemao-chip

# 运行安装脚本
cd ~/shuai-yemao-chip
./scripts/install.sh

# 安装插件
./scripts/install-plugins.sh

# 安装 Understand-Anything（知识图谱）
git clone https://github.com/Lum1104/Understand-Anything.git ~/.claude/plugins/marketplaces/Understand-Anything
cd ~/.claude/plugins/marketplaces/Understand-Anything
./install.sh claude

# 在 settings.json 中启用插件（12 个）
# "enabledPlugins": {
#   "ecc@ecc": true,
#   "claude-hud@claude-hud": true,
#   "superpowers@superpowers-marketplace": true,
#   "claude-code-zh-cn": true,
#   "claude-mem@thedotmack": true,
#   "understand-anything@understand-anything": true,
#   "codex@openai-codex": true,
#   "clangd-lsp@claude-plugins-official": true,
#   "pyright-lsp@claude-plugins-official": true,
#   "claude-md-management@claude-plugins-official": true,
#   "hookify@claude-plugins-official": true,
#   "skill-creator@claude-plugins-official": true,
#   "session-report@claude-plugins-official": true
# }

# 配置 API Key
vim ~/.claude/settings.json

# 重启 Claude Code
claude
```

### 安装流程

```mermaid
flowchart TD
    A[开始] --> B[克隆仓库]
    B --> C[运行 install.sh]
    C --> D[复制配置文件]
    C --> E[复制规则目录]
    C --> F[复制 Agent 定义]
    C --> G[复制参考文档]
    D --> H[运行 install-plugins.sh]
    E --> H
    F --> H
    G --> H
    H --> I[安装 ECC]
    H --> J[安装 Claude HUD]
    H --> K[安装 Superpowers]
    H --> L[安装 Claude 中文]
    H --> M[安装 Claude Mem]
    H --> N[安装 Understand-Anything]
    I --> O[配置 API Key]
    J --> O
    K --> O
    L --> O
    M --> O
    N --> O
    O --> P[重启 Claude Code]
    P --> Q[完成]

    style A fill:#c8e6c9
    style Q fill:#c8e6c9
    style O fill:#fff9c4
```

## 📁 仓库结构

```mermaid
graph TB
    subgraph "shuai-yemao-chip"
        A[config/] --> A1[CLAUDE.md<br/>ECC 全局指令]
        A --> A2[SOUL.md<br/>ECC 核心身份]
        A --> A3[AGENTS.md<br/>ECC 163 Agent 指令]
        A --> A4[USER.md<br/>用户配置]
        A --> A5[settings.json<br/>已脱敏]

        B[rules/] --> B1[security/<br/>安全规则]
        B --> B2[workflow/<br/>工作流规则]
        B --> B3[embedded/<br/>嵌入式规则]
        B --> B4[privacy/<br/>隐私规则]
        B --> B5[ecc/<br/>ECC 标准规则]

        C[reference/] --> C1[EMBEDDED.md<br/>嵌入式约束]
        C --> C2[SECURITY.md<br/>安全规范]
        C --> C3[WORKFLOWS.md<br/>工作流 API]

        D[scripts/] --> D1[install.sh<br/>配置安装]
        D --> D2[install-plugins.sh<br/>插件安装]
        D --> D3[wf.sh<br/>工作流快捷命令]

        E[bin/] --> E1[model-switch<br/>模型切换]
        E --> E2[switch-api.js<br/>API 切换]

        F[hooks/] --> F1[hooks.json<br/>Clawd on Desk Hooks]
        F --> F2[ECC Hooks<br/>20+ 质量检查]
        F --> F3[Understand-Anything Hooks<br/>知识图谱更新]
    end

    style A fill:#e3f2fd
    style B fill:#fce4ec
    style C fill:#fff3e0
    style D fill:#f3e5f5
    style E fill:#e8f5e9
    style F fill:#e0f7fa
```

## 🔌 插件系统（12 个）

```mermaid
graph TB
    subgraph "社区插件"
        A[ECC] --> A1[163 Agent]
        A --> A2[107 Skills]
        A --> A3[Commands]
        A --> A4[Hooks]

        B[Claude HUD] --> B1[状态栏]
        B --> B2[进度显示]
        B --> B3[成本追踪]

        C[Superpowers] --> C1[增强技能]
        C --> C2[社区工作流]

        D[Claude 中文] --> D1[界面汉化]
        D --> D2[中文提示]

        E[Claude Mem] --> E1[记忆持久化]
        E --> E2[上下文管理]

        F[Understand-Anything] --> F1[知识图谱]
        F --> F2[代码分析]

        G[Codex] --> G1[OpenAI 集成]
        G --> G2[协作编程]
    end

    subgraph "官方插件（Anthropic）"
        H[clangd-lsp] --> H1[C/C++ 代码智能]
        I[pyright-lsp] --> I1[Python 类型检查]
        J[claude-md-management] --> J1[CLAUDE.md 管理]
        K[hookify] --> K1[Hook 自动创建]
        L[skill-creator] --> L1[技能创建/评估]
        M[session-report] --> M1[会话报告生成]
    end

    subgraph "插件来源"
        N[GitHub 仓库]
        N --> O[affaan-m/ECC]
        N --> P[jarrodwatts/claude-hud]
        N --> Q[obra/superpowers-marketplace]
        N --> R[anthropics/claude-plugins-official]
        N --> S[thedotmack/claude-mem]
        N --> T[Lum1104/Understand-Anything]
        N --> U[openai/codex-plugin-cc]
    end

    O --> A
    P --> B
    Q --> C
    R --> D
    R --> H
    R --> I
    R --> J
    R --> K
    R --> L
    R --> M
    S --> E
    T --> F
    U --> G

    style A fill:#e1f5fe
    style B fill:#f3e5f5
    style C fill:#e8f5e9
    style D fill:#fff3e0
    style E fill:#fce4ec
    style F fill:#e0f7fa
    style G fill:#ede7f6
    style H fill:#ffebee
    style I fill:#ffebee
    style J fill:#ffebee
    style K fill:#ffebee
    style L fill:#ffebee
    style M fill:#ffebee
```

## 🔗 MCP 服务器

```mermaid
graph TB
    subgraph "已配置 MCP 服务器"
        B[DBHub] --> B1[数据库连接]
        B --> B2[SQL 执行]
        B --> B3[数据库对象搜索]
    end

    subgraph "支持的数据库"
        C[SQLite] --> C1[轻量级嵌入式]
        D[PostgreSQL] --> D1[功能强大]
        E[MySQL] --> E1[流行开源]
        F[SQL Server] --> F1[企业级]
    end

    B --> C
    B --> D
    B --> E
    B --> F

    style B fill:#e3f2fd
    style C fill:#f3e5f5
    style D fill:#e1f5fe
    style E fill:#fce4ec
    style F fill:#e0f7fa
```

### MCP 配置

```json
{
  "mcpServers": {
    "dbhub": {
      "command": "pnpm",
      "args": ["dlx", "@bytebase/dbhub@latest", "--transport", "stdio"]
    }
  }
}
```

**DBHub MCP** - 数据库连接
- `execute_sql`: 执行 SQL 查询，支持事务和安全控制
- `search_objects`: 搜索和探索数据库结构
- 支持 SQLite, PostgreSQL, MySQL, SQL Server, MariaDB

## 🔧 Hooks 系统

```mermaid
graph TB
    subgraph "Clawd on Desk Hooks（settings.json）"
        A[SessionStart] --> A1[auto-start.js]
        A --> A2[clawd-hook.js]
        B[PreToolUse] --> B1[clawd-hook.js]
        C[PostToolUse] --> C1[clawd-hook.js]
        D[Stop] --> D1[clawd-hook.js]
        E[SessionEnd] --> E1[clawd-hook.js]
    end

    subgraph "ECC 插件 Hooks（20+）"
        F[PreToolUse] --> F1[bash:dispatcher]
        F --> F2[config-protection]
        F --> F3[mcp-health-check]
        F --> F4[gateguard-fact-force]
        G[PostToolUse] --> G1[quality-gate]
        G --> G2[design-quality-check]
        G --> G3[console-warn]
        G --> G4[ecc-context-monitor]
        H[Stop] --> H1[format-typecheck]
        H --> H2[cost-tracker]
        H --> H3[desktop-notify]
    end

    subgraph "Understand-Anything Hooks"
        I[SessionStart] --> I1[知识图谱过时检查]
        J[PostToolUse] --> J1[Git commit 检测]
    end

    style A fill:#e3f2fd
    style B fill:#e3f2fd
    style C fill:#e3f2fd
    style D fill:#e3f2fd
    style E fill:#e3f2fd
    style F fill:#e1f5fe
    style G fill:#e1f5fe
    style H fill:#e1f5fe
    style I fill:#e0f7fa
    style J fill:#e0f7fa
```

### Clawd on Desk 功能

| 功能 | 说明 |
|------|------|
| **实时状态感知** | 通过 Claude Code hooks 实时显示工作状态 |
| **12 种动画状态** | idle, thinking, typing, building, error, happy 等 |
| **权限气泡** | Claude Code 请求权限时弹出气泡提醒 |
| **拖拽移动** | 可以拖拽到屏幕任意位置 |
| **迷你模式** | 拖到屏幕边缘隐藏，鼠标悬停显示 |
| **免打扰模式** | 右键菜单进入睡眠模式 |
| **多代理支持** | Claude Code, Codex, Copilot, Gemini 等 |
| **系统托盘** | 调整大小、语言切换、自动启动 |

### 安装方式

```bash
# 下载安装包
# 访问: https://github.com/rullerzhou-afk/clawd-on-desk/releases/latest
# 下载: Clawd-on-Desk-Setup-*-x64.exe

# 或从源码安装
git clone https://github.com/rullerzhou-afk/clawd-on-desk.git
cd clawd-on-desk
npm install
npm start
```

## 🎯 核心配置说明

### 配置层级

```mermaid
graph TB
    A[用户配置 - 最高优先级] --> B[插件配置 - 补充层]
    B --> C[Hooks 配置 - 自动化层]
    C --> D[合并后生效]

    A --> A1[CLAUDE.md - 全局指令]
    A --> A2[SOUL.md - 核心身份]
    A --> A3[AGENTS.md - Agent 指令]
    A --> A4[USER.md - 用户配置]
    A --> A5[rules/ - 分层规则]

    B --> B1[ECC - Agent + Skills]
    B --> B2[Claude HUD - 状态栏]
    B --> B3[Superpowers - 增强]
    B --> B4[Claude Mem - 记忆]
    B --> B5[Understand-Anything - 知识图谱]

    C --> C1[Clawd on Desk - 桌面宠物]
    C --> C2[ECC Hooks - 质量检查]
    C --> C3[Understand-Anything Hooks - 知识图谱]

    style A fill:#c8e6c9
    style B fill:#e3f2fd
    style C fill:#e0f7fa
    style D fill:#fff9c4
```

### CLAUDE.md - 全局指令

提供 Claude Code 的项目级指导，包括：

| 内容 | 说明 |
|------|------|
| **项目概述** | Claude Code 插件 — 生产级 Agent、Skills、Hooks、Commands |
| **安全防护基线** | 防止角色覆盖、数据泄露、恶意内容生成 |
| **架构说明** | agents/、skills/、commands/、hooks/、rules/ 目录结构 |
| **关键命令** | `/tdd`、`/plan`、`/e2e`、`/code-review`、`/build-fix` |
| **开发规范** | 包管理器检测、跨平台支持、Agent/Skill 格式 |

### SOUL.md - 核心身份

ECC 的核心身份和原则：

| 原则 | 说明 |
|------|------|
| **Agent-First** | 尽早路由到专业 Agent 处理领域任务 |
| **Test-Driven** | 先写测试再实现，要求 80%+ 覆盖率 |
| **Security-First** | 验证所有输入，保护密钥，保持安全默认值 |
| **Immutability** | 优先不可变操作，避免状态突变 |
| **Plan Before Execute** | 复杂变更分阶段规划 |

**Agent 编排哲学**：专业 Agent 被主动调用 — planner 用于实现策略，reviewer 用于代码质量，security-reviewer 用于敏感代码，build-resolver 用于工具链故障。

### AGENTS.md - Agent 指令

ECC v2.1.0 提供 **163 个专业 Agent**：

| Agent 类别 | 代表 Agent | 用途 |
|------------|-----------|------|
| **规划** | planner、architect | 实现规划、系统设计 |
| **开发** | tdd-guide、code-reviewer | 测试驱动开发、代码审查 |
| **安全** | security-reviewer | 漏洞检测 |
| **构建** | build-error-resolver | 修复构建/类型错误 |
| **测试** | e2e-runner | 端到端 Playwright 测试 |
| **语言专属** | cpp-reviewer、go-reviewer、rust-reviewer、python-reviewer 等 | 各语言代码审查 |
| **运维** | loop-operator、harness-optimizer | 自动循环执行、配置调优 |

**Agent 编排规则**：

| 场景 | 自动调用 Agent |
|------|---------------|
| 复杂功能请求 | **planner** |
| 代码刚写/修改 | **code-reviewer** |
| Bug 修复或新功能 | **tdd-guide** |
| 架构决策 | **architect** |
| 安全敏感代码 | **security-reviewer** |
| 棕地项目接入 | **spec-miner** |

**安全指南**：提交前检查清单（无硬编码密钥、输入验证、SQL 注入防护、XSS 防护等）

**编码风格**：不可变性优先、小文件（200-400 行）、错误处理、输入验证

**测试要求**：最低 80% 覆盖率，强制 TDD 工作流（RED → GREEN → REFACTOR）

**开发工作流**：Plan → TDD → Review → Capture Knowledge → Commit

## 🔒 安全说明

```mermaid
graph TB
    A[安全检查清单] --> B[API Key / Token]
    A --> C[密码]
    A --> D[私钥]
    A --> E[内网 IP]
    A --> F[个人身份信息]

    G[settings.json] --> H[已脱敏<br/>API Key 替换为占位符]

    I[建议] --> J[设为私有仓库]
    I --> K[不要提交敏感信息]
    I --> L[使用环境变量]

    style A fill:#ffebee
    style G fill:#e8f5e9
    style I fill:#fff3e0
```

⚠️ **重要安全提示**

1. **settings.json 已脱敏** - API Key 等敏感信息已替换为占位符
2. **不要提交敏感信息** - `.env.secrets`、API Key 等不要上传到公开仓库
3. **私有仓库建议** - 建议将此仓库设为私有

## 📚 相关文档

| 文档 | 说明 |
|------|------|
| [INSTALL.md](INSTALL.md) | 完整安装指南 |
| [PLUGINS.md](PLUGINS.md) | 插件安装指南（含 GitHub 链接） |
| [CONFIG-ARCHITECTURE.md](CONFIG-ARCHITECTURE.md) | 配置架构详解 |

## 📦 相关仓库

| 仓库 | 内容 | 地址 |
|------|------|------|
| **shuai-yemao-chip** | 核心配置 | https://github.com/shuai-yemao/shuai-yemao-chip |
| **shuai-yemao-chip-skills** | 技能包（142） | https://github.com/shuai-yemao/shuai-yemao-chip-skills |
| **shuai-yemao-workflow** | 工作流（15+） | https://github.com/shuai-yemao/shuai-yemao-workflow |

## 📋 更新日志

### 2026-06-30

- ✅ 新增 6 个官方插件（global 作用域）
  - **clangd-lsp** — C/C++ 代码智能提示、跳转、诊断
  - **pyright-lsp** — Python 类型检查和代码智能
  - **claude-md-management** — CLAUDE.md 审查和会话学习捕获
  - **hookify** — Hook 自动化创建（分析会话预防不良行为）
  - **skill-creator** — 技能创建、优化和评估
  - **session-report** — HTML 会话报告（令牌/缓存/子代理）
- ✅ 新增 Codex 插件（OpenAI 协作编程）
- ✅ 新增 claude-plugins-official 市场源配置
- ✅ 更新 plugin-registry.json 注册表
- ✅ 同步 settings.json（hooks/statusline/spinner/language）
- ✅ 插件总数：6 → 12，Agent 总数：79 → 163，Skills：107+

### 2026-06-25

- ✅ 更新 Agent 数量：163（含官方插件新增）
- ✅ 同步所有 Agent 定义文件到仓库
- ✅ 更新配置文件（AGENTS.md / SOUL.md / CLAUDE.md / USER.md）
- ✅ 启用 Understand-Anything 插件（知识图谱）
  - 添加到 enabledPlugins
  - 配置 SessionStart 和 PostToolUse hooks
- ✅ 启用 ECC 插件（20+ hooks 已加载）
  - PreToolUse: bash:dispatcher, config-protection, mcp-health-check, gateguard-fact-force
  - PostToolUse: quality-gate, design-quality-check, console-warn, ecc-context-monitor
  - Stop: format-typecheck, cost-tracker, desktop-notify
- ✅ 更新插件系统图（12 个插件）
- ✅ 更新 MCP 服务器配置（仅 DBHub）
- ✅ 新增 Hooks 系统图（Clawd on Desk + ECC + Understand-Anything）
- ✅ 移除 Context7 MCP（未配置）

### 2026-06-24

- ✅ 初始版本
- ✅ 核心配置采用 ECC 标准（CLAUDE.md / SOUL.md / AGENTS.md / USER.md）
- ✅ 规则体系（security / workflow / embedded / privacy / ecc）
- ✅ 参考文档（EMBEDDED.md / SECURITY.md / WORKFLOWS.md）
- ✅ 插件配置（ECC / HUD / Superpowers / 中文 / Mem / Understand-Anything）
- ✅ 安装脚本（install.sh / install-plugins.sh）
- ✅ 完整文档（README / INSTALL / PLUGINS / CONFIG-ARCHITECTURE）
- ✅ README 使用 Mermaid 图表可视化架构
- ✅ 添加 Understand-Anything 知识图谱插件
- ✅ 更新技能包数量：142 个技能

## 📄 许可证

MIT License
