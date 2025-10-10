local M = {}

function M.telescope()
  local actions = require "telescope.actions"
  local action_state = require "telescope.actions.state"
  local lga_actions = require "telescope-live-grep-args.actions"
  local defaults = require "nvchad.configs.telescope"
  local close_term = function()
    local entry = action_state.get_selected_entry()
    local bufnr = tonumber(entry and (entry.bufnr or entry.value or entry[1]))

    if bufnr and vim.api.nvim_buf_is_valid(bufnr) then
      vim.api.nvim_buf_delete(bufnr, { force = true })
      print("Closed terminal buffer: " .. bufnr)
    else
      print "Invalid or no terminal selected!"
    end
  end

  local configs = {
    defaults = {
      mappings = {
        i = {
          ["<C-t>"] = require("trouble.sources.telescope").open,
          ["<C-x>"] = close_term,
        },
        n = { ["<C-t>"] = require("trouble.sources.telescope").open, ["<C-x>"] = close_term },
      },
      vimgrep_arguments = {
        "rg",
        "--color=never",
        "--no-heading",
        "--with-filename",
        "--line-number",
        "--column",
        "--smart-case",
        "-F", -- added: use fixed-string search so you don't need to escape parentheses
      },
    },
    extensions = {
      fuzzy = true,
      fzf = {},
      live_grep_args = {
        auto_quoting = true, -- enable/disable auto-quoting
        mappings = {
          i = {
            ["<C-k>"] = lga_actions.quote_prompt(),
            ["<C-i>"] = lga_actions.quote_prompt { postfix = " --iglob " },
            -- freeze the current list and start a fuzzy search in the frozen list
            ["<C-space>"] = actions.to_fuzzy_refine,
          },
        },
        -- ... also accepts theme settings, for example:
        -- theme = "dropdown", -- use dropdown theme
        -- theme = { }, -- use own theme spec
        -- layout_config = { mirror=true }, -- mirror preview pane
      },
    },
    extension_list = { "live_grep_args", "fzf", "frequency", "file_browser", "lazygit", "noice" },
  }

  return vim.tbl_deep_extend("force", defaults, configs)
end

return M
