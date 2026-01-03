local conform = require "conform"

conform.setup {
  formatters_by_ft = {
    lua = { "stylua" },
    python = { "isort", "black" },
    markdown = { "prettier", stop_after_first = true },
    json = { "jq", stop_after_first = true },
    javascript = { "prettierd", "prettier", stop_after_first = true },
    javascriptreact = { "prettierd", "prettier", stop_after_first = true },
    typescript = { "prettierd", "prettier", stop_after_first = true },
    typescriptreact = { "prettierd", "prettier", stop_after_first = true },
    svelte = { "prettierd", "prettier", stop_after_first = true },
    svx = { "prettierd", "prettier", stop_after_first = true },
    go = { "gofmt", "goimports", stop_after_first = true },
    dockerfile = { "dockerfmt" },
    yaml = { "prettierd", "prettier", stop_after_first = true },
    toml = { "taplo" },
  },
  format_on_save = {
    lsp_fallback = true,
    timeout_ms = 3000,
  },
}
