# dotfiles

Arch Linux + Hyprland. Desktop apps share one palette; tmux uses craftzdog's Solarized layout.

## What's in here

| | |
|---|---|
| **Compositor** | [Hyprland](https://github.com/hyprwm/Hyprland) (Lua config) |
| **Bar** | [Waybar](https://github.com/Alexays/Waybar), custom design |
| **Launcher** | [Rofi](https://github.com/davatorium/rofi), list + app grid |
| **Terminal** | [Ghostty](https://github.com/ghostty-org/ghostty) (primary), [Kitty](https://github.com/kovidgoyal/kitty) |
| **Multiplexer** | [tmux](https://github.com/tmux/tmux), both terminals open into it |
| **Font** | [PlemolJP Console NF](https://github.com/yuru7/PlemolJP), then BlexMono Nerd Font, then JetBrainsMono Nerd Font |
| **Shell** | [Zsh](https://github.com/zsh-users/zsh) + Powerlevel10k · [Fish](https://github.com/fish-shell/fish-shell) + Tide |
| **Files** | Yazi (`SUPER+E`), [Nautilus](https://gitlab.gnome.org/GNOME/nautilus) (`SUPER+SHIFT+E`) |
| **Editor** | [Neovim](https://github.com/neovim/neovim) + [LazyVim](https://github.com/LazyVim/LazyVim) |
| **Notifications** | [Mako](https://github.com/emersion/mako) |
| **Lock / idle** | [Hyprlock](https://github.com/hyprwm/hyprlock) + [Hypridle](https://github.com/hyprwm/hypridle) |
| **Wallpaper** | [Hyprpaper](https://github.com/hyprwm/hyprpaper) |
| **Dock** | [nwg-dock](https://github.com/nwg-piotr/nwg-dock-hyprland), auto-hide |
| **Monitors** | [nwg-displays](https://github.com/nwg-piotr/nwg-displays) (GUI) |

## Layout

```
.config/     mirrors ~/.config, one folder per app
.scripts/    executables, symlinked to ~/.scripts (on PATH)
.config/environment.d/  puts ~/.scripts on PATH for systemd user services
theme/       palettes + templates + the render engine
.zshrc       these two live in $HOME
.p10k.zsh
```

## Shell Setup

Zsh is the login shell; fish is installed alongside (`fish` to enter it).

**Zsh**

- [oh-my-zsh](https://github.com/ohmyzsh/ohmyzsh): framework
- [powerlevel10k](https://github.com/romkatv/powerlevel10k): prompt
- [zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions): ghost-text completion from history
- [zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting): colors commands as you type

**Fish**

- [fisher](https://github.com/jorgebucaran/fisher): plugin manager
- [tide](https://github.com/IlanCosman/tide): prompt
- [fzf.fish](https://github.com/PatrickF1/fzf.fish): fuzzy search keybindings

The complete Tide prompt (layout, colors, icons and item options) lives in
`.config/fish/conf.d/tide.fish`. Fish loads it automatically, including the
background shells Tide uses to draw the prompt. Edit this file to change the
versioned appearance; `fish_variables`, runtime caches and Fisher's installed
plugin files stay local.

The prompt uses craftzdog's [Tide colors](https://github.com/craftzdog/dotfiles/blob/bf2867469b8b7f0260e974a47297a7df61d53052/.config/fish/conf.d/tide.fish).
Its two-line layout is reconstructed from the repository's
[terminal screenshot](https://github.com/craftzdog/dotfiles/blob/bf2867469b8b7f0260e974a47297a7df61d53052/images/screenshot-1.png):
directory and Git on the left, status and time on the right, a left frame,
rounded outer ends and slanted internal separators. Upstream does not publish
the complete `tide configure` choices, so those choices are explicit locally.

On a fresh machine, install the plugins listed in `fish_plugins`:

```sh
fish -c 'fisher update'
```

After editing the prompt file, open a new fish shell, or run in fish:

```fish
source ~/.config/fish/conf.d/tide.fish
tide reload
```

**Terminal fonts**

Ghostty uses this fallback order: `PlemolJP Console NF`, `BlexMono Nerd Font`,
`JetBrainsMono Nerd Font`. Kitty uses the same primary font and the Fontconfig
rules in `.config/fontconfig/conf.d/50-terminal-fonts.conf` for fallbacks;
these rules also set the user's generic `monospace` preference.

Install the Nerd Font release [PlemolJP NF v3.1.0](https://github.com/yuru7/PlemolJP/releases/tag/v3.1.0):
extract the TTF files in `PlemolJPConsole_NF` into
`~/.local/share/fonts/PlemolJPConsoleNF/`, then run `fc-cache -f`.
The archive is `PlemolJP_NF_v3.1.0.zip`; its SHA-256 is
`015142b7ce4fb497ea6eb14567c435b69450eb5028fb7d29c032d1ffb3854abb`.
Font binaries stay outside the dotfiles repository. The package list below
installs BlexMono and JetBrainsMono. Reload Ghostty with `Ctrl+Shift+R` after
changing its configuration; restart Kitty to pick up Fontconfig changes.

**Shared CLI**

- [eza](https://github.com/eza-community/eza): ls replacement
- [bat](https://github.com/sharkdp/bat): cat replacement
- [fd](https://github.com/sharkdp/fd): find replacement
- [ripgrep](https://github.com/BurntSushi/ripgrep): grep replacement
- [fzf](https://github.com/junegunn/fzf): fuzzy finder
- [zoxide](https://github.com/ajeetdsouza/zoxide): cd that learns
- [ghq](https://github.com/x-motemen/ghq): repository manager
- [lazygit](https://github.com/jesseduffield/lazygit): git TUI
- [yazi](https://github.com/sxyazi/yazi): file manager
- [btop](https://github.com/aristocratos/btop): resource monitor

## Scripts

`.scripts/` sits on `PATH` in three places, because three different things
launch them: both shells (`.zshrc`, `config.fish`), Hyprland (via an absolute
path in `hyprland.lua`), and systemd user services (`environment.d`).
Miss any one and the buttons that call a script fail silently.

| | |
|---|---|
| `theme` | render palette across all apps |
| `wallpaper` | thumbnail picker for image, monitor, fit mode |
| `cheatsheet` | keybinding overlay, parsed from the Hyprland config |
| `powermenu` | lock / suspend / logout / reboot / shutdown |
| `audio-device` | pick output/input, moves live streams too |
| `taskmanager` · `files` · `dock` | thin wrappers, swap the app in one line |
| `sddm-install` | install the generated login theme (needs root) |

## Theming

One palette drives everything:

```sh
theme carbonfox     # render every template and reload
theme --list        # available palettes
```

`theme/palettes/*.toml` holds the colors. `theme/render.py` fills the
templates and reloads the running apps.

Desktop targets stay in sync: Waybar (config + CSS), Rofi (list + grid),
Mako, Ghostty, Kitty, GTK 3/4, btop, Yazi, the dock (CSS + launcher
icon), SDDM, and Hyprland's window borders.

tmux keeps the fixed Solarized theme from craftzdog; `theme` does not render
or reload its configuration.

The dock's Applications icon uses `accent` from the active palette, with
an `accent_dark` shadow. `theme/templates/dock-launcher.svg.tmpl` generates
`theme/dock/launcher.svg`, which `.scripts/dock` loads with `-ico`.

**New theme** = copy a palette, change the hex values, run `theme <name>`.
Never edit generated files. They carry a header pointing at their template.

Derived values are computed, not hand-picked: every color gets `_dark` (50%)
and `_dim` (75%) variants, plus `_raw` (`r,g,b`) and `_hex` forms. The bar's
3D shadows and the dock's launcher shadow come from those. Hyprland's active
border is a single flat color (`yellow`), not a gradient.

## Install

```sh
sudo pacman -S --needed hyprland hyprpaper hyprlock hypridle hyprpolkitagent \
  waybar rofi mako ghostty kitty yazi btop nautilus nwg-dock-hyprland \
  nwg-displays nwg-look grim slurp hyprshot wl-clipboard sddm \
  zsh zsh-autosuggestions zsh-syntax-highlighting fish fisher tmux git \
  eza bat fd ripgrep fzf zoxide ghq lazygit neovim stow \
  papirus-icon-theme adw-gtk-theme ttf-ibmplex-mono-nerd ttf-jetbrains-mono-nerd \
  pavucontrol networkmanager brightnessctl playerctl xdg-user-dirs \
  resvg poppler poppler-data imagemagick ffmpeg

git clone <repo> ~/.dotfiles && cd ~/.dotfiles
./install.sh
```

`install.sh` installs TPM and tmux-pain-control if missing, renders the theme,
creates the wallpaper folder and enables the user services. Log out and back
in so `environment.d` applies.

## Keybindings

`SUPER + /` opens a searchable cheat sheet, generated by reading
`hyprland.lua`, so it can't go stale. The full list lives there; below is
just enough to get in.

| Key | |
|---|---|
| `SUPER + /` | Cheat sheet |
| `SUPER + Q` | Terminal |
| `SUPER + R` | Launcher |
| `CTRL+ALT+DEL` | Session menu |

### tmux

Ghostty creates an independent tmux session for every new window or tab.
Kitty still attaches to the shared `main` session. Both fall back to zsh if
tmux is missing.

The prefix is **Ctrl+T**: press it, release it, then press the next key.
The status bar shows session/window/pane, username, each window's directory
and hostname. Window/pane numbering starts at 0 in a fresh server. Mouse
support follows the upstream default (off).

| Key | |
|---|---|
| `C-t c` | New window in the current directory |
| `C-t \|` / `C-t -` | Split right / down, inheriting the current directory |
| `C-t h/j/k/l` | Move between panes |
| `C-t H/J/K/L` | Resize panes |
| `C-t z` | Zoom pane |
| `C-t n/p/w` | Next / previous window / window list |
| `C-t r` | Reload tmux configuration |
| `C-t g` | Lazygit popup |
| `C-t y` | Claude Code popup in a separate session |
| `C-t o` | Open the current directory in the file manager |
| `C-t e` | Close all other panes in the current window |

Plugins live outside Git in `~/.config/tmux/plugins/`. TPM manages
`tmux-pain-control`; use `C-t I` to install missing plugins and `C-t U` to
update them. Run `./install.sh` to provision both on a fresh clone.

## Notes

- This is a personal setup and a work in progress. It's shaped around my
  machine and my habits, and it changes often. Read it, fork it, take what's
  useful. Use it at your own risk.
- Monitor layout (`monitors.lua`, `workspaces.lua`) is generated by
  nwg-displays and gitignored, because it's machine-specific.
- Fish is installed but zsh stays the login shell. Run `fish` to try it.
- Both shells have autosuggestions and syntax highlighting.
- No hardcoded home paths: configs use `$HOME` (hyprlang), `os.getenv("HOME")`
  (Lua), or theme-by-name (btop). Clone and it works under any username.
