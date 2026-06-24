#!/bin/bash
# Model Switch Script - 统一管理 Claude Code、VSCode 等平台的模型配置
# 用法: model-switch [config-name]

set -e

# 配置文件路径
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONFIG_FILE="${SCRIPT_DIR}/model-configs.json"
CLAUDE_SETTINGS="$HOME/.claude/settings.json"
VSCODE_SETTINGS="$HOME/AppData/Roaming/Code/User/settings.json"

# 颜色定义
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# 检查依赖
check_dependencies() {
    if ! command -v jq &> /dev/null; then
        echo -e "${RED}错误: 需要安装 jq${NC}"
        echo "请运行: winget install jqlang.jq"
        exit 1
    fi
}

# 显示帮助
show_help() {
    echo -e "${BLUE}模型切换脚本${NC}"
    echo ""
    echo "用法:"
    echo "  model-switch              交互式选择配置"
    echo "  model-switch <name>       切换到指定配置"
    echo "  model-switch --list       列出所有可用配置"
    echo "  model-switch --current    显示当前配置"
    echo "  model-switch --help       显示帮助"
    echo ""
    echo "示例:"
    echo "  model-switch mimo-pro     切换到 mimo-v2.5-pro"
    echo "  model-switch deepseek     切换到 deepseek"
}

# 列出所有配置
list_configs() {
    echo -e "${BLUE}可用的模型配置:${NC}"
    echo ""
    jq -r '.configs | to_entries[] | "  \(.key): \(.value.description)"' "$CONFIG_FILE"
    echo ""
}

# 显示当前配置
show_current() {
    local current=$(jq -r '.current' "$CONFIG_FILE")
    echo -e "${BLUE}当前配置:${NC} ${GREEN}$current${NC}"
    echo ""
    echo -e "${BLUE}配置详情:${NC}"
    jq --arg name "$current" '.configs[$name]' "$CONFIG_FILE" | jq -r '
        "  模型: \(.ANTHROPIC_MODEL)",
        "  基础URL: \(.ANTHROPIC_BASE_URL)",
        "  Haiku: \(.ANTHROPIC_DEFAULT_HAIKU_MODEL)",
        "  Sonnet: \(.ANTHROPIC_DEFAULT_SONNET_MODEL)",
        "  Opus: \(.ANTHROPIC_DEFAULT_OPUS_MODEL)",
        "  子代理: \(.CLAUDE_CODE_SUBAGENT_MODEL)"
    '
}

# 更新 Claude Code 配置
update_claude_settings() {
    local config_name="$1"
    echo -e "${YELLOW}更新 Claude Code 配置...${NC}"

    # 读取配置值
    local base_url=$(jq -r --arg name "$config_name" '.configs[$name].ANTHROPIC_BASE_URL' "$CONFIG_FILE")
    local auth_token=$(jq -r --arg name "$config_name" '.configs[$name].ANTHROPIC_AUTH_TOKEN' "$CONFIG_FILE")
    local model=$(jq -r --arg name "$config_name" '.configs[$name].ANTHROPIC_MODEL' "$CONFIG_FILE")
    local haiku=$(jq -r --arg name "$config_name" '.configs[$name].ANTHROPIC_DEFAULT_HAIKU_MODEL' "$CONFIG_FILE")
    local sonnet=$(jq -r --arg name "$config_name" '.configs[$name].ANTHROPIC_DEFAULT_SONNET_MODEL' "$CONFIG_FILE")
    local opus=$(jq -r --arg name "$config_name" '.configs[$name].ANTHROPIC_DEFAULT_OPUS_MODEL' "$CONFIG_FILE")
    local subagent=$(jq -r --arg name "$config_name" '.configs[$name].CLAUDE_CODE_SUBAGENT_MODEL' "$CONFIG_FILE")

    # 使用 jq 更新 settings.json
    local tmp_file=$(mktemp)
    jq --arg base_url "$base_url" \
       --arg auth_token "$auth_token" \
       --arg model "$model" \
       --arg haiku "$haiku" \
       --arg sonnet "$sonnet" \
       --arg opus "$opus" \
       --arg subagent "$subagent" \
       '.env.ANTHROPIC_BASE_URL = $base_url |
        .env.ANTHROPIC_AUTH_TOKEN = $auth_token |
        .env.ANTHROPIC_MODEL = $model |
        .env.ANTHROPIC_DEFAULT_HAIKU_MODEL = $haiku |
        .env.ANTHROPIC_DEFAULT_SONNET_MODEL = $sonnet |
        .env.ANTHROPIC_DEFAULT_OPUS_MODEL = $opus |
        .env.CLAUDE_CODE_SUBAGENT_MODEL = $subagent' \
       "$CLAUDE_SETTINGS" > "$tmp_file"

    mv "$tmp_file" "$CLAUDE_SETTINGS"
    echo -e "${GREEN}✓ Claude Code 配置已更新${NC}"
}

# 更新 VSCode 配置
update_vscode_settings() {
    local config_name="$1"
    echo -e "${YELLOW}更新 VSCode 配置...${NC}"

    # 读取配置值
    local base_url=$(jq -r --arg name "$config_name" '.configs[$name].ANTHROPIC_BASE_URL' "$CONFIG_FILE")
    local auth_token=$(jq -r --arg name "$config_name" '.configs[$name].ANTHROPIC_AUTH_TOKEN' "$CONFIG_FILE")
    local model=$(jq -r --arg name "$config_name" '.configs[$name].ANTHROPIC_MODEL' "$CONFIG_FILE")
    local haiku=$(jq -r --arg name "$config_name" '.configs[$name].ANTHROPIC_DEFAULT_HAIKU_MODEL' "$CONFIG_FILE")
    local sonnet=$(jq -r --arg name "$config_name" '.configs[$name].ANTHROPIC_DEFAULT_SONNET_MODEL' "$CONFIG_FILE")
    local opus=$(jq -r --arg name "$config_name" '.configs[$name].ANTHROPIC_DEFAULT_OPUS_MODEL' "$CONFIG_FILE")
    local subagent=$(jq -r --arg name "$config_name" '.configs[$name].CLAUDE_CODE_SUBAGENT_MODEL' "$CONFIG_FILE")

    # 构建新的 environmentVariables 数组
    local env_vars=$(jq -n \
        --arg base_url "$base_url" \
        --arg auth_token "$auth_token" \
        --arg model "$model" \
        --arg haiku "$haiku" \
        --arg sonnet "$sonnet" \
        --arg opus "$opus" \
        --arg subagent "$subagent" \
        '[
            {"name": "ALL_PROXY", "value": "socks5://127.0.0.1:7897"},
            {"name": "ANTHROPIC_AUTH_TOKEN", "value": $auth_token},
            {"name": "ANTHROPIC_BASE_URL", "value": $base_url},
            {"name": "ANTHROPIC_MODEL", "value": $model},
            {"name": "ANTHROPIC_DEFAULT_HAIKU_MODEL", "value": $haiku},
            {"name": "ANTHROPIC_DEFAULT_OPUS_MODEL", "value": $opus},
            {"name": "ANTHROPIC_DEFAULT_SONNET_MODEL", "value": $sonnet},
            {"name": "CLAUDE_CODE_EFFORT_LEVEL", "value": "high"},
            {"name": "CLAUDE_CODE_EXPERIMENTAL_AGENT_TEAMS", "value": "1"},
            {"name": "CLAUDE_CODE_MAX_OUTPUT_TOKENS", "value": "16000"},
            {"name": "CLAUDE_CODE_SKIP_FAST_MODE_NETWORK_ERRORS", "value": "1"},
            {"name": "CLAUDE_CODE_SKIP_UPDATE_CHECK", "value": "1"},
            {"name": "CLAUDE_CODE_SUBAGENT_MODEL", "value": $subagent},
            {"name": "MAX_THINKING_TOKENS", "value": "8000"}
        ]')

    # 更新 VSCode settings.json
    local tmp_file=$(mktemp)
    jq --argjson env_vars "$env_vars" \
       '.["claudeCode.environmentVariables"] = $env_vars' \
       "$VSCODE_SETTINGS" > "$tmp_file"

    mv "$tmp_file" "$VSCODE_SETTINGS"
    echo -e "${GREEN}✓ VSCode 配置已更新${NC}"
}

# 更新配置文件中的当前配置
update_current_config() {
    local config_name="$1"
    local tmp_file=$(mktemp)
    jq --arg name "$config_name" '.current = $name' "$CONFIG_FILE" > "$tmp_file"
    mv "$tmp_file" "$CONFIG_FILE"
}

# 交互式选择
interactive_select() {
    echo -e "${BLUE}请选择模型配置:${NC}"
    echo ""

    # 列出所有配置
    local configs=()
    local i=1
    while IFS= read -r line; do
        configs+=("$line")
        echo -e "  ${GREEN}$i)${NC} $line"
        ((i++))
    done < <(jq -r '.configs | keys[]' "$CONFIG_FILE")

    echo ""
    read -p "请输入编号 (1-${#configs[@]}): " choice

    if [[ "$choice" =~ ^[0-9]+$ ]] && [ "$choice" -ge 1 ] && [ "$choice" -le "${#configs[@]}" ]; then
        local selected="${configs[$((choice-1))]}"
        switch_config "$selected"
    else
        echo -e "${RED}无效的选择${NC}"
        exit 1
    fi
}

# 切换配置
switch_config() {
    local config_name="$1"

    # 检查配置是否存在
    if ! jq -e --arg name "$config_name" '.configs[$name]' "$CONFIG_FILE" > /dev/null 2>&1; then
        echo -e "${RED}错误: 配置 '$config_name' 不存在${NC}"
        echo ""
        list_configs
        exit 1
    fi

    echo -e "${BLUE}切换到配置: ${GREEN}$config_name${NC}"
    echo ""

    # 更新各个平台
    update_claude_settings "$config_name"
    update_vscode_settings "$config_name"
    update_current_config "$config_name"

    echo ""
    echo -e "${GREEN}✓ 模型配置已切换完成！${NC}"
    echo ""
    show_current
}

# 主函数
main() {
    check_dependencies

    case "${1:-}" in
        --help|-h)
            show_help
            ;;
        --list|-l)
            list_configs
            ;;
        --current|-c)
            show_current
            ;;
        "")
            interactive_select
            ;;
        *)
            switch_config "$1"
            ;;
    esac
}

main "$@"
