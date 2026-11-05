# Checklist post-bootstrap

Pasos manuales tras `./bootstrap.sh`. No meter datos personales en el repo.

## 1. Identidad git

```bash
git config --global user.name "Tu Nombre"
git config --global user.email "tu@email.com"
# recomendado: TU_USUARIO@users.noreply.github.com
```

## 2. GitHub CLI

```bash
gh auth login
# o: gh auth login --with-token < token.txt
```

## 3. SSH (opcional si usas HTTPS + gh)

```bash
ssh-keygen -t ed25519 -C "tu@email.com"
ssh-add --apple-use-keychain ~/.ssh/id_ed25519
pbcopy < ~/.ssh/id_ed25519.pub
# GitHub → Settings → SSH keys
```

## 4. Energía

```bash
sudo pmset -c sleep 0
sudo pmset -b sleep 10
```

## 5. Apps (permisos)

Abrir una vez: **Rectangle**, **Stats**, **iTerm2**, **Cursor**, **Comet**, **WhatsApp**, **Telegram**, **Obsidian**, **Syncthing**.

- Rectangle: modo Recommended; si choca con el tiling de macOS, desactiva el del sistema.
- iTerm: perfil Clear Dark + Nerd Font (lo deja el bootstrap).
- Syncthing: en Mac es `syncthing-app`; en Android suele usarse Syncthing-Fork.
- Codex IDE: extensión `openai.chatgpt` en Cursor (`./scripts/install-cursor-extensions.sh`).
- Codex CLI: `codex` (login la primera vez).

## 6. Docker (Colima)

```bash
colima start
docker run --rm hello-world   # smoke test
```

Parar cuando no lo uses: `colima stop`.

## 7. Rosetta 2 (opcional)

Solo si necesitas software Intel:

```bash
softwareupdate --install-rosetta --agree-to-license
```

## 8. Logout / reinicio

Cierra sesión o reinicia para asentar defaults de macOS (`defaults/macos.sh`).

## Reaplicar todo

```bash
cd ~/Projects/entorno-mac && ./bootstrap.sh
```
