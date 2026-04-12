local gh = function(x) return 'https://github.com/' .. x end

vim.pack.add({
  gh("folke/tokyonight.nvim"),
  gh("folke/which-key.nvim")
})

vim.cmd[[colorscheme tokyonight]]
