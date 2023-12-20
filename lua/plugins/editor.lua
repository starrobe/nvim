return {
  -- 文件树
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    cmd = "Neotree",
    opts = {
      close_if_last_window = true,
      enable_git_status = false,
      enable_diagnostics = false
    },
    keys = {
      { "<leader>e", "<cmd>Neotree toggle<cr>", desc = "Toggle Neotree" }
    }
  },
  {
    "nvim-telescope/telescope-fzf-native.nvim",
    lazy = true,
    build = "make",
  },
  {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    opts = {
      defaults = {
        prompt_prefix = "   ",
        selection_caret = "  ",
        entry_prefix = "  ",
        layout_strategy = "vertical",
        layout_config = {
          prompt_position = "top",
          width = 0.43,
          height = 0.38,
        },
        preview = false,
        sorting_strategy = "ascending",
      },
      pickers = {},
      extensions = {
        fzf = {
          fuzzy = true,                   -- false will only do exact matching
          override_generic_sorter = true, -- override the generic sorter
          override_file_sorter = true,    -- override the file sorter
          case_mode = "smart_case",
        }
      }
    },
    config = function(_, opts)
      local telescope = require("telescope")
      telescope.load_extension("fzf")
      telescope.load_extension("notify")
      telescope.setup(opts)
    end,
    keys = {
      -- File Packers
      { "<leader><space>", "<cmd>Telescope find_files<cr>",  desc = "Find Files" },
      { "<leader>/",       "<cmd>Telescope live_grep<cr>",   desc = "Live Grep" },
      { "<leader>ff",      "<cmd>Telescope find_files<cr>",  desc = "Find Files" },
      { "<leader>fg",      "<cmd>Telescope live_grep<cr>",   desc = "Live Grep" },
      { "<leader>fs",      "<cmd>Telescope grep_string<cr>", desc = "Grep Current String" },
      -- Vim Pickers
      { "<leader>fb",      "<cmd>Telescope buffers<cr>",     desc = "Find Buffers" },
      { "<leader>fh",      "<cmd>Telescope help_tags<cr>",   desc = "Find Helps" },
      { "<leader>fo",      "<cmd>Telescope vim_options<cr>", desc = "Vim Options" },
      { "<leader>fk",      "<cmd>Telescope keymaps<cr>",     desc = "Key Maps" },
      { "<leader>fc",      "<cmd>Telescope colorscheme<cr>", desc = "Color Scheme" },
      -- Extensions
      { "<leader>fn",      "<cmd>Telescope notify<cr>",      desc = "Notifications" }
    },
  },

  -- 终端
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    keys = {
      { "<C-\\>", mode = { "n" }, desc = "终端" },
    },
    opts = {
      open_mapping = [[<C-\>]],
      direction = "float",
      float_opts = {
        border = "curved",
        width = math.min(vim.o.columns, 90),
        height = math.min(vim.o.lines, 25)
      }
    }
  },

  -- Diagnostics列表
  {
    "folke/trouble.nvim",
    cmd = { "TroubleToggle", "Trouble" },
    opts = { use_diagnostic_signs = true },
    keys = {
      { "<leader>xx", "<cmd>TroubleToggle<cr>", desc = "Diagnostics" }
    },
  },
  {
    "folke/todo-comments.nvim",
    cmd = { "TodoTrouble", "TodoTelescope" },
    event = { "BufReadPost", "BufNewFile" },
    opts = {},
    keys = {
      { "]t",         function() require("todo-comments").jump_next() end, desc = "Next todo comment" },
      { "[t",         function() require("todo-comments").jump_prev() end, desc = "Previous todo comment" },
      { "<leader>xt", "<cmd>TodoTrouble<cr>",                              desc = "Todo" },
      { "<leader>xT", "<cmd>TodoTrouble keywords=TODO,FIX,FIXME<cr>",      desc = "Todo/Fix/Fixme" },
      { "<leader>ft", "<cmd>TodoTelescope<cr>",                            desc = "Todo" },
      { "<leader>fT", "<cmd>TodoTelescope keywords=TODO,FIX,FIXME<cr>",    desc = "Todo/Fix/Fixme" },
    }
  },

  -- 快捷键提示
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 500
    end,
    opts = {
      defaults = {
        ["g"] = { name = "+goto" },
        ["]"] = { name = "+net" },
        ["["] = { name = "+previous" },
        ["<leader><tab>"] = { name = "+tabs" },
        ["<leader>b"] = { name = "+buffer" },
        ["<leader>c"] = { name = "+code" },
        ["<leader>f"] = { name = "+find" },
        ["<leader>w"] = { name = "+windows" },
        ["<leader>x"] = { name = "+utils" },
      }
    },
    config = function(_, opts)
      local wk = require("which-key")
      wk.setup()
      wk.register(opts.defaults)
    end
  },

  -- 跳转
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    opts = {},
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

  -- 搜索替换
  {
    "nvim-pack/nvim-spectre",
    cmd = "Spectre",
    opts = { open_cmd = "noswapfile vnew" },
    keys = {
      { "<leader>fr", function() require("spectre").open() end, desc = "Replace in files (Spectre)" },
    },
  },
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPost", "BufNewFile" },
    opts = {}
  }
}
