require("config.options")
require("config.keymaps")

vim.diagnostic.config({
  virtual_text = false,
  float = {
    focusable = false,
    source = "if_many",
    header = "",
    prefix = "",
  },
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = "󰈸",
      [vim.diagnostic.severity.HINT] = "",
      [vim.diagnostic.severity.INFO] = "󰌪",
      [vim.diagnostic.severity.WARN] = "",
    },
  },
  severity_sort = true,
})
