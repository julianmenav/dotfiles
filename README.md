# dotfiles

Hyprland desktop, managed with [GNU Stow](https://www.gnu.org/software/stow/). Each top-level
directory is a stow package mirroring `$HOME`; `.stowrc` targets `~`, so the repo can live anywhere.

## Install

```sh
git clone https://github.com/julianmenav/dotfiles ~/Projects/dotfiles && cd ~/Projects/dotfiles
sudo pacman -S --needed $(grep -v '^#' packages/pacman.txt)
paru -S --needed $(sed 's/#.*//' packages/aur.txt)
stow hyprland hyprlock hypridle hyprpaper waybar rofi dunst kitty gtk qt starship nvim zsh backgrounds
stow host-home   # or host-work
chsh -s /usr/bin/zsh
```

Oh My Zsh and its plugins are cloned automatically the first time zsh starts. Log out and pick the
Hyprland session.

## Update

```sh
git pull
sudo pacman -S --needed $(grep -v '^#' packages/pacman.txt)      # anything new
stow -R hyprland hyprlock hypridle hyprpaper waybar rofi dunst kitty gtk qt starship nvim zsh backgrounds host-home
find ~ ~/.config -maxdepth 2 -xtype l -delete                     # links to packages that no longer exist
hyprctl reload
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

Wallpaper: waneella's *Lull* looping through mpvpaper, hyprpaper underneath as the still fallback.
The video lives outside the repo; the fetch commands are next to the `exec-once` in `hyprland.conf`.
