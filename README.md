# Dotfiles

**English** · [Português (Brasil)](docs/README.pt-BR.md)

My development environment: Fish/Zsh, Neovim with LazyVim, tmux, and terminal
configs shared across Linux and macOS. Hyprland desktop configs live separately.

## Contents

### Shells and CLI tools

- [Fish](https://fishshell.com/) + [Tide](https://github.com/IlanCosman/tide) — Single-line prompt, colors, and Neovim as the default editor
- [Zsh](https://www.zsh.org/) + [Powerlevel10k](https://github.com/romkatv/powerlevel10k) — Customized prompt with instant prompt support
- [Fisher](https://github.com/jorgebucaran/fisher) — Fish plugin manager; Fisher, Tide, and fzf.fish are listed in the versioned [plugin manifest](packages/common/fish/.config/fish/fish_plugins)
- [Oh My Zsh](https://github.com/ohmyzsh/ohmyzsh) — Zsh framework with the Git plugin enabled
- [fzf](https://github.com/junegunn/fzf) / [fzf.fish](https://github.com/PatrickF1/fzf.fish) — Interactive search for history and files; Zsh also configures file previews with bat and directory previews with eza
- [zoxide](https://github.com/ajeetdsouza/zoxide) (`z` / `zi`) — Directory jumping in both shells, with interactive selection through `zi`
- [eza](https://github.com/eza-community/eza) — `ls`, `ll`, `la`, and `lt` aliases with icons, Git status, and tree views; Fish also adds `tree`
- [bat](https://github.com/sharkdp/bat) — `cat` replacement in Fish and file previews in Zsh's fzf integration
- [fd](https://github.com/sharkdp/fd) — File search backend for fzf, including hidden files and excluding `.git`
- [ghq](https://github.com/x-motemen/ghq) + [fzf](https://github.com/junegunn/fzf) — Fish's `r` command selects a local Git repository and changes into it
- [zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions) — Suggestions from history and completions; `Ctrl+Space` accepts a suggestion
- [zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting) — Highlights commands as you type
- [Zsh history](https://zsh.sourceforge.io/Doc/Release/Options.html#History) — Up to 100,000 entries, duplicate removal, and incremental saving
- [Yazi](https://github.com/sxyazi/yazi) — Theme for the terminal file manager

Shell integrations live in [config.fish](packages/common/fish/.config/fish/config.fish)
and [.zshrc](packages/common/zsh/.zshrc). Plugin installation is defined in
[install-plugins.sh](scripts/install-plugins.sh); downloaded plugin code stays outside Git.

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
