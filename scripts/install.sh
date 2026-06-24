#!/bin/bash

# Claude Code 配置安装脚本
# 用于将配置从仓库恢复到 ~/.claude/ 目录

set -e

# 颜色定义
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# 打印带颜色的消息
print_info() {
    echo -e "${GREEN}[INFO]${NC} $1"
}

print_warn() {
    echo -e "${YELLOW}[WARN]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# 获取脚本所在目录
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
REPO_DIR="$( dirname "$SCRIPT_DIR" )"
CLAUDE_DIR="$HOME/.claude"

# 检查是否在仓库目录中
if [ ! -f "$REPO_DIR/config/CLAUDE.md" ]; then
    print_error "请在 shuai-yemao-chip 仓库目录中运行此脚本"
    exit 1
fi

print_info "开始安装 Claude Code 配置..."
print_info "仓库目录: $REPO_DIR"
print_info "目标目录: $CLAUDE_DIR"

# 创建目标目录
mkdir -p "$CLAUDE_DIR"
mkdir -p "$CLAUDE_DIR/rules"
mkdir -p "$CLAUDE_DIR/agents"
mkdir -p "$CLAUDE_DIR/reference"
mkdir -p "$CLAUDE_DIR/templates"
mkdir -p "$CLAUDE_DIR/scripts"
mkdir -p "$CLAUDE_DIR/bin"

# 复制核心配置文件
print_info "复制核心配置文件..."
cp "$REPO_DIR/config/CLAUDE.md" "$CLAUDE_DIR/"
cp "$REPO_DIR/config/SOUL.md" "$CLAUDE_DIR/"
cp "$REPO_DIR/config/AGENTS.md" "$CLAUDE_DIR/"
cp "$REPO_DIR/config/USER.md" "$CLAUDE_DIR/"

# 复制 settings.json（如果不存在）
if [ ! -f "$CLAUDE_DIR/settings.json" ]; then
    print_info "复制 settings.json 模板..."
    cp "$REPO_DIR/config/settings.json" "$CLAUDE_DIR/"
    print_warn "请编辑 $CLAUDE_DIR/settings.json 填入你的 API Key"
else
    print_warn "settings.json 已存在，跳过复制"
    print_warn "如需更新，请手动复制 $REPO_DIR/config/settings.json"
fi

# 复制目录
print_info "复制 rules 目录..."
cp -r "$REPO_DIR/rules/"* "$CLAUDE_DIR/rules/"

print_info "复制 agents 目录..."
cp -r "$REPO_DIR/agents/"* "$CLAUDE_DIR/agents/"

print_info "复制 reference 目录..."
cp -r "$REPO_DIR/reference/"* "$CLAUDE_DIR/reference/"

print_info "复制 templates 目录..."
cp -r "$REPO_DIR/templates/"* "$CLAUDE_DIR/templates/"

print_info "复制 scripts 目录..."
cp -r "$REPO_DIR/scripts/"* "$CLAUDE_DIR/scripts/"

print_info "复制 bin 目录..."
cp -r "$REPO_DIR/bin/"* "$CLAUDE_DIR/bin/"

# 克隆 skills 仓库（如果不存在）
if [ ! -d "$CLAUDE_DIR/skills" ]; then
    print_info "克隆 skills 仓库..."
    git clone https://github.com/shuai-yemao/shuai-yemao-chip-skills.git "$CLAUDE_DIR/skills-tmp"
    mkdir -p "$CLAUDE_DIR/skills"
    cp -r "$CLAUDE_DIR/skills-tmp/skills/"* "$CLAUDE_DIR/skills/"
    rm -rf "$CLAUDE_DIR/skills-tmp"
else
    print_warn "skills 目录已存在，跳过克隆"
    print_warn "如需更新，请执行: cd $CLAUDE_DIR/skills && git pull"
fi

# 克隆 workflows 仓库（如果不存在）
if [ ! -d "$CLAUDE_DIR/workflows" ]; then
    print_info "克隆 workflows 仓库..."
    git clone https://github.com/shuai-yemao/shuai-yemao-workflow.git "$CLAUDE_DIR/workflows-tmp"
    mkdir -p "$CLAUDE_DIR/workflows"
    cp -r "$CLAUDE_DIR/workflows-tmp/workflows/"* "$CLAUDE_DIR/workflows/"
    rm -rf "$CLAUDE_DIR/workflows-tmp"
else
    print_warn "workflows 目录已存在，跳过克隆"
    print_warn "如需更新，请执行: cd $CLAUDE_DIR/workflows && git pull"
fi

# 设置执行权限
print_info "设置脚本执行权限..."
chmod +x "$CLAUDE_DIR/scripts/"*.sh 2>/dev/null || true
chmod +x "$CLAUDE_DIR/bin/"* 2>/dev/null || true

print_info "安装完成！"
echo ""
echo "下一步："
echo "1. 编辑 $CLAUDE_DIR/settings.json 填入你的 API Key"
echo "2. 启动 Claude Code: claude"
echo "3. 安装插件: /plugin install claude-hud"
echo "4. 验证配置: /status"
echo ""
echo "详见 INSTALL.md 获取完整安装指南"
