#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"

echo "▶️ Starting setup..."

# --- Xcode CLI Tools ---
if ! xcode-select -p &>/dev/null; then
  echo "Installing Xcode Command Line Tools..."
  xcode-select --install
  read -p "Press enter after installation completes..."
fi

# --- Homebrew ---
if ! command -v brew &>/dev/null; then
  echo "Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

brew update
brew install git gh stow zsh neovim tmux lazygit \
  fd fzf ripgrep zoxide yazi jq tree wget htop \
  go pyenv nvm asdf pinentry-mac tmux-mem-cpu-load || true

# --- Ghostty ---
brew install --cask ghostty || true

# --- Backup existing configs ---
for cfg in .zshrc .config/nvim .config/ghostty .config/tmux; do
  [ -e "$HOME/$cfg" ] && [ ! -L "$HOME/$cfg" ] && mv "$HOME/$cfg" "$HOME/${cfg}.backup"
done

# --- Symlink dotfiles ---
cd "$SCRIPT_DIR"
stow nvim ghostty tmux zshrc

# --- Oh My Zsh ---
if [ ! -d "${ZSH:-$HOME/.oh-my-zsh}" ]; then
  echo "Installing Oh My Zsh..."
  RUNZSH=no CHSH=no KEEP_ZSHRC=yes \
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

# --- Powerlevel10k ---
if [ ! -d "$ZSH_CUSTOM/themes/powerlevel10k" ]; then
  echo "Installing Powerlevel10k..."
  git clone --depth=1 https://github.com/romkatv/powerlevel10k.git \
    "$ZSH_CUSTOM/themes/powerlevel10k"
fi

# --- zsh-autosuggestions ---
if [ ! -d "$ZSH_CUSTOM/plugins/zsh-autosuggestions" ]; then
  echo "Installing zsh-autosuggestions..."
  git clone https://github.com/zsh-users/zsh-autosuggestions \
    "$ZSH_CUSTOM/plugins/zsh-autosuggestions"
fi

# --- nvm + Node.js ---
export NVM_DIR="$HOME/.nvm"
mkdir -p "$NVM_DIR"
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"
if command -v nvm &>/dev/null; then
  nvm install --lts
  nvm alias default node
fi

# --- TPM (Tmux Plugin Manager) ---
if [ ! -d "$HOME/.tmux/plugins/tpm" ]; then
  git clone https://github.com/tmux-plugins/tpm "$HOME/.tmux/plugins/tpm"
fi

# --- Rust ---
if ! command -v rustc &>/dev/null; then
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
fi

# --- GPG pinentry ---
mkdir -p ~/.gnupg && chmod 700 ~/.gnupg
grep -q "pinentry-program" ~/.gnupg/gpg-agent.conf 2>/dev/null || \
  echo "pinentry-program $(which pinentry-mac)" >> ~/.gnupg/gpg-agent.conf

echo "✅ Setup complete. Run: exec zsh"
