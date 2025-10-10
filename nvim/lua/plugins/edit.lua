return {
  {
    "nvim-treesitter/nvim-treesitter-context",
    event = "BufReadPost",
    opts = {
      max_lines = 0,
      multiline_threshold = 1,
      patterns = {
        default = {
          "class",
          "function",
          "method",
        },
      },
    },
  },

  {
    "kylechui/nvim-surround",
    version = "*",
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup {}
    end,
  },

  {
    "chrisgrieser/nvim-rip-substitute",
    keys = {
      {
        "<leader>fr",
        function()
          require("rip-substitute").sub()
        end,
        mode = { "n", "x" },
        desc = "Search & replace in buffer",
      },
    },
  },

  {
    "windwp/nvim-ts-autotag",
    ft = {
      "javascript",
      "javascriptreact",
      "typescript",
      "typescriptreact",
      "svelte",
    },
    config = function()
      require("nvim-ts-autotag").setup()
    end,
  },
}
