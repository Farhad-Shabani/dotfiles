local M = {}
local hl = vim.api.nvim_set_hl

function M.diff_hl()
  -- Diff Highlights for OneDark theme
  hl(0, "DiffAdd", { bg = "#1e2a2e", fg = "#a3be8c" })
  hl(0, "DiffChange", { bg = "#242a30", fg = "#abb2bf" })
  hl(0, "DiffDelete", { bg = "#2a1e1f", fg = "#e06c75" })
  hl(0, "DiffText", { bg = "#4a2f00", fg = "#ffcc66" })
end

function M.conflict_hl()
  -- Git Conflict Highlights
  hl(0, "GitConflictCurrent", { bg = "#2a1e1f", fg = "#e06c75" })
  hl(0, "GitConflictIncoming", { bg = "#1e2a2e", fg = "#a3be8c" })
  hl(0, "GitConflictAncestor", { bg = "#4a2f00", fg = "#ffcc66" })
  hl(0, "GitConflictNone", { bg = "#2a1e1f", fg = "#e06c75" })
end

return M
