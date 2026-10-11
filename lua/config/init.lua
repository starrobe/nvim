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

-- 默认状态：关闭语法高亮 + 透明背景
require("config.highlight").apply()
require("config.transparent").apply()
require("config.colors").apply()
