#!/bin/bash
set -euo pipefail

echo "==> Dotfiles bootstrap"

# --- Detect package manager ---
if command -v apt-get &>/dev/null; then
  PM="apt-get"
  INSTALL="sudo apt-get install -y"
elif command -v dnf &>/dev/null; then
  PM="dnf"
  INSTALL="sudo dnf install -y"
elif command -v pacman &>/dev/null; then
  PM="pacman"
  INSTALL="sudo pacman -S --noconfirm"
elif command -v brew &>/dev/null; then
  PM="brew"
  INSTALL="brew install"
else
  echo "No supported package manager found (apt, dnf, pacman, brew)."
  exit 1
fi

echo "==> Using package manager: $PM"

# --- Core dependencies ---
PACKAGES=(stow git curl zsh)

# --- CLI tools (names vary by PM) ---
case "$PM" in
  apt-get)
    sudo apt-get update
    PACKAGES+=(neovim tmux bat eza fd-find zoxide ripgrep direnv lazygit yazi)
    ;;
  dnf)
    PACKAGES+=(neovim tmux bat eza fd-find zoxide ripgrep direnv lazygit yazi)
    ;;
  pacman)
    PACKAGES+=(neovim tmux bat eza fd zoxide ripgrep direnv lazygit yazi)
    ;;
  brew)
    PACKAGES+=(neovim tmux bat eza fd zoxide ripgrep direnv lazygit yazi)
    ;;
esac

echo "==> Installing packages..."
$INSTALL "${PACKAGES[@]}" || echo "Some packages may need manual installation"

# --- fzf (from GitHub for latest version) ---
if [ ! -d "$HOME/.fzf" ]; then
  echo "==> Installing fzf..."
  git clone --depth 1 https://github.com/junegunn/fzf.git "$HOME/.fzf"
  "$HOME/.fzf/install" --all --no-update-rc
fi

# --- Sesh (tmux session manager) ---
if ! command -v sesh &>/dev/null; then
  echo "==> Installing sesh..."
  SESH_VERSION=$(curl -sL https://api.github.com/repos/joshmedeski/sesh/releases/latest | grep '"tag_name"' | cut -d'"' -f4)
  SESH_VERSION_NUM="${SESH_VERSION#v}"
  curl -sL "https://github.com/joshmedeski/sesh/releases/download/${SESH_VERSION}/sesh_Linux_x86_64.tar.gz" | tar xz -C /tmp sesh
  sudo mv /tmp/sesh /usr/local/bin/sesh
  sudo chmod +x /usr/local/bin/sesh
  echo "    Installed sesh $SESH_VERSION"
fi

# --- Starship ---
if ! command -v starship &>/dev/null; then
  echo "==> Installing starship..."
  curl -sS https://starship.rs/install.sh | sh -s -- -y
fi

# --- Atuin ---
if ! command -v atuin &>/dev/null; then
  echo "==> Installing atuin..."
  curl --proto '=https' --tlsv1.2 -LsSf https://setup.atuin.sh | sh
fi

# --- Oh-my-zsh ---
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  echo "==> Installing oh-my-zsh..."
  RUNZSH=no sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

# --- Delta (git pager) ---
if ! command -v delta &>/dev/null; then
  echo "==> delta not found — install from https://github.com/dandavison/delta/releases"
fi

# --- Stow dotfiles ---
DOTFILES_DIR="$(cd "$(dirname "$0")" && pwd)"
echo "==> Stowing dotfiles from $DOTFILES_DIR..."
cd "$DOTFILES_DIR"
make install
make post-install

echo ""
echo "==> Done! Restart your shell or run: source ~/.zshrc"
echo "    Then open nvim to auto-install plugins."
echo "    In tmux, press prefix+I to install TPM plugins."
