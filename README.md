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

## Context-Aware Theming

The dotfiles automatically detect what kind of machine you're on and adjust visual
theming across all tools — same Tokyo Night base, different accent color per context.

### How it works

```
Shell startup → detect.sh → sets DOTFILES_CONTEXT + DOTFILES_ACCENT
                                    ↓
              ┌─────────────────────┼─────────────────────┐
              ▼                     ▼                     ▼
           tmux                  nvim                 starship
     (source theme conf)    (read env var)      (env_var module)
```

### Contexts

| Context | Accent | Signal | Detection |
|---------|--------|--------|-----------|
| `local` | Blue #7aa2f7 | Relaxed, default aesthetic | No SSH, hostname doesn't match patterns |
| `remote` | Cyan #7dcfff | Distinct but calm | SSH session detected |
| `prod` | Red #f7768e | High-signal danger | Hostname matches prod patterns |

### Configuration

Edit `context/.config/dotfiles/config.sh` to define hostname patterns:

```sh
DOTFILES_PROD_PATTERNS="prod|production"
```

Override manually for testing:

```sh
export DOTFILES_CONTEXT=prod   # then start tmux / nvim
```

### Tool integration

| Tool | How context is applied |
|------|----------------------|
| **tmux** | Sources a context-specific `.conf` that sets status bar, pane border, and message accent colors. Prod prefixes session name with "PROD:" |
| **nvim** | Switches Tokyo Night style variant: `night` (local), `moon` (remote), `storm` (prod). Prod adds red cursor line and status bar |
| **starship** | Shows a bold red `PROD` or cyan `REMOTE` badge before the prompt. Hidden for local |
| **lazygit** | Inherits terminal colors — benefits from tmux/terminal accent changes |
| **yazi** | Static Tokyo Night theme — consistent across contexts |

### Directory structure

```
context/.config/dotfiles/
├── config.sh              # Hostname patterns (single source of truth)
├── detect.sh              # Detection logic + color exports
└── themes/
    ├── tmux-local.conf    # Blue accents
    ├── tmux-remote.conf   # Cyan accents
    └── tmux-prod.conf     # Red accents + PROD label
```

### Extending with new contexts

1. Add hostname pattern to `config.sh`
2. Add a `case` branch in `detect.sh` with accent color + label
3. Add a `tmux-<context>.conf` theme file
4. Update the tmux `if-shell` chain in `.tmux.conf`

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
