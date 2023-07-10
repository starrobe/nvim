local M = {}

local diagnostic_icons = require("plugins.configs.icons").diagnostic

local modified_sign = function()
  local padding = (" "):rep(3)
  if vim.bo.modified then
    return padding .. "✘ "
  else
    return padding .. " "
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

M.config = {
  options = {
    globalstatus = true,
  },
  sections = {
    lualine_a = { modified_sign },
    lualine_b = {},
    lualine_c = {
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
      {
        "filename",
        symbols = {
          modified = "",
          readonly = require("plugins.configs.icons").file.FileReadOnly
        },
      },
    },
    lualine_x = {
      {
        function() return require("noice").api.status.command.get() end,
        cond = function() return package.loaded["noice"] and require("noice").api.status.command.has() end,
        color = "Statement"
      },
    },
    lualine_y = {},
    lualine_z = { location },
  },
  extensions = { "neo-tree", "lazy" },
}
return M
