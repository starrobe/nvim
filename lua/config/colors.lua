-- =============================================================================
-- 未启用 colorscheme 时，手动补充 tokyonight-storm 的若干颜色
--
-- 这里只覆盖 UI 提示与 gitsigns 符号等「非语法高亮」的 group，与
-- config/highlight.lua（syntax off）无关。颜色值取自 tokyonight-storm 调色板。
-- 若之后重新启用 colorscheme，这些覆盖可删除（tokyonight 会自己定义它们）。
-- =============================================================================

local M = {}

--- 应用颜色覆盖（需在 colorscheme 之后调用）
function M.apply()
  -- 提示符颜色（hit-enter / more-prompt）—— tokyonight-storm 的 purple
  -- vim.api.nvim_set_hl(0, "Question", { fg = "#9d7cd8" })
  -- vim.api.nvim_set_hl(0, "MoreMsg", { fg = "#9d7cd8" })
  vim.api.nvim_set_hl(0, "Question", {})
  vim.api.nvim_set_hl(0, "MoreMsg", {})

  -- gitsigns 符号颜色 —— tokyonight-storm 的 git.add / change / delete
  vim.api.nvim_set_hl(0, "GitSignsAdd", { fg = "#449dab" })
  vim.api.nvim_set_hl(0, "GitSignsChange", { fg = "#6183bb" })
  vim.api.nvim_set_hl(0, "GitSignsDelete", { fg = "#914c54" })
end

return M
