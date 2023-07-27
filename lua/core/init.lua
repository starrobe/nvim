require "core.options"
require "core.mappings"

local diagnostic_signs = require("plugins.configs.icons").diagnostic
for type, icon in pairs(diagnostic_signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end
local config = {
  virtual_text = false,
  float = {
    focusable = false,
    source = 'if_many',
    header = '',
    prefix = '',
  },
  severity_sort = true,
}
vim.diagnostic.config(config)

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

local lazy_ok, lazy = pcall(require, "lazy")
if not lazy_ok then
  return
end
lazy.setup("plugins")
