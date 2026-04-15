return {
  settings = {
    Lua = {
      diagnostics = {
        globals = { "Snacks" },
      },
      runtime = {
        version = "LuaJIT",
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
