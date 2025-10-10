-- This file needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/ui/blob/v2.5/lua/nvconfig.lua

local custom_file = function()
  -- Handle separator style
  local sep_style = require("nvconfig").ui.statusline.separator_style
  local sep_icons = require("nvchad.stl.utils").separators
  local separators = (type(sep_style) == "table" and sep_style) or sep_icons[sep_style]
  local sep_r = separators["right"]

  -- Get file path
  local path = vim.fn.expand "%:~:."
  local name = (path == "" and "Empty") or path

  -- Get file icon
  local icon = "󰈚"
  if name ~= "Empty" then
    local devicons_present, devicons = pcall(require, "nvim-web-devicons")

    if devicons_present then
      local ft_icon = devicons.get_icon(name)
      icon = (ft_icon ~= nil and ft_icon) or icon
    end
  end

  -- Formatting adjustments
  name = " " .. name .. (sep_style == "default" and " " or "")

  -- Preserve background color of St_file
  local bg_color = vim.fn.synIDattr(vim.fn.hlID "St_file", "bg")
  vim.cmd("hi St_FilePath guifg=#6b6b6b guibg=" .. bg_color)

  return "%#St_file# " .. icon .. "%#St_FilePath#" .. name .. "%#St_file_sep#" .. sep_r
end

---@type ChadrcConfig
local M = {}

M.base46 = {
  integrations = {
    "bufferline",
    "dap",
    "devicons",
    "diffview",
    "git",
    "git-conflict",
    "nvimtree",
    "syntax",
    "tbline",
    "telescope",
    "todo",
    "treesitter",
    "trouble",
  },
  theme = "darcula",
}

M.ui = {
  statusline = {
    order = { "mode", "custom_file", "git", "%=", "lsp_msg", "%=", "diagnostics", "lsp", "cursor", "cwd" },
    modules = { custom_file = custom_file },
  },
}

M.nvdash = {
  load_on_startup = true,
  header = {
    [[ _   _      _ _        __        __         _     _ _ ]],
    [[| | | | ___| | | ___   \ \      / /__  _ __| | __| | |]],
    [[| |_| |/ _ \ | |/ _ \   \ \ /\ / / _ \| '__| |/ _` | |]],
    [[|  _  |  __/ | | (_) |   \ V  V / (_) | |  | | (_| |_|]],
    [[|_| |_|\___|_|_|\___/     \_/\_/ \___/|_|  |_|\__,_(_)]],
    [[                                                      ]],
  },
}

return M
