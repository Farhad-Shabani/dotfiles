return {
  {
    "iamcco/markdown-preview.nvim",
    ft = { "markdown" },
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    build = "cd app && yarn install",
    init = function()
      vim.g.mkdp_filetypes = { "markdown" }
    end,
  },

  {
    "MeanderingProgrammer/render-markdown.nvim",
    ft = { "markdown" },
    dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
    config = function(_, opts)
      -- Soft monochrome palette - minimal contrast, easy on the eyes
      local c = {
        h1 = "#c5c3c0", h2 = "#b5b3b0", h3 = "#a5a3a0",
        h4 = "#959390", h5 = "#8a8885", h6 = "#807e7b",
        bg1 = "#302f2e", bg2 = "#2e2d2c", bg3 = "#2c2b2a",
        bg4 = "#2b2a29", bg5 = "#2a2928", bg6 = "#292827",
        code_bg = "#272625", code_inline_bg = "#323130",
        text = "#a09e9b", quote = "#858380",
        link = "#9a9895", link_url = "#706e6b",
        table_head = "#8a8885", table_row = "#7a7875", table_border = "#504e4b",
        checked = "#a5a3a0", unchecked = "#454340",
      }

      local function set_highlights()
        local hl = vim.api.nvim_set_hl
        -- Headings (render-markdown + treesitter)
        for i, fg in ipairs({ c.h1, c.h2, c.h3, c.h4, c.h5, c.h6 }) do
          local bold = i <= 4
          hl(0, "RenderMarkdownH" .. i, { fg = fg, bold = bold })
          hl(0, "@markup.heading." .. i .. ".markdown", { fg = fg, bold = bold })
        end
        for i, bg in ipairs({ c.bg1, c.bg2, c.bg3, c.bg4, c.bg5, c.bg6 }) do
          hl(0, "RenderMarkdownH" .. i .. "Bg", { bg = bg })
        end
        -- Code
        hl(0, "RenderMarkdownCode", { bg = c.code_bg })
        hl(0, "RenderMarkdownCodeInline", { bg = c.code_inline_bg, fg = c.text })
        hl(0, "@markup.raw.block.markdown", { bg = c.code_bg })
        hl(0, "@markup.raw.markdown_inline", { bg = c.code_inline_bg, fg = c.text })
        -- Links
        hl(0, "RenderMarkdownLink", { fg = c.link, underline = true })
        hl(0, "@markup.link.markdown_inline", { fg = c.link, underline = true })
        hl(0, "@markup.link.label.markdown_inline", { fg = c.link })
        hl(0, "@markup.link.url.markdown_inline", { fg = c.link_url, underline = true })
        -- Quotes
        hl(0, "RenderMarkdownQuote", { fg = c.quote, italic = true })
        hl(0, "@markup.quote.markdown", { fg = c.quote, italic = true })
        -- Tables
        hl(0, "RenderMarkdownTableHead", { fg = c.table_head, bold = true })
        hl(0, "RenderMarkdownTableRow", { fg = c.table_row })
        hl(0, "@markup.heading.markdown", { fg = c.table_head, bold = true })
        hl(0, "@punctuation.special.markdown", { fg = c.table_border })
        -- Checkboxes
        hl(0, "RenderMarkdownChecked", { fg = c.checked })
        hl(0, "RenderMarkdownUnchecked", { fg = c.unchecked })
      end

      set_highlights()
      vim.api.nvim_create_autocmd("ColorScheme", { callback = set_highlights })
      require("render-markdown").setup(opts)
    end,
    opts = {
      debounce = 250, -- increase from default 100ms to reduce race conditions
      render_modes = { "n", "c" }, -- don't render during insert mode (reduces race conditions)
      heading = {
        icons = { "󰎤 ", "󰎧 ", "󰎪 ", "󰎭 ", "󰎱 ", "󰎳 " },
      },
      checkbox = {
        unchecked = { highlight = "RenderMarkdownUnchecked" },
        checked = { icon = "󰄵 ", highlight = "RenderMarkdownChecked" },
      },
      code = {
        sign = false,
        width = "block",
        border = "thin",
        highlight = "RenderMarkdownCode",
        highlight_inline = "RenderMarkdownCodeInline",
      },
      link = { highlight = "RenderMarkdownLink" },
      quote = { icon = "▎", highlight = "RenderMarkdownQuote" },
    },
  },
}
