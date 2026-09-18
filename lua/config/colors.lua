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

  -- 错误/警告信息（E37 等）—— 灰调，与诊断色 Error/Warn 保持一致
  vim.api.nvim_set_hl(0, "ErrorMsg", { fg = "#a06b75" })
  vim.api.nvim_set_hl(0, "WarningMsg", { fg = "#a38f63" })

  -- 搜索当前匹配（默认亮黄 bg）/ 不可见字符（默认亮青）—— 改为与选区一致的灰调
  vim.api.nvim_set_hl(0, "IncSearch", { bg = "#4f5258" })
  vim.api.nvim_set_hl(0, "CurSearch", { bg = "#4f5258" })
  vim.api.nvim_set_hl(0, "SpecialKey", { fg = "#4f5258" })

  -- 补全菜单：去掉匹配字串的加粗高亮（link 到 Pmenu/PmenuSel）
  vim.api.nvim_set_hl(0, "PmenuMatch", { link = "Pmenu" })
  vim.api.nvim_set_hl(0, "PmenuMatchSel", { link = "PmenuSel" })

  -- snacks notifier 消息高亮：正文/标题/页脚/边框保留不透明背景（link 到 NormalFloat），
  -- 仅取消诊断色；图标（compact 样式未使用）link 到无颜色 group。
  -- notifier 在首次通知时会用 default link 重新挂上这些 group，所以这里用非默认 link。
  vim.api.nvim_set_hl(0, "SnacksNotifierPlain", {})
  for _, level in ipairs({ "Error", "Warn", "Info", "Debug", "Trace" }) do
    for _, part in ipairs({ "", "Title", "Footer", "Border" }) do
      vim.api.nvim_set_hl(0, "SnacksNotifier" .. part .. level, { link = "NormalFloat" })
    end
    vim.api.nvim_set_hl(0, "SnacksNotifierIcon" .. level, { link = "SnacksNotifierPlain" })
  end
  -- 通知历史窗口：正文不透明背景，标题/时间取消颜色
  vim.api.nvim_set_hl(0, "SnacksNotifierHistory", { link = "NormalFloat" })
  vim.api.nvim_set_hl(0, "SnacksNotifierHistoryTitle", { link = "SnacksNotifierPlain" })
  vim.api.nvim_set_hl(0, "SnacksNotifierHistoryDateTime", { link = "SnacksNotifierPlain" })

  -- 浮动窗口标题/页脚背景：默认 bg 为 nil（透明），设为 NormalFloat 的背景使其不透明
  local float_bg = vim.api.nvim_get_hl(0, { name = "NormalFloat", link = false }).bg
  if float_bg then
    vim.api.nvim_set_hl(0, "FloatTitle", { bg = float_bg, update = true })
    vim.api.nvim_set_hl(0, "FloatFooter", { bg = float_bg, update = true })
  end

  -- gitsigns 符号颜色 —— 灰调但提高饱和度，拉开绿(Add)/蓝(Change) 的色相便于分辨
  vim.api.nvim_set_hl(0, "GitSignsAdd", { fg = "#6aa184" })
  vim.api.nvim_set_hl(0, "GitSignsChange", { fg = "#7c8dc4" })
  vim.api.nvim_set_hl(0, "GitSignsDelete", { fg = "#9a8085" })

  -- 诊断颜色 —— 与 gitsigns 同款灰调：去饱和以贴合「素净」，按严重度区分色相。
  -- 基座 DiagnosticXxx 的 fg 由 virtual text / float 的 default link 继承；
  -- 下划线 squiggle 颜色由 DiagnosticUnderlineXxx 的 sp 控制（update 保留 underline）。
  local diag_colors = {
    { "Error", "#a06b75" }, -- 玫瑰红
    { "Warn",  "#a38f63" }, -- 灰琥珀
    { "Info",  "#6b94a0" }, -- 灰青
    { "Hint",  "#7c8dc4" }, -- 灰蓝（同 GitSignsChange）
    { "Ok",    "#6aa184" }, -- 灰绿（同 GitSignsAdd）
  }
  for _, d in ipairs(diag_colors) do
    vim.api.nvim_set_hl(0, "Diagnostic" .. d[1], { fg = d[2] })
    vim.api.nvim_set_hl(0, "DiagnosticUnderline" .. d[1], { sp = d[2], update = true })
  end

  -- diff / 目录 / 拼写 —— 去饱和，与错误/诊断色保持一致
  vim.api.nvim_set_hl(0, "DiffDelete", { fg = "#a06b75" })
  vim.api.nvim_set_hl(0, "Directory", { fg = "#7c8dc4" })
  vim.api.nvim_set_hl(0, "QuickFixLine", { bg = "#2c2e33" })
  local spell_colors = {
    { "Bad",   "#a06b75" }, -- 拼错 → 玫瑰红
    { "Cap",   "#a38f63" }, -- 应大写 → 灰琥珀
    { "Rare",  "#6b94a0" }, -- 生僻词 → 灰青
    { "Local", "#6aa184" }, -- 其它区域拼写 → 灰绿
  }
  for _, s in ipairs(spell_colors) do
    vim.api.nvim_set_hl(0, "Spell" .. s[1], { sp = s[2], update = true })
  end
end

return M
