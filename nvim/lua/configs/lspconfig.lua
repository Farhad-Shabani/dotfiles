local util = require "lspconfig.util"
local blink = require "blink.cmp"
local nvlsp = require "nvchad.configs.lspconfig"

nvlsp.defaults()

-- NOTE: rust-analyzer is setup by rustaceanvim, not needed to be included in servers!

local servers = {
  html = {},
  cssls = {},
  ts_ls = {
    root_dir = util.root_pattern "package.json",
    single_file_support = false,
  },
  tailwindcss = {},
  eslint = {},
  sqlls = {},
  svelte = {},
  pyright = {},
  gopls = {
    ft = { "go", "gomod", "gowork", "gotmpl" },
    root_dir = util.root_pattern("go.work", "go.mod", ".git"),
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
    root_dir = util.root_pattern("deno.json", "deno.jsonc"),
  },
  cairo_ls = {
    ft = "cairo",
    enable = true,
    cmd = { "scarb", "cairo-language-server", "/C", "--node-ipc" },
  },
  yamlls = {
    ft = { "yaml", "yml" },
  },
  zls = {
    ft = { "zig", "zir" },
  },
}

vim.lsp.config("*", {
  on_init = nvlsp.on_init,
  on_attach = nvlsp.on_attach,
  capabilities = blink.get_lsp_capabilities(nvlsp.capabilities),
})

for name, opts in pairs(servers) do
  vim.lsp.config(name, opts)
  vim.lsp.enable(name)
end
