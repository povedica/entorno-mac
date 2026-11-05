#!/usr/bin/env bash
# bootstrap.sh — instala/reaplica el entorno de trabajo en un Mac nuevo
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$ROOT"

log()  { printf '\n==> %s\n' "$*"; }
ok()   { printf '    ✓ %s\n' "$*"; }
warn() { printf '    ! %s\n' "$*" >&2; }

need_cmd() {
  command -v "$1" >/dev/null 2>&1
}

# ---------------------------------------------------------------------------
# 1. Xcode Command Line Tools
# ---------------------------------------------------------------------------
ensure_clt() {
  log "Command Line Tools"
  if xcode-select -p >/dev/null 2>&1; then
    ok "ya instaladas: $(xcode-select -p)"
  else
    warn "instalando CLT (puede pedir diálogo gráfico)…"
    xcode-select --install || true
    echo "    Cuando termine la instalación de CLT, vuelve a ejecutar: ./bootstrap.sh"
    exit 1
  fi
}

# ---------------------------------------------------------------------------
# 2. Homebrew
# ---------------------------------------------------------------------------
ensure_brew() {
  log "Homebrew"
  if need_cmd brew; then
    ok "ya instalado: $(brew --prefix)"
  else
    warn "instalando Homebrew…"
    NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  fi

  # Apple Silicon: asegurar PATH en esta sesión y en zsh
  if [[ -x /opt/homebrew/bin/brew ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv zsh)"
    if ! grep -q 'brew shellenv' "${HOME}/.zprofile" 2>/dev/null; then
      {
        echo ''
        echo '# Homebrew (entorno-mac)'
        echo 'eval "$(/opt/homebrew/bin/brew shellenv zsh)"'
      } >> "${HOME}/.zprofile"
      ok "añadido brew shellenv a ~/.zprofile"
    fi
  fi

  need_cmd brew || { warn "brew no está en PATH"; exit 1; }
  ok "brew $(brew --version | head -1)"
}

# ---------------------------------------------------------------------------
# 3. Brewfile
# ---------------------------------------------------------------------------
install_brewfile() {
  log "Brew bundle"
  brew bundle --file="${ROOT}/Brewfile"
  ok "Brewfile aplicado"
}

# ---------------------------------------------------------------------------
# 4. Dotfiles
# ---------------------------------------------------------------------------
link_dotfile() {
  local src="$1" dest="$2"
  mkdir -p "$(dirname "$dest")"
  if [[ -e "$dest" && ! -L "$dest" ]]; then
    local bak="${dest}.bak.$(date +%Y%m%d%H%M%S)"
    mv "$dest" "$bak"
    warn "backup: $dest → $bak"
  fi
  ln -sfn "$src" "$dest"
  ok "link $dest → $src"
}

install_git_include() {
  # ~/.gitconfig debe ser un archivo REAL (no symlink al repo):
  # ahí vive user.name / user.email (privados). El repo solo se incluye.
  local shared="${ROOT}/dotfiles/gitconfig"
  if [[ -L "${HOME}/.gitconfig" ]]; then
    rm -f "${HOME}/.gitconfig"
    warn "eliminado symlink ~/.gitconfig (la identidad no debe versionarse)"
  fi
  if [[ ! -f "${HOME}/.gitconfig" ]]; then
    printf '# gitconfig local — identidad + include de entorno-mac\n' > "${HOME}/.gitconfig"
    ok "creado ~/.gitconfig"
  fi
  git config --global include.path "$shared"
  ok "include.path → $shared"

  if ! git config --global user.name >/dev/null 2>&1 \
     || ! git config --global user.email >/dev/null 2>&1; then
    warn "Configura tu identidad git (no se sube al repo):"
    echo "    git config --global user.name \"Tu Nombre\""
    echo "    git config --global user.email \"tu@email.com\""
    echo "    # privacidad GitHub: TU_USUARIO@users.noreply.github.com"
  fi
}

install_iterm_profile() {
  local src="${ROOT}/dotfiles/iterm2/Clear Dark.json"
  local dest_dir="${HOME}/Library/Application Support/iTerm2/DynamicProfiles"
  [[ -f "$src" ]] || return 0
  mkdir -p "$dest_dir"
  ln -sfn "$src" "${dest_dir}/Clear Dark.json"
  defaults write com.googlecode.iterm2 "Default Bookmark Guid" -string "entorno-mac-clear-dark"
  ok "iTerm2 perfil Clear Dark (default)"
}

install_starship_config() {
  local src="${ROOT}/dotfiles/starship.toml"
  [[ -f "$src" ]] || return 0
  mkdir -p "${HOME}/.config"
  link_dotfile "$src" "${HOME}/.config/starship.toml"
}

install_dotfiles() {
  log "Dotfiles"
  link_dotfile "${ROOT}/dotfiles/zshrc" "${HOME}/.zshrc"
  link_dotfile "${ROOT}/dotfiles/gitignore_global" "${HOME}/.gitignore_global"
  install_git_include
  install_iterm_profile
  install_starship_config
}

# ---------------------------------------------------------------------------
# 5. Defaults macOS
# ---------------------------------------------------------------------------
apply_defaults() {
  log "Defaults macOS"
  bash "${ROOT}/defaults/macos.sh"
  ok "defaults aplicados (algunos requieren logout/reboot)"
}

# ---------------------------------------------------------------------------
# 6. Post-pasos locales (runtimes)
# ---------------------------------------------------------------------------
post_runtimes() {
  log "Runtimes"
  if need_cmd fnm; then
    eval "$(fnm env --use-on-cd --shell zsh)" 2>/dev/null || eval "$(fnm env)"
    if ! fnm list 2>/dev/null | grep -q 'lts'; then
      fnm install --lts || warn "fnm install --lts falló (reintentar luego)"
      fnm default lts-latest 2>/dev/null || true
    fi
    ok "fnm: $(fnm --version 2>/dev/null || true)"
  fi

  if need_cmd uv; then
    ok "uv: $(uv --version)"
  fi

  if need_cmd starship; then
    ok "starship: $(starship --version | head -1)"
  fi
}

print_checklist() {
  log "Checklist manual (ver CHECKLIST.md)"
  cat <<'EOF'
    [ ] git config --global user.name / user.email
    [ ] gh auth login
    [ ] SSH (opcional si usas HTTPS + gh)
    [ ] sudo pmset -c sleep 0
    [ ] Abrir Rectangle / Stats / iTerm2 / Cursor (permisos)
    [ ] colima start
    [ ] Rosetta (opcional): softwareupdate --install-rosetta --agree-to-license
    [ ] Logout o reinicio (asentar defaults)
EOF
}

main() {
  log "entorno-mac bootstrap — ${ROOT}"
  ensure_clt
  ensure_brew
  install_brewfile
  install_dotfiles
  apply_defaults
  post_runtimes
  print_checklist
  log "Listo"
}

main "$@"
