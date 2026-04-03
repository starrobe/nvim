return {
  {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    build = ":TSUpdate",
    opts = {
      ensure_installed = {
        "bash",
        "c",
        "cpp",
        "lua",
        "markdown",
        "markdown_inline",
        "query",
        "python",
        "regex",
        "rust",
        "vim",
        "vimdoc",
      },
      sync_intall = true,
      highlight = {
        enable = true,
      },
    },
  },
}
