local g = vim.g

g.mapleader = " "
g.maplocalleader = "\\"

g.base46_cache = vim.fn.stdpath "data" .. "/nvchad/base46/"

-- load themes and integrations
dofile(g.base46_cache .. "defaults")
dofile(g.base46_cache .. "syntax")
dofile(g.base46_cache .. "statusline")
dofile(g.base46_cache .. "devicons")
dofile(g.base46_cache .. "nvimtree")
dofile(g.base46_cache .. "telescope")
dofile(g.base46_cache .. "treesitter")
dofile(g.base46_cache .. "tbline")

-- bootstrap lazy and all plugins
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

if not vim.uv.fs_stat(lazypath) then
  local repo = "https://github.com/folke/lazy.nvim.git"
  vim.fn.system { "git", "clone", "--filter=blob:none", repo, "--branch=stable", lazypath }
end

vim.opt.rtp:prepend(lazypath)

local lazy_config = require "configs.lazy"

-- load plugins
require("lazy").setup({
  {
    "NvChad/NvChad",
    lazy = false,
    branch = "v2.5",
    import = "nvchad.plugins",
  },
  { import = "plugins" },
}, lazy_config)
require("note").setup()

require "nvchad.options"
require "options"
require "nvchad.autocmds"
require "autocmds"
vim.schedule(function()
  require "mappings"
end)
require "configs.conform"
require "configs.lspconfig"
require "configs.treesitter"
