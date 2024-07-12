local M = {}

local has_words_before = function()
  unpack = unpack or table.unpack
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local luasnip = require "luasnip"
local cmp = require "cmp"

-- 指定 snippet 引擎
M.config = {
  view = {
    entries = { name = 'custom', selection_order = 'near_cursor' }
  },
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-c>'] = cmp.mapping.abort(),
    ["<CR>"] = cmp.mapping({
      i = function(fallback)
        if cmp.visible() and cmp.get_active_entry() then
          cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false })
        else
          fallback()
        end
      end,
      s = cmp.mapping.confirm({ select = true }),
      c = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true }),
    }),
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        if #cmp.get_entries() == 1 then
          cmp.confirm({ select = true })
        else
          cmp.select_next_item()
        end
      elseif luasnip.locally_jumpable(1) then
        luasnip.jump(1)
      elseif has_words_before() then
        cmp.complete()
        if #cmp.get_entries() == 1 then
          cmp.confirm({ select = true })
        end
      else
        fallback()
      end
    end, { "i", "s" }),
    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.locally_jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { "i", "s" }),
  }),

  -- 来源
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'luasnip' }, -- For vsnip users.
  }, {
    { name = 'buffer' },
  }),
  formatting = {
    format = function(_, item)
      -- Icons
      local icons = require("plugins.configs.icons").code
      item.kind = string.format('%s', icons[item.kind])

      -- https://github.com/hrsh7th/nvim-cmp/discussions/609
      FIXEDWIDTH = FIXEDWIDTH or false
      local content = item.abbr
      if FIXEDWIDTH then
        vim.o.pumwidth = FIXEDWIDTH
      end

      local win_width = vim.api.nvim_win_get_width(0)
      local max_context_width = FIXEDWIDTH and FIXEDWIDTH - 10 or math.floor(win_width * 0.2)

      if #content > max_context_width then
        item.abbr = vim.fn.strcharpart(content, 0, max_context_width - 3) .. "..."
      else
        item.abbr = content .. (" "):rep(max_context_width - #content)
      end
      item.menu = " "
      return item
    end
  },
}

return M
