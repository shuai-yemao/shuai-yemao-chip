# Claude Code 插件安装指南

本文档列出所有需要安装的插件及其 GitHub 仓库链接。

## 插件总览

| 插件 | 用途 | GitHub 仓库 |
|------|------|-------------|
| **ECC** | 核心插件 - 67 Agent + 271 Skills + 92 Commands | [affaan-m/ECC](https://github.com/affaan-m/ECC) |
| **Claude HUD** | 状态栏和进度显示 | [jarrodwatts/claude-hud](https://github.com/jarrodwatts/claude-hud) |
| **Superpowers** | 增强功能和技能 | [obra/superpowers-marketplace](https://github.com/obra/superpowers-marketplace) |
| **Claude Code 中文** | 界面汉化 | [anthropics/claude-plugins-official](https://github.com/anthropics/claude-plugins-official) |
| **Claude Mem** | 记忆管理 | [thedotmack/claude-mem](https://github.com/thedotmack/claude-mem) |
| **Understand-Anything** | 知识图谱 - 代码分析和可视化 | [Lum1104/Understand-Anything](https://github.com/Lum1104/Understand-Anything) |

---

## 详细安装步骤

### 1. ECC (Everything Claude Code) - 核心插件

**GitHub**: https://github.com/affaan-m/ECC

**功能**:
- 67 个专业 Agent（planner、architect、tdd-guide、code-reviewer 等）
- 271 个技能（工作流、领域知识）
- 92 个命令（/tdd、/plan、/e2e 等）
- 自动化 Hook 工作流
- 安全规则和编码标准

**安装**:
```bash
# 启动 Claude Code 后运行
/plugin install ecc

# 或手动克隆
git clone https://github.com/affaan-m/ECC.git ~/.claude/plugins/marketplaces/ecc
```

**配置**: 安装后自动生效，无需额外配置。

---

### 2. Claude HUD - 状态栏显示

**GitHub**: https://github.com/jarrodwatts/claude-hud

**功能**:
- 实时状态栏显示
- 进度条和任务跟踪
- 自定义主题和颜色
- 成本追踪

**安装**:
```bash
# 启动 Claude Code 后运行
/plugin install claude-hud

# 或手动克隆
git clone https://github.com/jarrodwatts/claude-hud.git ~/.claude/plugins/marketplaces/claude-hud
```

**配置**: 安装后自动生效。

---

### 3. Superpowers - 增强功能

**GitHub**: https://github.com/obra/superpowers-marketplace

**功能**:
- 增强的技能库
- 额外的 Agent 和命令
- 社区贡献的工作流
- 扩展的开发工具

**安装**:
```bash
# 启动 Claude Code 后运行
/plugin install superpowers

# 或手动克隆
git clone https://github.com/obra/superpowers-marketplace.git ~/.claude/plugins/marketplaces/superpowers-marketplace
```

**配置**: 安装后自动生效。

---

### 4. Claude Code 中文汉化

**GitHub**: https://github.com/anthropics/claude-plugins-official

**功能**:
- 界面汉化
- 中文提示和错误消息
- 本地化支持

**安装**:
```bash
# 启动 Claude Code 后运行
/plugin install claude-code-zh-cn

# 或手动克隆
git clone https://github.com/anthropics/claude-plugins-official.git ~/.claude/plugins/marketplaces/claude-plugins-official
```

**配置**: 安装后自动生效。

---

### 5. Claude Mem - 记忆管理

**GitHub**: https://github.com/thedotmack/claude-mem

**功能**:
- 会话记忆持久化
- 上下文管理
- 知识积累

**安装**:
```bash
# 启动 Claude Code 后运行
/plugin install claude-mem

# 或手动克隆
git clone https://github.com/thedotmack/claude-mem.git ~/.claude/plugins/marketplaces/thedotmack
```

**配置**: 安装后自动生效。

---

### 6. Understand-Anything - 知识图谱

**GitHub**: https://github.com/Lum1104/Understand-Anything

**功能**:
- 代码库分析和知识图谱构建
- 交互式可视化仪表板
- 智能搜索（按名称或语义）
- 差异影响分析
- 新人入职指南生成
- 业务领域知识提取

**安装**:
```bash
# 启动 Claude Code 后运行
/plugin marketplace add Egonex-AI/Understand-Anything
/plugin install understand-anything

# 或手动克隆
git clone https://github.com/Lum1104/Understand-Anything.git ~/.claude/plugins/marketplaces/Understand-Anything
cd ~/.claude/plugins/marketplaces/Understand-Anything
./install.sh claude
```

**使用命令**:
| 命令 | 功能 |
|------|------|
| `/understand` | 分析项目，构建知识图谱 |
| `/understand-dashboard` | 打开交互式可视化仪表板 |
| `/understand-chat` | 向代码库提问 |
| `/understand-diff` | 分析当前更改的影响 |
| `/understand-explain <file>` | 解释特定文件 |
| `/understand-domain` | 提取业务领域知识 |
| `/understand-knowledge` | 分析知识库 |
| `/understand-onboard` | 生成新人入职指南 |

**配置**: 安装后自动生效。

---

## 一键安装脚本

将以下内容保存为 `install-plugins.sh` 并运行：

```bash
#!/bin/bash

# Claude Code 插件一键安装脚本

set -e

CLAUDE_DIR="$HOME/.claude"
MARKETPLACES_DIR="$CLAUDE_DIR/plugins/marketplaces"

echo "开始安装 Claude Code 插件..."

# 创建目录
mkdir -p "$MARKETPLACES_DIR"

# 1. ECC
echo "安装 ECC..."
if [ ! -d "$MARKETPLACES_DIR/ecc" ]; then
    git clone https://github.com/affaan-m/ECC.git "$MARKETPLACES_DIR/ecc"
    echo "✓ ECC 安装完成"
else
    echo "✓ ECC 已存在，跳过"
fi

# 2. Claude HUD
echo "安装 Claude HUD..."
if [ ! -d "$MARKETPLACES_DIR/claude-hud" ]; then
    git clone https://github.com/jarrodwatts/claude-hud.git "$MARKETPLACES_DIR/claude-hud"
    echo "✓ Claude HUD 安装完成"
else
    echo "✓ Claude HUD 已存在，跳过"
fi

# 3. Superpowers
echo "安装 Superpowers..."
if [ ! -d "$MARKETPLACES_DIR/superpowers-marketplace" ]; then
    git clone https://github.com/obra/superpowers-marketplace.git "$MARKETPLACES_DIR/superpowers-marketplace"
    echo "✓ Superpowers 安装完成"
else
    echo "✓ Superpowers 已存在，跳过"
fi

# 4. Claude Code 中文
echo "安装 Claude Code 中文..."
if [ ! -d "$MARKETPLACES_DIR/claude-plugins-official" ]; then
    git clone https://github.com/anthropics/claude-plugins-official.git "$MARKETPLACES_DIR/claude-plugins-official"
    echo "✓ Claude Code 中文安装完成"
else
    echo "✓ Claude Code 中文已存在，跳过"
fi

# 5. Claude Mem
echo "安装 Claude Mem..."
if [ ! -d "$MARKETPLACES_DIR/thedotmack" ]; then
    git clone https://github.com/thedotmack/claude-mem.git "$MARKETPLACES_DIR/thedotmack"
    echo "✓ Claude Mem 安装完成"
else
    echo "✓ Claude Mem 已存在，跳过"
fi

# 6. Understand-Anything
echo "安装 Understand-Anything..."
if [ ! -d "$MARKETPLACES_DIR/Understand-Anything" ]; then
    git clone https://github.com/Lum1104/Understand-Anything.git "$MARKETPLACES_DIR/Understand-Anything"
    cd "$MARKETPLACES_DIR/Understand-Anything"
    ./install.sh claude
    echo "✓ Understand-Anything 安装完成"
else
    echo "✓ Understand-Anything 已存在，跳过"
fi

echo ""
echo "插件安装完成！"
echo "请重启 Claude Code 以加载插件。"
echo ""
echo "验证安装："
echo "1. 启动 Claude Code: claude"
echo "2. 检查插件: /plugin list"
```

---

## 验证安装

```bash
# 启动 Claude Code
claude

# 检查已安装插件
/plugin list

# 检查 ECC Agent
/agents

# 检查技能
/skills

# 检查状态栏
/status
```

---

## 插件配置说明

### settings.json 中的插件配置

```json
{
  "enabledPlugins": {
    "claude-code-zh-cn": true,
    "claude-hud@claude-hud": true,
    "superpowers@superpowers-marketplace": true,
    "ecc@ecc": true,
    "understand-anything@Understand-Anything": true
  }
}
```

### 市场源配置

```json
{
  "extraKnownMarketplaces": {
    "anthropic-agent-skills": {
      "source": {
        "source": "github",
        "repo": "anthropics/skills"
      }
    },
    "claude-hud": {
      "source": {
        "source": "github",
        "repo": "jarrodwatts/claude-hud"
      }
    },
    "superpowers-marketplace": {
      "source": {
        "source": "github",
        "repo": "obra/superpowers-marketplace"
      }
    },
    "ecc": {
      "source": {
        "source": "git",
        "url": "https://github.com/affaan-m/ECC.git"
      }
    }
  }
}
```

---

## 常见问题

### Q: 插件安装后没有生效？
A: 重启 Claude Code，然后运行 `/plugin list` 检查。

### Q: 如何更新插件？
A: 在插件目录中运行 `git pull`，然后重启 Claude Code。

### Q: 插件冲突怎么办？
A: 检查 `~/.claude/settings.json` 中的 `enabledPlugins`，禁用冲突的插件。

### Q: 如何卸载插件？
A: 删除插件目录，然后从 `settings.json` 中移除相关配置。

---

## 相关链接

| 资源 | 链接 |
|------|------|
| Claude Code 官方文档 | https://docs.anthropic.com/en/docs/claude-code |
| ECC 文档 | https://github.com/affaan-m/ECC#readme |
| Claude HUD 文档 | https://github.com/jarrodwatts/claude-hud#readme |
| Superpowers 文档 | https://github.com/obra/superpowers-marketplace#readme |
| Understand-Anything 文档 | https://github.com/Lum1104/Understand-Anything#readme |
