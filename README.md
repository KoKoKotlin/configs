# Configs
This repository contains my config files for the programs that I run on linux.

| File / folder        | Goes to                               |
|----------------------|---------------------------------------|
| `.zshrc`, `.zshenv`  | `~/`                                  |
| `.emacs`             | `~/`                                  |
| `alacritty.toml`     | `~/.config/alacritty/`                |
| `helix/config.toml`  | `~/.config/helix/`                    |
| `init.lua`           | `~/.config/nvim/`                     |
| `init.vim`           | `~/.vimrc` (vim) — older vim-plug variant |
| `hypr/`              | `~/.config/hypr/` (hyprland, hyprpaper, hypridle, hyprlock) |
| `waybar/`, `mako/`   | `~/.config/waybar/`, `~/.config/mako/` |
| `dwm/`, `slstatus/`  | build with `sudo make clean install`  |
| `autostart.sh`       | dwm (X11) session autostart           |
| `download-*`, `to-mp3`, `duplex-print.sh` | `~/.local/bin/`  |

## Dependencies

- **zsh:** `eza vivid zsh-syntax-highlighting zsh-autosuggestions`;
  optional `fzf zoxide bat fd-find starship`
- **alacritty:** CaskaydiaCove Nerd Font and the theme collection:
  `git clone https://github.com/alacritty/alacritty-theme ~/.config/alacritty/themes`
- **scripts:** `yt-dlp`, `ffmpeg`, CUPS (`lp`) for duplex printing

## Arch Linux + Hyprland

```sh
sudo pacman -S --needed hyprland hyprpaper hypridle hyprlock hyprpolkitagent \
    xdg-desktop-portal-hyprland xdg-desktop-portal-gtk qt6-wayland qt6ct \
    waybar mako fuzzel cliphist wl-clipboard hyprshot brightnessctl playerctl \
    pipewire wireplumber pipewire-pulse pavucontrol network-manager-applet \
    alacritty nautilus ttf-jetbrains-mono-nerd ttf-cascadia-code-nerd
# NVIDIA (RTX 20xx and newer):
sudo pacman -S --needed nvidia-open nvidia-utils
```

Start the session with `start-hyprland` (or `uwsm start hyprland.desktop`),
then check `hyprctl configerrors` and `hyprctl monitors` (adjust the
monitor names in `hypr/hyprland.conf`). Create `~/Pictures/Screenshots`
for SUPER+SHIFT+P.
