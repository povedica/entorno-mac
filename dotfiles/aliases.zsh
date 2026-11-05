# aliases.zsh — set mínimo propio (entorno-mac)
# Principio: pocos, memorables, sin pisar herramientas modernas (eza/fd/bat/rg).

# ---------------------------------------------------------------------------
# Archivos / listado
# ---------------------------------------------------------------------------
alias ls='eza --group-directories-first'
alias ll='eza -lah --group-directories-first'
alias la='eza -la --group-directories-first'
alias cat='bat --paging=never'
alias tree='eza --tree'

# ---------------------------------------------------------------------------
# Navegación
# ---------------------------------------------------------------------------
alias ..='cd ..'
alias ...='cd ../..'
alias -- -='cd -'
alias projects='cd ~/Projects'
alias c='clear'

# ---------------------------------------------------------------------------
# Git (shell). Complementa los alias de dotfiles/gitconfig (git st, git lg…).
# ---------------------------------------------------------------------------
alias g='git'
alias gst='git status -sb'
alias gco='git checkout'
alias gcb='git checkout -b'
alias ga='git add'
alias gc='git commit'
alias gp='git push'
alias gl='git pull'
alias gd='git diff'
alias glg='git log --oneline --graph --decorate -20'

# ---------------------------------------------------------------------------
# Shell
# ---------------------------------------------------------------------------
alias reload='source ~/.zshrc'

# ---------------------------------------------------------------------------
# Global aliases (zsh): van al final de cualquier comando
#   ls -l G foo   →  ls -l | rg foo
# ---------------------------------------------------------------------------
alias -g H='| head'
alias -g T='| tail'
alias -g L='| bat --paging=always'
alias -g G='| rg --color=always'
