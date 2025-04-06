return {
  {
    "saghen/blink.cmp",
    dependencies = "rafamadriz/friendly-snippets",
    version = "*",
    opts = {
      completion = {
        list = { selection = { preselect = true, auto_insert = true } },

        accept = { auto_brackets = { enabled = true } },

        menu = {
          -- nvim-cmp style menu
          draw = {
            treesitter = { "lsp" },
            columns = {
              { "label", "label_description", gap = 1 },
              { "kind_icon", "kind" },
            },
          },
        },

        -- Show documentation when selecting a completion item
        documentation = { auto_show = true, auto_show_delay_ms = 500 },
      },

      keymap = { preset = "super-tab", ["<CR>"] = { "accept", "fallback" } },

      cmdline = {
        completion = {
          list = { selection = { preselect = false } },
          menu = { auto_show = true },
        },
      },

      appearance = {
        use_nvim_cmp_as_default = true,
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
