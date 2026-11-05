#!/usr/bin/env bash
# defaults/macos.sh — preferencias de sistema (idempotente)
# Fuente: baseline entorno-mac. Revisar antes de aplicar en máquinas ya personalizadas.
set -euo pipefail

echo "Aplicando defaults de macOS…"

# ---------------------------------------------------------------------------
# General / UI
# ---------------------------------------------------------------------------
# Mostrar extensiones de archivo
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

# No crear .DS_Store en volúmenes de red / USB
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true

# Expansión completa en paneles de guardar/imprimir
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode2 -bool true
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint -bool true
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint2 -bool true

# ---------------------------------------------------------------------------
# Teclado / trackpad / entrada
# ---------------------------------------------------------------------------
# Repetición de teclas más ágil (valores típicos de desarrollo)
defaults write NSGlobalDomain KeyRepeat -int 2
defaults write NSGlobalDomain InitialKeyRepeat -int 25

# Teclas de función estándar (F1–F12) sin pulsar Fn
defaults write NSGlobalDomain com.apple.keyboard.fnState -bool true

# Desactivar “corrección” automática molesta en código
defaults write NSGlobalDomain NSAutomaticCapitalizationEnabled -bool false
defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false
defaults write NSGlobalDomain NSAutomaticPeriodSubstitutionEnabled -bool false
defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false
defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false

# ---------------------------------------------------------------------------
# Finder
# ---------------------------------------------------------------------------
defaults write com.apple.finder ShowPathbar -bool true
defaults write com.apple.finder ShowStatusBar -bool true
defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"   # lista
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"  # buscar en carpeta actual
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false
defaults write com.apple.finder _FXSortFoldersFirst -bool true

# Carpeta home como vista por defecto en nuevas ventanas
defaults write com.apple.finder NewWindowTarget -string "PfHm"
defaults write com.apple.finder NewWindowTargetPath -string "file://${HOME}/"

# ---------------------------------------------------------------------------
# Dock
# ---------------------------------------------------------------------------
defaults write com.apple.dock tilesize -int 42
defaults write com.apple.dock mineffect -string "scale"
defaults write com.apple.dock minimize-to-application -bool true
defaults write com.apple.dock show-recents -bool false
defaults write com.apple.dock autohide -bool false

# ---------------------------------------------------------------------------
# Energía (más usable con monitor externo / trabajo)
# ---------------------------------------------------------------------------
# Requiere sudo para algunos ajustes; se intenta y se avisa si falla
if sudo -n true 2>/dev/null; then
  sudo pmset -a displaysleep 10
  sudo pmset -c sleep 0          # no dormir sistema en AC
  sudo pmset -b sleep 10         # batería: 10 min
  sudo pmset -a disksleep 10
else
  echo "  (sin sudo cacheado: pmset omitido — ejecuta luego: sudo pmset -c sleep 0)"
fi

# ---------------------------------------------------------------------------
# Screenshots
# ---------------------------------------------------------------------------
mkdir -p "${HOME}/Desktop/Screenshots"
defaults write com.apple.screencapture location -string "${HOME}/Desktop/Screenshots"
defaults write com.apple.screencapture type -string "png"
defaults write com.apple.screencapture disable-shadow -bool true

# ---------------------------------------------------------------------------
# Aplicar
# ---------------------------------------------------------------------------
killall Finder 2>/dev/null || true
killall Dock 2>/dev/null || true
killall SystemUIServer 2>/dev/null || true

echo "Defaults aplicados."
