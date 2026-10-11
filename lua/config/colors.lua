-- =============================================================================
-- 这里只覆盖 UI 提示与 gitsigns 符号等「非语法高亮」的 group，与
-- config/highlight.lua（syntax off）无关。
-- =============================================================================

-- 调色板
local c = {
  rose = "#a06b75", -- 错误 / diff 删除 / 拼错
  amber = "#a38f63", -- 警告 / 应大写
  teal = "#6b94a0", -- 信息 / 生僻词
  blue = "#7c8dc4", -- 提示 / change / 目录
  green = "#6aa184", -- ok / add / 本地拼写
  rose_gray = "#9a8085", -- gitsigns 删除符号（更灰的玫瑰）
  gray = "#4f5258", -- 选区 / 搜索 / 不可见字符
  panel = "#2c2e33", -- 淡背景（quickfix 当前行）
}

local M = {}

--- 应用颜色覆盖（需在 colorscheme 之后调用）
function M.apply()
  -- 提示符颜色（hit-enter / more-prompt）—— 清为默认色
  vim.api.nvim_set_hl(0, "Question", {})
  vim.api.nvim_set_hl(0, "MoreMsg", {})

  -- 模式显示（showmode 的 -- INSERT -- / -- NORMAL -- 等）—— 清为默认色
  vim.api.nvim_set_hl(0, "ModeMsg", {})

  -- 错误/警告信息（E37 等）—— 灰调，与诊断色 Error/Warn 保持一致
  vim.api.nvim_set_hl(0, "ErrorMsg", { fg = c.rose })
  vim.api.nvim_set_hl(0, "WarningMsg", { fg = c.amber })

  -- 搜索当前匹配（默认亮黄 bg）/ 不可见字符（默认亮青）—— 改为与选区一致的灰调
  vim.api.nvim_set_hl(0, "IncSearch", { bg = c.gray })
  vim.api.nvim_set_hl(0, "CurSearch", { bg = c.gray })
  vim.api.nvim_set_hl(0, "Search", { bg = c.gray }) -- Substitute link 到 Search，一并变灰
  vim.api.nvim_set_hl(0, "SpecialKey", { fg = c.gray })

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
  vim.api.nvim_set_hl(0, "GitSignsAdd", { fg = c.green })
  vim.api.nvim_set_hl(0, "GitSignsChange", { fg = c.blue })
  vim.api.nvim_set_hl(0, "GitSignsDelete", { fg = c.rose_gray })

  -- 诊断颜色 —— 与 gitsigns 同款灰调
  -- 基座 DiagnosticXxx 的 fg 由 virtual text / float 的 default link 继承；
  -- 下划线 squiggle 颜色由 DiagnosticUnderlineXxx 的 sp 控制（update 保留 underline）。
  local diag_colors = {
    { "Error", c.rose }, -- 玫瑰红
    { "Warn", c.amber }, -- 灰琥珀
    { "Info", c.teal }, -- 灰青
    { "Hint", c.blue }, -- 灰蓝（同 GitSignsChange）
    { "Ok", c.green }, -- 灰绿（同 GitSignsAdd）
  }
  for _, d in ipairs(diag_colors) do
    vim.api.nvim_set_hl(0, "Diagnostic" .. d[1], { fg = d[2] })
    vim.api.nvim_set_hl(0, "DiagnosticUnderline" .. d[1], { sp = d[2], update = true })
  end

  -- diff / 目录 / 拼写 —— 去饱和，与错误/诊断色保持一致
  vim.api.nvim_set_hl(0, "DiffAdd", { bg = c.gray })
  vim.api.nvim_set_hl(0, "DiffText", { bg = c.gray }) -- DiffTextAdd link 到 DiffText
  vim.api.nvim_set_hl(0, "DiffDelete", { fg = c.rose })
  vim.api.nvim_set_hl(0, "Directory", { fg = c.blue })
  vim.api.nvim_set_hl(0, "QuickFixLine", { bg = c.panel })
  local spell_colors = {
    { "Bad", c.rose }, -- 拼错 → 玫瑰红
    { "Cap", c.amber }, -- 应大写 → 灰琥珀
    { "Rare", c.teal }, -- 生僻词 → 灰青
    { "Local", c.green }, -- 其它区域拼写 → 灰绿
  }
  for _, s in ipairs(spell_colors) do
    vim.api.nvim_set_hl(0, "Spell" .. s[1], { sp = s[2], update = true })
  end
end

return M
