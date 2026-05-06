require("config.options")
require("config.keymaps")

vim.diagnostic.config({
  float = {
    source = "if_many",
    header = "",
    prefix = "",
  },
  severity_sort = true,
})
