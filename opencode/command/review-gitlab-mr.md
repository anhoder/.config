---
description: Execute an end-to-end GitLab Merge Request review using OpenCode, including context sync, inline feedback, labeling, and optional auto-merge.
---

## User Input

```text
$ARGUMENTS
```

你 **必须** 解析传入参数（如果存在），格式为 `<project_id> <mr_iid>`，否则立即向用户索取。

## Purpose

作为 OpenCode 中的高级审查员，全面检查指定的 GitLab Merge Request：同步远程信息、拉取源码、逐文件评估、在线程中给出中文反馈、更新标签并在通过时尝试自动合并，同时保证本地工作副本被完整恢复。

## Label System

### Review Status Labels
| Label | Color | Description |
|-------|-------|-------------|
| `bot::review::in-progress` | 🔵 #6699cc | 首次审查进行中 |
| `bot::review::re-reviewing` | 🟣 #9966cc | 复审进行中 |
| `bot::review::success` | 🟢 #009966 | 审查通过，无严重/警告问题 |
| `bot::review::needs-fix` | 🔴 #dc143c | 发现严重问题，必须修复 |
| `bot::review::needs-improvement` | 🟠 #ff9900 | 发现警告级问题，建议修复 |
| `bot::review::not-supported` | ⚫ #808080 | 不支持审查 |
| `bot::review::error` | ⚪ #cccccc | 审查过程出错 |

### Issue Category Labels
| Label | Color | Description |
|-------|-------|-------------|
| `bot::issue::security` | 🔴 #dc143c | 发现安全问题 |
| `bot::issue::performance` | 🟠 #cd5b45 | 发现性能问题 |
| `bot::issue::logic` | 🟡 #ffcc00 | 发现逻辑/业务问题 |
| `bot::issue::error-handling` | 🟣 #9966cc | 错误处理问题 |

### Label Flow
```
首次 Review:
in-progress → success / needs-fix / needs-improvement

复审 Review:
re-reviewing → success / needs-fix / needs-improvement

出错时:
any → error
```

## Workflow Overview

1. 解析输入参数
2. 获取 MR 元数据并验证状态
3. 判断是否复审并加载上下文
4. 同步/切换到源码分支
5. 分析 diff 与文件级上下文
6. 聚焦关键审查维度
7. 在线程中提交问题
8. 发布总结报告
9. 更新审查/问题标签
10. 若通过尝试自动合并
11. 恢复本地工作副本
12. 故障兜底与告警

## Detailed Workflow

### Step 1: Parse Arguments

- 从 `$ARGUMENTS` 中读取 `project_id` 与 `mr_iid`
- 缺失或非法时，要求用户按 `<project_id> <mr_iid>` 重试

### Step 2: Fetch MR Information and Check Status

使用 GitLab MCP Server：
1. 调 `mcp__gitlab__get_merge_request` 获取 MR 详情
2. 如果 `state` 为 `merged` 或 `closed`，告知用户并终止审查
3. 调 `mcp__gitlab__get_merge_request_diffs` 拉取全部 diff
4. 记录 source branch、target branch、diff_refs（base_sha/head_sha/start_sha）
5. 读取现有标签，为后续判定做准备

### Step 3: Handle Previous Review Context

- 有 `bot::review::success/needs-fix/needs-improvement` → 复审
- 有 `bot::review::in-progress/re-reviewing` → 前次未完成，视为复审
- 无任何 `bot::review::*` → 首次审查

**复审流程：**
1. 调 `mcp__gitlab__mr_discussions`、`mcp__gitlab__get_merge_request_notes`
2. 复盘既有问题、已解决线程与未解决讨论
3. 关注修复情况、新增 diff 与潜在回归
4. 移除历史 `bot::review::*` 状态标签并加上 `bot::review::re-reviewing`

**首次审查：**
- 直接进入代码审查
- 通过 `mcp__gitlab__update_merge_request` 添加 `bot::review::in-progress`

### Step 4: Sync Local Repository

1. **记录当前状态**
   - `ORIGINAL_BRANCH=$(git branch --show-current)`
   - `git status --porcelain` 检查是否脏工作区
   - 如存在修改：
     - `STASH_ID="opencode-review-$(date +%s)"`
     - `git stash push -m "$STASH_ID"`
2. **同步源分支**：`git fetch origin <source_branch>`
3. **切换分支**：若当前分支不同，执行 `git checkout -B <source_branch> origin/<source_branch>`
4. 确认 checkout 成功后再继续

### Step 5: Analyze Code Changes

- 对每个修改文件使用 Read 工具加载上下文
- 调 `mcp__cclsp__get_diagnostics` 查看语义/语法警告
- 需要时用 `mcp__cclsp__find_references`、`mcp__cclsp__find_definition` 理解调用链
- 复审时比对上一轮记录：确认修复、发现回归、标注未改动的问题块

### Step 6: Perform Code Review

**必须修复（严重）**
- 逻辑缺陷、错误行为
- 安全漏洞（SQL 注入/XSS/命令注入等）
- 数据一致性/事务问题
- 并发/竞态风险
- 资源泄漏/内存泄漏
- 关键路径缺失错误处理

**应当改进（警告）**
- 性能瓶颈
- 输入校验缺失
- 错误的异常处理
- 潜在空指针/越界
- 错误的 API 使用
- 边界条件不足
- 死代码/无法到达分支

**架构建议（可选）**
- SOLID 违背
- 缺失合理抽象
- 过度复杂流程
- 关键路径缺少测试

### Step 7: Post Review Comments

- 使用 `mcp__gitlab__create_merge_request_thread` 在具体行开启讨论
- Position 参数：`position_type=text`、`base_sha`/`head_sha`/`start_sha`（来自 diff_refs）、`old_path`/`new_path`、`new_line`/`old_line`
- 评论模版（全程使用中文）：

````
**[严重程度]** 问题标题

**问题描述：** 清晰说明问题所在

**修改建议：** 如何修复或改进

**示例代码（如有必要）：**
```php
// 建议的修复代码
```
````

严重度：`[严重]`（必须修复）、`[警告]`（建议修复）、`[建议]`（可选优化）。

### Step 8: Post Summary Report

使用 `mcp__gitlab__create_note` 发布总结（中文）：

**首次审查模版**
```
## 代码审查总结

### 概览
- **审查文件数：** X
- **发现问题数：** Y（严重: A, 警告: B, 建议: C）
- **整体评估：** [通过 / 需要修改 / 需要讨论]

### 严重问题
1. [描述 + 文件:行号]

### 警告
1. [描述 + 文件:行号]

### 建议
1. [描述 + 文件:行号]

### 亮点
- [积极发现]

---
*此审查由 OpenCode 执行*
```

**复审模版**
```
## 代码审查总结（复审）

### 概览
- **审查文件数：** X
- **本次发现问题数：** Y（严重: A, 警告: B, 建议: C）
- **已修复问题数：** Z
- **整体评估：** [通过 / 需要继续修改 / 需要讨论]

### 已修复的问题 ✅
1. [描述]

### 仍未解决的问题 ⚠️
1. [描述 + 文件:行号]

### 新发现的问题
1. [描述 + 文件:行号]

### 亮点
- [积极改进]

---
*此审查由 OpenCode 执行*
```

### Step 9: Update MR Labels

1. 先移除所有 `bot::review::*` 与 `bot::issue::*`
2. 根据结果添加状态：
   | Condition | Status Label |
   |-----------|--------------|
   | 无严重/警告问题 | `bot::review::success` |
   | 存在严重问题 | `bot::review::needs-fix` |
   | 仅有警告问题 | `bot::review::needs-improvement` |
3. 按类别增加问题标签：
   | Issue Type | Label |
   |------------|-------|
   | 安全漏洞 | `bot::issue::security` |
   | 性能瓶颈 | `bot::issue::performance` |
   | 逻辑/业务错误 | `bot::issue::logic` |
   | 错误处理缺陷 | `bot::issue::error-handling` |
4. 其他自定义标签保持不变

### Step 10: Auto-Merge on Success

- 只有当状态为 `bot::review::success` 时才尝试
- 调 `mcp__gitlab__merge_merge_request`，`should_remove_source_branch=true`
- 无论合并成功、权限不足或其他失败，都继续执行 Step 11 并向用户汇报

### Step 11: Restore Working State

1. 若记录了 `ORIGINAL_BRANCH`，执行 `git checkout <ORIGINAL_BRANCH>`（失败时给出提示）
2. 如曾 stash：
   ```bash
   STASH_REF=$(git stash list | grep "$STASH_ID" | head -1 | cut -d: -f1)
   if [ -n "$STASH_REF" ]; then
     git stash pop "$STASH_REF"
   fi
   ```
   冲突时提醒用户但不终止流程
3. 汇报最终分支与 stash 恢复情况

### Step 12: Error Handling

- 任一步骤失败：移除其他 `bot::review::*`，添加 `bot::review::error`
- API/Git/权限/网络错误分别告知用户并提示重试
- 始终尝试执行 Step 11 还原环境
- 使用 `mcp__gitlab__create_note` 发布失败摘要：
  ```
  ## ⚠️ 代码审查失败

  **错误原因：** [具体错误信息]

  **建议操作：** [如何解决或重试]

  ---
  *此审查由 OpenCode 执行*
  ```

## Operating Notes

1. 所有评论、总结、告警均使用中文。
2. 禁止挑格式/缩进/命名等纯风格问题，除非会引发真实缺陷。
3. 聚焦功能正确性、安全、性能、错误处理与边界条件。
4. 反馈必须可执行，必要时给出修复示例。
5. 即便没有发现问题，也要发布总结说明已完成审查。
6. 无论成功或失败，务必在收尾前还原用户的工作状态。

