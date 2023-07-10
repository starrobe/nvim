return {
  -- 自动括号
  {
    "windwp/nvim-autopairs",
    event = "VeryLazy",
    opts = {
      check_ts = true,
      ts_config = {
        lua = { 'string' }, -- it will not add a pair on that treesitter node
        javascript = { 'template_string' },
        java = false,       -- don't check treesitter on java
      },
      fast_wrap = {
        map = '<M-e>',
        chars = { '{', '[', '(', '"', "'" },
        pattern = [=[[%'%"%>%]%)%}%,]]=],
        end_key = '$',
        keys = 'qwertyuiopzxcvbnmasdfghjkl',
        check_comma = true,
        highlight = 'Search',
        highlight_grey = 'Comment'
      },
    }
  },

  -- 注释
  {
    "numToStr/Comment.nvim",
    config = true,
    keys = {
      {
        "<C-_>",
        function()
          require("Comment.api").toggle.linewise.current()
        end,
        desc = "注释当前行"
      },
      {
        "<C-_>",
        function()
          local esc = vim.api.nvim_replace_termcodes(
            '<ESC>', true, false, true
          )
          vim.api.nvim_feedkeys(esc, 'nx', false)
          require("Comment.api").toggle.linewise(vim.fn.visualmode())
        end,
        mode = "x",
        desc = "注释选中的行"
      }
    },
  },

  -- 添加环绕符号如 "", '', (), {}等
  {
    "kylechui/nvim-surround",
    config = true,
    event = "VeryLazy",
  },

  -- 跳转
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    config = true,
    keys = {
      {
        "s",
        mode = { "n", "x", "o" },
        function()
          require("flash").jump()
        end,
        desc = "Flash",
      },
      {
        "S",
        mode = { "n", "o", "x" },
        function()
          require("flash").treesitter()
        end,
        desc = "Flash Treesitter",
      },
    },
  },

  -- 代码补全
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      {
        "L3MON4D3/LuaSnip",
        build = "make install_jsregexp",
        dependencies = {
          "rafamadriz/friendly-snippets",
          config = function()
            require("luasnip.loaders.from_vscode").lazy_load()
          end,
        },
      },
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
}
