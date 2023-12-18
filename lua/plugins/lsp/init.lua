return {
  {
    "williamboman/mason.nvim",
    cmd = "Mason",
    opts = {}
  },
  {
    "williamboman/mason-lspconfig.nvim",
    opts = {
      ensure_installed = require("plugins.lsp.config").servers
    }
  },
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      { "folke/neodev.nvim", opts = {} },
      "mason.nvim",
      "mason-lspconfig.nvim",
    },
    config = function()
      local options = {}
      local lspconfig = require("plugins.lsp.config")
      local servers = require("mason-lspconfig").get_installed_servers();
      table.insert(servers, "clangd")

      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("UserLspConfig", {}),
        callback = function(ev)
          lspconfig.keymapping(ev)
        end
      })

      for _, server in pairs(servers) do
        options = {
          capabilities = lspconfig.capabilities,
        }
        local require_ok, settings = pcall(require, "plugins.lsp.settings." .. server)
        if require_ok then
          options = vim.tbl_deep_extend("force", settings, options)
        end
        require("lspconfig")[server].setup(options)
      end
    end,
  },
  {
    "nvimtools/none-ls.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = function()
      local null_ls = require("null-ls")
      return {
        sources = {
          null_ls.builtins.formatting.clang_format.with({
            extra_args = {
              "-style={BasedOnStyle: LLVM, IndentWidth: 4}"
            }
          })
        },
      }
    end,
  },
}
