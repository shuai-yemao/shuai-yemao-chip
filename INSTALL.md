# Claude Code 配置安装指南

将 Claude Code 配置从 GitHub 仓库恢复到新电脑。

## 快速安装

### 1. 克隆仓库

```bash
git clone https://github.com/shuai-yemao/shuai-yemao-chip.git ~/shuai-yemao-chip
cd ~/shuai-yemao-chip
```

### 2. 运行安装脚本

```bash
# Windows (Git Bash)
./scripts/install.sh

# 或手动复制（见下方）
```

### 3. 手动安装步骤

#### 步骤 1: 复制核心配置

```bash
# 创建目录
mkdir -p ~/.claude

# 复制配置文件
cp config/CLAUDE.md ~/.claude/
cp config/SOUL.md ~/.claude/
cp config/AGENTS.md ~/.claude/
cp config/USER.md ~/.claude/
```

#### 步骤 2: 配置 settings.json

```bash
# 复制模板
cp config/settings.json ~/.claude/settings.json

# 编辑并填入你的敏感信息
# - ANTHROPIC_AUTH_TOKEN: 你的 API Key
# - skills.directories: 你的用户名路径
```

#### 步骤 3: 复制目录

```bash
# Rules 规则
cp -r rules/* ~/.claude/rules/

# Agents 定义
cp -r agents/* ~/.claude/agents/

# Reference 参考文档
cp -r reference/* ~/.claude/reference/

# Templates 模板
cp -r templates/* ~/.claude/templates/

# Scripts 脚本
cp -r scripts/* ~/.claude/scripts/

# Bin 工具
cp -r bin/* ~/.claude/bin/
```

#### 步骤 4: 克隆 Skills 和 Workflows

```bash
# Skills 技能包
git clone https://github.com/shuai-yemao/shuai-yemao-chip-skills.git ~/.claude/skills-tmp
cp -r ~/.claude/skills-tmp/skills/* ~/.claude/skills/
rm -rf ~/.claude/skills-tmp

# Workflows 工作流
git clone https://github.com/shuai-yemao/shuai-yemao-workflow.git ~/.claude/workflows-tmp
cp -r ~/.claude/workflows-tmp/workflows/* ~/.claude/workflows/
rm -rf ~/.claude/workflows-tmp
```

#### 步骤 5: 安装插件

```bash
# 启动 Claude Code 后运行
/plugin install claude-hud
/plugin install ecc
/plugin install superpowers
```

## 目录结构说明

```
~/.claude/
├── CLAUDE.md           # 全局指令
├── SOUL.md             # 人格配置 (Chip)
├── AGENTS.md           # Agent 行为守则
├── USER.md             # 用户配置
├── settings.json       # 主设置（需填入 API Key）
├── rules/              # 规则文件
│   ├── security/       # 安全规则
│   ├── workflow/       # 工作流规则
│   ├── embedded/       # 嵌入式规则
│   ├── privacy/        # 隐私规则
│   └── ecc/            # ECC 规则
├── agents/             # Agent 定义
│   ├── code-reviewer.md
│   ├── devops.md
│   ├── embedded-expert.md
│   └── test-runner.md
├── reference/          # 参考文档
│   ├── EMBEDDED.md
│   ├── SECURITY.md
│   └── WORKFLOWS.md
├── templates/          # 模板文件
├── skills/             # 技能包（从 chip-skills 仓库）
├── workflows/          # 工作流（从 workflow 仓库）
├── scripts/            # 脚本文件
└── bin/                # 工具脚本
```

## 需要手动配置的敏感信息

### settings.json

| 字段 | 说明 |
|------|------|
| `ANTHROPIC_AUTH_TOKEN` | 你的 API Key |
| `skills.directories` | 你的用户名路径 |

### 可选：MCP Server 配置

如果你使用 MCP Server，需要在 `settings.json` 中配置：

```json
"mcpServers": {
  "your-server": {
    "type": "http",
    "url": "https://your-mcp-server.com"
  }
}
```

## 验证安装

```bash
# 启动 Claude Code
claude

# 检查配置
/status

# 检查技能
/skills

# 测试工作流
Workflow({ name: 'requirements-alignment', args: { requirement: 'test' } })
```

## 故障排除

### 问题：找不到技能

```bash
# 检查技能目录
ls -la ~/.claude/skills/

# 重新克隆技能仓库
git clone https://github.com/shuai-yemao/shuai-yemao-chip-skills.git ~/.claude/skills-tmp
cp -r ~/.claude/skills-tmp/skills/* ~/.claude/skills/
```

### 问题：工作流不工作

```bash
# 检查工作流目录
ls -la ~/.claude/workflows/

# 重新克隆工作流仓库
git clone https://github.com/shuai-yemao/shuai-yemao-workflow.git ~/.claude/workflows-tmp
cp -r ~/.claude/workflows-tmp/workflows/* ~/.claude/workflows/
```

### 问题：插件未加载

```bash
# 检查插件目录
ls -la ~/.claude/plugins/

# 重新安装插件
/plugin install claude-hud
/plugin install ecc
```

## 同步更新

当原始配置更新时，在新电脑上执行：

```bash
# 拉取最新配置
cd ~/shuai-yemao-chip
git pull

# 重新复制配置
cp config/* ~/.claude/
cp -r rules/* ~/.claude/rules/
cp -r agents/* ~/.claude/agents/
cp -r reference/* ~/.claude/reference/

# 更新技能和工作流
cd ~/.claude/skills && git pull
cd ~/.claude/workflows && git pull
```
