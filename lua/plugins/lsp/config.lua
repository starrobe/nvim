local M = {}

M.servers = {
  "lua_ls",
  "clangd",
  "pyright",
  "marksman",
}

local status_cmp_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
M.capabilities = status_cmp_ok and cmp_nvim_lsp.default_capabilities() or vim.lsp.protocol.make_client_capabilities()

M.keymapping = function(ev)
  -- Enable completion triggered by <c-x><c-o>
  vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

  -- Buffer local mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, { buffer = ev.buf, desc = "Goto Declaration" })
  vim.keymap.set('n', 'gd', "<cmd>Telescope lsp_definitions<cr>", { buffer = ev.buf, desc = "Definitions" })
  vim.keymap.set('n', 'gr', "<cmd>Telescope lsp_references<cr>", { buffer = ev.buf, desc = "References" })
  vim.keymap.set('n', 'gi', "<cmd>Telescope lsp_implementations<cr>", { buffer = ev.buf, desc = "Implementations" })
  vim.keymap.set('n', 'gt', "<cmd>Telescope lsp_type_definitions<cr>", { buffer = ev.buf, desc = "Type Definitions" })
  vim.keymap.set('n', 'gk', vim.lsp.buf.signature_help, { buffer = ev.buf, desc = "Signature Help" })
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, { buffer = ev.buf, desc = "Hover" })

  vim.keymap.set('n', '<leader>cr', vim.lsp.buf.rename, { buffer = ev.buf, desc = "Rename" })
  vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, { buffer = ev.buf, desc = "Code Action" })
  vim.keymap.set('n', '<leader>cf', function()
    vim.lsp.buf.format { async = true }
  end, { buffer = ev.buf, desc = "Code Format" })
  vim.keymap.set('n', '<leader>\\', function ()
    vim.lsp.buf.format({async = true})
  end, {buffer = ev.buf, desc = "Code Format"})
end

return M
