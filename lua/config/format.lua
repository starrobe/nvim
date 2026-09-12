-- =============================================================================
-- 格式化：按文件类型分发到具体 formatter
-- 未列出的语言统一走 LSP format（vim.lsp.buf.format）
-- 添加新语言：在 formatters 表里加一条 filetype -> 函数即可
-- =============================================================================

local M = {}

local formatters = {}

-- Lua：stylua（2 空格，见 after/ftplugin/lua.lua）
formatters.lua = function()
  local file = vim.api.nvim_buf_get_name(0)
  local args = { "stylua", "--indent-type", "Spaces", "--indent-width", "2" }
  if file ~= "" then
    vim.list_extend(args, { "--stdin-filepath", file })
  end
  vim.list_extend(args, { "-" }) -- 从 stdin 读取
  vim.system(args, { stdin = vim.api.nvim_buf_get_lines(0, 0, -1, false), text = true }, function(out)
    vim.schedule(function()
      if out.code == 0 then
        vim.api.nvim_buf_set_lines(0, 0, -1, false, vim.split(out.stdout:gsub("\n$", ""), "\n", { plain = true }))
      else
        vim.notify("stylua 格式化失败: " .. (out.stderr or ""), vim.log.levels.ERROR)
      end
    end)
  end)
end

function M.format()
  local formatter = formatters[vim.bo.filetype]
  if formatter then
    formatter()
  else
    vim.lsp.buf.format()
  end
end

return M
