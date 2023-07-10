return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    init = function()
      vim.g.neo_tree_remove_legacy_commands = 1
    end,
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
    "nvim-telescope/telescope.nvim",
    dependencies = {
      { 'nvim-lua/plenary.nvim' },
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
        config = function()
          local telescope = require("telescope")
          telescope.load_extension("fzf")
          telescope.load_extension("notify")
        end
      },
    },
    cmd = "Telescope",
    opts = {
      defaults = {
        preview = false,
        layout_strategy = 'center',
        border = true,
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
    keys = {
      -- File Packers
      { "<leader><space>", "<cmd>Telescope find_files<cr>",  desc = "Find Files" },
      { "<leader>/",       "<cmd>Telescope live_grep<cr>",   desc = "Live Grep" },
      { "<leader>ff",      "<cmd>Telescope find_files<cr>",  desc = "Find Files" },
      { "<leader>fg",      "<cmd>Telescope live_grep<cr>",   desc = "Live Grep" },
      { "<leader>fs",      "<cmd>Telescope grep_string<cr>", desc = "Grep String" },
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
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = true,
  },
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
        width = math.min(vim.o.columns, 80),
        height = math.min(vim.o.lines, 21)
      }
    }
  },
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
    dependencies = { "plenary.nvim" },
    cmd = { "TodoTrouble", "TodoTelescope" },
    event = { "BufReadPost", "BufNewFile" },
    config = true,
    keys = {
      { "<leader>xt", "<cmd>TodoTrouble<cr>",                           desc = "Todo" },
      { "<leader>xT", "<cmd>TodoTrouble keywords=TODO,FIX,FIXME<cr>",   desc = "Todo/Fix/Fixme" },
      { "<leader>ft", "<cmd>TodoTelescope<cr>",                         desc = "Todo" },
      { "<leader>fT", "<cmd>TodoTelescope keywords=TODO,FIX,FIXME<cr>", desc = "Todo/Fix/Fixme" },
    }
  },
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
}
