return {
  {
    "ellisonleao/gruvbox.nvim",
    cond = false,
    -- lazy = false,
    -- priority = 1000, -- make sure to load this before all the other start plugins
    -- config = function()
    --   vim.cmd([[colorscheme gruvbox]])
    -- end,
  },
  {
    "ntk148v/komau.vim",
    cond = false,
  },
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000, -- make sure to load this before all the other start plugins
    opts = {},
    config = function(_, opts)
      require("tokyonight").setup(opts)
      vim.cmd([[colorscheme tokyonight]])
    end,
  },
}
