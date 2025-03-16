return {
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    opts = {
      fast_wrap = {},
    },
  },
  {
    "folke/ts-comments.nvim",
    event = "VeryLazy",
    opts = {},
  },
  {
    "kylechui/nvim-surround",
    version = "^3.0.0",
    event = "VeryLazy",
    opts = {},
  },
  {
    "hrsh7th/nvim-cmp",
    event = { "InsertEnter" },
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      {
        "L3MON4D3/LuaSnip",
        build = "make install_jsregexp",
        dependencies = {
          "rafamadriz/friendly-snippets",
        },
        config = function()
          require("luasnip.loaders.from_vscode").lazy_load()
          require("luasnip").setup()
        end,
      },
    },
    opts = function()
      return require("plugins.configs.nvim-cmp").config
    end
  },
  {
    "folke/lazydev.nvim",
    ft = "lua",
    opts = {
      library = {
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
        -- { path = "snacks.nvim",        words = { "Snacks" } },
        -- { path = "lazy.nvim",          words = { "LazyVim" } },
      },
    },
  }
  -- TODO: 懒得折腾了，留着以后了
  -- TODO: fzf-lua as a replacement for telescope.nvim
  -- LazyVim好像没用fzf-lua
  -- TODO: blink.cmp as a replacement for nvim-cmp
  -- TODO: snacks.nvim
  -- nvim-notify => snacks.notifier
  -- snacks.terminal for new termianl
  -- ...
  -- TODO: grug-far.nvim as a replacement for nvim-spectre
  -- TODO: 待续。。。
}
