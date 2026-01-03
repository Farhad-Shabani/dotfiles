require("nvim-treesitter").setup {
  ensure_installed = {
    "bash",
    "dockerfile",
    "json",
    "yaml",
    "toml",
    "just",
    "regex",
    "vim",
    "lua",
    "markdown",
    "sql",
    "javascript",
    "typescript",
    "tsx",
    "rust",
    "solidity",
    "cairo",
    "svelte",
    "go",
    "gomod",
    "gosum",
    "python",
    "zig",
  },
  highlight = {
    enable = true,
    -- Or use a function for more flexibility, e.g. to disable slow treesitter highlight for large files
    disable = function(lang, buf)
      local max_filesize = 100 * 1024 -- 100 KB
      local ok, stats = pcall(vim.uv.fs_stat, vim.api.nvim_buf_get_name(buf))
      if ok and stats and stats.size > max_filesize then
        return true
      end
    end,
  },
}
