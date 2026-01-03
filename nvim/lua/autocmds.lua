local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

-- All custom autocmds in a single group for easy clearing on reload
local custom = augroup("CustomAutocmds", { clear = true })

-- Auto reload on focus gain in Cairo
autocmd({ "FocusGained", "BufEnter", "CursorHold" }, {
  group = custom,
  pattern = "*.cairo",
  callback = function()
    vim.cmd.checktime()
  end,
})

-- Show dashboard when last buffer is deleted
autocmd("BufDelete", {
  group = custom,
  callback = function()
    local bufs = vim.t.bufs or {}
    if #bufs == 1 and vim.api.nvim_buf_get_name(bufs[1]) == "" then
      vim.cmd.Nvdash()
    end
  end,
})

-- Markdown/text file settings
autocmd("FileType", {
  group = custom,
  pattern = { "markdown", "text" },
  callback = function()
    vim.opt_local.textwidth = 80
    vim.opt_local.timeoutlen = 50
    vim.cmd.NoMatchParen()
    vim.defer_fn(function()
      vim.bo.indentexpr = ""
    end, 100)

    -- nb system tag highlights
    vim.fn.matchadd("DiagnosticOk", "#win")
    vim.fn.matchadd("DiagnosticError", "#block")
    vim.fn.matchadd("DiagnosticWarn", "#idea")
    vim.fn.matchadd("DiagnosticInfo", "#deep")
    vim.fn.matchadd("DiagnosticHint", "#meet")
  end,
})

-- MDsveX: treat .svx files as markdown
autocmd({ "BufNewFile", "BufRead" }, {
  group = custom,
  pattern = "*.svx",
  callback = function()
    vim.bo.filetype = "markdown"
    vim.bo.syntax = "markdown"
  end,
})

-- Terminal: disable spell
autocmd("FileType", {
  group = custom,
  pattern = "terminal",
  callback = function()
    vim.opt_local.spell = false
  end,
})

-- Cairo: use 4-space indentation
autocmd("FileType", {
  group = custom,
  pattern = "cairo",
  callback = function()
    vim.opt_local.tabstop = 4
    vim.opt_local.shiftwidth = 4
    vim.opt_local.expandtab = true
  end,
})

-- Filetype detection for env files
vim.filetype.add {
  pattern = {
    [".*%.env%..*"] = "sh",
  },
  filename = {
    [".env"] = "sh",
  },
}
