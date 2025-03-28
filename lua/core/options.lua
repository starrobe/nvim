vim.g.mapleader = " "
vim.g.maplocalleader = "\\"
local opt = vim.opt

-- 第80列高亮
opt.colorcolumn = "80"

-- 同步系统与nvim的剪切板
opt.clipboard = "unnamedplus"

-- 补全menu的配置
-- 详情见`:help 'completeopt'`
opt.completeopt = "menu,menuone,noselect"

-- 当前行高亮
opt.cursorline = true

-- 根据缩进折叠
-- 开始时关闭所有折叠
opt.foldmethod = "indent"
opt.foldlevelstart = 99

-- 搜索智能匹配
-- 搜索时忽略大小写
opt.hlsearch = false
opt.smartcase = true
opt.ignorecase = true

-- 通过字符展示不可见的符号
opt.list = true
opt.listchars = {
  nbsp = "⦸",
  extends = "»",
  precedes = "«",
  tab = "▷⋯",
  trail = "•",
}

-- 使用鼠标
opt.mouse = "a"

-- 显示行数
-- 显示相对行数
opt.number = true
opt.relativenumber = true

-- 下拉菜单的最大item数
opt.pumheight = 12

-- 向上/下跳行浏览时，与顶部/底部隔3行
-- 左右隔3行
opt.scrolloff = 3
opt.sidescrolloff = 3

-- 不显示模式
opt.showmode = false

-- 智能缩进
opt.smartindent = true

-- 默认向下,向右分屏
opt.splitbelow = true
opt.splitright = true

-- 终端中使用guifg/guibg代替ctermfg/ctermbg
opt.termguicolors = true

-- 不换行
opt.wrap = false

-- 保存undo历史到undo文件中
opt.undofile = true

opt.expandtab = true -- 用空格组成tab
opt.shiftwidth = 2 -- 自动缩进的长度
opt.shiftround = true -- shiftwidth整数倍缩进
opt.softtabstop = 2 -- tab插入的空格数
opt.tabstop = 2 -- tab显示的空格数
