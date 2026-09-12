-- =============================================================================
-- 格式化：按文件类型分发到具体 formatter
-- 未列出的语言统一走 LSP format（vim.lsp.buf.format）
-- 添加新语言：用 make_stdin_formatter 生成函数，加进 formatters 表即可
-- =============================================================================

local M = {}

-- 通用 stdin formatter：把 buffer 内容交给 CLI，成功后替换
-- base_cmd：命令 + 固定参数（不含 --stdin-filepath 和 -）
local function make_stdin_formatter(base_cmd)
  return function()
    local file = vim.api.nvim_buf_get_name(0)
    local args = vim.deepcopy(base_cmd)
    if file ~= "" then
      vim.list_extend(args, { "--stdin-filepath", file })
    end
    vim.list_extend(args, { "-" }) -- 从 stdin 读取
    vim.system(args, { stdin = vim.api.nvim_buf_get_lines(0, 0, -1, false), text = true }, function(out)
      vim.schedule(function()
        if out.code == 0 then
          vim.api.nvim_buf_set_lines(0, 0, -1, false, vim.split(out.stdout:gsub("\n$", ""), "\n", { plain = true }))
        else
          vim.notify("格式化失败: " .. (out.stderr or ""), vim.log.levels.ERROR)
        end
      end)
    end)
  end
end

local formatters = {}

-- Lua：stylua（2 空格，见 after/ftplugin/lua.lua）
formatters.lua = make_stdin_formatter({ "stylua", "--indent-type", "Spaces", "--indent-width", "2" })

-- JS/TS/Vue：oxfmt（prettier 兼容）
for _, ft in ipairs({ "javascript", "javascriptreact", "typescript", "typescriptreact", "vue" }) do
  formatters[ft] = make_stdin_formatter({ "oxfmt" })
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
