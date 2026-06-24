#!/bin/bash

# 工作流快速启动器
# 简化工作流的使用方式

set -e

# 配置
WORKFLOWS_DIR="$HOME/.claude/workflows"

# 颜色定义
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# 显示菜单
show_menu() {
    clear
    echo -e "${CYAN}=========================================="
    echo "  Claude 工作流快速启动器"
    echo "==========================================${NC}"
    echo ""
    echo "请选择要执行的工作流："
    echo ""
    echo -e "${GREEN}【业务工作流】${NC}"
    echo "  1) 需求工程"
    echo "  2) Scrum 敏捷"
    echo "  3) 生产管理"
    echo "  4) 缺陷管理"
    echo "  5) 法规认证"
    echo ""
    echo -e "${GREEN}【技术工作流】${NC}"
    echo "  6) 测试 CI/CD"
    echo "  7) DFMEA 管理"
    echo "  8) 硬件设计"
    echo "  9) 固件开发"
    echo "  10) 机械设计"
    echo "  11) 工厂测试"
    echo "  12) 软件开发"
    echo ""
    echo -e "${GREEN}【工具工作流】${NC}"
    echo "  13) 工具链管理"
    echo "  14) 可视化"
    echo "  15) 文档写作"
    echo "  16) 协作工具"
    echo ""
    echo -e "${YELLOW}  0) 退出${NC}"
    echo ""
    echo -n "请输入选项 [0-16]: "
}

# 获取工作流名称
get_workflow_name() {
    local choice=$1
    case $choice in
        1) echo "requirements-engineering" ;;
        2) echo "scrum-development" ;;
        3) echo "production-management" ;;
        4) echo "defect-management" ;;
        5) echo "compliance-certification" ;;
        6) echo "testing-cicd" ;;
        7) echo "dfmea-management" ;;
        8) echo "hardware-design" ;;
        9) echo "firmware-development" ;;
        10) echo "mechanical-design" ;;
        11) echo "factory-test" ;;
        12) echo "software-development" ;;
        13) echo "toolchain-management" ;;
        14) echo "visualization" ;;
        15) echo "document-writing" ;;
        16) echo "collaboration" ;;
        *) echo "" ;;
    esac
}

# 获取工作流中文名
get_workflow_chinese_name() {
    local choice=$1
    case $choice in
        1) echo "需求工程" ;;
        2) echo "Scrum 敏捷" ;;
        3) echo "生产管理" ;;
        4) echo "缺陷管理" ;;
        5) echo "法规认证" ;;
        6) echo "测试 CI/CD" ;;
        7) echo "DFMEA 管理" ;;
        8) echo "硬件设计" ;;
        9) echo "固件开发" ;;
        10) echo "机械设计" ;;
        11) echo "工厂测试" ;;
        12) echo "软件开发" ;;
        13) echo "工具链管理" ;;
        14) echo "可视化" ;;
        15) echo "文档写作" ;;
        16) echo "协作工具" ;;
        *) echo "" ;;
    esac
}

# 显示工作流详情
show_workflow_detail() {
    local workflow=$1
    local workflow_dir="$WORKFLOWS_DIR/$workflow"

    echo ""
    echo -e "${CYAN}=========================================="
    echo "  工作流详情"
    echo "==========================================${NC}"
    echo ""

    if [ -f "$workflow_dir/README.md" ]; then
        # 显示前 30 行
        head -30 "$workflow_dir/README.md"
        echo ""
        echo "... (更多内容请查看 $workflow_dir/README.md)"
    else
        echo "工作流目录: $workflow_dir"
    fi
}

# 执行工作流
execute_workflow() {
    local workflow=$1
    local workflow_name=$(get_workflow_chinese_name $workflow)

    echo ""
    echo -e "${BLUE}=========================================="
    echo "  执行工作流: $workflow_name"
    echo "==========================================${NC}"
    echo ""

    # 询问项目目录
    echo -n "请输入项目目录路径 (例: D:/my-project): "
    read project_dir

    if [ -z "$project_dir" ]; then
        echo -e "${RED}错误: 项目目录不能为空${NC}"
        return 1
    fi

    # 创建项目目录
    mkdir -p "$project_dir" 2>/dev/null || true

    echo ""
    echo -e "${GREEN}项目目录: $project_dir${NC}"
    echo ""

    # 生成 Claude 命令
    echo -e "${YELLOW}请在 Claude 中执行以下命令：${NC}"
    echo ""
    echo "----------------------------------------"
    echo "执行 $workflow_name 工作流"
    echo "项目目录: $project_dir"
    echo "----------------------------------------"
    echo ""

    # 询问是否打开 Claude
    echo -n "是否现在打开 Claude 执行？(y/n): "
    read open_claude

    if [ "$open_claude" = "y" ] || [ "$open_claude" = "Y" ]; then
        echo ""
        echo "正在启动 Claude..."
        echo ""
        echo "请在 Claude 中输入："
        echo "----------------------------------------"
        echo "执行 $workflow_name 工作流，项目目录: $project_dir"
        echo "----------------------------------------"
        echo ""
        echo "按 Enter 继续..."
        read
    fi
}

# 快速执行模式
quick_execute() {
    local workflow=$1
    local workflow_name=$(get_workflow_chinese_name $workflow)

    echo ""
    echo -e "${BLUE}快速执行: $workflow_name${NC}"
    echo ""

    # 询问项目目录
    echo -n "项目目录: "
    read project_dir

    if [ -z "$project_dir" ]; then
        project_dir="$HOME/project-$(date +%Y%m%d)"
        echo "使用默认目录: $project_dir"
    fi

    # 创建项目目录
    mkdir -p "$project_dir" 2>/dev/null || true

    # 生成提示词
    echo ""
    echo -e "${GREEN}=========================================="
    echo "  Claude 提示词"
    echo "==========================================${NC}"
    echo ""
    echo "请复制以下内容到 Claude："
    echo ""
    echo "----------------------------------------"
    cat << EOF
执行 $workflow_name 工作流。

项目目录: $project_dir

请按照工作流流程执行，输出结果到项目目录。

如果需要输入数据，请询问我。
EOF
    echo "----------------------------------------"
    echo ""

    # 复制到剪贴板
    if command -v clip &> /dev/null; then
        cat << EOF | clip
执行 $workflow_name 工作流。

项目目录: $project_dir

请按照工作流流程执行，输出结果到项目目录。

如果需要输入数据，请询问我。
EOF
        echo -e "${GREEN}✅ 提示词已复制到剪贴板${NC}"
    fi
}

# 查看工作流文档
view_docs() {
    local workflow=$1
    local workflow_dir="$WORKFLOWS_DIR/$workflow"

    echo ""
    echo -e "${BLUE}=========================================="
    echo "  工作文档"
    echo "==========================================${NC}"
    echo ""

    if [ -f "$workflow_dir/USAGE.md" ]; then
        cat "$workflow_dir/USAGE.md"
    elif [ -f "$workflow_dir/README.md" ]; then
        cat "$workflow_dir/README.md"
    else
        echo "未找到文档"
        echo "工作流目录: $workflow_dir"
    fi
}

# 列出所有工作流
list_workflows() {
    echo ""
    echo -e "${CYAN}=========================================="
    echo "  所有工作流"
    echo "==========================================${NC}"
    echo ""

    for dir in "$WORKFLOWS_DIR"/*/; do
        if [ -d "$dir" ]; then
            local name=$(basename "$dir")
            local has_readme="❌"
            local has_usage="❌"
            local has_workflow="❌"

            [ -f "$dir/README.md" ] && has_readme="✅"
            [ -f "$dir/USAGE.md" ] && has_usage="✅"
            [ -f "$dir/workflow.js" ] && has_workflow="✅"

            echo "$name"
            echo "  README: $has_readme | USAGE: $has_usage | workflow.js: $has_workflow"
        fi
    done
}

# 主流程
main() {
    while true; do
        show_menu
        read choice

        case $choice in
            0)
                echo ""
                echo -e "${GREEN}再见！${NC}"
                exit 0
                ;;
            [1-9]|1[0-6])
                local workflow=$(get_workflow_name $choice)
                local workflow_name=$(get_workflow_chinese_name $choice)

                if [ -z "$workflow" ]; then
                    echo -e "${RED}无效选项${NC}"
                    sleep 1
                    continue
                fi

                echo ""
                echo -e "${GREEN}已选择: $workflow_name${NC}"

                echo ""
                echo "请选择操作："
                echo "  1) 快速执行"
                echo "  2) 查看详情"
                echo "  3) 查看文档"
                echo ""
                echo -n "请选择 [1-3]: "
                read action

                case $action in
                    1)
                        quick_execute $choice
                        ;;
                    2)
                        show_workflow_detail $workflow
                        echo ""
                        echo -n "按 Enter 继续..."
                        read
                        ;;
                    3)
                        view_docs $workflow
                        echo ""
                        echo -n "按 Enter 继续..."
                        read
                        ;;
                    *)
                        echo -e "${RED}无效选项${NC}"
                        sleep 1
                        ;;
                esac
                ;;
            *)
                echo -e "${RED}无效选项，请重新选择${NC}"
                sleep 1
                ;;
        esac
    done
}

# 运行主流程
main "$@"
