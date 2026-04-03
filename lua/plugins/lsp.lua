return {
  {
    "mason-org/mason.nvim",
    lazy = true,
    cmd = "Mason",
    opts = {},
  },
  {
    "mason-org/mason-lspconfig.nvim",
    lazy = true,
    opts = {},
  },
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPost", "BufNewFile" },
    dependencies = {
      "mason-lspconfig.nvim",
    },
    config = function()
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("UserLspConfig", {}),
        callback = function(ev)
          vim.keymap.set("n", "<leader>uh", vim.lsp.buf.signature_help, { buffer = ev.buf, desc = "Signature Help" })
          vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = ev.buf, desc = "Hover" })
          vim.keymap.set("n", "<leader>cr", vim.lsp.buf.rename, { buffer = ev.buf, desc = "Rename" })
          vim.keymap.set({ "n", "v" }, "<space>ca", vim.lsp.buf.code_action, { buffer = ev.buf, desc = "Code Action" })
        end,
      })

      vim.lsp.inlay_hint.enable()
      vim.lsp.config("*", {})
    end,
  },
}
