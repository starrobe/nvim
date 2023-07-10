return {
  {
    "williamboman/mason.nvim",
    cmd = "Mason",
    config = true
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
      { "folke/neodev.nvim",  opts = { experimental = { pathStrict = true } } },
      "mason.nvim",
      "mason-lspconfig.nvim",
    },
    config = function()
      local options = {}
      local lspconfig = require("plugins.lsp.config")
      local servers = lspconfig.servers

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
}
