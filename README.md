# My Neovim Config

个人使用的Neovim 配置。

![screenshot](https://img.starrobe.cn/screenshot/nvim.png)

## ✨ 特性

- 🚀 **原生插件管理**：基于 Neovim 内置的 `vim.pack`，无额外管理器依赖，启动快
- 🎨 **tokyonight-storm** 主题 + 半透明浮窗，极简状态栏（`statuscolumn` 由 snacks 接管）
- ⌨️ **blink.cmp** 补全，`enter` 预设 + Tab/S-Tab 导航
- 🔍 **snacks.nvim** 统一 picker / notifier / words / grep 体验
- 🏃 **flash.nvim** 快速跳转，`s` / `S` / `R` 直达
- 🧹 **conform.nvim** 统一格式化（clang-format / ruff）
- 🌳 **nvim-treesitter** 语法高亮 + 折叠

## 📦 插件

| 类别 | 插件 |
|------|------|
| 主题 | tokyonight.nvim、gruvbox.nvim |
| 补全 | blink.cmp、blink.lib |
| LSP | nvim-lspconfig（lua_ls / clangd / ty / ruff） |
| 语法 | nvim-treesitter |
| 格式化 | conform.nvim |
| 导航 | flash.nvim、which-key.nvim |
| UI | snacks.nvim、mini.icons、nvim-web-devicons |
| Git | gitsigns.nvim |

## 🛠 依赖

- **Neovim** ≥ 0.11（依赖内置 `vim.pack`）
- 系统工具：`clangd`、`clang-format`、`ruff`（按需）

## 📥 安装

```bash
git clone <your-repo-url> ~/.config/nvim
```

首次启动会自动安装插件；也可手动执行：

```vim
:PackUpdate   " 更新/安装插件
:PackClean    " 清理未启用的插件
```

## ⌨️ 按键映射

> `<leader>` = `空格`

| 按键 | 功能 |
|------|------|
| `<C-h/j/k/l>` | 窗口 / 光标方向导航 |
| `<leader>bn` / `<leader>bd` | 新建 / 删除 Buffer |
| `[b` / `]b` | 上一个 / 下一个 Buffer |
| `<leader>wd` / `<leader>wo` | 关闭窗口 / 关闭其他窗口 |
| `<leader>wk/j/h/l` | 调整窗口大小 |
| `<leader>d` | 悬浮显示诊断信息 |
| `[d` / `]d` | 上一个 / 下一个诊断 |
| `s` / `S` / `R` | flash 跳转（普通 / Treesitter / 搜索） |
| `<leader>cf` | 格式化代码 |
| `<leader><space>` | 查找文件 |
| `<leader>fb` | 查找 Buffer |
| `<leader>sg` / `<leader>sw` | Grep / 搜索光标词 |
| `<leader>sh` / `<leader>sd` | 帮助 / 诊断列表 |
| `<leader>sn` | 通知历史 |
| `[[` / `]]` | 上一个 / 下一个引用 |

## 📁 目录结构

```
~/.config/nvim
├── init.lua              # 入口
├── lua/
│   ├── config/
│   │   ├── init.lua      # 组合入口 + 诊断配置
│   │   ├── options.lua   # 编辑器选项
│   │   └── keymaps.lua   # 按键映射
│   └── plugins/
│       └── init.lua      # 插件声明与配置
├── after/lsp/            # 各 LSP server 独立配置
│   ├── clangd.lua
│   └── lua_ls.lua
└── nvim-pack-lock.json   # 插件版本锁定
```
