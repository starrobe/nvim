# 配置改进建议

> 审查日期：2026-09-12
> 基于 `main`（已合并 inlay-hint 分支）的配置审查。
>
> 进度：一档（清理/正确性）已完成；二档已处理/保留；三档（小建议）待处理。

## 一、清理 / 正确性 ✅ 已完成

1. ✅ 删除 `opt.hidden = true`（废弃选项）
2. ✅ `vim.wo[0][0]` → `vim.wo`（惯用写法）
3. ✅ `<C-Space>` 触发补全改用 `vim.lsp.completion.get()`

## 二、体验改进 ✅ 已处理 / 保留

4. **`opt.laststatus = 0`（无状态栏）** — 保留现状（用户选择）
5. ✅ 删除 `opt.smartindent = true`（改用默认 `autoindent` 兜底）
6. **`~/.clang-format` 不在仓库** — 保留现状（用户选择）

## 三、小建议（可维护性 / 细节）— 待处理

- ~~**`after/ftplugin/lua.lua` 未设 `expandtab`**~~ ✅ 已补 `vim.bo.expandtab = true`。
- ~~**`undofile` 未设 `undodir`**~~ — 无需改动：默认 `~/.local/state/nvim/undo//` 已标准且工作正常。
- ~~**`DiffOrig` 用字符串拼接命令**~~ — 撤回：现有 `fnameescape(filename)` 已正确转义，无需改动。
- **`format.lua` 目前只覆盖 Lua**：后续加 JSON/YAML（prettier）、Markdown 等，直接在 `formatters` 表加一条。

## 四、确认项（无需改动）

- Python 的 `ty` + `ruff` 组合合理且现代，`ty` 管类型/补全，`ruff` 管 lint/格式化。
- `ruff` 在 `vim.lsp.enable` 中，Python 格式化走其 LSP format。
