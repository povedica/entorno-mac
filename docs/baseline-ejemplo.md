# Ejemplo: baseline de un Mac nuevo

Plantilla de lo que conviene anotar **antes** del bootstrap.  
Este archivo es un ejemplo **sin datos privados** (sin series, MAC, IP, UUID, etc.).

## Resumen

| Campo | Ejemplo |
|---|---|
| Equipo | MacBook Air (Apple Silicon) |
| Chip / RAM / disco | M-series · 16 GB · ~512 GB SSD |
| SO | macOS (versión actual del equipo) |
| Arquitectura | arm64 |
| Locale | es-ES |
| Shell | zsh |
| SIP / FileVault / Gatekeeper | activos (típico en Mac nuevo) |

## Qué suele faltar en un Mac recién iniciado

- Homebrew
- Identidad git (`user.name` / `user.email`)
- Claves SSH
- Runtimes (Node, Python, Docker…)
- Apps de trabajo (editor, terminal, navegador)
- Dotfiles (casi vacíos)

## Qué NO guardar en un repo público

- Número de serie, Hardware UUID, UDID
- Direcciones MAC e IPs locales
- Emails personales, tokens, claves
- Identificadores de Apple Pay / Secure Element
- Nombre completo del equipo si no quieres vincularlo

Para soporte Apple, esos datos se consultan en local:

```bash
system_profiler SPHardwareDataType
```

## Tras el bootstrap

Actualiza tu propio checklist local (no hace falta subirlo) o usa `CHECKLIST.md` del repo.
