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

Más pasos opcionales: [`CHECKLIST.md`](./CHECKLIST.md).

## Qué hace `./bootstrap.sh`

1. Comprueba Xcode CLT  
2. Instala Homebrew si falta  
3. `brew bundle` con el [`Brewfile`](./Brewfile)  
4. Enlaza dotfiles (`zshrc`, `gitignore_global`, Starship, iTerm)  
5. Incluye `dotfiles/gitconfig` en tu `~/.gitconfig` (sin `user.*`)  
6. Aplica [`defaults/macos.sh`](./defaults/macos.sh)  
7. Instala Node LTS con `fnm` si está disponible  

Idempotente en lo razonable: se puede volver a ejecutar.

## Estructura

```text
bootstrap.sh           # orquestador
Brewfile               # fórmulas + casks (editar = personalizar)
defaults/macos.sh      # preferencias del sistema
dotfiles/
  zshrc                # shell (Starship, autocomplete, autosuggestions…)
  gitconfig            # git compartido (sin identidad)
  gitignore_global
  starship.toml        # preset tokyo-night
  iterm2/Clear Dark.json
CHECKLIST.md           # post-bootstrap manual
docs/baseline-ejemplo.md
```

## Personalizar

| Quieres… | Edita… | Luego |
|---|---|---|
| Apps / CLI | `Brewfile` | `brew bundle --file=./Brewfile` |
| Shell | `dotfiles/zshrc` | nueva pestaña o `source ~/.zshrc` |
| Prompt | `dotfiles/starship.toml` | nueva pestaña |
| iTerm | `dotfiles/iterm2/Clear Dark.json` | reiniciar iTerm |
| macOS UI | `defaults/macos.sh` | `./defaults/macos.sh` |

## Privacidad (repo público)

**No** versionar: emails reales, claves SSH, tokens, `.env`, series/IP/MAC.

La identidad git vive solo en `~/.gitconfig` local. El repo solo se incluye:

```ini
[include]
  path = ~/Projects/entorno-mac/dotfiles/gitconfig
```

## Para agentes

- Entrada: `./bootstrap.sh`  
- Fuente de paquetes: `Brewfile`  
- Shell: `dotfiles/zshrc` → `~/.zshrc` (symlink)  
- No escribir secretos en el repo  
- Tras cambiar dotfiles de iTerm/Starship, reiniciar terminal  

## Licencia

MIT
