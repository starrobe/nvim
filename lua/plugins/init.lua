local gh = function(x) return "https://github.com/" .. x end

vim.pack.add({
  gh("folke/tokyonight.nvim"),
  gh("folke/which-key.nvim"),
  gh("folke/flash.nvim"),
  gh("folke/snacks.nvim"),
  gh("nvim-tree/nvim-web-devicons"),
  gh("nvim-mini/mini.icons"),
  gh("neovim/nvim-lspconfig"),
  gh("nvim-treesitter/nvim-treesitter"),
  {
    src = gh("saghen/blink.cmp"),
    version = vim.version.range("1.*"),
  },
  gh("stevearc/conform.nvim"),
})

vim.cmd [[colorscheme tokyonight]]


vim.api.nvim_create_user_command("PackUpdate", function()
  vim.pack.update()
end, {})

vim.api.nvim_create_user_command("PackClean", function()
  local non_active_plugins = vim.iter(vim.pack.get())
      :filter(function(x) return not x.active end)
      :map(function(x) return x.spec.name end)
      :totable()
  if #non_active_plugins == 0 then
    vim.notify("没有插件被卸载。", vim.log.levels.INFO)
    return
  end
  vim.pack.del(non_active_plugins)

  local message = "以下插件已卸载:\n- " .. table.concat(non_active_plugins, "\n- ")
  vim.notify(message, vim.log.levels.INFO)
end, {})

-- which-key.nvim
local wk = require("which-key")
wk.setup({
  preset = "helix",
})
wk.add({
  {
    mode = { "n", "v" },
    { "]",         group = "next" },
    { "[",         group = "previous" },
    { "<leader>b", group = "buffer" },
    { "<leader>c", group = "code" },
    { "<leader>f", group = "find" },
    { "<leader>s", group = "search" },
    { "<leader>w", group = "windows" },
  }
})

-- lsp
vim.lsp.enable({ "lua_ls", "clangd", "ty", "ruff" })

-- cmp
require("blink.cmp").setup({
  keymap = {
    preset = "enter",
    ["<Tab>"] = { "select_next", "snippet_forward", "fallback" },
    ["<S-Tab>"] = { "select_prev", "snippet_backward", "fallback" },
  },
  completion = {
    list = {
      selection = {
        preselect = false,
      },
    },
    menu = {
      draw = {
        treesitter = { "lsp" },
      },
    },
    documentation = {
      auto_show = true,
      auto_show_delay_ms = 200,
    },
  },
  cmdline = { enabled = false },
})

-- conform.nvim
require("conform").setup({
  formatters_by_ft = {
    c = { "clang_format" },
    cpp = { "clang_format" },
    python = { "ruff" },
  },
  default_format_opts = {
    lsp_format = "fallback",
  },
  format_on_save = {
    -- I recommend these options. See :help conform.format for details.
    lsp_format = "fallback",
    timeout_ms = 500,
  },
  formatters = {
    clang_format = {
      prepend_args = {
        "--style",
        "{BasedOnStyle: LLVM, IndentWidth: 2}",
      },
    },
  },
})

-- snacks.nvim
require("snacks").setup({
  bigfile = { enabled = true },
  explorer = { enabled = true },
  indent = { enabled = true },
  input = { enabled = true },
  picker = { enabled = true },
  notifier = { enabled = true },
  quickfile = { enabled = true },
  scope = { enabled = true },
  scroll = { enabled = true },
  statuscolumn = { enabled = true },
  words = { enabled = true },
})
