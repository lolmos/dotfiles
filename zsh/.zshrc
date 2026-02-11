#!/bin/zsh
# shellcheck shell=bash

# --- Environment ---
export EDITOR=nvim
export VISUAL=nvim
export PATH="$HOME/.local/bin:$PATH"
export STARSHIP_CONFIG="$HOME/.config/starship/starship.toml"

# Fix for Ghostty terminal
[ "$TERM" = "xterm-ghostty" ] && export TERM=xterm-256color

# --- Oh-my-zsh ---
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME=""  # Using starship instead

plugins=(
  git
  docker
  docker-compose
  vi-mode
  zsh-autosuggestions
  zsh-syntax-highlighting
)

[ -f "$ZSH/oh-my-zsh.sh" ] && source "$ZSH/oh-my-zsh.sh"

# --- History ---
HISTSIZE=50000
SAVEHIST=50000
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_SAVE_NO_DUPS
setopt HIST_REDUCE_BLANKS
setopt SHARE_HISTORY
setopt INC_APPEND_HISTORY

# --- NVM ---
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

# --- Modern CLI aliases ---
alias cat="bat --paging=never"
alias ls="eza"
alias ll="eza -la"
alias la="eza -a"
alias lt="eza --tree"
alias vim="nvim"
alias vi="nvim"
alias lg="lazygit"
alias y="yazi"

# --- Git aliases ---
alias gs="git status"
alias ga="git add"
alias gc="git commit"
alias gp="git push"
alias gl="git pull"
alias gd="git diff"
alias gco="git checkout"
alias gb="git branch"

# --- Tool init ---
eval "$(starship init zsh)"
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
command -v zoxide &>/dev/null && eval "$(zoxide init zsh)"

# --- Machine-specific overrides ---
source ~/.zshrc.local 2>/dev/null || true

# -- yazi shortcut and function to open cwd on quit
function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	command yazi "$@" --cwd-file="$tmp"
	IFS= read -r -d '' cwd < "$tmp"
	[ "$cwd" != "$PWD" ] && [ -d "$cwd" ] && builtin cd -- "$cwd"
	rm -f -- "$tmp"
}
