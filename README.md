# entorno-mac

Bootstrap reproducible para **macOS (Apple Silicon)**.  
Clonas el repo, ejecutas un script, y dejas un Mac nuevo (o reseteado) con un set de trabajo coherente: Homebrew, CLI, apps, dotfiles y defaults.

Pensado para reutilizarlo cuando cambies de Mac — y para que cualquiera pueda adaptarlo.

## Requisitos

- Mac con chip Apple Silicon
- Cuenta de administrador
- Conexión a internet
- [Xcode Command Line Tools](https://developer.apple.com/download/all/) (el script te avisa si faltan)

## Instalación (3 pasos)

```bash
# 1. Clonar
mkdir -p ~/Projects && cd ~/Projects
git clone https://github.com/povedica/entorno-mac.git
cd entorno-mac

# 2. Bootstrap (Homebrew + Brewfile + dotfiles + defaults + Node LTS)
chmod +x bootstrap.sh defaults/macos.sh
./bootstrap.sh

# 3. Identidad git (obligatorio — no se versiona en el repo)
git config --global user.name "Tu Nombre"
git config --global user.email "tu@email.com"
```

Email privado en GitHub (recomendado):

```bash
git config --global user.email "TU_USUARIO@users.noreply.github.com"
```

Comprueba:

```bash
git config --global --get user.name
git config --global --get user.email
```

## Después del bootstrap

| Paso | Comando / acción |
|---|---|
| SSH | `ssh-keygen -t ed25519 -C "tu@email.com"` → subir la `.pub` a GitHub |
| GitHub CLI | `gh auth login` |
| Energía (AC) | `sudo pmset -c sleep 0 && sudo pmset -b sleep 10` |
| Docker local | `colima start` |
| Permisos GUI | Abrir Rectangle, Stats, iTerm2, Cursor una vez |

Detalle: [`CHECKLIST.md`](./CHECKLIST.md).

## Qué instala

Definido en [`Brewfile`](./Brewfile) (edítalo a tu gusto):

- **CLI:** git, gh, ripgrep, fd, fzf, bat, eza, starship, zoxide, neovim, tmux…
- **Runtimes:** fnm (Node), uv (Python), mise
- **Contenedores:** Colima + Docker CLI
- **Apps:** Cursor, iTerm2, Firefox, Chrome, Rectangle, Stats…

```bash
# Reaplicar solo paquetes tras editar el Brewfile
brew bundle --file=./Brewfile
```

## Estructura

```text
entorno-mac/
├── bootstrap.sh          # instalación / reaplicación
├── Brewfile              # fórmulas y casks
├── defaults/macos.sh     # preferencias del sistema
├── dotfiles/
│   ├── zshrc             # → ~/.zshrc (symlink)
│   ├── gitconfig         # preferencias compartidas (sin name/email)
│   └── gitignore_global  # → ~/.gitignore_global
├── docs/baseline-ejemplo.md
├── CHECKLIST.md
└── README.md
```

## Identidad git y privacidad

La identidad **no** vive en este repositorio (es público).

El bootstrap deja en tu máquina un `~/.gitconfig` real que **incluye** la config compartida del repo:

```ini
[include]
    path = ~/Projects/entorno-mac/dotfiles/gitconfig
```

Tú solo añades:

```bash
git config --global user.name "Tu Nombre"
git config --global user.email "tu@email.com"
```

Así `user.*` nunca se sube al remoto por accidente.

**No versionar:** claves SSH, tokens, `.env`, series de hardware, IPs, emails reales. Ver `.gitignore`.

## Personalizar

1. Comenta/descomenta líneas en `Brewfile`
2. Ajusta `dotfiles/zshrc` y `defaults/macos.sh`
3. Vuelve a ejecutar `./bootstrap.sh` (es idempotente en lo razonable)

## Otro Mac / desde cero

```bash
git clone https://github.com/povedica/entorno-mac.git ~/Projects/entorno-mac
cd ~/Projects/entorno-mac && ./bootstrap.sh
git config --global user.name "Tu Nombre"
git config --global user.email "tu@email.com"
```

## Licencia

MIT — úsalo, fórkealo y adáptalo.
