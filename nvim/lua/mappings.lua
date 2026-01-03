require "nvchad.mappings"

local map = vim.keymap.set

local function opts(desc, expr)
  return { noremap = true, silent = true, desc = desc, expr = expr or false }
end

-- Exit (jk handled by better-escape.nvim)
map("n", "<leader>jk", "<cmd>nohl<CR>", opts "Clear search highlight")
map("n", "<leader>q", "<cmd>q<CR>", opts "Close buffer")
map("n", "<leader>Q", "<cmd>q!<CR>", opts "Close buffer forcefully")
map("n", "<A-w>", "<cmd>tabclose<CR>", opts "Close tab")
map("n", "<leader>cx", '<cmd>:lua require("nvchad.tabufline").closeAllBufs()<CR>', opts "Close all buffers")
map("n", "<leader>co", '<cmd>lua require("nvchad.tabufline").closeAllBufs(false)<CR>', opts "Close other buffers")

-- Save
vim.keymap.del("n", "<C-s>")
map({ "n" }, "<leader>s", "<cmd>w<CR>", opts "Save buffer")
map(
  "n",
  "<leader>w",
  '<cmd>w<CR><cmd>:lua require("nvchad.tabufline").close_buffer()<CR>',
  opts "Save buffer and close"
)

-- Yank and paste
map({ "v", "x" }, "<leader>p", '"_dP', opts "Delete w/o storing in register and paste")
map({ "n", "v" }, "<leader>y", '"ay', opts "Yank to 'a' register")
map({ "v", "x" }, "<leader>pa", '"_d"aP', opts "Delete and paste from 'a' register")
map({ "v", "x" }, "<D-c>", '"+y', opts "Yank to clippboard")

-- Modify without altering registers
map({ "n", "v" }, "x", '"_x', opts "Delete single char, w/o storing in register")
map({ "n", "v" }, "X", '"_X', opts "Delete single char before cursor, w/o storing in register")
map({ "n", "v" }, "c", '"_c', opts "Change, w/o storing in register")
map({ "n", "v" }, "C", '"_C', opts "Change to EOL, w/o storing in register")

-- Center movement on screen
map("n", "<C-d>", "<C-d>zz", opts "Scroll down and recenter")
map("n", "<C-u>", "<C-u>zz", opts "Scroll down and recenter")

-- Select all
map({ "n" }, "<leader>a", "<cmd>norm ggVG<cr>", opts "Select all text in the buffer")

-- Move lines
map("n", "<A-j>", "<cmd>m .+1<cr>==", { desc = "Move Down" })
map("n", "<A-k>", "<cmd>m .-2<cr>==", { desc = "Move Up" })
map("i", "<A-j>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move Down" })
map("i", "<A-k>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move Up" })
map("v", "<A-j>", ":m '>+1<cr>gv=gv", { desc = "Move Down" })
map("v", "<A-k>", ":m '<-2<cr>gv=gv", { desc = "Move Up" })

-- Resize windows
map("n", "<A-C-l>", "<cmd>vertical resize -2<cr>", opts "Decrease Window Width")
map("n", "<A-C-h>", "<cmd>vertical resize +2<cr>", opts "Increase Window Width")
map("n", "<A-C-j>", "<cmd>resize -2<cr>", opts "Decrease Window Height")
map("n", "<A-C-k>", "<cmd>resize +2<cr>", opts "Increase Window Height")

-- ZenMode
map("n", "<leader>z", "<cmd>ZenMode<CR>", opts "Toggle ZenMode")

-- Find
map("n", "<leader>ff", "<cmd>Telescope find_files<CR>", opts "Telescope find files")
map("n", "<leader>f", "<cmd>Telescope resume<CR>", opts "Telescope resume last search")
map(
  "n",
  "<Leader>fb",
  ":Telescope file_browser path=%:p:h select_buffer=true<CR>",
  opts "Telescope file browser (on current buffer)"
)
map("n", "<Leader>fR", ":%s/<C-r><C-w>//g<Left><Left>", opts "Find and replace focused word")
map("n", "<leader>fs", "<cmd>Telescope grep_string<CR>", opts "Telescope find word under cursor")
map("n", "<leader>fc", "<cmd>Telescope commands<CR>", opts "Telescope find commands")
map("n", "<leader>fo", "<cmd>Telescope oldfiles<CR>", opts "Telescope find history")
map("n", "<leader>fW", function()
  require("telescope.builtin").live_grep {
    additional_args = function(args)
      return vim.list_extend(args, { "--hidden", "--no-ignore" })
    end,
  }
end, opts "Telescope find word in all files")
map(
  "n",
  "<leader>fl",
  "<cmd>:lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>",
  opts "Telescope live grep args"
)
map(
  "n",
  "<leader>k",
  "<cmd>:lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>",
  opts "Telescope live grep args"
)
map("n", "<leader>fm", "<cmd>Telescope marks<CR>", opts "Telescope marks")
map("n", "<leader>fj", "<cmd>Telescope jumplist<CR>", opts "Telescope jumplist")
map("n", "[x", function()
  require("treesitter-context").go_to_context(vim.v.count1)
end, opts "Go to context")

-- Navigation
local function harpoon_list()
  return require("harpoon"):list()
end
map("n", "<leader>hl", function()
  require("configs.nav").toggle_telescope(harpoon_list())
end, opts "Open harpoon window")
map("n", "<leader>ha", function()
  harpoon_list():add()
end, opts "Add file")
map("n", "<leader>hn", function()
  harpoon_list():next()
end, opts "Next file")
map("n", "<leader>hp", function()
  harpoon_list():prev()
end, opts "Prev file")
for ii = 1, 4 do
  map("n", "<leader>" .. ii, function()
    harpoon_list():select(ii)
  end, opts("Select file" .. ii))
end
map("n", "<leader>nm", "<cmd>Neominimap toggle<CR>", opts "Toggle global minimap")
map("n", "<leader>nr", "<cmd>Neominimap refresh<CR>", opts "Refresh global minimap")
map("n", "<leader>no", "<cmd>Neominimap on<CR>", opts "Enable global minimap")
map("n", "<leader>nc", "<cmd>Neominimap off<CR>", opts "Disable global minimap")
map("n", "<leader>nb", "<cmd>Neominimap bufToggle<CR>", opts "Toggle minimap for current buffer")

-- Debugging
map("n", "<Leader>dl", "<cmd>lua require'dap'.step_into()<CR>", opts "Debugger step into")
map("n", "<Leader>dj", "<cmd>lua require'dap'.step_over()<CR>", opts "Debugger step over")
map("n", "<Leader>dk", "<cmd>lua require'dap'.step_out()<CR>", opts "Debugger step out")
map("n", "<Leader>dc", "<cmd>lua require'dap'.continue()<CR>", opts "Debugger continue")
map("n", "<Leader>db", "<cmd>lua require'dap'.toggle_breakpoint()<CR>", opts "Debugger toggle breakpoint")
map(
  "n",
  "<Leader>dd",
  "<cmd>lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>",
  opts "Debugger set conditional breakpoint"
)
map("n", "<Leader>de", "<cmd>lua require'dap'.terminate()<CR>", opts "Debugger reset")
map("n", "<Leader>dr", "<cmd>lua require'dap'.run_last()<CR>", opts "Debugger run last")

-- Diagnostics
map("n", "<Leader>e", vim.diagnostic.open_float, opts "Show diagnostics float")
map("n", "<leader>fq", "<cmd>Telescope quickfix<CR>", opts "Telescope quickfix")
map("n", "<leader>lz", "<cmd>Telescope spell_suggest<CR>", opts "Telescope spell suggest")
map("n", "<leader>le", "<cmd>Telescope diagnostics<CR>", opts "Telescope diagnostics")
map("n", "<leader>tn", "<cmd>Telescope noice<CR>", opts "Telescope noice")

-- LSP
map("n", "<leader>lr", "<cmd>Telescope lsp_references<CR>", opts "Telescope references")
map("n", "<leader>li", "<cmd>Telescope lsp_implementations<CR>", opts "Telescope implementations")
map("n", "<leader>ld", "<cmd>Telescope lsp_definitions<CR>", opts "Telescope definitions")
map("n", "<leader>lt", "<cmd>Telescope lsp_type_definitions<CR>", opts "Telescope type definitions")
map("n", "<leader>lI", "<cmd>Telescope lsp_incoming_calls<CR>", opts "Telescope incoming calls")
map("n", "<leader>lO", "<cmd>Telescope lsp_outgoing_calls<CR>", opts "Telescope outgoing calls")
map("n", "<leader>lS", "<cmd>Telescope lsp_workspace_symbols<CR>", opts "Telescope workspace symbols")
map("n", "<leader>ls", "<cmd>Telescope lsp_dynamic_workspace_symbols<CR>", opts "Telescope dynamic workspace symbols")
map("n", "<leader>lD", vim.lsp.buf.declaration, opts "Declaration of current symbol")
map("n", "<leader>la", vim.lsp.buf.code_action, opts "Code action")
map("n", "<leader>rn", vim.lsp.buf.rename, opts "Rename symbol")

-- Rust
map("n", "<leader>ra", "<cmd>RustLsp codeAction<CR>", opts "Rust code action")
map("n", "<Leader>rt", "<cmd>RustTest -- --nocapture<CR>", opts "Rust run test under cursor")
map("n", "<leader>re", "<cmd>RustLsp expandMacro<CR>", opts "Rust expand macro")
map("n", "<Leader>rd", "<cmd>lua vim.cmd('RustLsp testables')<CR>", opts "Rust debugger testables")

-- Logging
map("n", "glm", function()
  require("chainsaw").messageLog()
end, opts "Create message log statement")
map("n", "gld", function()
  require("chainsaw").debugLog()
end, opts "Create debug log statement")
map("n", "glv", function()
  require("chainsaw").variablelog()
end, opts "Log name & value under cursor")
map("n", "gla", function()
  require("chainsaw").assertLog()
end, opts "Assersion statement under cursor")
map("n", "gle", function()
  require("chainsaw").emojiLog()
end, opts "Insert Emoji log")
map("n", "glr", function()
  require("chainsaw").removeLogs()
end, opts "Remove all logs")

-- TODOs
map("n", "]t", function()
  require("todo-comments").jump_next()
end, opts "Next todo comment")
map("n", "[t", function()
  require("todo-comments").jump_prev()
end, opts "Previous todo comment")

-- Lazy
map("n", "<Leader>Ls", "<cmd>Lazy sync<CR>", opts "Lazy sync")
map("n", "<Leader>Lu", "<cmd>Lazy update<CR>", opts "Lazy update")

-- Git
map("n", "<leader>tf", "<cmd>Telescope git_files<CR>", opts "Telescope find git files")
map("n", "<leader>tB", "<cmd>Telescope git_branches<CR>", opts "Telescope git branches")
map("n", "<leader>tc", "<cmd>Telescope git_commits<CR>", opts "Telescope git commits (repository)")
map("n", "<leader>tC", "<cmd>Telescope git_bcommits<CR>", opts "Telescope git commits (current file)")
map("v", "<Leader>go", "<cmd>'<,'>GBrowse<CR>", opts "Open current selection in web")
map("n", "<Leader>go", "<cmd>GBrowse<CR>", opts "Open current selection in web")
map("v", "<Leader>gy", "<cmd>'<,'>GBrowse!<CR>", opts "Copy permalink of current selection")
map("n", "<Leader>gy", "<cmd>GBrowse!<CR>", opts "Copy permalink of current selection")
map("n", "<Leader>o", "<cmd>Octo pr<CR>", opts "Octo PR")
map("n", "<Leader>op", "<cmd>Octo pr list<CR>", opts "Octo PR list")
map("n", "<Leader>oi", "<cmd>Octo issue list<CR>", opts "Octo issue list")
map("n", "<Leader>or", "<cmd>Octo review<CR>", opts "Octo review")

map("n", "]c", function()
  if vim.wo.diff then
    vim.cmd.normal { "]c", bang = true }
  else
    require("gitsigns").nav_hunk "next"
  end
end, opts "Gitsigns next git hunk")
map("n", "[c", function()
  if vim.wo.diff then
    vim.cmd.normal { "[c", bang = true }
  else
    require("gitsigns").nav_hunk "prev"
  end
end, opts "Gitsigns prev git hunk")
map({ "n", "v" }, "<leader>gs", function()
  require("gitsigns").stage_hunk()
end, opts "Gitsings stage hunk")
map({ "n", "v" }, "<leader>gr", function()
  require("gitsigns").reset_hunk()
end, opts "Gitsigns Reset hunk")
map("n", "<leader>gS", function()
  require("gitsigns").stage_buffer()
end, opts "Gitsigns stage buffer")
map("n", "<leader>gR", function()
  require("gitsigns").reset_buffer()
end, opts "Gitsigns reset buffer")
map("n", "<leader>gp", function()
  require("gitsigns").preview_hunk()
end, opts "Gitsigns preview hunk")
map("n", "<leader>gi", function()
  require("gitsigns").preview_hunk_inline()
end, opts "Gitsigns preview hunk inline")
map("n", "<leader>gb", function()
  require("gitsigns").blame_line { full = true }
end, opts "Gitsings blame line")

map("n", "<leader>tb", function()
  require("gitsigns").toggle_current_line_blame()
end, opts "Gitsigns toggle current line blame")
map("n", "<leader>td", function()
  require("gitsigns").toggle_deleted()
end, opts "Gitsigns toggle deleted lines")
map("n", "<leader>tw", function()
  require("gitsigns").toggle_word_diff()
end, opts "Gitsigns toggle word diff in hunks")
map("n", "<Leader>gd", "<cmd>DiffviewOpen<CR>", opts "Diff view all current changes")
map(
  "n",
  "<Leader>gm",
  "<cmd>DiffviewOpen origin/main...HEAD --imply-local<CR>",
  opts "Diff view against base (for PRs)"
)
map("n", "<leader>gf", function()
  require("gitsigns").diffthis()
end, opts "Gitsigns diff against index")
map("n", "<leader>gc", function()
  require("gitsigns").diffthis "~"
end, opts "Gitsigns diff against last commit")
map("n", "<Leader>gh", "<cmd>DiffviewFileHistory %<CR>", opts "Diff view current file history")
map("n", "<Leader>gH", "<cmd>DiffviewFileHistory --range=origin/main...HEAD<CR>", opts "Diff view current file history")
map("n", "<leader>gQ", function()
  require("gitsigns").setqflist "all"
end, opts "Gitsings add all hunks to quickfix")
map("n", "<leader>gq", function()
  require("gitsigns").setqflist()
end, opts "Gitsigns add buffer hunks to quickfix")
map({ "o", "x" }, "gv", "<cmd>Gitsigns select_hunk<CR>", opts "Gitsigns select hunk")
map("n", "ga", function()
  require("configs.nvim-tree").git_add()
end, opts "Git add")
map("n", "<leader>gc", ':G commit -m "', opts "Git commit")

-- Whisper
map({ "n", "i" }, "<leader>v", function()
  vim.fn.system "voice"
  vim.cmd 'normal! "+p'
end, { desc = "Voice input" })

map("v", "<leader>l", function()
  local path = vim.fn.expand "%:."
  local start_line = vim.fn.line "v"
  local end_line = vim.fn.line "."
  if start_line > end_line then
    start_line, end_line = end_line, start_line
  end
  local ref = start_line == end_line and path .. ":" .. start_line or path .. ":" .. start_line .. "-" .. end_line
  vim.fn.setreg("+", ref)
  print(ref)
end, opts "Copy file:line reference")

-- Command-line mode vim-like navigation
map("c", "<C-h>", "<Left>", { desc = "Move left" })
map("c", "<C-l>", "<Right>", { desc = "Move right" })
map("c", "<C-j>", "<Down>", { desc = "Next history" })
map("c", "<C-k>", "<Up>", { desc = "Previous history" })
