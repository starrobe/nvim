local gh = function(x) return "https://github.com/" .. x end

vim.pack.add({
  gh("folke/tokyonight.nvim"),
  gh("ellisonleao/gruvbox.nvim"),
  gh("folke/which-key.nvim"),
  gh("folke/flash.nvim"),
  gh("folke/snacks.nvim"),
  gh("folke/noice.nvim"),
  gh("nvim-tree/nvim-web-devicons"),
  gh("nvim-mini/mini.icons"),
  gh("neovim/nvim-lspconfig"),
  gh("nvim-treesitter/nvim-treesitter"),
  gh("MunifTanjim/nui.nvim"),
  {
    src = gh("saghen/blink.cmp"),
    version = vim.version.range("1.*"),
  },
  gh("stevearc/conform.nvim"),
})

vim.cmd.colorscheme("tokyonight")
vim.cmd.packadd("nvim.undotree")


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
  icons = {
    -- 禁用所有mapping icons
    mappings = false,
  }
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
        columns    = { { "label" }, { "label_description" } }
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
  indent = { enabled = true },
  input = { enabled = true },
  picker = {
    enabled = true,
    layout = {
      preset = "select",
    },
    icons = {
      files = { enabled = false },
      diagnostics = {
        Error = "󰈸 ",
        Warn = " ",
        Hint = " ",
        Info = "󰌪 ",
      },
    },
  },
  notifier = { enabled = true },
  quickfile = { enabled = true },
  scope = { enabled = true },
  scroll = { enabled = true },
  statuscolumn = { enabled = true },
  words = { enabled = true },
})

-- noice.nvim
require("noice").setup({
  lsp = {
    -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
    override = {
      ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
      ["vim.lsp.util.stylize_markdown"] = true,
    },
  },
  -- you can enable a preset for easier configuration
  presets = {
    bottom_search = true,         -- use a classic bottom cmdline for search
    command_palette = true,       -- position the cmdline and popupmenu together
    long_message_to_split = true, -- long messages will be sent to a split
    inc_rename = false,           -- enables an input dialog for inc-rename.nvim
    lsp_doc_border = false,       -- add a border to hover docs and signature help
  },
})

-- nvim-treesitter
local ensure_installed = {
  "bash",
  "c",
  "cpp",
  "lua",
  "markdown",
  "markdown_inline",
  "query",
  "python",
  "regex",
  "rust",
  "vim",
  "vimdoc",
}
require("nvim-treesitter").install(ensure_installed)

vim.api.nvim_create_autocmd("FileType", {
  pattern = ensure_installed,
  callback = function()
    vim.treesitter.start()
    vim.wo[0][0].foldexpr = "v:lua.vim.treesitter.foldexpr()"
    vim.wo[0][0].foldmethod = "expr"
    vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
  end,
})
