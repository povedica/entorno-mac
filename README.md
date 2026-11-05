# entorno-mac

Bootstrap de macOS (Apple Silicon) reproducible.

Un comando deja Homebrew, apps, CLI, dotfiles y defaults listos. Sirve para un Mac nuevo y para que un humano o un agente sepan qué hay y qué tocar.

## Uso

```bash
git clone https://github.com/povedica/entorno-mac.git ~/Projects/entorno-mac
cd ~/Projects/entorno-mac
chmod +x bootstrap.sh defaults/macos.sh
./bootstrap.sh
```

Luego (local, no va al repo):

```bash
git config --global user.name "Tu Nombre"
git config --global user.email "tu@email.com"   # o TU_USUARIO@users.noreply.github.com
```

Pasos manuales: [`CHECKLIST.md`](./CHECKLIST.md).

## Qué hace `./bootstrap.sh`

1. Comprueba Xcode CLT  
2. Instala Homebrew si falta  
3. `brew bundle` con el [`Brewfile`](./Brewfile)  
4. Enlaza dotfiles (zsh, aliases, Starship, iTerm, gitignore)  
5. Incluye `dotfiles/gitconfig` en tu `~/.gitconfig` (sin `user.*`)  
6. Aplica [`defaults/macos.sh`](./defaults/macos.sh)  
7. Instala Node LTS con `fnm` si está disponible  

Idempotente en lo razonable: se puede volver a ejecutar.

## Stack de terminal

| Pieza | Detalle |
|---|---|
| Shell | zsh + `dotfiles/zshrc` |
| Prompt | Starship preset **tokyo-night** (separadores en flecha ``) |
| Fuente | JetBrainsMono Nerd Font (iconos) |
| iTerm2 | Perfil **Clear Dark** (siempre oscuro) |
| Completado | zsh-autocomplete + zsh-autosuggestions |
| Alias | Set mínimo en `dotfiles/aliases.zsh` |

## Docker (Colima)

Más ligero que Docker Desktop. Ya viene en el Brewfile.

```bash
colima start    # arrancar
colima status   # estado
colima stop     # parar
docker ps       # usa el contexto "colima"
```

## Rosetta 2 (opcional)

Solo para apps Intel (x86_64). El motor ocupa poco; la caché puede crecer con el uso.

```bash
softwareupdate --install-rosetta --agree-to-license
```

## Estructura

```text
bootstrap.sh
Brewfile
defaults/macos.sh
dotfiles/
  zshrc, aliases.zsh, gitconfig, gitignore_global
  starship.toml, iterm2/Clear Dark.json
  cursor-extensions.txt
scripts/install-cursor-extensions.sh
CHECKLIST.md
docs/baseline-ejemplo.md
```

## Apps incluidas (Brewfile)

Navegadores: Firefox, Chrome, **Comet**.  
Comms: WhatsApp, Telegram.  
Notas/sync: Obsidian, Syncthing (`syncthing-app`).  
Dev: Cursor, iTerm2, **Codex CLI** (`codex`) + extensión IDE `openai.chatgpt`.

```bash
./scripts/install-cursor-extensions.sh   # Codex en Cursor
codex                                    # login CLI la 1ª vez
```

## Personalizar

| Quieres… | Edita… | Luego |
|---|---|---|
| Apps / CLI | `Brewfile` | `brew bundle --file=./Brewfile` |
| Extensiones Cursor | `dotfiles/cursor-extensions.txt` | `./scripts/install-cursor-extensions.sh` |
| Shell / alias | `dotfiles/zshrc`, `aliases.zsh` | `reload` o nueva pestaña |
| Prompt | `dotfiles/starship.toml` | nueva pestaña |
| iTerm | `dotfiles/iterm2/Clear Dark.json` | reiniciar iTerm |
| macOS UI | `defaults/macos.sh` | ejecutarlo; logout/reboot |

## Privacidad (repo público)

**No** versionar: emails, claves SSH, tokens, `.env`, series/IP/MAC.

Identidad git solo en `~/.gitconfig` local:

```ini
[include]
  path = ~/Projects/entorno-mac/dotfiles/gitconfig
```

## Para agentes

- Entrada: `./bootstrap.sh`  
- Paquetes: `Brewfile`  
- Shell: `dotfiles/zshrc` → `~/.zshrc`  
- Alias: `dotfiles/aliases.zsh`  
- Post-pasos humanos: `CHECKLIST.md`  
- No escribir secretos en el repo  

## Licencia

MIT
