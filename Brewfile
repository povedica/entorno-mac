# Brewfile — set de trabajo reproducible (Apple Silicon)
# Uso: brew bundle --file=./Brewfile
# Comentar lo que no quieras; descomentar bloques opcionales.

# ---------------------------------------------------------------------------
# Core CLI
# ---------------------------------------------------------------------------
brew "git"
brew "gh"
brew "wget"
brew "curl"
brew "jq"
brew "yq"
brew "ripgrep"
brew "fd"
brew "fzf"
brew "bat"
brew "eza"
brew "tree"
brew "htop"
brew "watch"
brew "tmux"
brew "neovim"
brew "coreutils"
brew "gnu-sed"
brew "findutils"
brew "gawk"
brew "grep"
brew "mas"
brew "starship"
brew "zoxide"
brew "shellcheck"
brew "zsh-autosuggestions"
brew "zsh-autocomplete"

# ---------------------------------------------------------------------------
# Runtimes / gestores
# ---------------------------------------------------------------------------
brew "fnm"   # Node (instalar versión con: fnm install --lts)
brew "uv"    # Python (uv python install 3.13)
brew "mise"  # opcional: gestor unificado (node/python/go/…)

# ---------------------------------------------------------------------------
# Contenedores — Colima (ligero). Alternativa GUI: cask docker-desktop
# Uso: colima start | status | stop
# ---------------------------------------------------------------------------
brew "colima"
brew "docker"
brew "docker-compose"
brew "docker-buildx"

# ---------------------------------------------------------------------------
# Apps GUI (casks)
# ---------------------------------------------------------------------------
cask "cursor"
cask "rectangle"          # ventanas con atajos
cask "iterm2"
cask "firefox"
cask "google-chrome"
cask "comet"              # navegador AI (Perplexity)
cask "whatsapp"
cask "telegram"
cask "obsidian"
cask "syncthing-app"      # sync (en Android suele usarse Syncthing-Fork)
cask "codex"              # OpenAI Codex CLI (`codex`)
cask "appcleaner"
cask "the-unarchiver"
cask "stats"              # menú: CPU/RAM/red

# Opcionales — descomentar según necesidad:
# cask "visual-studio-code"
# cask "orbstack"         # alternativa a Colima/Docker Desktop
# cask "docker-desktop"
# cask "slack"
# cask "spotify"
# cask "1password"
# cask "figma"

# ---------------------------------------------------------------------------
# Mac App Store (requiere sesión en App Store + `mas signin` si aplica)
# ---------------------------------------------------------------------------
# mas "Xcode", id: 497799835
# mas "Keynote", id: 409183694

# Fuentes (iconos Starship / Nerd Font)
cask "font-jetbrains-mono-nerd-font"
