# dotfiles

Hyprland desktop, managed with [GNU Stow](https://www.gnu.org/software/stow/). Each top-level
directory is a stow package mirroring `$HOME`; `.stowrc` targets `~`, so the repo can live anywhere.

## Install

```sh
git clone https://github.com/julianmenav/dotfiles ~/Projects/dotfiles && cd ~/Projects/dotfiles
sudo pacman -S --needed $(grep -v '^#' packages/pacman.txt)
paru -S --needed $(sed 's/#.*//' packages/aur.txt)
git clone https://github.com/ohmyzsh/ohmyzsh ~/.oh-my-zsh
git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
curl -fsSL https://raw.githubusercontent.com/HyDE-Project/hyde-themes/Tokyo-Night/Source/Gtk_TokyoNight.tar.gz | tar xz -C ~/.local/share/themes
stow hyprland hyprlock hypridle hyprpaper waybar rofi dunst kitty gtk qt starship nvim zsh backgrounds
stow host-home   # or host-work
chsh -s /usr/bin/zsh
```

## Layout

| Package | What |
|---|---|
| `hyprland` | compositor config: binds, rules, look; sources `~/.config/hypr/local.conf` last |
| `hyprlock`, `hypridle`, `hyprpaper` | lock screen, idle, wallpaper (+ `Super+Shift+W` cycle script) |
| `waybar`, `rofi`, `dunst` | bar, launcher, notifications |
| `kitty`, `starship`, `zsh`, `nvim` | terminal and shell |
| `gtk`, `qt` | GTK settings, qt6ct/qt5ct with a matching palette |
| `backgrounds` | wallpapers, linked to `~/.config/backgrounds` |
| `host-home`, `host-work` | per-machine: monitors, GPU env, machine-only binds, `~/.zshrc.local` |

Stow exactly one `host-*` package. Everything else is identical on every machine; a difference
between machines goes into the host package, never into a shared file.

## Look

Tokyo Night, following the [HyDE](https://github.com/HyDE-Project/HyDE) theme of the same name:
waybar islands, rofi, dunst, kitty, hyprlock, borders and blur, GTK theme `Tokyo-Night`,
icons `Tela-circle-purple`, cursor `Bibata-Modern-Ice`. Colours are static, no theme engine.
