return {
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = function()
      local diagnostic_icons = require("icons").diagnostic

      local modified_sign = function()
        local padding = (" "):rep(1)
        if vim.bo.modified then
          return padding .. "✘ "
        else
          return padding .. "  "
        end
      end

      local location = function()
        local rhs = " "

        if vim.fn.winwidth(0) > 80 then
          local column = vim.fn.virtcol(".")
          local width = vim.fn.virtcol("$")
          local line = vim.api.nvim_win_get_cursor(0)[1]
          local height = vim.api.nvim_buf_line_count(0)

          -- Add padding to stop RHS from changing too much as we move the cursor.
          local padding = #tostring(height) - #tostring(line)
          if padding > 0 then
            rhs = rhs .. (" "):rep(padding)
          end

          rhs = rhs .. "ℓ "
          rhs = rhs .. line
          rhs = rhs .. "/"
          rhs = rhs .. height
          rhs = rhs .. " \u{1d68c} "
          rhs = rhs .. column
          rhs = rhs .. "/"
          rhs = rhs .. width
          rhs = rhs .. " "
          -- Add padding to stop rhs from changing too much as we move the cursor.
          if #tostring(column) < 2 then
            rhs = rhs .. " "
          end
          if #tostring(width) < 2 then
            rhs = rhs .. " "
          end
        end
        return rhs
      end

      local format_sign = function()
        return "%="
      end

      local opts = {
        options = {
          globalstatus = true,
        },
        sections = {
          lualine_a = { modified_sign },
          lualine_b = {},
          lualine_c = {
            {
              "filename",
              path = 1,
              symbols = {
                modified = "",
                readonly = require("icons").file.FileReadOnly,
              },
              separator = "",
            },
            {
              format_sign,
              separator = "",
            },
            {
              "diagnostics",
              symbols = {
                error = diagnostic_icons.Error .. " ",
                warn = diagnostic_icons.Warn .. " ",
                info = diagnostic_icons.Info .. " ",
                hint = diagnostic_icons.Hint .. " ",
              },
              separator = "",
            },
          },
          lualine_x = {
            {
              require("noice").api.status.command.get,
              cond = require("noice").api.status.command.has,
              color = function()
                return { fg = Snacks.util.color("Statement") }
              end,
            },
          },
          lualine_y = {},
          lualine_z = { location },
        },
        extensions = { "lazy" },
      }
      return opts
    end,
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
          },
        },
        hover = {
          enabled = true,
          delay = 200,
          reveal = { "close" },
        },
        indicator = {
          style = "none",
        },
        diagnostics_indicator = function(count, level)
          local diagnostic_signs = require("icons").diagnostic
          local icon = level:match("error") and diagnostic_signs.Error .. " " or diagnostic_signs.Warn .. " "
          return " " .. icon .. count
        end,
      },
    },
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
        bottom_search = true, -- use a classic bottom cmdline for search
        command_palette = true, -- position the cmdline and popupmenu together
        long_message_to_split = true, -- long messages will be sent to a split
        inc_rename = false, -- enables an input dialog for inc-rename.nvim
        lsp_doc_border = false, -- add a border to hover docs and signature help
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
  { "echasnovski/mini.icons", lazy = true },
  { "MunifTanjim/nui.nvim", lazy = true },
}
