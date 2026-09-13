return {
  settings = {
    Lua = {
      diagnostics = {
        globals = { "Snacks" },
      },
      runtime = {
        version = "LuaJIT",
        -- 让 lua-ls 像 Neovim 一样解析模块（见 :h lua-module-load）
        path = {
          "lua/?.lua",
          "lua/?/init.lua",
        },
      },
      workspace = {
        checkThirdParty = false,
        library = {
          vim.env.VIMRUNTIME,
        },
      },
      completion = {
        callSnippet = "Replace",
      },
    },
  },
}
