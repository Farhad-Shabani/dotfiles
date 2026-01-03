return {
  {
    "mrcjkb/rustaceanvim",
    version = "^7",
    lazy = false,
    config = function()
      vim.g.rustaceanvim = {
        tools = {
          test_executor = "background",
          code_actions = {
            ui_select_fallback = true,
          },
          float_win_config = {
            border = "rounded",
          },
        },
        server = {
          on_attach = function(client, bufnr)
            if client.server_capabilities.inlayHintProvider then
              vim.defer_fn(function()
                if vim.api.nvim_buf_is_valid(bufnr) then
                  pcall(vim.lsp.inlay_hint.enable, true, { bufnr = bufnr })
                end
              end, 100)
            end
          end,
          default_settings = {
            ["rust-analyzer"] = {
              check = {
                command = "clippy",
                extraArgs = { "--no-deps" },
              },
              procMacro = {
                enable = true,
                ignored = {
                  leptos_macro = { "server" },
                },
              },
              cargo = {
                autoreload = true,
                buildScripts = {
                  enable = true,
                },
              },
              imports = {
                granularity = {
                  group = "module",
                },
                prefix = "self",
              },
              completion = {
                postfix = { enable = true },
                autoimport = { enable = true },
              },
              diagnostics = {
                disabled = { "unresolved-proc-macro" },
              },
              inlayHints = {
                closingBraceHints = { enable = true },
                lifetimeElisionHints = { enable = "skip_trivial" },
              },
            },
          },
        },
      }
    end,
  },

  {
    "saecki/crates.nvim",
    tag = "stable",
    event = { "BufRead Cargo.toml" },
    config = function()
      require("crates").setup {
        lsp = {
          enabled = true,
          actions = true,
          completion = true,
          hover = true,
        },
        completion = {
          cmp = { enabled = false },
        },
      }
    end,
  },
}
