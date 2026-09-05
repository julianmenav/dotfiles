#!/usr/bin/env bash
# Installs the non-dotfile parts of the HyDE "Tokyo Night" look:
#   - GTK theme "Tokyo-Night" (tarball from the hyde-themes repo) -> ~/.local/share/themes
#   - prints the package commands for icons, cursor, rofi, dunst and Qt theming
# Safe to re-run.
set -euo pipefail

THEMES_DIR="${XDG_DATA_HOME:-$HOME/.local/share}/themes"
GTK_URL="https://raw.githubusercontent.com/HyDE-Project/hyde-themes/Tokyo-Night/Source/Gtk_TokyoNight.tar.gz"

mkdir -p "$THEMES_DIR"
if [ -d "$THEMES_DIR/Tokyo-Night" ]; then
    echo "GTK theme already present: $THEMES_DIR/Tokyo-Night"
else
    echo "Downloading Tokyo-Night GTK theme..."
    curl -fsSL "$GTK_URL" | tar xz -C "$THEMES_DIR"
    echo "Installed $THEMES_DIR/Tokyo-Night"
fi

cat <<MSG

Packages (run yourself, they need sudo):
  sudo pacman -S --needed rofi rofi-emoji dunst qt6ct qt5ct tela-circle-icon-theme-purple
  paru -S bibata-cursor-theme          # cursor "Bibata-Modern-Ice" (AUR)

Then stow the packages (see README) and:  hyprctl reload && pkill -SIGUSR2 waybar
MSG
