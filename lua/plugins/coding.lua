return {
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    opts = {
      fast_wrap = {},
    },
    config = function(_, opts)
      require("nvim-autopairs").setup(opts)
      -- If you want insert `(` after select function or method item
      local cmp_autopairs = require('nvim-autopairs.completion.cmp')
      local cmp = require('cmp')
      cmp.event:on(
        'confirm_done',
        cmp_autopairs.on_confirm_done()
      )
    end
  },
  {
    "numToStr/Comment.nvim",
    event = "VeryLazy",
    opts = {},
  },
  {
    "kylechui/nvim-surround",
    version = "*",
    event = "VeryLazy",
    opts = {},
  },
  {
    "hrsh7th/nvim-cmp",
    event = { "InsertEnter", "CmdlineEnter" },
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "saadparwaiz1/cmp_luasnip"
    },
    config = function()
      local options = require("plugins.configs.nvim-cmp").config
      require("cmp").setup(options)
    end
  },
  {
    "L3MON4D3/LuaSnip",
    build = "make install_jsregexp",
    lazy = true,
    dependencies = {
      "rafamadriz/friendly-snippets",
      config = function()
        require("luasnip.loaders.from_vscode").lazy_load()
      end,
    },
  },
}
