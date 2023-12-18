return {
  -- 自动括号
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    opts = {
      check_ts = true,
      ts_config = {
        lua = { 'string' }, -- it will not add a pair on that treesitter node
        javascript = { 'template_string' },
        java = false,       -- don't check treesitter on java
      },
      fast_wrap = {
        map = '<M-e>', -- <Alt-e>
        chars = { '{', '[', '(', '"', "'" },
        pattern = [=[[%'%"%>%]%)%}%,]]=],
        end_key = '$',
        before_key = 'h',
        after_key = 'l',
        cursor_pos_before = true,
        keys = 'qwertyuiopzxcvbnmasdfghjkl',
        manual_position = true,
        highlight = 'Search',
        highlight_grey = 'Comment'
      },
    },
  },

  -- 注释
  {
    "numToStr/Comment.nvim",
    opts = {},
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
          require("Comment.api").toggle.blockwise(vim.fn.visualmode())
        end,
        mode = "x",
        desc = "注释选中的行"
      }
    },
  },

  -- 添加环绕符号如 "", '', (), {}等
  {
    "kylechui/nvim-surround",
    event = "VeryLazy",
    opts = {},
  },

  -- 代码补全
  {
    "hrsh7th/nvim-cmp",
    event = {"InsertEnter", "CmdlineEnter"},
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
    dependencies = {
      "rafamadriz/friendly-snippets",
      config = function()
        require("luasnip.loaders.from_vscode").lazy_load()
      end,
    },
  },
}
