return {
  {
    "williamboman/mason.nvim",
    lazy = true,
    cmd = "Mason",
    opts = {},
  },
  {
    "williamboman/mason-lspconfig.nvim",
    lazy = true,
    opts = {},
  },
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      local servers = require("mason-lspconfig").get_installed_servers()

      local has_cmp, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
      local has_blink, blink = pcall(require, "blink.cmp")

      local capabilities = vim.tbl_deep_extend(
        "force",
        {},
        vim.lsp.protocol.make_client_capabilities(),
        has_cmp and cmp_nvim_lsp.default_capabilities() or {},
        has_blink and blink.get_lsp_capabilities() or {}
      )

      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("UserLspConfig", {}),
        callback = function(ev)
          vim.keymap.set("n", "<leader>gk", vim.lsp.buf.signature_help, { buffer = ev.buf, desc = "Signature Help" })
          vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = ev.buf, desc = "Hover" })
          vim.keymap.set("n", "<leader>cr", vim.lsp.buf.rename, { buffer = ev.buf, desc = "Rename" })
          vim.keymap.set({ "n", "v" }, "<space>ca", vim.lsp.buf.code_action, { buffer = ev.buf, desc = "Code Action" })
        end,
      })

      -- https://neovim.io/doc/user/lsp.html#_lua-module:-vim.lsp.inlay_hint
      vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())

      for _, server in pairs(servers) do
        local has_server_config, server_config = pcall(require, "plugins.lsp.servers." .. server)
        local server_opts = vim.tbl_deep_extend("force", {
          capabilities = vim.deepcopy(capabilities),
        }, has_server_config and server_config or {})
        require("lspconfig")[server].setup(server_opts)
      end
    end,
  },
}
