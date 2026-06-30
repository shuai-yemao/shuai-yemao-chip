# Claude Code 插件安装指南

本文档列出所有已安装的插件及其 GitHub 仓库链接。

## 插件总览（12 个）

| 插件 | 用途 | GitHub 仓库 | 市场 |
|------|------|-------------|------|
| **ECC** | 核心插件 - 163 Agent + 107 Skills | [affaan-m/ECC](https://github.com/affaan-m/ECC) | ecc |
| **Claude HUD** | 状态栏和进度显示 | [jarrodwatts/claude-hud](https://github.com/jarrodwatts/claude-hud) | claude-hud |
| **Superpowers** | 增强功能和技能 | [obra/superpowers-marketplace](https://github.com/obra/superpowers-marketplace) | superpowers-marketplace |
| **Claude Code 中文** | 界面汉化 | [anthropics/claude-plugins-official](https://github.com/anthropics/claude-plugins-official) | claude-plugins-official |
| **Claude Mem** | 记忆管理和上下文持久化 | [thedotmack/claude-mem](https://github.com/thedotmack/claude-mem) | thedotmack |
| **Understand-Anything** | 知识图谱 - 代码分析和可视化 | [Lum1104/Understand-Anything](https://github.com/Lum1104/Understand-Anything) | understand-anything |
| **Codex** | OpenAI Codex 协作编程集成 | [openai/codex-plugin-cc](https://github.com/openai/codex-plugin-cc) | openai-codex |

### Anthropic 官方插件（6 个，global 作用域）

| 插件 | 版本 | 用途 | 安装方式 |
|------|------|------|----------|
| **clangd-lsp** | 1.0.0 | C/C++ 代码智能（跳转/补全/诊断） | 需装 `clangd` |
| **pyright-lsp** | 1.0.0 | Python 类型检查和代码智能 | 需装 `pyright` |
| **claude-md-management** | 1.0.0 | CLAUDE.md 审查 + 会话学习捕获 | 开箱即用 |
| **hookify** | 1.0.0 | Hook 自动化创建和管理 | 开箱即用 |
| **skill-creator** | 1.0.0 | 技能创建、优化和评估 | 开箱即用 |
| **session-report** | 1.0.0 | HTML 会话使用报告 | 开箱即用 |

---

## 官方插件使用指南

### clangd-lsp — C/C++ 代码智能

```bash
# 安装 clangd
scoop install llvm        # Windows
winget install LLVM.LLVM  # Windows
apt install clangd        # Linux
brew install llvm         # macOS
```

效果：打开 `.c`/`.h`/`.cpp` 文件时自动提供符号跳转、代码补全、编译诊断。

### pyright-lsp — Python 代码智能

```bash
npm install -g pyright
```

效果：打开 `.py` 文件时自动提供类型检查、代码补全。

### claude-md-management — CLAUDE.md 管理

| 命令 | 用途 |
|------|------|
| `/claude-md-management:revise-claude-md` | 分析当前会话，更新 CLAUDE.md 学习内容 |

技能：`claude-md-management:claude-md-improver` — 审查和优化 CLAUDE.md 质量。

### hookify — Hook 自动化

| 命令 | 用途 |
|------|------|
| `/hookify:hookify` | 分析会话，创建预防不良行为的 Hook |
| `/hookify:configure` | 配置 Hook 参数 |
| `/hookify:list` | 列出已有 Hook 规则 |
| `/hookify:help` | 查看帮助 |

技能：`hookify:writing-rules` | 代理：`hookify:conversation-analyzer`

### skill-creator — 技能创建

技能：`skill-creator:skill-creator` — 从零创建、优化、评估、基准测试技能。

### session-report — 会话报告

技能：`session-report:session-report` — 生成 HTML 会话报告（令牌用量、缓存效率、子代理、最贵提示）。

---

## 一键安装脚本

```bash
#!/bin/bash
set -e
CLAUDE_DIR="$HOME/.claude"
M="$CLAUDE_DIR/plugins/marketplaces"
mkdir -p "$M"

[ ! -d "$M/ecc" ] && git clone https://github.com/affaan-m/ECC.git "$M/ecc"
[ ! -d "$M/claude-hud" ] && git clone https://github.com/jarrodwatts/claude-hud.git "$M/claude-hud"
[ ! -d "$M/superpowers-marketplace" ] && git clone https://github.com/obra/superpowers-marketplace.git "$M/superpowers-marketplace"
[ ! -d "$M/claude-plugins-official" ] && git clone https://github.com/anthropics/claude-plugins-official.git "$M/claude-plugins-official"
[ ! -d "$M/thedotmack" ] && git clone https://github.com/thedotmack/claude-mem.git "$M/thedotmack"
[ ! -d "$M/Understand-Anything" ] && git clone https://github.com/Lum1104/Understand-Anything.git "$M/Understand-Anything" && cd "$M/Understand-Anything" && ./install.sh claude
[ ! -d "$M/openai-codex" ] && git clone https://github.com/openai/codex-plugin-cc.git "$M/openai-codex"

echo "插件安装完成！请重启 Claude Code。"
```

---

## settings.json 插件配置（12 个）

```json
{
  "enabledPlugins": {
    "claude-code-zh-cn": true,
    "claude-hud@claude-hud": true,
    "superpowers@superpowers-marketplace": true,
    "ecc@ecc": true,
    "claude-mem@thedotmack": true,
    "understand-anything@understand-anything": true,
    "codex@openai-codex": true,
    "clangd-lsp@claude-plugins-official": true,
    "pyright-lsp@claude-plugins-official": true,
    "claude-md-management@claude-plugins-official": true,
    "hookify@claude-plugins-official": true,
    "skill-creator@claude-plugins-official": true,
    "session-report@claude-plugins-official": true
  }
}
```

## 市场源配置

```json
{
  "extraKnownMarketplaces": {
    "anthropic-agent-skills": { "source": { "source": "github", "repo": "anthropics/skills" } },
    "claude-hud": { "source": { "source": "github", "repo": "jarrodwatts/claude-hud" } },
    "superpowers-marketplace": { "source": { "source": "github", "repo": "obra/superpowers-marketplace" } },
    "ecc": { "source": { "source": "git", "url": "https://github.com/affaan-m/ECC.git" } },
    "understand-anything": { "source": { "source": "github", "repo": "Lum1104/Understand-Anything" } },
    "openai-codex": { "source": { "source": "github", "repo": "openai/codex-plugin-cc" } }
  }
}
```

---

## 常见问题

**Q: 插件安装后没有生效？** 重启 Claude Code，运行 `/plugin list` 检查。  
**Q: 如何更新插件？** 在市场目录中 `git pull`，然后重启。  
**Q: LSP 插件不工作？** 确保系统已安装对应的语言服务器（`clangd`/`pyright`）。

## 相关链接

| 资源 | 链接 |
|------|------|
| Claude Code 文档 | https://code.claude.com/docs |
| 插件参考 | https://code.claude.com/docs/en/plugins-reference |
| ECC | https://github.com/affaan-m/ECC |
| Claude HUD | https://github.com/jarrodwatts/claude-hud |
| Understand-Anything | https://github.com/Lum1104/Understand-Anything |
