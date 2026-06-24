# Shuai Yemao Chip

Claude Code 完整配置备份 — 用于在新电脑上快速恢复开发环境。

## 仓库结构

```
shuai-yemao-chip/
├── config/                 # 核心配置文件
│   ├── CLAUDE.md          # 全局指令
│   ├── SOUL.md            # 人格配置 (Chip)
│   ├── AGENTS.md          # Agent 行为守则
│   ├── USER.md            # 用户配置
│   └── settings.json      # 主设置（已脱敏）
├── rules/                  # 规则文件
│   ├── security/          # 安全规则
│   ├── workflow/          # 工作流规则
│   ├── embedded/          # 嵌入式规则
│   ├── privacy/           # 隐私规则
│   └── ecc/               # ECC 规则
├── agents/                 # Agent 定义
│   ├── code-reviewer.md   # 代码审查 Agent
│   ├── devops.md          # DevOps Agent
│   ├── embedded-expert.md # 嵌入式专家 Agent
│   └── test-runner.md     # 测试运行 Agent
├── reference/              # 参考文档
│   ├── EMBEDDED.md        # 嵌入式开发约束
│   ├── SECURITY.md        # 安全规范
│   └── WORKFLOWS.md       # 工作流 API 参考
├── templates/              # 模板文件
├── scripts/                # 脚本文件
│   ├── install.sh         # 安装脚本
│   └── wf.sh              # 工作流快捷命令
├── bin/                    # 工具脚本
├── INSTALL.md              # 安装指南
└── README.md               # 本文件
```

## 相关仓库

| 仓库 | 内容 | 地址 |
|------|------|------|
| **shuai-yemao-chip** | 核心配置 | https://github.com/shuai-yemao/shuai-yemao-chip |
| **shuai-yemao-chip-skills** | 技能包 | https://github.com/shuai-yemao/shuai-yemao-chip-skills |
| **shuai-yemao-workflow** | 工作流 | https://github.com/shuai-yemao/shuai-yemao-workflow |

## 快速开始

```bash
# 1. 克隆配置仓库
git clone https://github.com/shuai-yemao/shuai-yemao-chip.git ~/shuai-yemao-chip

# 2. 运行安装
cd ~/shuai-yemao-chip
./scripts/install.sh

# 3. 安装插件
./scripts/install-plugins.sh

# 4. 配置 API Key
vim ~/.claude/settings.json

# 5. 重启 Claude Code
claude
```

详见 [INSTALL.md](INSTALL.md) 和 [PLUGINS.md](PLUGINS.md)

## 核心配置说明

### SOUL.md - Chip 人格

嵌入式系统架构师人格，专注于：
- MCU 架构（ARM Cortex, STM32 HAL/SPL）
- 外设驱动（ADC, DAC, DMA, Timer, I²C, SPI, CAN, UART）
- 无线通信（BLE, WiFi, LoRa, MQTT）
- RTOS（FreeRTOS）
- 工具链（CMake, IAR, Keil, ESP-IDF, PlatformIO）

### AGENTS.md - 行为守则

定义了 Agent 的权限等级、文件操作边界、通信协议和安全约束。

### rules/ - 分层规则

| 规则目录 | 用途 |
|----------|------|
| `security/` | 安全规则（密钥管理、MCP 安全、权限配置） |
| `workflow/` | 工作流编写规则 |
| `embedded/` | 嵌入式开发专属约束 |
| `privacy/` | 数据隐私与脱敏规则 |
| `ecc/` | ECC（Evolved Constitutional AI）规则 |

### agents/ - 专用 Agent

| Agent | 用途 |
|-------|------|
| `code-reviewer` | 代码质量审查 |
| `devops` | 部署与运维 |
| `embedded-expert` | 嵌入式开发专家 |
| `test-runner` | 测试执行与分析 |

## 安全说明

⚠️ **重要安全提示**

1. **settings.json 已脱敏** - API Key 等敏感信息已替换为占位符
2. **不要提交敏感信息** - `.env.secrets`、API Key 等不要上传到公开仓库
3. **私有仓库建议** - 建议将此仓库设为私有

### 敏感信息检查清单

- [ ] API Key / Token
- [ ] 密码
- [ ] 私钥
- [ ] 内网 IP 地址
- [ ] 个人身份信息

## 更新日志

### 2026-06-24

- 初始版本
- 包含完整的 Claude Code 配置
- 添加安装指南
- 集成 skills 和 workflows 仓库

## 许可证

MIT License
