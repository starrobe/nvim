-- =============================================================================
-- 透明背景开关
--
-- vim/vi 默认不设置背景色，因此能透出终端的透明背景；Neovim 的 colorscheme
-- （tokyonight）会给 Normal 等 group 设置不透明的背景色，从而遮住终端透明。
--
-- 这里在渲染层把「编辑器背景」相关 group 的背景色清为 NONE，并保存原始值，
-- 关闭时按保存值还原，因此不依赖重新加载 colorscheme，也不影响其它 UI 高亮
-- （搜索、选区、diff、浮动窗口等保持原样）。
-- =============================================================================

local M = {}

local enabled = true -- 默认透明背景（透出终端背景）

-- 编辑器背景相关 group（对应 tokyonight 的 transparent 选项所处理的 group）
local bg_groups = {
  "Normal", -- 正文背景
  "NormalNC", -- 非当前窗口背景
  "SignColumn", -- 符号列（gitsigns）
  "FoldColumn", -- 折叠列
  "TabLineFill", -- 标签页空白处
}

local saved = {} -- group -> 原始背景色

-- 保存原始背景色并清空，使背景透明
local function clear_bg()
  saved = {}
  for _, group in ipairs(bg_groups) do
    local hl = vim.api.nvim_get_hl(0, { name = group, link = false })
    saved[group] = hl.bg
    if hl.bg then
      vim.api.nvim_set_hl(0, group, { bg = "NONE", update = true })
    end
  end
end

-- 按保存值还原背景色
local function restore_bg()
  for _, group in ipairs(bg_groups) do
    local bg = saved[group]
    if bg then
      vim.api.nvim_set_hl(0, group, { bg = bg, update = true })
    end
  end
  saved = {}
end

--- 开启/关闭透明背景
--- @param enable boolean
function M.set_enabled(enable)
  if enable == enabled then
    return
  end
  enabled = enable
  if enable then
    clear_bg()
  else
    restore_bg()
  end
end

--- 切换透明背景
function M.toggle()
  M.set_enabled(not enabled)
end

--- 重新应用当前状态（供其它模块重载 colorscheme 后调用，避免透明被覆盖）
function M.reapply()
  if enabled then
    clear_bg()
  end
end

--- @return boolean 当前是否开启透明背景
function M.is_enabled()
  return enabled
end

--- 应用当前状态（启动时调用，无条件应用，绕过 set_enabled 的幂等检查）
function M.apply()
  if enabled then
    clear_bg()
  else
    restore_bg()
  end
end

return M
