# Neovim Config

个人使用的Neovim 配置。

![screenshot](https://img.starrobe.cn/screenshot/nvim.png)

## 📦 插件

| 类别 | 插件 |
|------|------|
| 主题 | tokyonight.nvim、gruvbox.nvim |
| 补全 | 原生 `vim.lsp.completion`（内置） |
| LSP | nvim-lspconfig |
| 语法 | nvim-treesitter |
| 导航 | flash.nvim、which-key.nvim |
| UI | snacks.nvim、mini.icons、nvim-web-devicons |
| Git | gitsigns.nvim |

## 🛠 依赖

- **Neovim** ≥ 0.11（依赖内置 `vim.pack`）
- **LSP 服务器**：`lua_ls`、`clangd`、`ty`、`ruff`、`ts_ls`、`marksman`
- **格式化工具**：`stylua`（Lua）、`oxfmt`（JS/TS/Vue），其余语言走 LSP format

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
| `<C-Space>` | 触发补全 |
| `Tab` / `S-Tab` | 补全列表上下移动 / snippet 跳转 |
| `Enter` | 确认补全项 |
| `<leader>bn` / `<leader>bd` | 新建 / 删除 Buffer |
| `[b` / `]b` | 上一个 / 下一个 Buffer |
| `<leader>wd` / `<leader>wo` | 关闭窗口 / 关闭其他窗口 |
| `<leader>wk/j/h/l` | 调整窗口大小 |
| `<leader>d` | 悬浮显示诊断信息 |
| `[d` / `]d` | 上一个 / 下一个诊断 |
| `s` / `S` / `R` | flash 跳转（普通 / Treesitter / 搜索） |
| `<leader>cf` | 格式化代码 |
| `<leader><space>` | 查找文件 |
| `<leader>sb` | 查找 Buffer |
| `<leader>ss` / `<leader>sw` | Grep / 搜索光标词 |
| `<leader>sh` / `<leader>sd` | 帮助 / 诊断列表 |
| `<leader>sn` | 通知历史 |
| `<leader>uh` / `<leader>ui` / `<leader>ud` | 内联提示 / 缩进线 / 诊断 开关 |
| `<leader>ub` | Git Blame 开关 |
| `<leader>us` | 语法高亮 开关（`syntax off`/`on`） |
| `<leader>ut` | 透明背景 开关 |
| `[[` / `]]` | 上一个 / 下一个引用 |

## 📁 目录结构

```
~/.config/nvim
├── init.lua              # 入口
├── lua/
│   ├── config/
│   │   ├── init.lua      # 组合入口 + 诊断配置
│   │   ├── options.lua   # 编辑器选项
│   │   ├── keymaps.lua   # 按键映射
│   │   ├── format.lua    # 格式化（按文件类型分发 formatter）
│   │   ├── highlight.lua # 语法高亮开关（syntax off/on）
│   │   ├── transparent.lua # 透明背景开关
│   │   └── colors.lua    # 未启用 colorscheme 时补充的部分颜色
│   └── plugins/
│       └── init.lua      # 插件声明与配置
├── after/
│   ├── ftplugin/
│   │   └── lua.lua       # Lua 文件缩进设置（2 空格）
│   └── lsp/              # 各 LSP server 独立配置
│       ├── clangd.lua
│       └── lua_ls.lua
└── nvim-pack-lock.json   # 插件版本锁定
```
