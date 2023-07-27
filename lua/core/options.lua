vim.g.mapleader      = " "
vim.g.maplocalleader = " "
local opt            = vim.opt

opt.colorcolumn      = "80"                    -- 第80列高亮
opt.clipboard        = "unnamedplus"           -- 剪切板
opt.completeopt      = "menu,menuone,noselect" -- 补全menu
opt.cursorline       = true                    -- 当前行高亮
opt.foldmethod       = "indent"                -- 根据缩进折叠
opt.foldlevelstart   = 99                      -- 开始时关闭所有折叠
opt.hlsearch         = false                   -- 关闭搜索匹配高亮
opt.ignorecase       = true                    -- 搜索时忽略大小写
opt.list             = true                    -- 通过字符展示不可见的符号
opt.listchars        = {
  nbsp     = '⦸',
  extends  = '»',
  precedes = '«',
  tab      = '▷⋯',
  trail    = '•',
}
opt.number           = true  -- 显示行数
opt.pumheight        = 12    -- popup menu的最大高度
opt.relativenumber   = true  -- 显示相对行数
opt.scrolloff        = 3     -- 向上/下跳行浏览时，与顶部/底部隔3行
opt.sidescrolloff    = 3     -- 左右隔3行
opt.showmode         = false -- 不显示模式
opt.smartcase        = true  -- 搜索时智能匹配
opt.smartindent      = true  -- 智能自动缩进
opt.splitbelow       = true  -- 向下分屏
opt.splitright       = true  -- 向右分屏
opt.termguicolors    = true  -- 终端中使用guifg/guibg代替ctermfg/ctermbg
opt.visualbell       = true  -- 关闭声音
opt.wrap             = false -- 不换行

-- opt.backup默认为off
opt.swapfile         = false -- 不创建swap文件
opt.undofile         = true  -- 使用undo文件
opt.writebackup      = false -- 编辑时不备份

opt.expandtab        = true  -- 用空格组成tab
opt.shiftwidth       = 2     -- 自动缩进的长度
opt.shiftround       = true  -- shiftwidth整数倍缩进
opt.softtabstop      = 2     -- tab插入的空格数
opt.tabstop          = 2     -- tab显示的空格数
