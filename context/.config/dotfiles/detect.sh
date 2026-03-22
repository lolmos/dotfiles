#!/bin/sh
# Context detection — sets DOTFILES_CONTEXT and DOTFILES_ACCENT.
# Sourced by .zshrc early in startup. Must be fast and POSIX-compatible.
#
# Flow: manual override > hostname match > SSH detection > default (local)

# Load hostname patterns
. "${HOME}/.config/dotfiles/config.sh" 2>/dev/null

# Skip detection if manually overridden
if [ -z "$DOTFILES_CONTEXT" ]; then
  _hostname=$(hostname -s 2>/dev/null || hostname)

  if echo "$_hostname" | grep -qiE "${DOTFILES_PROD_PATTERNS:-^$}"; then
    DOTFILES_CONTEXT="prod"
  elif [ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY" ] || [ -n "$SSH_CONNECTION" ]; then
    DOTFILES_CONTEXT="remote"
  else
    DOTFILES_CONTEXT="local"
  fi

  unset _hostname
fi

export DOTFILES_CONTEXT

# --- Color palette per context ---
# Same Tokyo Night base, different accent color.
# These vars are consumed by tools that support dynamic theming.
case "$DOTFILES_CONTEXT" in
  prod)
    export DOTFILES_ACCENT="#f7768e"       # red — danger
    export DOTFILES_ACCENT_DIM="#703040"   # muted red
    export DOTFILES_LABEL="PROD"
    ;;
  remote)
    export DOTFILES_ACCENT="#7dcfff"       # cyan — distinct
    export DOTFILES_ACCENT_DIM="#2d5a6e"   # muted cyan
    export DOTFILES_LABEL="REMOTE"
    ;;
  *)
    export DOTFILES_ACCENT="#7aa2f7"       # blue — relaxed
    export DOTFILES_ACCENT_DIM="#394b70"   # muted blue (dark5)
    export DOTFILES_LABEL=""
    ;;
esac
