# dotfiles

Managed with [GNU stow](https://www.gnu.org/software/stow/). Every top-level directory is a
stow package that mirrors `$HOME`. The `.stowrc` sets `--target=~`, so the repo can live anywhere
(here `~/Projects/dotfiles`) and `stow` always links into your home.

## Layout

- Shared packages (identical on every machine): `hyprland`, `hyprlock`, `hypridle`, `hyprpaper`,
  `waybar`, `wofi`, `mako`, `kitty`, `starship`, `nvim`, `zsh`, `backgrounds`.
- Host packages (stow **exactly one**): `host-home` (desktop, NVIDIA), `host-work` (laptop).
  They provide the files the shared configs include at the end:
  - `~/.config/hypr/local.conf` — monitors, GPU env vars, machine-only binds (Slack at work)
  - `~/.zshrc.local` — work tools, aliases, PATHs

## Install

```sh
git clone <this repo> ~/Projects/dotfiles && cd ~/Projects/dotfiles
stow hyprland hyprlock hypridle hyprpaper waybar wofi mako kitty starship nvim zsh backgrounds
stow host-home   # or: stow host-work
```

Switch profile: `stow -D host-work && stow host-home`. Reload Hyprland with `hyprctl reload`.

## Adding a per-machine difference

Put it in the host package, not in the shared file. Hyprland's `local.conf` is additive: it can
add binds, override env vars, or `unbind` a shared bind. `~/.zshrc.local` is a normal zsh file.
