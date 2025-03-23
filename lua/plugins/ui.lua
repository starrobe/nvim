return {
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = require("plugins.configs.lualine").config,
  },
  {
    "akinsho/bufferline.nvim",
    event = "VeryLazy",
    opts = {
      options = {
        diagnostics = "nvim_lsp",
        offsets = {
          {
            filetype = "snacks_layout_box",
          }
        },
        hover = {
          enabled = true,
          delay = 200,
          reveal = { 'close' }
        },
        indicator = {
          style = "none",
        },
        diagnostics_indicator = function(count, level)
          local diagnostic_signs = require("plugins.configs.icons").diagnostic
          local icon = level:match("error") and diagnostic_signs.Error .. " "
              or diagnostic_signs.Warn .. " "
          return " " .. icon .. count
        end
      }
    }
  },
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {
      lsp = {
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
          ["cmp.entry.get_documentation"] = true,
        },
      },
      presets = {
        bottom_search = true,         -- use a classic bottom cmdline for search
        command_palette = true,       -- position the cmdline and popupmenu together
        long_message_to_split = true, -- long messages will be sent to a split
        inc_rename = false,           -- enables an input dialog for inc-rename.nvim
        lsp_doc_border = false,       -- add a border to hover docs and signature help
      },
      routes = {
        {
          filter = {
            event = "msg_show",
            any = {
              -- 看不懂。。。
              -- https://www.lazyvim.org/plugins/ui#noicenvim
              { find = "%d+L, %d+B" },
              { find = "; after #%d+" },
              { find = "; before #%d+" },
            },
          },
          view = "mini",
        },
      },
    },
  },
  { "nvim-tree/nvim-web-devicons", lazy = true },
  { "MunifTanjim/nui.nvim",        lazy = true },
}
