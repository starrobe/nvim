return {
  {
    "williamboman/mason.nvim",
    lazy = true,
    cmd = "Mason",
    opts = {}
  },
  {
    "williamboman/mason-lspconfig.nvim",
    lazy = true,
    opts = {}
  },
  {
    "folke/neodev.nvim",
    lazy = true,
    opts = {}
  },
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPost", "BufNewFile" },
    dependencies = {
      "neodev.nvim"
    },
    config = function()
      local options = {}
      local lspconfig = require("plugins.lsp.config")
      local servers = require("mason-lspconfig").get_installed_servers();

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
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    keys = {
      {
        "<leader>cf",
        function()
          require("conform").format({ async = true, lsp_format = "fallback" })
        end,
        mode = "n",
        desc = "Code Format",
      },
      {
        "<leader>\\",
        function()
          require("conform").format({ async = true, lsp_format = "fallback" })
        end,
        mode = "n",
        desc = "Code Format",
      }
    },
    -- Everything in opts will be passed to setup()
    opts = {
      format = {
        lsp_format = "fallback"
      },
      -- Define your formatters
      formatters_by_ft = {
        lua = { "stylua" },
        c = { "clang-format" },
        cpp = { "clang-format" }
      },
      -- Set up format-on-save
      format_on_save = { timeout_ms = 500, lsp_format = "fallback" },
      -- Customize formatters
      formatters = {},
    },
    init = function()
      vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
    end,
    config = function(_, opts)
      opts.formatters["clang-format"] = { prepend_args = { "--style", "{ BasedOnStyle: LLVM, IndentWidth: 4 }" } }
      require("conform").setup(opts)
    end,
  }
}
