-- =============================================================================
-- 按键映射
-- =============================================================================

local map = vim.keymap.set
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- 插入模式下的方向键映射
map("i", "<C-h>", "<Left>", { desc = "Move left" })
map("i", "<C-l>", "<Right>", { desc = "Move right" })
map("i", "<C-j>", "<Down>", { desc = "Move down" })
map("i", "<C-k>", "<Up>", { desc = "Move up" })

-- 窗口导航
map("n", "<C-h>", "<C-w>h", { desc = "Move to left window" })
map("n", "<C-l>", "<C-w>l", { desc = "Move to right window" })
map("n", "<C-j>", "<C-w>j", { desc = "Move to lower window" })
map("n", "<C-k>", "<C-w>k", { desc = "Move to upper window" })

-- 缩进后保持选中
map("v", "<", "<gv", { desc = "Indent left and reselect" })
map("v", ">", ">gv", { desc = "Indent right and reselect" })

-- Buffer 管理
map("n", "<leader>bn", "<cmd>enew<cr>", { desc = "New Buffer" })
map("n", "<leader>bd", "<cmd>bd<cr>", { desc = "Delete Buffer" })
map("n", "]b", "<cmd>bn<cr>", { desc = "Next Buffer" })
map("n", "[b", "<cmd>bp<cr>", { desc = "Previous Buffer" })

-- Window 管理
map("n", "<leader>wd", "<C-w>c", { desc = "Close Window" })
map("n", "<leader>wo", "<C-w>o", { desc = "Close other Window" })
map("n", "<leader>wk", "<cmd>resize +2<cr>", { desc = "Increase window height" })
map("n", "<leader>wj", "<cmd>resize -2<cr>", { desc = "Decrease window height" })
map("n", "<leader>wl", "<cmd>vertical resize -2<cr>", { desc = "Decrease window width" })
map("n", "<leader>wh", "<cmd>vertical resize +2<cr>", { desc = "Increase window width" })

-- Diagnostic 导航
map("n", "<leader>d", vim.diagnostic.open_float, { desc = "Float Diagnostic" })
map("n", "[d", function()
  vim.diagnostic.jump({ count = -1, float = true })
end, { desc = "Previous Diagnostic" })
map("n", "]d", function()
  vim.diagnostic.jump({ count = 1, float = true })
end, { desc = "Next Diagnostic" })
