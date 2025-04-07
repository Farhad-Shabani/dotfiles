local lspconfig = require "lspconfig"
local nvlsp = require "nvchad.configs.lspconfig"

nvlsp.defaults()

-- NOTE: rust-analyzer is setup by rustaceanvim, not needed to be included in servers!

local servers = {
  html = {},
  cssls = {},
  ts_ls = {
    root_dir = lspconfig.util.root_pattern "package.json",
    single_file_support = false,
  },
  tailwindcss = {},
  eslint = {},
  sqlls = {},
  svelte = {},
  pyright = {},
  gopls = {
    ft = { "go", "gomod", "gowork", "gotmpl" },
    root_dir = lspconfig.util.root_pattern("go.work", "go.mod", ".git"),
    settings = {
      gopls = {
        completeUnimported = true,
        usePlaceholders = true,
        analyses = {
          unusedparams = true,
        },
      },
    },
  },
  denols = {
    root_dir = lspconfig.util.root_pattern("deno.json", "deno.jsonc"),
  },
  cairo_ls = {
    ft = "cairo",
    enable = true,
    cmd = { "scarb", "cairo-language-server", "/C", "--node-ipc" },
  },
  yamlls = {
    ft = { "yaml", "yml" },
  },
}

for name, opts in pairs(servers) do
  opts.on_init = nvlsp.on_init
  opts.on_attach = nvlsp.on_attach
  opts.capabilities = require("blink.cmp").get_lsp_capabilities(nvlsp.capabilities)
  lspconfig[name].setup(opts)
end
