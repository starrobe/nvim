require("core.options")
require("core.mappings")

local diagnostic_signs = require("plugins.configs.icons").diagnostic
local config = {
  virtual_text = false,
  float = {
    focusable = false,
    source = "if_many",
    header = "",
    prefix = "",
  },
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = diagnostic_signs.Error,
      [vim.diagnostic.severity.HINT] = diagnostic_signs.Hint,
      [vim.diagnostic.severity.INFO] = diagnostic_signs.Info,
      [vim.diagnostic.severity.WARN] = diagnostic_signs.Warn,
    },
  },
  severity_sort = true,
}
vim.diagnostic.config(config)

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Setup lazy.nvim
require("lazy").setup({
  spec = {
    -- import your plugins
    { import = "plugins" },
  },
  -- Configure any other settings here. See the documentation for more details.
  -- colorscheme that will be used when installing plugins.
  install = { colorscheme = { "habamax" } },
})
