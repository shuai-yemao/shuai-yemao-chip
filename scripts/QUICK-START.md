# 工作流快速启动指南

## 🚀 3 种简便使用方法

### 方法 1：快捷命令（推荐）

```bash
# 设置别名（只需一次）
alias wf='bash ~/.claude/scripts/wf.sh'

# 使用快捷命令
wf req D:/my-project        # 需求工程
wf fw D:/firmware           # 固件开发
wf viz                      # 可视化
wf list                     # 列出所有工作流
```

### 方法 2：交互式菜单

```bash
# 运行交互式菜单
bash ~/.claude/scripts/workflow-runner.sh
```

### 方法 3：直接调用

```bash
# 直接执行
bash ~/.claude/scripts/wf.sh req D:/my-project
```

---

## 📋 快捷键对照表

| 快捷键 | 工作流 | 中文名 |
|--------|--------|--------|
| `req` | requirements-engineering | 需求工程 |
| `scrum` | scrum-development | Scrum 敏捷 |
| `prod` | production-management | 生产管理 |
| `defect` | defect-management | 缺陷管理 |
| `compliance` | compliance-certification | 法规认证 |
| `test` | testing-cicd | 测试 CI/CD |
| `dfmea` | dfmea-management | DFMEA 管理 |
| `hw` | hardware-design | 硬件设计 |
| `fw` | firmware-development | 固件开发 |
| `mech` | mechanical-design | 机械设计 |
| `factory` | factory-test | 工厂测试 |
| `sw` | software-development | 软件开发 |
| `tool` | toolchain-management | 工具链管理 |
| `viz` | visualization | 可视化 |
| `doc` | document-writing | 文档写作 |
| `collab` | collaboration | 协作工具 |

---

## 💡 使用示例

### 示例 1：执行需求工程工作流

```bash
# 步骤 1：生成提示词
wf req D:/my-project

# 输出：
# ==========================================
#   执行工作流: 需求工程
# ==========================================
#
# 项目目录: D:/my-project
#
# 请复制以下内容到 Claude：
# ----------------------------------------
# 执行 需求工程 工作流。
#
# 项目目录: D:/my-project
#
# 请按照工作流流程执行，输出结果到项目目录。
#
# 如果需要输入数据，请询问我。
# ----------------------------------------
#
# ✅ 提示词已复制到剪贴板

# 步骤 2：在 Claude 中粘贴提示词
# 按 Ctrl+V 粘贴到 Claude 对话框
```

### 示例 2：执行固件开发工作流

```bash
# 生成提示词
wf fw D:/firmware-project

# 在 Claude 中粘贴执行
```

### 示例 3：使用数字快捷键

```bash
# 数字 1-16 对应 16 个工作流
wf 1 D:/my-project    # 等同于 wf req
wf 9 D:/firmware      # 等同于 wf fw
```

---

## 🎯 完整工作流程

```bash
# 1. 启动交互式菜单
bash ~/.claude/scripts/workflow-runner.sh

# 或使用快捷命令
wf req D:/my-project

# 2. 复制生成的提示词

# 3. 在 Claude 中粘贴执行

# 4. 查看输出结果
ls -la D:/my-project/
```

---

## 🔧 配置别名（可选）

### 方法 1：临时别名

```bash
alias wf='bash ~/.claude/scripts/wf.sh'
```

### 方法 2：永久别名

```bash
# 添加到 ~/.bashrc 或 ~/.bash_profile
echo "alias wf='bash ~/.claude/scripts/wf.sh'" >> ~/.bashrc
source ~/.bashrc
```

### 方法 3：Windows Git Bash

```bash
# 添加到 ~/.bashrc
echo "alias wf='bash ~/.claude/scripts/wf.sh'" >> ~/.bashrc
```

---

## ❓ 常见问题

### Q1: 命令没有权限？

```bash
chmod +x ~/.claude/scripts/wf.sh
chmod +x ~/.claude/scripts/workflow-runner.sh
```

### Q2: 如何查看所有工作流？

```bash
wf list
# 或
bash ~/.claude/scripts/workflow-runner.sh
```

### Q3: 如何查看工作流详情？

```bash
# 查看工作流文档
cat ~/.claude/workflows/requirements-engineering/USAGE.md
```

### Q4: 提示词没有复制到剪贴板？

手动复制即可：
```bash
wf req D:/my-project
# 手动复制输出的提示词
```

---

## 📝 总结

**最简便的方式：**

```bash
# 1. 设置别名（一次）
alias wf='bash ~/.claude/scripts/wf.sh'

# 2. 使用（每次）
wf req D:/my-project    # 生成提示词
# 复制到 Claude 执行
```

**3 步完成：**
1. `wf req D:/project` - 生成提示词
2. 复制提示词 - 自动复制到剪贴板
3. 粘贴到 Claude - 执行工作流
