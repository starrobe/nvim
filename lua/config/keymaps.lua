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

-- flash.nvim
map({ "n", "x", "o" }, "s", function()
  require("flash").jump()
end, { desc = "Flash" })
map({ "n", "x", "o" }, "S", function()
  require("flash").treesitter()
end, { desc = "Flash Treesitter" })
map({ "x", "o" }, "R", function()
  require("flash").treesitter_search()
end, { desc = "Treesitter Search" })
map("o", "r", function()
  require("flash").remote()
end, { desc = "Remote Flash" })
map({ "c" }, "<c-s>", function()
  require("flash").toggle()
end, { desc = "Toggle Flash Search" })

-- 格式化（按语言分发，见 lua/config/format.lua）
map("n", "<leader>cf", function()
  require("config.format").format()
end, { desc = "Code Format" })

-- snacks.nvim
map("n", "<leader><space>", function()
  Snacks.picker.files()
end, { desc = "Find Files" })
map("n", "<leader>fb", function()
  Snacks.picker.buffers()
end, { desc = "Find Buffers" })
map("n", "<leader>sh", function()
  Snacks.picker.help()
end, { desc = "Help Pages" })
map("n", "<leader>sd", function()
  Snacks.picker.diagnostics()
end, { desc = "Diagnostics" })
map("n", "<leader>sg", function()
  Snacks.picker.grep()
end, { desc = "Grep" })
map({ "n", "x" }, "<leader>sw", function()
  Snacks.picker.grep_word()
end, { desc = "Visual selection or word" })
map("n", "<leader>sn", function()
  Snacks.notifier.show_history()
end, { desc = "Notifications History" })
map("n", "]]", function()
  Snacks.words.jump(vim.v.count1)
end, { desc = "Next Reference" })
map("n", "[[", function()
  Snacks.words.jump(-vim.v.count1)
end, { desc = "Pre Reference" })

-- 补全（原生 LSP completion）
-- <C-Space> 在多数终端会被发送为 NUL（<C-@>），两者都映射以确保能触发
map("i", "<C-Space>", function()
  vim.lsp.completion.get()
end, { desc = "Trigger completion" })
map("i", "<C-@>", function()
  vim.lsp.completion.get()
end, { desc = "Trigger completion (C-Space fallback)" })

-- Enter 确认补全项（原生默认确认键是 <C-y>，这里改用 Enter）
map("i", "<CR>", function()
  return vim.fn.pumvisible() == 1 and "<C-y>" or "<CR>"
end, { expr = true, desc = "Accept completion" })

-- Tab / S-Tab：补全列表上下移动 → snippet 占位符跳转 → 退化为 Tab
local function completion_tab_next()
  if vim.fn.pumvisible() == 1 then
    return "<C-n>"
  end
  if vim.snippet.active({ direction = 1 }) then
    return "<Cmd>lua vim.snippet.jump(1)<CR>"
  end
  return "<Tab>"
end
local function completion_tab_prev()
  if vim.fn.pumvisible() == 1 then
    return "<C-p>"
  end
  if vim.snippet.active({ direction = -1 }) then
    return "<Cmd>lua vim.snippet.jump(-1)<CR>"
  end
  return "<Tab>"
end
map({ "i", "s" }, "<Tab>", completion_tab_next, { expr = true, silent = true, desc = "Completion next / snippet jump" })
map(
  { "i", "s" },
  "<S-Tab>",
  completion_tab_prev,
  { expr = true, silent = true, desc = "Completion prev / snippet jump back" }
)

-- lsp
-- 移除 Neovim 默认的 gr* 映射（已迁移到 <leader>c / <leader>g）
for _, key in ipairs({ "grn", "gra", "grx", "grr", "gri", "grt" }) do
  pcall(vim.keymap.del, "n", key)
  pcall(vim.keymap.del, "x", key)
end

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("UserLspConfig", { clear = true }),
  callback = function(ev)
    -- <leader>c 操作类
    vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { buffer = ev.buf, desc = "Code Action" })
    vim.keymap.set("n", "<leader>cr", vim.lsp.buf.rename, { buffer = ev.buf, desc = "Rename" })
    vim.keymap.set("n", "<leader>cl", vim.lsp.codelens.run, { buffer = ev.buf, desc = "Run CodeLens" })
    -- <leader>g 跳转类
    vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, { buffer = ev.buf, desc = "Definition" })
    vim.keymap.set("n", "<leader>gD", vim.lsp.buf.declaration, { buffer = ev.buf, desc = "Declaration" })
    vim.keymap.set("n", "<leader>gt", vim.lsp.buf.type_definition, { buffer = ev.buf, desc = "Type Definition" })
    vim.keymap.set("n", "<leader>gi", vim.lsp.buf.implementation, { buffer = ev.buf, desc = "Implementation" })
    vim.keymap.set("n", "<leader>gr", vim.lsp.buf.references, { buffer = ev.buf, desc = "References" })
  end,
})

-- vim.keymap.set({ "n", "i", "s" }, "<c-f>", function()
--   if not require("noice.lsp").scroll(4) then
--     return "<c-f>"
--   end
-- end, { silent = true, expr = true })

-- vim.keymap.set({ "n", "i", "s" }, "<c-b>", function()
--   if not require("noice.lsp").scroll(-4) then
--     return "<c-b>"
--   end
-- end, { silent = true, expr = true })
