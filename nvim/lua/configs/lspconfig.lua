local blink = require "blink.cmp"
local nvlsp = require "nvchad.configs.lspconfig"

nvlsp.defaults()

-- NOTE: rust-analyzer is setup by rustaceanvim, not needed to be included in servers!

local servers = {
  bashls = {
    ft = { "sh", "bash" },
  },
  html = {},
  cssls = {},
  ts_ls = {
    root_dir = function(bufnr)
      return vim.fs.root(bufnr, { "package.json" })
    end,
    single_file_support = false,
  },
  tailwindcss = {},
  eslint = {},
  sqlls = {},
  svelte = {},
  pyright = {
    cmd = { "pyright-langserver", "--stdio" },
    filetypes = { "python" },
  },
  gopls = {
    ft = { "go", "gomod", "gowork", "gotmpl" },
    settings = {
      gopls = {
        completeUnimported = true,
        usePlaceholders = true,
        analyses = {
          unusedparams = true,
          shadow = true,
        },
      },
    },
  },
  denols = {
    root_dir = function(bufnr)
      return vim.fs.root(bufnr, { "deno.json", "deno.jsonc" })
    end,
  },
  cairo_ls = {
    ft = { "cairo" },
    enable = true,
    cmd = { "scarb", "cairo-language-server", "--node-ipc" },
  },
  solidity_ls = {
    ft = { "sol" },
  },
  typos_lsp = {
    config = "~/.config/.typos.toml",
    ft = { "rust", "python", "lua", "markdown", "text" },
    root_dir = function(bufnr)
      return vim.fs.root(bufnr, { ".git" })
    end,
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
  root_dir = function(bufnr)
    return vim.fs.root(bufnr, { ".git" }) or vim.fn.fnamemodify(vim.api.nvim_buf_get_name(bufnr), ":h")
  end,
})

for name, opts in pairs(servers) do
  -- Only call vim.lsp.config if there are custom options
  -- Empty tables would override nvim-lspconfig defaults
  if next(opts) ~= nil then
    vim.lsp.config(name, opts)
  end
  vim.lsp.enable(name)
end
