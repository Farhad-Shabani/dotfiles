return {
  {
    "saghen/blink.cmp",
    dependencies = {
      "rafamadriz/friendly-snippets",
      "Kaiser-Yang/blink-cmp-avante",
    },
    version = "1.*",
    opts = {
      enabled = function()
        return vim.bo.filetype ~= "markdown"
      end,

      completion = {
        list = { selection = { preselect = true, auto_insert = true } },

        accept = { auto_brackets = { enabled = true } },

        menu = {
          draw = {
            treesitter = { "lsp" },
            columns = {
              { "label", "label_description", gap = 1 },
              { "kind_icon", "kind" },
            },
          },
        },

        documentation = { auto_show = true, auto_show_delay_ms = 500 },
      },

      cmdline = {
        completion = {
          list = { selection = { preselect = false } },
          menu = { auto_show = true },
        },
      },

      fuzzy = { implementation = "prefer_rust_with_warning" },
    },
  },

  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    opts = {
      fast_wrap = {},
      disable_filetype = { "TelescopePrompt", "vim" },
    },
  },

  {
    "hrsh7th/nvim-cmp",
    enabled = false,
  },
}
