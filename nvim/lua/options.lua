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

-- OSC 52 clipboard (works over SSH)
-- Check multiple env vars since SSH_TTY may not persist in tmux
local function is_ssh()
  return os.getenv("SSH_TTY") or os.getenv("SSH_CLIENT") or os.getenv("SSH_CONNECTION")
end

if is_ssh() then
  vim.g.clipboard = {
    name = "OSC 52",
    copy = {
      ["+"] = require("vim.ui.clipboard.osc52").copy("+"),
      ["*"] = require("vim.ui.clipboard.osc52").copy("*"),
    },
    paste = {
      ["+"] = require("vim.ui.clipboard.osc52").paste("+"),
      ["*"] = require("vim.ui.clipboard.osc52").paste("*"),
    },
  }
end

-- Performance
o.updatetime = 250
o.timeout = true
o.timeoutlen = 500
o.ttimeoutlen = 20
o.synmaxcol = 300
