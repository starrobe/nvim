-- =============================================================================
-- 语法高亮开关：实现 Vim/vi `:syntax off` 的效果
--
-- Neovim 的语法高亮有三个独立来源，`:syntax off` 只能关掉第一个：
--   1. 传统正则语法高亮（Comment / String / Keyword 等标准 group）
--   2. treesitter 高亮（@xxx capture group）
--   3. LSP 语义 token 高亮（@lsp.xxx group，colorscheme 会 link 到 @xxx 或直接上色）
--
-- 因此这里在「渲染层」一次性清空所有语法相关的 highlight group，覆盖全部
-- 三个来源；同时关闭 LSP 语义 token 引擎。UI 高亮（搜索、选区、diff、
-- 诊断、光标行等）不受影响，符合 `:syntax off` 的语义。恢复时重新加载
-- colorscheme 即可还原全部 group 定义。
-- =============================================================================

local M = {}

local enabled = false -- 当前状态，默认关闭语法高亮

-- 传统正则语法高亮使用的标准 group（见 :h group-name）
local std_syntax_groups = {
  "Comment",
  "Constant",
  "String",
  "Character",
  "Number",
  "Boolean",
  "Float",
  "Identifier",
  "Function",
  "Statement",
  "Conditional",
  "Repeat",
  "Label",
  "Operator",
  "Keyword",
  "Exception",
  "PreProc",
  "Include",
  "Define",
  "Macro",
  "PreCondit",
  "Type",
  "StorageClass",
  "Structure",
  "Typedef",
  "Special",
  "SpecialChar",
  "Tag",
  "Delimiter",
  "SpecialComment",
  "Debug",
  "Underlined",
  "Ignore",
  "Error",
  "Todo",
}

-- 清空所有语法相关 group：传统正则 + treesitter(@xxx) + LSP 语义(@lsp.xxx)
local function clear_syntax_groups()
  for _, group in ipairs(std_syntax_groups) do
    vim.api.nvim_set_hl(0, group, {})
  end
  -- 所有 @ 前缀 group：treesitter capture（@xxx）与 LSP 语义 token（@lsp.xxx）
  for _, group in ipairs(vim.fn.getcompletion("@", "highlight")) do
    vim.api.nvim_set_hl(0, group, {})
  end
end

-- 重新加载 colorscheme，恢复全部 group 定义（含 @xxx 与 @lsp.xxx 的 link）
local function restore_syntax_groups()
  if vim.g.colors_name and vim.g.colors_name ~= "" then
    vim.cmd.colorscheme(vim.g.colors_name)
    -- 重载 colorscheme 会一并恢复背景色，透明背景若已开启需重新应用
    pcall(function()
      require("config.transparent").reapply()
    end)
  end
end

--- 开启/关闭语法高亮
--- @param enable boolean
function M.set_enabled(enable)
  if enable == enabled then
    return
  end
  enabled = enable
  if enable then
    vim.lsp.semantic_tokens.enable(true)
    restore_syntax_groups()
  else
    vim.lsp.semantic_tokens.enable(false)
    clear_syntax_groups()
  end
end

--- 切换语法高亮
function M.toggle()
  M.set_enabled(not enabled)
end

--- @return boolean 当前是否开启语法高亮
function M.is_enabled()
  return enabled
end

--- 应用当前状态（启动时调用，无条件应用，绕过 set_enabled 的幂等检查）
function M.apply()
  if enabled then
    vim.lsp.semantic_tokens.enable(true)
    restore_syntax_groups()
  else
    vim.lsp.semantic_tokens.enable(false)
    clear_syntax_groups()
  end
end

return M
