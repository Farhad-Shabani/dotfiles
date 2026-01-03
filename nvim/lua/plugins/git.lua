-- Shared color palette (modern aesthetic)
local C = {
  -- Foreground (modern, balanced)
  green = "#5dba63",
  red = "#e86b64",
  blue = "#6ba8e0",
  orange = "#e0a060",

  -- Diff (semantic: green=added, red=removed)
  add_bg = "#1a2e1a",
  del_bg = "#2e1a1a",
  add_text_bg = "#264f26",
  del_text_bg = "#4f2626",
  change_bg = "#232323",
  neutral = "#323232",

  -- Conflict (semantic: blue=current/ours, green=incoming/theirs)
  current_bg = "#1a1a2e",
  incoming_bg = "#1a2e1a",
  ancestor_bg = "#232323",
}

return {
  {
    "sindrets/diffview.nvim",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      local hl = vim.api.nvim_set_hl

      local function set_diff_hl()
        -- Base diff highlights
        hl(0, "DiffAdd", { bg = C.add_bg })
        hl(0, "DiffDelete", { bg = C.del_bg }) -- Keep readable for gitsigns inline preview
        hl(0, "DiffChange", { bg = C.change_bg })
        hl(0, "DiffText", { bg = C.add_text_bg, fg = C.green, bold = true })

        -- Left pane (old/deletions - red)
        hl(0, "DiffAddLeft", { bg = C.del_bg })
        hl(0, "DiffDeleteLeft", { fg = C.neutral, bg = C.neutral })
        hl(0, "DiffChangeLeft", { bg = C.del_bg })
        hl(0, "DiffTextLeft", { bg = C.del_text_bg, fg = C.red, bold = true })

        -- Right pane (new/additions - green)
        hl(0, "DiffAddRight", { bg = C.add_bg })
        hl(0, "DiffDeleteRight", { fg = C.neutral, bg = C.neutral })
        hl(0, "DiffChangeRight", { bg = C.add_bg })
        hl(0, "DiffTextRight", { bg = C.add_text_bg, fg = C.green, bold = true })

        -- Diffview specific
        hl(0, "DiffviewDiffAddAsDelete", { bg = C.del_bg })
        hl(0, "DiffviewDiffDeleteDim", { fg = C.neutral, bg = C.neutral })

        -- File panel
        hl(0, "DiffviewFilePanelTitle", { fg = C.orange, bold = true })
        hl(0, "DiffviewFilePanelCounter", { fg = C.orange })
        hl(0, "DiffviewFilePanelInsertions", { fg = C.green })
        hl(0, "DiffviewFilePanelDeletions", { fg = C.red })

        -- Status indicators
        hl(0, "DiffviewStatusAdded", { fg = C.green })
        hl(0, "DiffviewStatusModified", { fg = C.orange })
        hl(0, "DiffviewStatusRenamed", { fg = C.orange })
        hl(0, "DiffviewStatusDeleted", { fg = C.red })
        hl(0, "DiffviewStatusUntracked", { fg = C.green })
      end

      vim.opt.fillchars:append { diff = " " }

      require("diffview").setup {
        enhanced_diff_hl = true,
        hooks = {
          view_opened = set_diff_hl,
          diff_buf_win_enter = function(_, winid, ctx)
            if ctx.layout_name:match "^diff2" then
              if ctx.symbol == "a" then
                vim.wo[winid].winhl = table.concat({
                  "DiffAdd:DiffAddLeft",
                  "DiffDelete:DiffDeleteLeft",
                  "DiffChange:DiffChangeLeft",
                  "DiffText:DiffTextLeft",
                }, ",")
              else
                vim.wo[winid].winhl = table.concat({
                  "DiffAdd:DiffAddRight",
                  "DiffDelete:DiffDeleteRight",
                  "DiffChange:DiffChangeRight",
                  "DiffText:DiffTextRight",
                }, ",")
              end
            end
          end,
        },
      }
    end,
    cmd = {
      "DiffviewOpen",
      "DiffviewClose",
      "DiffviewLog",
      "DiffviewRefresh",
    },
    default_args = {
      DiffviewOpen = { "--imply-local" },
    },
  },

  {
    "lewis6991/gitsigns.nvim",
    event = "User FilePost",
    opts = function()
      require "nvchad.configs.gitsigns"
      return require("gitsigns").setup {
        current_line_blame = true,
        current_line_blame_opts = {
          delay = 200,
        },
      }
    end,
  },

  {
    "NeogitOrg/neogit",
    cmd = {
      "Neogit",
      "NeogitCommit",
      "NeogitLogCurrent",
      "NeogitResetState",
    },
    dependencies = {
      "nvim-lua/plenary.nvim", -- required
      "sindrets/diffview.nvim", -- optional - Diff integration
      "nvim-telescope/telescope.nvim", -- optional
    },
    config = true,
  },

  {
    "kdheepak/lazygit.nvim",
    cmd = {
      "LazyGit",
      "LazyGitConfig",
      "LazyGitCurrentFile",
      "LazyGitFilter",
      "LazyGitFilterCurrentFile",
    },
    -- optional for floating window border decoration
    dependencies = {
      "nvim-telescope/telescope.nvim",
      "nvim-lua/plenary.nvim",
    },
    -- setting the keybinding for LazyGit with 'keys' is recommended in
    -- order to load the plugin when the command is run for the first time
    keys = {
      { "<leader>gl", "<cmd>LazyGit<cr>", desc = "LazyGit", noremap = true, silent = true },
    },
  },

  {
    "akinsho/git-conflict.nvim",
    version = "*",
    event = "VeryLazy",
    config = function()
      local hl = vim.api.nvim_set_hl
      hl(0, "ConflictCurrent", { bg = C.current_bg }) -- blue: what you have
      hl(0, "ConflictIncoming", { bg = C.incoming_bg }) -- green: what's coming
      hl(0, "ConflictAncestor", { bg = C.ancestor_bg }) -- gray: common ancestor

      require("git-conflict").setup {
        default_mappings = true,
        highlights = {
          current = "ConflictCurrent",
          incoming = "ConflictIncoming",
          ancestor = "ConflictAncestor",
        },
      }
    end,
  },

  {
    "tpope/vim-fugitive",
    lazy = false,
  },

  { "tpope/vim-rhubarb", lazy = false },

  {
    "pwntester/octo.nvim",
    lazy = false,
    requires = {
      "nvim-lua/plenary.nvim",
      "nvim-telecope/telescope.nvim",
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      require("octo").setup {
        mappings = {
          issue = {
            close_issue = { lhs = "<leader>ic", desc = "close issue" },
            reopen_issue = { lhs = "<leader>io", desc = "reopen issue" },
            list_issues = { lhs = "<leader>il", desc = "list open issues on same repo" },
            reload = { lhs = "<C-r>", desc = "reload issue" },
            open_in_browser = { lhs = "<C-b>", desc = "open issue in browser" },
            copy_url = { lhs = "<C-y>", desc = "copy url to system clipboard" },
            add_assignee = { lhs = "<leader>aa", desc = "add assignee" },
            remove_assignee = { lhs = "<leader>ad", desc = "remove assignee" },
            create_label = { lhs = "<leader>lc", desc = "create label" },
            add_label = { lhs = "<leader>la", desc = "add label" },
            remove_label = { lhs = "<leader>ld", desc = "remove label" },
            goto_issue = { lhs = "<leader>gi", desc = "navigate to a local repo issue" },
            add_comment = { lhs = "<leader>ca", desc = "add comment" },
            delete_comment = { lhs = "<leader>cd", desc = "delete comment" },
            next_comment = { lhs = "]c", desc = "go to next comment" },
            prev_comment = { lhs = "[c", desc = "go to previous comment" },
            react_hooray = { lhs = "<leader>rp", desc = "add/remove 🎉 reaction" },
            react_heart = { lhs = "<leader>rh", desc = "add/remove ❤️ reaction" },
            react_eyes = { lhs = "<leader>re", desc = "add/remove 👀 reaction" },
            react_thumbs_up = { lhs = "<leader>r+", desc = "add/remove 👍 reaction" },
            react_thumbs_down = { lhs = "<leader>r-", desc = "add/remove 👎 reaction" },
            react_rocket = { lhs = "<leader>rr", desc = "add/remove 🚀 reaction" },
            react_laugh = { lhs = "<leader>rl", desc = "add/remove 😄 reaction" },
            react_confused = { lhs = "<leader>rc", desc = "add/remove 😕 reaction" },
          },
          pull_request = {
            checkout_pr = { lhs = "<leader>po", desc = "checkout PR" },
            merge_pr = { lhs = "<leader>pm", desc = "merge commit PR" },
            squash_and_merge_pr = { lhs = "<leader>psm", desc = "squash and merge PR" },
            rebase_and_merge_pr = { lhs = "<leader>prm", desc = "rebase and merge PR" },
            list_commits = { lhs = "<leader>pc", desc = "list PR commits" },
            list_changed_files = { lhs = "<leader>pf", desc = "list PR changed files" },
            show_pr_diff = { lhs = "<leader>pd", desc = "show PR diff" },
            add_reviewer = { lhs = "<leader>va", desc = "add reviewer" },
            remove_reviewer = { lhs = "<leader>vd", desc = "remove reviewer request" },
            close_issue = { lhs = "<leader>ic", desc = "close PR" },
            reopen_issue = { lhs = "<leader>io", desc = "reopen PR" },
            list_issues = { lhs = "<leader>il", desc = "list open issues on same repo" },
            reload = { lhs = "<C-r>", desc = "reload PR" },
            open_in_browser = { lhs = "<C-b>", desc = "open PR in browser" },
            copy_url = { lhs = "<C-y>", desc = "copy url to system clipboard" },
            goto_file = { lhs = "gf", desc = "go to file" },
            add_assignee = { lhs = "<leader>aa", desc = "add assignee" },
            remove_assignee = { lhs = "<leader>ad", desc = "remove assignee" },
            create_label = { lhs = "<leader>lc", desc = "create label" },
            add_label = { lhs = "<leader>la", desc = "add label" },
            remove_label = { lhs = "<leader>ld", desc = "remove label" },
            goto_issue = { lhs = "<leader>gi", desc = "navigate to a local repo issue" },
            add_comment = { lhs = "<leader>ca", desc = "add comment" },
            delete_comment = { lhs = "<leader>cd", desc = "delete comment" },
            next_comment = { lhs = "]c", desc = "go to next comment" },
            prev_comment = { lhs = "[c", desc = "go to previous comment" },
            react_hooray = { lhs = "<leader>rp", desc = "add/remove 🎉 reaction" },
            react_heart = { lhs = "<leader>rh", desc = "add/remove ❤️ reaction" },
            react_eyes = { lhs = "<leader>re", desc = "add/remove 👀 reaction" },
            react_thumbs_up = { lhs = "<leader>r+", desc = "add/remove 👍 reaction" },
            react_thumbs_down = { lhs = "<leader>r-", desc = "add/remove 👎 reaction" },
            react_rocket = { lhs = "<leader>rr", desc = "add/remove 🚀 reaction" },
            react_laugh = { lhs = "<leader>rl", desc = "add/remove 😄 reaction" },
            react_confused = { lhs = "<leader>rc", desc = "add/remove 😕 reaction" },
            review_start = { lhs = "<leader>vs", desc = "start a review for the current PR" },
            review_resume = { lhs = "<leader>vr", desc = "resume a pending review for the current PR" },
          },
          review_thread = {
            goto_issue = { lhs = "<leader>gi", desc = "navigate to a local repo issue" },
            add_comment = { lhs = "<leader>ca", desc = "add comment" },
            add_suggestion = { lhs = "<leader>sa", desc = "add suggestion" },
            delete_comment = { lhs = "<leader>cd", desc = "delete comment" },
            next_comment = { lhs = "]c", desc = "go to next comment" },
            prev_comment = { lhs = "[c", desc = "go to previous comment" },
            select_next_entry = { lhs = "]q", desc = "move to next changed file" },
            select_prev_entry = { lhs = "[q", desc = "move to previous changed file" },
            select_first_entry = { lhs = "[Q", desc = "move to first changed file" },
            select_last_entry = { lhs = "]Q", desc = "move to last changed file" },
            close_review_tab = { lhs = "<C-c>", desc = "close review tab" },
            react_hooray = { lhs = "<leader>rp", desc = "add/remove 🎉 reaction" },
            react_heart = { lhs = "<leader>rh", desc = "add/remove ❤️ reaction" },
            react_eyes = { lhs = "<leader>re", desc = "add/remove 👀 reaction" },
            react_thumbs_up = { lhs = "<leader>r+", desc = "add/remove 👍 reaction" },
            react_thumbs_down = { lhs = "<leader>r-", desc = "add/remove 👎 reaction" },
            react_rocket = { lhs = "<leader>rr", desc = "add/remove 🚀 reaction" },
            react_laugh = { lhs = "<leader>rl", desc = "add/remove 😄 reaction" },
            react_confused = { lhs = "<leader>rc", desc = "add/remove 😕 reaction" },
          },
          submit_win = {
            approve_review = { lhs = "<C-A>", desc = "approve review" },
            comment_review = { lhs = "<C-m>", desc = "comment review" },
            request_changes = { lhs = "<C-r>", desc = "request changes review" },
            close_review_tab = { lhs = "<C-c>", desc = "close review tab" },
          },
          review_diff = {
            submit_review = { lhs = "<leader>vs", desc = "submit review" },
            discard_review = { lhs = "<leader>vd", desc = "discard review" },
            add_review_comment = { lhs = "<leader>ca", desc = "add a new review comment" },
            add_review_suggestion = { lhs = "<leader>sa", desc = "add a new review suggestion" },
            focus_files = { lhs = "<leader>e", desc = "move focus to changed file panel" },
            toggle_files = { lhs = "<leader>b", desc = "hide/show changed files panel" },
            next_thread = { lhs = "]t", desc = "move to next thread" },
            prev_thread = { lhs = "[t", desc = "move to previous thread" },
            select_next_entry = { lhs = "]q", desc = "move to next changed file" },
            select_prev_entry = { lhs = "[q", desc = "move to previous changed file" },
            select_first_entry = { lhs = "[Q", desc = "move to first changed file" },
            select_last_entry = { lhs = "]Q", desc = "move to last changed file" },
            close_review_tab = { lhs = "<C-c>", desc = "close review tab" },
            toggle_viewed = { lhs = "<leader><space>", desc = "toggle viewer viewed state" },
            goto_file = { lhs = "gf", desc = "go to file" },
          },
          file_panel = {
            submit_review = { lhs = "<leader>vs", desc = "submit review" },
            discard_review = { lhs = "<leader>vd", desc = "discard review" },
            next_entry = { lhs = "j", desc = "move to next changed file" },
            prev_entry = { lhs = "k", desc = "move to previous changed file" },
            select_entry = { lhs = "<cr>", desc = "show selected changed file diffs" },
            refresh_files = { lhs = "R", desc = "refresh changed files panel" },
            focus_files = { lhs = "<leader>e", desc = "move focus to changed file panel" },
            toggle_files = { lhs = "<leader>b", desc = "hide/show changed files panel" },
            select_next_entry = { lhs = "]q", desc = "move to next changed file" },
            select_prev_entry = { lhs = "[q", desc = "move to previous changed file" },
            select_first_entry = { lhs = "[Q", desc = "move to first changed file" },
            select_last_entry = { lhs = "]Q", desc = "move to last changed file" },
            close_review_tab = { lhs = "<C-c>", desc = "close review tab" },
            toggle_viewed = { lhs = "<leader><space>", desc = "toggle viewer viewed state" },
          },
        },
      }
    end,
  },
}
