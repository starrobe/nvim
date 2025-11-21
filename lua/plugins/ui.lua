return {
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
        bottom_search = true, -- use a classic bottom cmdline for search
        command_palette = true, -- position the cmdline and popupmenu together
        long_message_to_split = true, -- long messages will be sent to a split
        inc_rename = false, -- enables an input dialog for inc-rename.nvim
        lsp_doc_border = false, -- add a border to hover docs and signature help
      },
    },
  },
  {
    "akinsho/bufferline.nvim",
    cond = false,
    event = "VeryLazy",
    opts = {
      options = {
        diagnostics = "nvim_lsp",
        offsets = {
          {
            filetype = "snacks_layout_box",
          },
        },
        indicator = {
          style = "none",
        },
        diagnostics_indicator = function(count, level)
          local diagnostic_signs = require("icons").diagnostic
          local icon = level:match("error") and diagnostic_signs.Error .. " " or diagnostic_signs.Warn .. " "
          return " " .. icon .. count
        end,
        -- show_buffer_icons = false,
        show_buffer_close_icons = false,
        separator_style = "slant",
        hover = {
          enabled = true,
          delay = 200,
          reveal = { "close" },
        },
      },
    },
  },
  { "nvim-tree/nvim-web-devicons", lazy = true },
  { "nvim-mini/mini.icons", lazy = true },
  { "MunifTanjim/nui.nvim", lazy = true },
}
