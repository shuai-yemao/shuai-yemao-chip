# Shuai Yemao Chip

Claude Code 完整配置备份 — 用于在新电脑上快速恢复开发环境。

## 🏗️ 系统架构

```mermaid
graph TB
    subgraph "Claude Code 配置系统"
        A[CLAUDE.md<br/>全局指令] --> B[SOUL.md<br/>人格配置]
        A --> C[AGENTS.md<br/>行为守则]
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
        K[agents/] --> L[code-reviewer]
        K --> M[devops]
        K --> N[embedded-expert]
        K --> O[test-runner]
    end

    subgraph "插件系统"
        P[plugins/] --> Q[ECC<br/>67 Agent + 271 Skills]
        P --> R[Claude HUD<br/>状态栏]
        P --> S[Superpowers<br/>增强功能]
        P --> T[Claude 中文<br/>汉化]
        P --> U[Claude Mem<br/>记忆管理]
    end

    B --> V[嵌入式系统架构师]
    C --> W[权限等级 + 安全约束]
    J --> X[ECC 标准规则]
    Q --> Y[Agent 编排 + 工作流]
```

## 📦 仓库关系

```mermaid
graph LR
    A[shuai-yemao-chip<br/>核心配置] --> B[shuai-yemao-chip-skills<br/>技能包]
    A --> C[shuai-yemao-workflow<br/>工作流]

    B --> D[85+ 技能]
    C --> E[15+ 核心工作流]

    A --> F[配置文件<br/>CLAUDE.md / SOUL.md / AGENTS.md]
    A --> G[规则体系<br/>security / workflow / embedded]
    A --> H[Agent 定义<br/>code-reviewer / devops / ...]
    A --> I[插件配置<br/>ECC / HUD / Superpowers]

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
        A[config/] --> A1[CLAUDE.md]
        A --> A2[SOUL.md]
        A --> A3[AGENTS.md]
        A --> A4[USER.md]
        A --> A5[settings.json]

        B[rules/] --> B1[security/]
        B --> B2[workflow/]
        B --> B3[embedded/]
        B --> B4[privacy/]
        B --> B5[ecc/]

        C[agents/] --> C1[code-reviewer.md]
        C --> C2[devops.md]
        C --> C3[embedded-expert.md]
        C --> C4[test-runner.md]

        D[reference/] --> D1[EMBEDDED.md]
        D --> D2[SECURITY.md]
        D --> D3[WORKFLOWS.md]

        E[scripts/] --> E1[install.sh]
        E --> E2[install-plugins.sh]
        E --> E3[wf.sh]

        F[bin/] --> F1[model-switch]
        F --> F2[switch-api.js]
    end

    style A fill:#e3f2fd
    style B fill:#fce4ec
    style C fill:#e8f5e9
    style D fill:#fff3e0
    style E fill:#f3e5f5
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
    A --> A2[SOUL.md - 人格配置]
    A --> A3[AGENTS.md - 行为守则]
    A --> A4[USER.md - 用户配置]
    A --> A5[rules/ - 分层规则]

    B --> B1[ECC - Agent + Skills]
    B --> B2[Claude HUD - 状态栏]
    B --> B3[Superpowers - 增强]

    style A fill:#c8e6c9
    style B fill:#e3f2fd
    style C fill:#fff9c4
```

### SOUL.md - 人格配置

| 领域 | 覆盖方向 |
|------|----------|
| **MCU 架构** | ARM Cortex（core 寄存器、中断异常、内存架构）、STM32 HAL/SPL |
| **外设驱动** | ADC、DAC、DMA、Timer、Watchdog、CRC、RTC、Flash、SRAM |
| **总线协议** | I²C、SPI、CAN、UART、USB |
| **无线通信** | BLE、WiFi、LoRa、GPS、Cellular、MQTT |
| **RTOS** | FreeRTOS 模块、RTOS 调试与优化 |
| **工具链** | CMake、IAR、Keil、ESP-IDF、PlatformIO |

### AGENTS.md - 行为守则

| 权限等级 | 行为 |
|----------|------|
| 🟢 **自动** | 读、查、问（不需要确认） |
| 🟡 **确认** | 写、改、删、执行（先问再干） |
| 🔴 **必须批准** | 不可逆操作（git push、rm -rf 等） |

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
- ✅ 核心配置（CLAUDE.md / SOUL.md / AGENTS.md / USER.md）
- ✅ 规则体系（security / workflow / embedded / privacy / ecc）
- ✅ Agent 定义（code-reviewer / devops / embedded-expert / test-runner）
- ✅ 参考文档（EMBEDDED.md / SECURITY.md / WORKFLOWS.md）
- ✅ 插件配置（ECC / HUD / Superpowers / 中文 / Mem）
- ✅ 安装脚本（install.sh / install-plugins.sh）
- ✅ 完整文档（README / INSTALL / PLUGINS / CONFIG-ARCHITECTURE）

## 📄 许可证

MIT License
