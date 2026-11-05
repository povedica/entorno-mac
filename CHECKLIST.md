# Checklist post-bootstrap

Pasos manuales tras `./bootstrap.sh`. No meter datos personales en el repo.

## Identidad git

```bash
git config --global user.name "Tu Nombre"
git config --global user.email "tu@email.com"
# recomendado: TU_USUARIO@users.noreply.github.com
```

## SSH (opcional si usas HTTPS + `gh`)

```bash
ssh-keygen -t ed25519 -C "tu@email.com"
ssh-add --apple-use-keychain ~/.ssh/id_ed25519
pbcopy < ~/.ssh/id_ed25519.pub
# pegar en GitHub → Settings → SSH keys
```

## GitHub CLI

```bash
gh auth login
# o: gh auth login --with-token < token.txt
```

## Energía

```bash
sudo pmset -c sleep 0
sudo pmset -b sleep 10
```

## Apps (permisos)

Abrir una vez: Rectangle, Stats, iTerm2, Cursor.  
Si Rectangle choca con el tiling de macOS, desactiva el del sistema.

## Docker (cuando lo necesites)

```bash
colima start
```

## Reaplicar

```bash
cd ~/Projects/entorno-mac && ./bootstrap.sh
```
