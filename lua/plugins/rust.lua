return {
  {
    "mrcjkb/rustaceanvim",
    version = "6.2", -- Recommended
    lazy = false, -- This plugin is already lazy
    ft = "rust",
    config = function()
      vim.g.rustaceanvim = {
        server = {
          on_attach = function(client, bufnr)
            if client.server_capabilities.inlayHintProvider then
              vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
            end
          end,
        },
        default_settings = {
          ["rust-analyzer"] = {
            checkOnSave = {
              command = "clippy",
              -- extraArgs = { "--all-features", "--all-targets" },
            },
            rustfmt = {
              overrideCommand = { "leptosfmt", "--stdin", "--rustfmt" },
              -- extraArgs = { "+nightly" },
            },
            procMacro = {
              enable = true,
              ignored = {
                leptos_macro = {
                  "server",
                },
              },
            },
            -- check = {
            --   command = "clippy",
            --   features = "all",
            --   allTargets = true,
            -- },
            cargo = {
              autoreload = true,
              extraEnv = { CARGO_PROFILE_RUST_ANALYZER_INHERITS = "dev" },
              extraArgs = { "--profile", "rust-analyzer" },
              features = "all",
              buildScripts = {
                enable = true,
              },
            },
            imports = {
              granularity = {
                group = "module",
              },
            },
            diagnostics = {
              disabled = { "unresolved-proc-macro" },
            },
          },
        },
      }
    end,
  },

  {
    "saecki/crates.nvim",
    ft = { "toml" },
    config = function()
      require("crates").setup {}
    end,
  },
}
