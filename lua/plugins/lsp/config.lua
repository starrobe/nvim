local M = {}


local status_cmp_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
M.capabilities = status_cmp_ok and cmp_nvim_lsp.default_capabilities() or vim.lsp.protocol.make_client_capabilities()

M.keymapping = function(ev)
  -- Enable completion triggered by <c-x><c-o>
  vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

  -- Buffer local mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  vim.keymap.set('n', 'gk', vim.lsp.buf.signature_help, { buffer = ev.buf, desc = "Signature Help" })
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, { buffer = ev.buf, desc = "Hover" })

  vim.keymap.set('n', '<leader>cr', vim.lsp.buf.rename, { buffer = ev.buf, desc = "Rename" })
  vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, { buffer = ev.buf, desc = "Code Action" })
end

return M
