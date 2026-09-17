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
  -- 提示符颜色（hit-enter / more-prompt）—— 清为默认色
  vim.api.nvim_set_hl(0, "Question", {})
  vim.api.nvim_set_hl(0, "MoreMsg", {})

  -- 模式显示（showmode 的 -- INSERT -- / -- NORMAL -- 等）—— 清为默认色
  vim.api.nvim_set_hl(0, "ModeMsg", {})

  -- snacks notifier 消息高亮：全部取消（正文/图标/边框/标题/页脚/历史），改为无颜色。
  -- notifier 在首次通知时会用 default link 重新挂上这些 group；空定义会被 default
  -- 覆盖，因此统一 link 到一个无颜色的空 group，保持无颜色。
  vim.api.nvim_set_hl(0, "SnacksNotifierPlain", {})
  for _, part in ipairs({ "", "Icon", "Border", "Title", "Footer" }) do
    for _, level in ipairs({ "Error", "Warn", "Info", "Debug", "Trace" }) do
      vim.api.nvim_set_hl(0, "SnacksNotifier" .. part .. level, { link = "SnacksNotifierPlain" })
    end
  end
  for _, group in ipairs({
    "SnacksNotifierHistory",
    "SnacksNotifierHistoryTitle",
    "SnacksNotifierHistoryDateTime",
  }) do
    vim.api.nvim_set_hl(0, group, { link = "SnacksNotifierPlain" })
  end

  -- gitsigns 符号颜色 —— tokyonight-storm 的 git.add / change / delete
  vim.api.nvim_set_hl(0, "GitSignsAdd", { fg = "#449dab" })
  vim.api.nvim_set_hl(0, "GitSignsChange", { fg = "#6183bb" })
  vim.api.nvim_set_hl(0, "GitSignsDelete", { fg = "#914c54" })
end

return M
