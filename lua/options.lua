local g = vim.g
local o = vim.o

g.markdown_fenced_languages = {
  "ts=typescript",
}

o.cursorlineopt = "both"
o.relativenumber = true
o.number = true
o.ruler = true
o.autoread = true
o.mouse = "a"
o.termguicolors = true
o.expandtab = true
o.autoindent = true
o.signcolumn = "yes"
o.conceallevel = 1

local autocmd = vim.api.nvim_create_autocmd

autocmd("FileType", {
  pattern = { "markdown", "text", "gitcommit" },
  callback = function()
    vim.opt_local.spell = true
    vim.opt_local.spelllang = "en_us"
    vim.opt_local.spelloptions = "camel"
  end,
})

autocmd("FileType", {
  pattern = { "terminal" },
  callback = function()
    vim.opt_local.spell = false
  end,
})

autocmd("FileType", {
  pattern = { "cairo" },
  callback = function()
    o.tabstop = 4
    o.shiftwidth = 4
    o.expandtab = true
  end,
})
