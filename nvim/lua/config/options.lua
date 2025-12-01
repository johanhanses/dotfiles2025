-- Editor options

local opt = vim.opt

-- Indentation
opt.tabstop = 2
opt.shiftwidth = 2
opt.softtabstop = 2
opt.expandtab = true
opt.smartindent = true

-- Line numbers
opt.number = true
opt.relativenumber = false

-- Visual
opt.cursorline = true
opt.termguicolors = true
opt.signcolumn = "yes"
opt.colorcolumn = "+1"
opt.scrolloff = 3
opt.wrap = true

-- Search
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = true
opt.incsearch = true

-- Behavior
opt.hidden = true
opt.swapfile = false
opt.backup = false
opt.undofile = true
opt.updatetime = 250
opt.timeoutlen = 300

-- Clipboard (system integration)
opt.clipboard = "unnamedplus"

-- Mouse
opt.mouse = "a"

-- Splits
opt.splitright = true
opt.splitbelow = true

-- Grep (use ripgrep)
opt.grepprg = "rg --vimgrep --smart-case"
opt.grepformat = "%f:%l:%c:%m"

-- Completion
opt.completeopt = "menu,menuone,noinsert,preview"

-- Diff
opt.diffopt:append("vertical")
opt.diffopt:append("filler")

-- Disable list characters
opt.list = false

-- Filetype detection
vim.cmd("filetype plugin indent on")
vim.cmd("syntax enable")
