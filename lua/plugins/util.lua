return {
  { "nvim-lua/plenary.nvim", lazy = true },
  {
    "norcalli/nvim-colorizer.lua",
    keys = {
      { "<leader>xc", "<cmd>ColorizerToggle<cr>", desc = "Toggle colorizer" }
    },
    config = function()
      require("colorizer").setup()
    end
  },
  {
    "ahmedkhalf/project.nvim",
    config = function()
      require("project_nvim").setup()
      require("telescope").load_extension("projects")
    end,
    keys = {
      { "<leader>fp", "<Cmd>Telescope projects<CR>", desc = "Projects" },
    },
  }
}
