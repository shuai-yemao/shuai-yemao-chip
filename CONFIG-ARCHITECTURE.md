# Claude Code 配置架构说明

## 配置层级关系

```
┌─────────────────────────────────────────────────────────────┐
│                    用户自定义配置（最高优先级）                  │
├─────────────────────────────────────────────────────────────┤
│  ~/.claude/CLAUDE.md      ← 全局指令（系统架构、日常使用）     │
│  ~/.claude/SOUL.md        ← 人格配置（Chip - 嵌入式架构师）   │
│  ~/.claude/AGENTS.md      ← Agent 行为守则（权限、边界）      │
│  ~/.claude/USER.md        ← 用户配置（偏好、环境）            │
│  ~/.claude/rules/         ← 分层规则（安全、工作流、嵌入式）   │
└─────────────────────────────────────────────────────────────┘
                              ↓ 补充（不覆盖）
┌─────────────────────────────────────────────────────────────┐
│                    ECC 插件配置（插件层）                      │
├─────────────────────────────────────────────────────────────┤
│  plugins/cache/ecc/CLAUDE.md    ← ECC 项目说明               │
│  plugins/cache/ecc/SOUL.md      ← ECC 核心身份               │
│  plugins/cache/ecc/AGENTS.md    ← ECC Agent 编排规则         │
│  rules/ecc/                     ← ECC 规则（补充用户规则）    │
└─────────────────────────────────────────────────────────────┘
```

## 详细配置说明

### 1. 用户自定义配置（你的配置）

#### CLAUDE.md - 全局指令
```markdown
# Claude Code 全局配置

SOUL.md（Chip 人格）和 AGENTS.md（行为守则）由 session-start hook 自动注入。

**五层 Agent 系统已全局部署。** 任意目录下可直接调用 Workflow。

## 系统架构
需求对齐层 → 安全层 → 编排层 → 记忆层
                    工具层（技能管理）  Ops 层（系统运维）

## 日常使用
- 启动新需求: Workflow({ name: 'requirements-alignment', args: {...} })
- 专用 Agent: embedded-expert, frontend-expert, code-reviewer, test-runner, devops
```

**作用**: 定义系统架构和日常使用方式，是 Claude Code 的入口指令。

#### SOUL.md - 人格配置
```markdown
# Chip — 系统级架构师

> 嵌入式系统架构师。Grill Mode 默认。

## Role
系统级架构师。Grill 逐层对齐需求，产出施工文件，确认后执行。

## 专业领域
- MCU 架构: ARM Cortex, STM32 HAL/SPL
- 外设驱动: ADC, DAC, DMA, Timer, I²C, SPI, CAN, UART
- 无线通信: BLE, WiFi, LoRa, MQTT
- RTOS: FreeRTOS
- 工具链: CMake, IAR, Keil, ESP-IDF, PlatformIO
```

**作用**: 定义 Claude 的人格和专业领域，决定回答风格和专业方向。

#### AGENTS.md - Agent 行为守则
```markdown
# Agents — AI 行为守则

## 权限等级
| 等级 | 行为 |
|------|------|
| 🟢 自动 | 读、查、问（不需要确认） |
| 🟡 确认 | 写、改、删、执行（先问再干） |
| 🔴 必须你批准 | 不可逆操作（git push、rm -rf 等） |

## 文件操作边界
| 路径 | 读 | 写 | 删 | 执行 |
|------|:--:|:--:|:--:|:--:|
| *.md（项目根） | 🟢 | 🟡 | 🔴 | — |
| .claude/ | 🟢 | 🟡 | 🔴 | — |
| skills/ | 🟢 | 🟡 | 🔴 | — |
```

**作用**: 定义 Agent 的权限等级、文件操作边界和安全约束。

#### USER.md - 用户配置
```markdown
# User Profile

## Name
TNSH

## Preferences
- 语言：中文（Simplified Chinese），代码/寄存器/路径/命令保持英文
- 风格：简洁务实，用数据支撑结论
- 嵌入式领域：STM32 Cortex-M3/M4/M7、ESP32-S3、FreeRTOS
- 知识管理：使用 Obsidian 管理嵌入式知识

## Context
- 操作系统：Windows
- Python：C:\Users\zhang\AppData\Local\Programs\Python\Python312\python
- Obsidian Vault：C:\Users\zhang\Documents\Obsidian Vault
```

**作用**: 定义用户偏好、工作环境和工具链，让 Claude 更了解你的工作方式。

#### rules/ - 分层规则
```
rules/
├── INDEX.md              ← 规则索引
├── security/             ← 安全规则（密钥管理、MCP 安全）
├── workflow/             ← 工作流规则（Workflow 编写）
├── embedded/             ← 嵌入式规则（STM32、HAL 库）
├── privacy/              ← 隐私规则（数据脱敏）
└── ecc/                  ← ECC 规则（补充用户规则）
    ├── common/           ← 通用 ECC 规则
    └── typescript/       ← TypeScript 专属规则
```

**作用**: 按领域分层组织规则，补充 AGENTS.md 的具体约束。

---

### 2. ECC 插件配置（插件层）

#### ECC 是什么？
ECC（Everything Claude Code）是一个 Claude Code 插件，提供：
- 30+ 专业 Agent
- 135+ 技能
- 60+ 命令
- 自动化 Hook 工作流

#### ECC 的配置文件
```markdown
# plugins/cache/ecc/SOUL.md

## Core Identity
Everything Claude Code (ECC) is a production-ready AI coding plugin
with 30 specialized agents, 135 skills, 60 commands, and automated
hook workflows for software development.

## Core Principles
1. Agent-First — route work to the right specialist as early as possible.
2. Test-Driven — write or refresh tests before trusting implementation changes.
3. Security-First — validate inputs, protect secrets, and keep safe defaults.
4. Immutability — prefer explicit state transitions over mutation.
5. Plan Before Execute — complex changes should be broken into deliberate phases.
```

#### ECC 的规则（rules/ecc/）
```markdown
# rules/ecc/common/agents.md

## Available Agents
| Agent | Purpose | When to Use |
|-------|---------|-------------|
| planner | Implementation planning | Complex features, refactoring |
| architect | System design | Architectural decisions |
| tdd-guide | Test-driven development | New features, bug fixes |
| code-reviewer | Code review | After writing code |
| security-reviewer | Security analysis | Before commits |
```

**作用**: ECC 提供通用的 Agent 编排规则、安全规则、编码风格等，作为你自定义规则的补充。

---

## 配置加载顺序

```
1. 用户自定义配置（最高优先级）
   ↓
2. 插件配置（ECC 等，补充用户配置）
   ↓
3. 合并后的配置生效
```

### 关键点

1. **用户配置优先**: 你的 `CLAUDE.md`、`SOUL.md`、`AGENTS.md` 会覆盖 ECC 的同名配置
2. **规则合并**: `rules/ecc/` 的规则会与你的 `rules/` 目录下的规则合并
3. **Agent 扩展**: ECC 提供的 Agent 会添加到你的 Agent 列表中，但你的 `agents/` 目录下的定义优先

---

## 实际使用示例

### 场景 1: 嵌入式开发
```bash
# 你的 SOUL.md 定义了 Chip 人格（嵌入式架构师）
# ECC 的 rules/ecc/common/security.md 提供安全规则
# 两者合并：嵌入式开发 + 安全约束

# Claude 会：
# 1. 使用你的 Chip 人格（嵌入式专业领域）
# 2. 遵守你的 AGENTS.md 权限等级
# 3. 应用 ECC 的安全检查规则
```

### 场景 2: 代码审查
```bash
# 你的 agents/code-reviewer.md 定义了代码审查 Agent
# ECC 的 rules/ecc/common/code-review.md 提供审查规则
# 两者合并：你的审查标准 + ECC 的最佳实践

# Claude 会：
# 1. 使用你的 code-reviewer Agent 配置
# 2. 应用你的代码审查标准
# 3. 补充 ECC 的安全和质量检查
```

### 场景 3: 工作流执行
```bash
# 你的 workflows/ 目录定义了工作流
# ECC 的 commands/ 提供快捷命令
# 两者独立，互不干扰

# Claude 会：
# 1. 优先使用你的 workflows/
# 2. ECC 的 commands 作为补充
```

---

## 配置文件对比

| 文件 | 用户配置 | ECC 配置 | 优先级 |
|------|----------|----------|--------|
| `CLAUDE.md` | `~/.claude/CLAUDE.md` | `plugins/ecc/CLAUDE.md` | 用户 > ECC |
| `SOUL.md` | `~/.claude/SOUL.md` | `plugins/ecc/SOUL.md` | 用户 > ECC |
| `AGENTS.md` | `~/.claude/AGENTS.md` | `plugins/ecc/AGENTS.md` | 用户 > ECC |
| `rules/` | `~/.claude/rules/` | `rules/ecc/` | 合并，用户规则优先 |
| `agents/` | `~/.claude/agents/` | `plugins/ecc/agents/` | 合并，用户 Agent 优先 |
| `skills/` | `~/.claude/skills/` | `plugins/ecc/skills/` | 合并，用户技能优先 |

---

## 如何自定义

### 1. 修改你的配置
```bash
# 编辑你的 SOUL.md（人格）
vim ~/.claude/SOUL.md

# 编辑你的 AGENTS.md（行为守则）
vim ~/.claude/AGENTS.md

# 编辑你的规则
vim ~/.claude/rules/security/README.md
```

### 2. 禁用 ECC 的某些规则
```bash
# 如果 ECC 的某个规则与你的冲突，可以在你的规则中覆盖
# 例如：禁用 ECC 的 TypeScript 规则
echo "# TypeScript 规则已禁用" > ~/.claude/rules/ecc/typescript/.disabled
```

### 3. 添加自己的 Agent
```bash
# 在你的 agents/ 目录添加
vim ~/.claude/agents/my-custom-agent.md
```

---

## 总结

1. **你的配置是核心**: `CLAUDE.md`、`SOUL.md`、`AGENTS.md` 定义了你的 Claude Code 行为
2. **ECC 是补充**: 提供通用的 Agent、技能、规则，补充你的配置
3. **合并生效**: 两者配置会合并，用户配置优先级更高
4. **灵活自定义**: 你可以随时修改你的配置，ECC 不会覆盖

**简单来说**: 你的配置告诉 Claude "你是谁、怎么做"，ECC 的配置告诉 Claude "有什么工具可以用"。
