# Dotfiles

**English** · [Português (Brasil)](docs/README.pt-BR.md)

My development environment: Fish/Zsh, Neovim with LazyVim, tmux, and terminal
configs shared across Linux and macOS. Hyprland desktop configs live separately.

## Contents

### Shells and CLI tools

- [Fish + Tide](packages/common/fish/) — Single-line prompt, colors, aliases, fzf, zoxide, and Fisher plugin manifest
- [Zsh + Powerlevel10k](packages/common/zsh/) — Prompt, history, aliases, fzf, zoxide, autosuggestions, and syntax highlighting
- [btop](packages/common/btop/) — Resource monitor settings and a theme matching the palette
- [Yazi](themes/templates/common/yazi-theme.toml.tmpl) — Theme for the terminal file manager

### Editor

- [Neovim + LazyVim](packages/common/nvim/) — Options, keybindings, autocommands, and pinned plugin versions
- [Blink](packages/common/nvim/.config/nvim/lua/plugins/completion.lua) — Autocompletion, Tab navigation, and completion documentation
- [Diffview](packages/common/nvim/.config/nvim/lua/plugins/diffview.lua) — Git diffs and file history inside the editor

### Terminals and sessions

- [Ghostty](packages/common/ghostty/) — Fonts and fallbacks, colors, transparency, keybindings, and independent tmux sessions
- [Kitty](packages/common/kitty/) — Font, colors, transparency, tabs, and connection to the shared `main` tmux session
- [tmux](packages/common/tmux/) — Panes, keybindings, mouse support, Solarized status bar, popups, and Linux/macOS adaptations

### Fonts and appearance

- [Fontconfig](packages/linux/fontconfig/) — Linux font preferences: PlemolJP Console NF, BlexMono, and JetBrainsMono Nerd Font
- [GTK 3/4](packages/linux/gtk/) — GTK application appearance and CSS generated from the palette
- [Shared themes](themes/) — The `theme` command, renderer, and Carbonfox, Solarized Osaka, and Solarized Dark Patched palettes

### Hyprland desktop

- [Hyprland](packages/desktops/hyprland/compositor/.config/hypr/hyprland.lua) — Windows, keybindings, rules, environment, and loading of monitor settings
- [Waybar](themes/templates/hyprland/) — Bar modules and styling, with fullscreen auto-hide
- [Rofi](packages/desktops/hyprland/rofi/) — List launcher, application grid, and theme
- [Mako](themes/templates/hyprland/mako-config.tmpl) — Notification appearance and settings
- [nwg-dock](packages/desktops/hyprland/scripts/.scripts/dock) — Dock startup, styling, launcher icon, and service

### Session and automation

- [Hypridle](packages/desktops/hyprland/compositor/.config/hypr/hypridle.conf) — Session idle actions
- [Hyprlock](packages/desktops/hyprland/compositor/.config/hypr/hyprlock.conf) — Lock screen appearance and behavior
- [Hyprpaper / wallpaper](packages/desktops/hyprland/scripts/.scripts/wallpaper) — Image, monitor, and fit selection; generates local wallpaper settings
- [SDDM](themes/sddm/) — Login screen theme and system installation script
- [Services and environment](packages/desktops/hyprland/services/) — systemd units for the dock and fullscreen handling, plus script PATH setup
- [Desktop scripts](packages/desktops/hyprland/scripts/) — Audio, screenshots, session menu, shortcut lookup, files, and task manager

Generated configs are maintained through templates; the links above point to
the sources to edit. Monitor settings, selected wallpaper, caches, and downloaded
plugins stay outside Git. Fonts are installed separately.

## Profiles

- `cli` — Shells, editor, tmux, btop, and Yazi
- `macos` — CLI + Ghostty and Kitty
- `linux-desktop` — CLI + terminals, Fontconfig, and GTK
- `arch-hyprland` — Linux desktop + Hyprland, bar, dock, and scripts

Validated on this Arch setup. macOS and other Linux distributions still need testing on those systems.

## Installation

With Git, GNU Stow, and Python 3.11+ installed, clone into `~/.dotfiles`:

```sh
cd ~/.dotfiles
./install.sh --profile cli --dry-run
./install.sh --profile cli
```

Choose one of the profiles above. The installer creates symlinks and generates
themes; dependencies, plugins, and services have separate steps in the
[installation guide](docs/installation.md) (Portuguese).

## Repository layout

- `packages/common/`: shared configs, organized by application.
- `packages/linux/`: Linux integrations.
- `packages/desktops/hyprland/`: desktop and its services.
- `profiles/`: package selection for each environment.
- `bootstrap/`: Arch and macOS dependencies.
- `themes/`: palettes, templates, and renderer.
- `docs/`: usage and maintenance guides (Portuguese).

[Shells](docs/shell.md) · [Editor](docs/editor.md) ·
[Terminals and tmux](docs/terminal.md) · [Desktop](docs/desktop.md) ·
[Themes](docs/theming.md)
