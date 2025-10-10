return {
  "obsidian-nvim/obsidian.nvim",
  version = "*", -- recommended, use latest release instead of latest commit
  event = {
    -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
    -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/*.md"
    -- refer to `:h file-pattern` for more examples

    "BufReadPre "
      .. vim.fn.expand "~"
      .. "/Library/Mobile\\ Documents/iCloud~md~obsidian/Documents/vault/*.md",
    "BufNewFile " .. vim.fn.expand "~" .. "/Library/Mobile\\ Documents/iCloud~md~obsidian/Documents/vault/*.md",
  },
  dependencies = {
    "nvim-lua/plenary.nvim", -- Required
  },
  opts = {
    completion = {
      nvim_cmp = false,
      blink = true,
    },
    workspaces = {
      {
        name = "vault",
        path = "~/Library/Mobile Documents/iCloud~md~obsidian/Documents/vault",
      },
    },
    templates = {
      folder = "Templates",
      date_format = "%Y-%m-%d",
      time_format = "%H:%M",
    },
    daily_notes = {
      folder = "Daily",
      template = "Daily.md",
    },
  },
}
