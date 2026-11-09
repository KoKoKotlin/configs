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
| `hypr/`              | `~/.config/hypr/`                     |
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
