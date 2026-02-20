# Dotfiles

Personal dotfiles managed with [GNU Stow](https://www.gnu.org/software/stow/).

## Tools

| Tool | Purpose |
|------|---------|
| **neovim** | Editor |
| **tmux** | Terminal multiplexer |
| **zsh** | Shell (oh-my-zsh) |
| **starship** | Prompt |
| **fzf** | Fuzzy finder |
| **lazygit** | Git TUI |
| **bat** | `cat` with syntax highlighting |
| **eza** | Modern `ls` |
| **fd** | Modern `find` |
| **ripgrep** | Fast grep |
| **zoxide** | Smart `cd` |
| **yazi** | File manager |
| **sesh** | Tmux session manager — fuzzy switch between sessions and zoxide directories (`prefix + T`) |
| **atuin** | Shell history |
| **direnv** | Per-directory env vars |
| **delta** | Git diff pager |

## Install

```sh
./bootstrap.sh
```

## Usage

```sh
make install    # Stow all packages
make uninstall  # Unstow all packages
make restow     # Re-stow (fix stale symlinks)
```
