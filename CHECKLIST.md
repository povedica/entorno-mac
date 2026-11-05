# Checklist post-bootstrap

Marca lo que vayas completando tras `./bootstrap.sh`.

## Lo hace el script

- [x] Homebrew (`/opt/homebrew` en Apple Silicon)
- [x] Paquetes del `Brewfile` (CLI + casks)
- [x] Dotfiles (`~/.zshrc`, include de gitconfig, `~/.gitignore_global`)
- [x] Defaults de macOS (Finder, Dock, teclado, screenshots…)
- [x] Node LTS vía fnm (si fnm está en el Brewfile)

## Lo haces tú (datos personales — fuera del repo)

### 1. Identidad git

```bash
git config --global user.name "Tu Nombre"
git config --global user.email "tu@email.com"

# Opción privacidad (GitHub):
# git config --global user.email "TU_USUARIO@users.noreply.github.com"

git config --global --get user.name
git config --global --get user.email
```

### 2. SSH

```bash
ssh-keygen -t ed25519 -C "tu@email.com"
eval "$(ssh-agent -s)"
ssh-add --apple-use-keychain ~/.ssh/id_ed25519
pbcopy < ~/.ssh/id_ed25519.pub
# GitHub → Settings → SSH and GPG keys → New SSH key
```

### 3. GitHub CLI

```bash
gh auth login
```

### 4. Energía (opcional, pide sudo)

```bash
sudo pmset -c sleep 0
sudo pmset -b sleep 10
```

### 5. Apps y Docker

- [ ] Abrir Rectangle, Stats, iTerm2, Cursor (permisos de accesibilidad/red)
- [ ] `colima start` cuando necesites Docker
- [ ] (Opcional) Rosetta: `softwareupdate --install-rosetta --agree-to-license`
- [ ] Cerrar sesión o reiniciar para asentar defaults

## Reaplicar más adelante

```bash
cd ~/Projects/entorno-mac && ./bootstrap.sh
```
