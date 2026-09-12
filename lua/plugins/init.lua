local gh = function(x) return "https://github.com/" .. x end

vim.pack.add({
  gh("folke/tokyonight.nvim"),
  gh("ellisonleao/gruvbox.nvim"),
  gh("folke/which-key.nvim"),
  gh("folke/flash.nvim"),
  gh("folke/snacks.nvim"),
  gh("nvim-tree/nvim-web-devicons"),
  gh("nvim-mini/mini.icons"),
  gh("neovim/nvim-lspconfig"),
  gh("nvim-treesitter/nvim-treesitter"),
  gh("saghen/blink.lib"),
  gh("saghen/blink.cmp"),
  gh("stevearc/conform.nvim"),
  gh("lewis6991/gitsigns.nvim"),
  -- gh("MunifTanjim/nui.nvim"),
  -- gh("folke/noice.nvim"),
})

vim.cmd.colorscheme("tokyonight-storm")
-- vim.cmd.packadd("nvim.undotree")

vim.api.nvim_create_user_command('DiffOrig', function()
  -- 获取当前缓冲区的文件名（确保已存盘）
  local filename = vim.api.nvim_buf_get_name(0)
  if filename == '' then
    vim.notify('Current buffer has no file name, please save first.', vim.log.levels.ERROR)
    return
  end

  -- 垂直分割新窗口，设置 buftype=nofile
  vim.cmd('vert new')
  vim.cmd('set buftype=nofile')

  -- 读取原文件内容（使用 ++edit 避免编码警告）
  vim.cmd('read ++edit ' .. vim.fn.fnameescape(filename))
  -- 删除第一行空行
  vim.cmd('0d_')

  -- 启用 diff
  vim.cmd('diffthis')
  vim.cmd('wincmd p')
  vim.cmd('diffthis')
end, {
  desc = 'Diff current buffer against saved file'
})

vim.api.nvim_create_user_command("PackUpdate", function()
  vim.pack.update()
end, {})

vim.api.nvim_create_user_command("PackClean", function()
  local non_active_plugins = vim.iter(vim.pack.get())
      :filter(function(x) return not x.active end)
      :map(function(x) return x.spec.name end)
      :totable()
  if #non_active_plugins == 0 then
    vim.notify("没有需要卸载的插件。", vim.log.levels.INFO)
    return
  end
  vim.pack.del(non_active_plugins)
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
local cmp = require("blink.cmp")
cmp.build():pwait()
cmp.setup({
  keymap = {
    preset = "enter",
    ["<Tab>"] = { "select_next", "snippet_forward", "fallback" },
    ["<S-Tab>"] = { "select_prev", "snippet_backward", "fallback" },
  },
  completion = {
    list = {
      selection = {
        preselect = false,
        auto_insert = true
      },
    },
    menu = {
      auto_show = false,
      winblend = vim.o.winblend,
      draw = {
        treesitter = { "lsp" },
        columns = { { 'label', 'label_description' } }
      },
    },
    documentation = {
      auto_show = true,
      auto_show_delay_ms = 500,
      window = {
        winblend = vim.o.winblend,
      },
    },
  },
  -- signature = {
  --   enabled = true,
  --   window = {
  --     winblend = 24,
  --   },
  -- },
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
  formatters = {
    clang_format = {
      prepend_args = {
        "--style",
        "{BasedOnStyle: LLVM, IndentWidth: 4}",
      },
    },
  },
})

-- snacks.nvim
require("snacks").setup({
  bigfile = { enabled = true },
  -- indent = { enabled = true },
  input = { enabled = true },
  picker = {
    enabled = true,
    layout = {
      preset = "select",
    },
    icons = {
      files = { enabled = false },
    },
  },
  notifier = { enabled = true },
  quickfile = { enabled = true },
  scope = { enabled = true },
  scroll = { enabled = true },
  statuscolumn = { enabled = true },
  words = { enabled = true },
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

-- noice
-- require("noice").setup({
--   lsp = {
--     -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
--     override = {
--       ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
--       ["vim.lsp.util.stylize_markdown"] = true,
--       ["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
--     },
--   },
--   -- you can enable a preset for easier configuration
--   presets = {
--     bottom_search = true,         -- use a classic bottom cmdline for search
--     command_palette = true,      -- position the cmdline and popupmenu together
--     long_message_to_split = true, -- long messages will be sent to a split
--     inc_rename = false,           -- enables an input dialog for inc-rename.nvim
--     lsp_doc_border = false,       -- add a border to hover docs and signature help
--   },
--
--   cmdline = {
--     view = "cmdline"
--   }
-- })
