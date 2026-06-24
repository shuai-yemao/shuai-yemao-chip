#!/bin/bash

# 工作流快捷命令
# 用法: wf [工作流名称] [项目目录]

set -e

# 工作流映射
declare -A WORKFLOWS=(
    ["req"]="requirements-engineering"
    ["scrum"]="scrum-development"
    ["prod"]="production-management"
    ["defect"]="defect-management"
    ["compliance"]="compliance-certification"
    ["test"]="testing-cicd"
    ["dfmea"]="dfmea-management"
    ["hw"]="hardware-design"
    ["fw"]="firmware-development"
    ["mech"]="mechanical-design"
    ["factory"]="factory-test"
    ["sw"]="software-development"
    ["tool"]="toolchain-management"
    ["viz"]="visualization"
    ["doc"]="document-writing"
    ["collab"]="collaboration"
)

# 中文名映射
declare -A NAMES=(
    ["requirements-engineering"]="需求工程"
    ["scrum-development"]="Scrum 敏捷"
    ["production-management"]="生产管理"
    ["defect-management"]="缺陷管理"
    ["compliance-certification"]="法规认证"
    ["testing-cicd"]="测试 CI/CD"
    ["dfmea-management"]="DFMEA 管理"
    ["hardware-design"]="硬件设计"
    ["firmware-development"]="固件开发"
    ["mechanical-design"]="机械设计"
    ["factory-test"]="工厂测试"
    ["software-development"]="软件开发"
    ["toolchain-management"]="工具链管理"
    ["visualization"]="可视化"
    ["document-writing"]="文档写作"
    ["collaboration"]="协作工具"
)

# 颜色定义
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# 显示帮助
show_help() {
    echo -e "${CYAN}Claude 工作流快捷命令${NC}"
    echo ""
    echo "用法: wf [工作流] [项目目录]"
    echo ""
    echo "示例:"
    echo "  wf req D:/my-project        # 执行需求工程工作流"
    echo "  wf fw D:/firmware           # 执行固件开发工作流"
    echo "  wf viz                      # 执行可视化工作流"
    echo "  wf list                     # 列出所有工作流"
    echo "  wf help                     # 显示帮助"
    echo ""
    echo "可用工作流:"
    echo "  req      - 需求工程"
    echo "  scrum    - Scrum 敏捷"
    echo "  prod     - 生产管理"
    echo "  defect   - 缺陷管理"
    echo "  compliance - 法规认证"
    echo "  test     - 测试 CI/CD"
    echo "  dfmea    - DFMEA 管理"
    echo "  hw       - 硬件设计"
    echo "  fw       - 固件开发"
    echo "  mech     - 机械设计"
    echo "  factory  - 工厂测试"
    echo "  sw       - 软件开发"
    echo "  tool     - 工具链管理"
    echo "  viz      - 可视化"
    echo "  doc      - 文档写作"
    echo "  collab   - 协作工具"
    echo ""
    echo "快捷方式:"
    echo "  wf 1  -> wf req"
    echo "  wf 2  -> wf scrum"
    echo "  wf 3  -> wf prod"
    echo "  wf 4  -> wf defect"
    echo "  wf 5  -> wf compliance"
    echo "  wf 6  -> wf test"
    echo "  wf 7  -> wf dfmea"
    echo "  wf 8  -> wf hw"
    echo "  wf 9  -> wf fw"
    echo "  wf 10 -> wf mech"
    echo "  wf 11 -> wf factory"
    echo "  wf 12 -> wf sw"
    echo "  wf 13 -> wf tool"
    echo "  wf 14 -> wf viz"
    echo "  wf 15 -> wf doc"
    echo "  wf 16 -> wf collab"
}

# 列出所有工作流
list_workflows() {
    echo -e "${CYAN}=========================================="
    echo "  所有工作流"
    echo "==========================================${NC}"
    echo ""
    echo "快捷键 | 完整名称              | 中文名"
    echo "--------|----------------------|----------"
    echo "req     | requirements-engineering | 需求工程"
    echo "scrum   | scrum-development        | Scrum 敏捷"
    echo "prod    | production-management    | 生产管理"
    echo "defect  | defect-management        | 缺陷管理"
    echo "compliance | compliance-certification | 法规认证"
    echo "test    | testing-cicd             | 测试 CI/CD"
    echo "dfmea   | dfmea-management         | DFMEA 管理"
    echo "hw      | hardware-design          | 硬件设计"
    echo "fw      | firmware-development     | 固件开发"
    echo "mech    | mechanical-design        | 机械设计"
    echo "factory | factory-test             | 工厂测试"
    echo "sw      | software-development     | 软件开发"
    echo "tool    | toolchain-management     | 工具链管理"
    echo "viz     | visualization            | 可视化"
    echo "doc     | document-writing         | 文档写作"
    echo "collab  | collaboration            | 协作工具"
}

# 生成提示词
generate_prompt() {
    local workflow=$1
    local project_dir=$2
    local workflow_name=${NAMES[$workflow]}

    if [ -z "$workflow_name" ]; then
        echo -e "${RED}错误: 未知的工作流 '$workflow'${NC}"
        exit 1
    fi

    # 默认项目目录
    if [ -z "$project_dir" ]; then
        project_dir="$HOME/project-$(date +%Y%m%d)"
    fi

    # 创建项目目录
    mkdir -p "$project_dir" 2>/dev/null || true

    echo -e "${GREEN}=========================================="
    echo "  执行工作流: $workflow_name"
    echo "==========================================${NC}"
    echo ""
    echo -e "项目目录: ${BLUE}$project_dir${NC}"
    echo ""

    # 生成提示词
    local prompt="执行 $workflow_name 工作流。

项目目录: $project_dir

请按照工作流流程执行，输出结果到项目目录。

如果需要输入数据，请询问我。"

    echo -e "${YELLOW}请复制以下内容到 Claude：${NC}"
    echo ""
    echo "----------------------------------------"
    echo "$prompt"
    echo "----------------------------------------"
    echo ""

    # 复制到剪贴板
    if command -v clip &> /dev/null; then
        echo "$prompt" | clip
        echo -e "${GREEN}✅ 提示词已复制到剪贴板${NC}"
    elif command -v pbcopy &> /dev/null; then
        echo "$prompt" | pbcopy
        echo -e "${GREEN}✅ 提示词已复制到剪贴板${NC}"
    fi
}

# 主流程
main() {
    local workflow=$1
    local project_dir=$2

    # 处理数字快捷方式
    case $workflow in
        1) workflow="req" ;;
        2) workflow="scrum" ;;
        3) workflow="prod" ;;
        4) workflow="defect" ;;
        5) workflow="compliance" ;;
        6) workflow="test" ;;
        7) workflow="dfmea" ;;
        8) workflow="hw" ;;
        9) workflow="fw" ;;
        10) workflow="mech" ;;
        11) workflow="factory" ;;
        12) workflow="sw" ;;
        13) workflow="tool" ;;
        14) workflow="viz" ;;
        15) workflow="doc" ;;
        16) workflow="collab" ;;
    esac

    case $workflow in
        help|--help|-h)
            show_help
            ;;
        list|ls)
            list_workflows
            ;;
        "")
            show_help
            ;;
        *)
            # 获取完整工作流名称
            local full_workflow=${WORKFLOWS[$workflow]}

            if [ -z "$full_workflow" ]; then
                echo -e "${RED}错误: 未知的工作流 '$workflow'${NC}"
                echo ""
                echo "使用 'wf list' 查看所有可用工作流"
                exit 1
            fi

            generate_prompt "$full_workflow" "$project_dir"
            ;;
    esac
}

# 运行主流程
main "$@"
