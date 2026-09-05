#!/usr/bin/env bash
# Bootstrap these dotfiles on an Arch/CachyOS machine.
#
#   ./install.sh home|work          install packages, fonts, GTK theme, oh-my-zsh, then stow
#   ./install.sh --check home|work  only report what is missing, change nothing
#
# Idempotent: safe to re-run after a git pull.
set -euo pipefail
cd "$(dirname "$(readlink -f "$0")")"

CHECK=0
[ "${1:-}" = "--check" ] && { CHECK=1; shift; }
HOST="${1:-}"
case "$HOST" in
    home|work) ;;
    *) echo "usage: $0 [--check] home|work"; exit 1 ;;
esac

SHARED=(hyprland hyprlock hypridle hyprpaper waybar rofi dunst kitty gtk qt starship nvim zsh backgrounds)
pkgs()   { grep -vE '^\s*(#|$)' "$1" | sed 's/#.*//' | awk '{print $1}'; }
missing(){ for p in "$@"; do pacman -Q "$p" >/dev/null 2>&1 || echo "$p"; done; }

echo "== packages (official repos)"
MISSING_PAC=$(missing $(pkgs packages/pacman.txt))
echo "   missing: ${MISSING_PAC:-none}" | tr '\n' ' '; echo

echo "== packages (AUR / CachyOS repo)"
MISSING_AUR=$(missing $(pkgs packages/aur.txt))
echo "   missing: ${MISSING_AUR:-none}" | tr '\n' ' '; echo

if [ "$CHECK" -eq 0 ]; then
    [ -n "$MISSING_PAC" ] && sudo pacman -S --needed $MISSING_PAC
    if [ -n "$MISSING_AUR" ]; then
        HELPER=$(command -v paru || command -v yay || true)
        for p in $MISSING_AUR; do
            if pacman -Si "$p" >/dev/null 2>&1; then sudo pacman -S --needed "$p"        # in a configured repo (CachyOS)
            elif [ -n "$HELPER" ]; then "$HELPER" -S --needed "$p"
            else echo "   !! $p needs an AUR helper (paru/yay); skipped"; fi
        done
    fi
fi

echo "== oh-my-zsh + plugins"
OMZ="$HOME/.oh-my-zsh"
for repo in "ohmyzsh/ohmyzsh:$OMZ" \
            "zsh-users/zsh-autosuggestions:$OMZ/custom/plugins/zsh-autosuggestions" \
            "zsh-users/zsh-syntax-highlighting:$OMZ/custom/plugins/zsh-syntax-highlighting"; do
    src=${repo%%:*}; dst=${repo#*:}
    if [ -d "$dst" ]; then echo "   ok      $dst"
    elif [ "$CHECK" -eq 1 ]; then echo "   missing $dst"
    else git clone -q --depth 1 "https://github.com/$src" "$dst" && echo "   cloned  $dst"; fi
done

echo "== GTK theme"
if [ -d "${XDG_DATA_HOME:-$HOME/.local/share}/themes/Tokyo-Night" ]; then echo "   ok      Tokyo-Night"
elif [ "$CHECK" -eq 1 ]; then echo "   missing Tokyo-Night (scripts/theme-assets.sh)"
else ./scripts/theme-assets.sh >/dev/null && echo "   installed Tokyo-Night"; fi

echo "== stow (shared packages + host-$HOST)"
if [ "$CHECK" -eq 1 ]; then
    stow -n -R "${SHARED[@]}" "host-$HOST" 2>&1 | grep -iE 'conflict|existing' | sed 's/^/   /' || echo "   no conflicts"
else
    stow -R "${SHARED[@]}" "host-$HOST"
    echo "   linked"
fi

echo "== misc"
mkdir -p "$HOME/Images/screenshots"
[ "$(getent passwd "$USER" | cut -d: -f7)" = "$(command -v zsh)" ] && echo "   login shell is zsh" || echo "   login shell is not zsh: run  chsh -s $(command -v zsh)"
[ "$HOST" = home ] && [ ! -f "$HOME/Videos/wallpapers/pinterest-69735494225962758.mp4" ] && echo "   host-home expects the video wallpaper in ~/Videos/wallpapers (see host-home/.config/hypr/local.conf)"
echo "done. Log out and choose the Hyprland session; on a live session run: hyprctl reload"
