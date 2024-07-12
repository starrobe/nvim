return {
  { "nvim-lua/plenary.nvim", lazy = true },
  {
    "norcalli/nvim-colorizer.lua",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      require("colorizer").setup()
    end
  },
}
