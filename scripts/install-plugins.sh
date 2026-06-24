#!/bin/bash

# Claude Code 插件一键安装脚本

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

CLAUDE_DIR="$HOME/.claude"
MARKETPLACES_DIR="$CLAUDE_DIR/plugins/marketplaces"

echo "=========================================="
echo "  Claude Code 插件一键安装脚本"
echo "=========================================="
echo ""

print_info "开始安装插件..."

# 创建目录
mkdir -p "$MARKETPLACES_DIR"

# 1. ECC (Everything Claude Code) - 核心插件
echo ""
print_info "1/5 安装 ECC (Everything Claude Code)..."
if [ ! -d "$MARKETPLACES_DIR/ecc" ]; then
    git clone https://github.com/affaan-m/ECC.git "$MARKETPLACES_DIR/ecc"
    print_info "✓ ECC 安装完成"
else
    print_warn "✓ ECC 已存在，跳过"
fi

# 2. Claude HUD - 状态栏显示
echo ""
print_info "2/5 安装 Claude HUD..."
if [ ! -d "$MARKETPLACES_DIR/claude-hud" ]; then
    git clone https://github.com/jarrodwatts/claude-hud.git "$MARKETPLACES_DIR/claude-hud"
    print_info "✓ Claude HUD 安装完成"
else
    print_warn "✓ Claude HUD 已存在，跳过"
fi

# 3. Superpowers - 增强功能
echo ""
print_info "3/5 安装 Superpowers..."
if [ ! -d "$MARKETPLACES_DIR/superpowers-marketplace" ]; then
    git clone https://github.com/obra/superpowers-marketplace.git "$MARKETPLACES_DIR/superpowers-marketplace"
    print_info "✓ Superpowers 安装完成"
else
    print_warn "✓ Superpowers 已存在，跳过"
fi

# 4. Claude Code 中文汉化
echo ""
print_info "4/5 安装 Claude Code 中文..."
if [ ! -d "$MARKETPLACES_DIR/claude-plugins-official" ]; then
    git clone https://github.com/anthropics/claude-plugins-official.git "$MARKETPLACES_DIR/claude-plugins-official"
    print_info "✓ Claude Code 中文安装完成"
else
    print_warn "✓ Claude Code 中文已存在，跳过"
fi

# 5. Claude Mem - 记忆管理
echo ""
print_info "5/5 安装 Claude Mem..."
if [ ! -d "$MARKETPLACES_DIR/thedotmack" ]; then
    git clone https://github.com/thedotmack/claude-mem.git "$MARKETPLACES_DIR/thedotmack"
    print_info "✓ Claude Mem 安装完成"
else
    print_warn "✓ Claude Mem 已存在，跳过"
fi

echo ""
echo "=========================================="
print_info "插件安装完成！"
echo "=========================================="
echo ""
echo "下一步："
echo "1. 重启 Claude Code: claude"
echo "2. 检查插件: /plugin list"
echo "3. 验证 ECC: /agents"
echo ""
echo "插件说明详见: PLUGINS.md"
