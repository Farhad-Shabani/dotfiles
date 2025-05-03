local conform = require "conform"
local autocmd = vim.api.nvim_create_autocmd

conform.setup {
  formatters_by_ft = {
    lua = { "stylua" },
    python = { "isort", "black" },
    -- rust = { "rustfmt", lsp_format = "fallback" },
    markdown = { "markdownlint", stop_after_first = true },
    json = { "jq", stop_after_first = true },
    javascript = { "prettierd", "prettier", stop_after_first = true },
    javascriptreact = { "prettierd", "prettier", stop_after_first = true },
    typescript = { "prettierd", "prettier", stop_after_first = true },
    typescriptreact = { "prettierd", "prettier", stop_after_first = true },
    svelte = { "prettierd", "prettier", stop_after_first = true },
    svx = { "prettierd", "prettier", stop_after_first = true },
    toml = { "taplo", stop_after_first = true },
  },
}

autocmd("bufwritepre", {
  pattern = "*",
  callback = function(args)
    conform.format { bufnr = args.buf }
  end,
})
