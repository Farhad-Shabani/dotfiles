<div align="center">
    <h1>NvChad Plus</h1>
</div>

This repository extends [NvChad](https://github.com/NvChad/NvChad) with additional plugins and configurations for an enhanced Neovim experience.

## 📌 Prerequisites

- **System Requirements:** `curl`, `grep`, `Node.js` ≥ 18, `npm`, and `yarn`
- **Neovim** ≥ 0.11
- **Github CLI** ≥ 2.2.0
- **lazygit**: Check the [installation](https://github.com/jesseduffield/lazygit?tab=readme-ov-file#installation).

## 🔌 Additional Plugins

- **Finder**: `telescope.nvim` extended with `live_grep_args`, `fzf`, `frecency`, `file_browser`
- **Navigation**: `harpoon`, `neominimap`
- **Completion**: `blink.cmp`, `nvim-autopairs`
- **Editing**: `nvim-treesitter-context`, `nvim-surround`, `nvim-rip-substitute`, `nvim-ts-autotag`, `flash.nvim`
- **Debugging**: `nvim-dap`, `nvim-dap-ui`, `trouble.nvim`, `nvim-chainsaw`
- **Git**: `lazygit`, `octo.nvim`, `diffview.nvim`, `git-conflict.nvim`, `vim-fugitive`, `vim-rhubarb`
- **Rust**: `rustaceanvim`, `crates.nvim`
- **Markdown**: `markdown-preview`, `render-markdown`
- **Coding Assistant**: `Avante`

## 🌍 Language Support

- Rust, Cairo, Circom, Deno, TypeScript, JavaScript, JSX, TSX, Svelte, TailwindCSS, HTML

## 🎹 Keymaps

This configuration includes a set of custom key mappings for enhance workflow.
For the full list refer to the [`mappings.lua`](lua/mappings.lua) file.

## 🛠️ Customization

### lazygit - edit files in same process

Use an alias to start nvim with the `--listen` parameter:

```bashrc
# ~/.bashrc
alias vim='nvim --listen /tmp/nvim-server.pipe'
```

Modify lazygit to attempt connecting to existing nvim instance on edit:

```
# Linux: ~/.config/lazygit/config.yml
# MacOS: ~/Library/Application\ Support/lazygit/config.yml
os:
  editCommand: 'nvim'
  editCommandTemplate: '{{editor}} --server /tmp/nvim-server.pipe --remote-tab "{{filename}}"'
```

### Statusline - Full file path relative to home

The NvChad statusline now shows the full path of the current file relative to the home directory, making it easier to track your location as you browse multiple libraries.

### Themes

- **darcula**: A customized `darcula-dark` theme for Rust.
- **everforest_dm**: A medium dark Everforest variant.
- **vscode**: A dark, VSCode-inspired theme that fuses familiar aesthetics with vibrant accents and tailored syntax highlights.
