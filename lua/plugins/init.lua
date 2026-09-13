local gh = function(x)
  return "https://github.com/" .. x
end

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
  gh("lewis6991/gitsigns.nvim"),
  -- gh("MunifTanjim/nui.nvim"),
  -- gh("folke/noice.nvim"),
})

vim.cmd.colorscheme("tokyonight-storm")
-- vim.cmd.packadd("nvim.undotree")

vim.api.nvim_create_user_command("DiffOrig", function()
  -- 获取当前缓冲区的文件名（确保已存盘）
  local filename = vim.api.nvim_buf_get_name(0)
  if filename == "" then
    vim.notify("Current buffer has no file name, please save first.", vim.log.levels.ERROR)
    return
  end

  -- 垂直分割新窗口，设置 buftype=nofile
  vim.cmd("vert new")
  vim.cmd("set buftype=nofile")

  -- 读取原文件内容（使用 ++edit 避免编码警告）
  vim.cmd("read ++edit " .. vim.fn.fnameescape(filename))
  -- 删除第一行空行
  vim.cmd("0d_")

  -- 启用 diff
  vim.cmd("diffthis")
  vim.cmd("wincmd p")
  vim.cmd("diffthis")
end, {
  desc = "Diff current buffer against saved file",
})

vim.api.nvim_create_user_command("PackUpdate", function()
  vim.pack.update()
end, {})

vim.api.nvim_create_user_command("PackClean", function()
  local non_active_plugins = vim
    .iter(vim.pack.get())
    :filter(function(x)
      return not x.active
    end)
    :map(function(x)
      return x.spec.name
    end)
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
  },
})
wk.add({
  {
    mode = { "n", "v" },
    { "]", group = "next" },
    { "[", group = "previous" },
    { "<leader>b", group = "buffer" },
    { "<leader>c", group = "code" },
    { "<leader>f", group = "find" },
    { "<leader>s", group = "search" },
    { "<leader>u", group = "ui" },
    { "<leader>w", group = "windows" },
  },
})

-- lsp
vim.lsp.enable({ "lua_ls", "clangd", "ty", "ruff", "ts_ls", "marksman" })

-- 原生 LSP 补全（自动触发）
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(ev)
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    if client and client:supports_method("textDocument/completion") then
      vim.lsp.completion.enable(true, ev.data.client_id, ev.buf, {
        autotrigger = true,
        -- 去掉 kind（Keyword/Snippet 等），保留单词和 menu（类型/签名说明）
        convert = function(item)
          return { abbr = item.label, kind = "" }
        end,
      })
    end
  end,
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
Snacks.toggle.inlay_hints():map("<leader>uh")
Snacks.toggle.indent():map("<leader>ug")
Snacks.toggle.diagnostics():map("<leader>ud")

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
    vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
    vim.wo.foldmethod = "expr"
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
