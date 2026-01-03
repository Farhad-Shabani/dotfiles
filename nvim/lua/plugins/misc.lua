return {
  {
    "nvchad/base46",
    branch = "v3.0",
    build = function()
      require("base46").load_all_highlights()
    end,
  },

  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },

  {
    "stevearc/conform.nvim",
    event = "BufWritePre",
    config = function()
      require "configs.conform"
    end,
  },

  {
    "iden3/vim-circom-syntax",
    ft = { "circom" },
  },

  {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {
      lsp = {
        -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
        },
        signature = { enabled = false },
      },
      -- you can enable a preset for easier configuration
      presets = {
        command_palette = true, -- position the cmdline and popupmenu together
        long_message_to_split = true, -- long messages will be sent to a split
        inc_rename = false, -- enables an input dialog for inc-rename.nvim
        lsp_doc_border = false, -- add a border to hover docs and signature help
      },
    },
    dependencies = {
      "MunifTanjim/nui.nvim",
    },
  },

  {
    "LunarVim/bigfile.nvim",
    opts = {
      filesize = 1, -- 1 MiB threshold
      features = {
        "indent_blankline",
        "lsp",
        "treesitter",
        "syntax",
        "matchparen",
        "vimopts",
      },
    },
  },

  {
    "folke/zen-mode.nvim",
    event = "VeryLazy",
    cmd = { "ZenMode" },
    opts = {
      window = {
        options = {
          ruler = true,
          number = true,
          relativenumber = true,
        },
      },
      plugins = {
        options = {
          showcmd = true,
          laststatus = 3,
        },
      },
      on_open = function(win)
        local view = require "zen-mode.view"
        local layout = view.layout(view.opts)
        vim.api.nvim_win_set_config(win, {
          width = layout.width,
          height = layout.height - 1,
        })
        vim.api.nvim_win_set_config(view.bg_win, {
          width = vim.o.columns,
          height = view.height() - 1,
          row = 1,
          col = layout.col,
          relative = "editor",
        })
      end,
    },
  },

  {
    "HakonHarnes/img-clip.nvim",
    opts = {},
    keys = {
      { "<leader>pi", "<cmd>PasteImage<cr>", desc = "Paste image from system clipboard" },
    },
  },
}
