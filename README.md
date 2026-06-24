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
        K[67 专业 Agent] --> L[planner<br/>实现规划]
        K --> M[architect<br/>系统设计]
        K --> N[code-reviewer<br/>代码审查]
        K --> O[security-reviewer<br/>安全检测]
        K --> P[tdd-guide<br/>测试驱动]
    end

    subgraph "插件系统"
        Q[plugins/] --> R[ECC<br/>67 Agent + 271 Skills]
        Q --> S[Claude HUD<br/>状态栏]
        Q --> T[Superpowers<br/>增强功能]
        Q --> U[Claude 中文<br/>汉化]
        Q --> V[Claude Mem<br/>记忆管理]
    end

    B --> W[Agent-First<br/>Test-Driven<br/>Security-First]
    C --> X[67 Agent + 安全指南<br/>+ 编码风格 + 测试要求]
    J --> Y[ECC 标准规则]
    R --> Z[Agent 编排 + 工作流]
```

## 📦 仓库关系

```mermaid
graph LR
    A[shuai-yemao-chip<br/>核心配置] --> B[shuai-yemao-chip-skills<br/>技能包]
    A --> C[shuai-yemao-workflow<br/>工作流]

    B --> D[85+ 技能]
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
    I --> N[配置 API Key]
    J --> N
    K --> N
    L --> N
    M --> N
    N --> O[重启 Claude Code]
    O --> P[完成]

    style A fill:#c8e6c9
    style P fill:#c8e6c9
    style N fill:#fff9c4
```

## 📁 仓库结构

```mermaid
graph TB
    subgraph "shuai-yemao-chip"
        A[config/] --> A1[CLAUDE.md<br/>ECC 全局指令]
        A --> A2[SOUL.md<br/>ECC 核心身份]
        A --> A3[AGENTS.md<br/>ECC 67 Agent 指令]
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
    end

    style A fill:#e3f2fd
    style B fill:#fce4ec
    style C fill:#fff3e0
    style D fill:#f3e5f5
    style E fill:#e8f5e9
```

## 🔌 插件系统

```mermaid
graph TB
    subgraph "已安装插件"
        A[ECC] --> A1[67 Agent]
        A --> A2[271 Skills]
        A --> A3[92 Commands]

        B[Claude HUD] --> B1[状态栏]
        B --> B2[进度显示]
        B --> B3[成本追踪]

        C[Superpowers] --> C1[增强技能]
        C --> C2[社区工作流]

        D[Claude 中文] --> D1[界面汉化]
        D --> D2[中文提示]

        E[Claude Mem] --> E1[记忆持久化]
        E --> E2[上下文管理]
    end

    subgraph "插件来源"
        F[GitHub 仓库]
        F --> G[affaan-m/ECC]
        F --> H[jarrodwatts/claude-hud]
        F --> I[obra/superpowers-marketplace]
        F --> J[anthropics/claude-plugins-official]
        F --> K[thedotmack/claude-mem]
    end

    G --> A
    H --> B
    I --> C
    J --> D
    K --> E

    style A fill:#e1f5fe
    style B fill:#f3e5f5
    style C fill:#e8f5e9
    style D fill:#fff3e0
    style E fill:#fce4ec
```

## 🎯 核心配置说明

### 配置层级

```mermaid
graph TB
    A[用户配置 - 最高优先级] --> B[插件配置 - 补充层]
    B --> C[合并后生效]

    A --> A1[CLAUDE.md - 全局指令]
    A --> A2[SOUL.md - 核心身份]
    A --> A3[AGENTS.md - Agent 指令]
    A --> A4[USER.md - 用户配置]
    A --> A5[rules/ - 分层规则]

    B --> B1[ECC - Agent + Skills]
    B --> B2[Claude HUD - 状态栏]
    B --> B3[Superpowers - 增强]

    style A fill:#c8e6c9
    style B fill:#e3f2fd
    style C fill:#fff9c4
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

ECC v2.0.0 提供 **67 个专业 Agent**：

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
| **shuai-yemao-chip-skills** | 技能包（85+） | https://github.com/shuai-yemao/shuai-yemao-chip-skills |
| **shuai-yemao-workflow** | 工作流（15+） | https://github.com/shuai-yemao/shuai-yemao-workflow |

## 📋 更新日志

### 2026-06-24

- ✅ 初始版本
- ✅ 核心配置采用 ECC 标准（CLAUDE.md / SOUL.md / AGENTS.md / USER.md）
- ✅ 规则体系（security / workflow / embedded / privacy / ecc）
- ✅ 参考文档（EMBEDDED.md / SECURITY.md / WORKFLOWS.md）
- ✅ 插件配置（ECC / HUD / Superpowers / 中文 / Mem）
- ✅ 安装脚本（install.sh / install-plugins.sh）
- ✅ 完整文档（README / INSTALL / PLUGINS / CONFIG-ARCHITECTURE）
- ✅ README 使用 Mermaid 图表可视化架构

## 📄 许可证

MIT License
