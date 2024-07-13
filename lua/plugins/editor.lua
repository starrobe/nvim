return {
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
      { "<leader><leader>", "<cmd>Telescope find_files<cr>",  desc = "Find Files" },
      { "<leader>ff",       "<cmd>Telescope find_files<cr>",  desc = "Find Files" },
      { "<leader>fs",       "<cmd>Telescope live_grep<cr>",   desc = "Live Grep" },
      -- Vim Pickers
      { "<leader>fb",       "<cmd>Telescope buffers<cr>",     desc = "Find Buffers" },
      { "<leader>fh",       "<cmd>Telescope help_tags<cr>",   desc = "Find Helps" },
      { "<leader>fo",       "<cmd>Telescope vim_options<cr>", desc = "Vim Options" },
      { "<leader>fk",       "<cmd>Telescope keymaps<cr>",     desc = "Key Maps" },
      { "<leader>fc",       "<cmd>Telescope colorscheme<cr>", desc = "Color Scheme" },
      -- Extensions
      { "<leader>fn",       "<cmd>Telescope notify<cr>",      desc = "Notifications" }
    },
  },
  {
    "folke/trouble.nvim",
    cmd = "Trouble",
    opts = {},
    keys = {
      { "<leader>lt", "<cmd>Trouble todo toggle<cr>",        desc = "Todo" },
      { "<leader>ld", "<cmd>Trouble diagnostics toggle<cr>", desc = "Diagnostics" }
    },
  },
  {
    "folke/todo-comments.nvim",
    event = { "BufReadPost", "BufNewFile" },
    opts = {},
    keys = {
      { "]t",         function() require("todo-comments").jump_next() end, desc = "Next todo comment" },
      { "[t",         function() require("todo-comments").jump_prev() end, desc = "Previous todo comment" },
      { "<leader>ft", "<cmd>TodoTelescope<cr>",                            desc = "Todo" },
    }
  },
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 500
    end,
    config = function()
      local wk = require("which-key")
      wk.setup()
      wk.add({
        { "g",             group = "goto" },
        { "]",             group = "next" },
        { "[",             group = "previous" },
        { "<leader><tab>", group = "tabs" },
        { "<leader>b",     group = "buffer" },
        { "<leader>c",     group = "code" },
        { "<leader>f",     group = "search" },
        { "<leader>w",     group = "windows" },
        { "<leader>l",     group = "list" },
      })
    end
  },
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    opts = {},
    keys = {
      { "s",     mode = { "n", "x", "o" }, function() require("flash").jump() end,              desc = "Flash" },
      { "S",     mode = { "n", "x", "o" }, function() require("flash").treesitter() end,        desc = "Flash Treesitter" },
      { "r",     mode = "o",               function() require("flash").remote() end,            desc = "Remote Flash" },
      { "R",     mode = { "o", "x" },      function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
      { "<c-s>", mode = { "c" },           function() require("flash").toggle() end,            desc = "Toggle Flash Search" },
    },
  },
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
