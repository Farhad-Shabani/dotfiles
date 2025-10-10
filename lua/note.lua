local M = {}
local uv = vim.uv or vim.loop
local state = {}

local function root()
  local g = vim.fn.systemlist("git rev-parse --show-toplevel")[1]
  return (g and g ~= "") and g or uv.cwd()
end

local function path()
  return root() .. "/notes.md"
end

function M.toggle()
  if state.win and vim.api.nvim_win_is_valid(state.win) then
    vim.api.nvim_win_close(state.win, true)
    state = {}
    return
  end
  vim.cmd("rightbelow vsplit " .. vim.fn.fnameescape(path()))
  state.win, state.buf = vim.api.nvim_get_current_win(), vim.api.nvim_get_current_buf()
  vim.api.nvim_win_set_width(state.win, 42)
  vim.wo[state.win].winfixwidth = true
  vim.wo[state.win].number = false
  vim.wo[state.win].relativenumber = false
  vim.wo[state.win].cursorline = false
  vim.wo[state.win].spell = true
  vim.bo[state.buf].filetype = "markdown"
  vim.cmd "wincmd p"
end

function M.todo()
  if not (state.win and vim.api.nvim_win_is_valid(state.win)) then
    M.toggle()
  end
  local ts = os.date "### %Y-%m-%d %H:%M"
  local last = vim.api.nvim_buf_line_count(state.buf)
  vim.api.nvim_buf_set_lines(state.buf, last, last, false, { "", tostring(ts), "- [ ] " })
end

function M.setup()
  vim.keymap.set("n", "<leader>N", M.toggle, { desc = "Notes toggle" })
  vim.keymap.set("n", "<leader>t", M.todo, { desc = "Notes todo" })
end

return M
