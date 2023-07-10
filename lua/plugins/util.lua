return {
  { "nvim-lua/plenary.nvim", lazy = true },
  {
    "norcalli/nvim-colorizer.lua",
    keys = {
      {"<leader>xc", "<cmd>ColorizerToggle<cr>", desc = "Toggle colorizer"}
    },
    config = function()
      require("colorizer").setup()
    end
  }
}
