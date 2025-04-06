return {
  {
    "mrcjkb/rustaceanvim",
    version = "^5", -- Recommended
    lazy = false, -- This plugin is already lazy
    ft = "rust",
    config = function()
      local mason_registry = require "mason-registry"
      local codelldb = mason_registry.get_package "codelldb"
      local extension_path = codelldb:get_install_path() .. "/extension/"
      local codelldb_path = extension_path .. "adapter/codelldb"
      local liblldb_path = extension_path .. "lldb/lib/lib/lldb.dylib"
      local cfg = require "rustaceanvim.config"

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
            },
            rustfmt = {
              overrideCommand = { "leptosfmt", "--stdin", "--rustfmt" },
            },
            procMacro = {
              enable = true,
              ignored = {
                leptos_macro = {
                  "server",
                },
              },
            },
            cargo = {
              autoreload = true,
              extraEnv = { CARGO_PROFILE_RUST_ANALYZER_INHERITS = "dev" },
              extraArgs = { "--profile", "rust-analyzer" },
              features = "all",
              buildScripts = {
                enable = true,
              },
              check = {
                command = "clippy",
                allTargets = true,
              },
            },
            completion = {
              postfix = {
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
        dap = {
          adapter = cfg.get_codelldb_adapter(codelldb_path, liblldb_path),
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
