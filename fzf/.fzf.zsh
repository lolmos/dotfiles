# --- fzf configuration ---

# Tokyo Night color palette
export FZF_DEFAULT_OPTS="
  --color=bg+:#283457,bg:#1a1b26,spinner:#9d7cd8,hl:#7aa2f7
  --color=fg:#c0caf5,header:#7aa2f7,info:#e0af68,pointer:#9d7cd8
  --color=marker:#9ece6a,fg+:#c0caf5,prompt:#9d7cd8,hl+:#7aa2f7
  --layout=reverse
  --border=rounded
  --height=80%
"

# Use fd if available (respects .gitignore)
if command -v fdfind &>/dev/null; then
  export FZF_DEFAULT_COMMAND="fdfind --type f --hidden --follow --exclude .git"
  export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
  export FZF_ALT_C_COMMAND="fdfind --type d --hidden --follow --exclude .git"
elif command -v fd &>/dev/null; then
  export FZF_DEFAULT_COMMAND="fd --type f --hidden --follow --exclude .git"
  export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
  export FZF_ALT_C_COMMAND="fd --type d --hidden --follow --exclude .git"
fi

# Previews
export FZF_CTRL_T_OPTS="--preview 'bat --color=always --style=numbers --line-range=:500 {}'"
export FZF_ALT_C_OPTS="--preview 'eza --tree --color=always --level=2 {}'"

# Source system fzf keybindings and completion
[ -f /usr/share/doc/fzf/examples/key-bindings.zsh ] && source /usr/share/doc/fzf/examples/key-bindings.zsh
[ -f /usr/share/doc/fzf/examples/completion.zsh ] && source /usr/share/doc/fzf/examples/completion.zsh
