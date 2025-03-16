local map = vim.api.nvim_set_keymap
local opts = { noremap = true }

map("i", "<C-h>", "<Left>", opts)
map("i", "<C-l>", "<Right>", opts)
map("i", "<C-j>", "<Down>", opts)
map("i", "<C-k>", "<Up>", opts)

map("n", "<C-h>", "<C-w>h", opts)
map("n", "<C-l>", "<C-w>l", opts)
map("n", "<C-j>", "<C-w>j", opts)
map("n", "<C-k>", "<C-w>k", opts)

-- gv会重新选择上一次所选文本
map("v", "<", "<gv", opts)
map("v", ">", ">gv", opts)

-- Buffer
map("n", "<leader>bn", "<cmd>enew<cr>", { desc = "New Buffer" })
map("n", "<leader>bd", "<cmd>bd<cr>", { desc = "Delete Buffer" })
map("n", "]b", "<cmd>bn<cr>", { desc = "Next Buffer" })
map("n", "[b", "<cmd>bp<cr>", { desc = "Previous Buffer" })

-- Window
map("n", "<leader>wc", "<C-w>c", { desc = "Close Window" })
map("n", "<leader>wo", "<C-w>o", { desc = "Close other Window" })
map("n", "<C-Up>", "<cmd>resize +2<cr>", { desc = "Increase window height" })
map("n", "<C-Down>", "<cmd>resize -2<cr>", { desc = "Decrease window height" })
map("n", "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease window width" })
map("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase window width" })

-- Diagnostic
map("n", "<leader>d", "<cmd>lua vim.diagnostic.open_float()<cr>", { desc = "Float Diagnostic" })
map("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<cr>", { desc = "Previous Diagnostic" })
map("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<cr>", { desc = "Next Diagnostic" })
