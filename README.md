# dotfiles

Managed with [GNU stow](https://www.gnu.org/software/stow/). Every top-level directory is a
stow package that mirrors `$HOME`. The `.stowrc` sets `--target=~`, so the repo can live anywhere
(here `~/Projects/dotfiles`) and `stow` always links into your home.

## Layout

- Shared packages (identical on every machine): `hyprland`, `hyprlock`, `hypridle`, `hyprpaper`,
  `waybar`, `rofi`, `dunst`, `kitty`, `gtk`, `qt`, `starship`, `nvim`, `zsh`, `backgrounds`.
- Host packages (stow **exactly one**): `host-home` (desktop, NVIDIA), `host-work` (laptop).
  They provide the files the shared configs include at the end:
  - `~/.config/hypr/local.conf` — monitors, GPU env vars, machine-only binds (Slack at work)
  - `~/.zshrc.local` — work tools, aliases, PATHs

## Install

```sh
git clone https://github.com/julianmenav/dotfiles ~/Projects/dotfiles && cd ~/Projects/dotfiles
./install.sh --check home    # or work: shows missing packages / stow conflicts, changes nothing
./install.sh home            # installs packages (pacman + AUR), oh-my-zsh, GTK theme, then stows
chsh -s /usr/bin/zsh         # once
```

Package lists live in `packages/pacman.txt` (official repos) and `packages/aur.txt`. Re-run
`./install.sh <host>` after a pull when something new was added; it only installs what is missing.
Switch profile: `stow -D host-work && stow host-home`. Reload Hyprland with `hyprctl reload`.

## Adding a per-machine difference

Put it in the host package, not in the shared file. Hyprland's `local.conf` is additive: it can
add binds, override env vars, or `unbind` a shared bind. `~/.zshrc.local` is a normal zsh file.

## Look: HyDE "Tokyo Night", ported

The visual style is a static port of the [HyDE](https://github.com/HyDE-Project/HyDE) Tokyo Night
theme: waybar islands, rofi launcher (HyDE style 6), dunst, kitty, hyprlock, Hyprland borders/blur,
GTK/Qt/icon/cursor settings. No HyDE scripts or wallbash; colours are hardcoded in each config.

Extra pieces that are not dotfiles:

```sh
./scripts/theme-assets.sh   # GTK theme tarball -> ~/.local/share/themes, prints the package list
sudo pacman -S --needed rofi rofi-emoji dunst qt6ct qt5ct tela-circle-icon-theme-purple
paru -S bibata-cursor-theme
```

Programs replaced by the port: wofi -> rofi (`$menu`, Super+R), wofi-emoji -> rofi-emoji (Super+.),
mako -> dunst. Keybindings are unchanged.
