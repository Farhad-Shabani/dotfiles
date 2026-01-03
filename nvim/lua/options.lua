local g = vim.g
local o = vim.o

-- Disable netrw (using nvim-tree)
g.loaded_netrw = 1
g.loaded_netrwPlugin = 1
g.markdown_fenced_languages = { "ts=typescript" }

-- UI
o.number = true
o.relativenumber = true
o.cursorlineopt = "both"
o.signcolumn = "yes"
o.ruler = true
o.termguicolors = true
o.conceallevel = 1

-- Editing
o.mouse = "a"
o.wrap = true
o.breakindent = true
o.autoindent = true
o.autoread = true
o.undofile = true

-- Search
o.ignorecase = true
o.smartcase = true
o.inccommand = "split"

-- Indentation
o.expandtab = true
o.tabstop = 2
o.shiftwidth = 2

-- Splits
o.splitright = true
o.splitbelow = true
o.scrolloff = 8
o.sidescrolloff = 8

-- Performance
o.updatetime = 250
o.timeout = true
o.timeoutlen = 500
o.ttimeoutlen = 20
o.synmaxcol = 300
