require("config.options")
require("config.keymaps")

vim.diagnostic.config({
  signs = false,
  float = {
    source = "if_many",
    header = "",
    prefix = "",
  },
  severity_sort = true,
  virtual_text = true,
})
