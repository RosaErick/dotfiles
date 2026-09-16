# Terminals and tmux

Configurations live in `packages/common/{ghostty,kitty,tmux}/`.
Ghostty opens an independent tmux session per window/tab. Kitty connects to
the shared `main` session. Both use Zsh if tmux is not installed.

## Fonts

Preference: **PlemolJP Console NF → BlexMono Nerd Font → JetBrainsMono Nerd Font**.
Ghostty declares this order directly. Kitty uses PlemolJP as its primary font;
on Linux, `packages/linux/fontconfig/` configures fallbacks.
The equivalent Kitty fallback on macOS still needs validation.

Install [PlemolJP NF v3.1.0](https://github.com/yuru7/PlemolJP/releases/tag/v3.1.0).
Extract the TTFs from `PlemolJPConsole_NF` in the `PlemolJP_NF_v3.1.0.zip` archive:

- Linux: `~/.local/share/fonts/PlemolJPConsoleNF/`, then `fc-cache -f`.
- macOS: install through Font Book or in `~/Library/Fonts/`.

Archive SHA-256: `015142b7ce4fb497ea6eb14567c435b69450eb5028fb7d29c032d1ffb3854abb`.
Also install both fallback fonts; the Arch bootstrap already includes them.
Font binaries stay outside Git.

## tmux

Prefix: **Ctrl+T**, release it, then press the next key.

| Key after the prefix | Action |
|---|---|
| `c` | New window |
| `\|` / `-` | Split right / down |
| `h/j/k/l` | Switch panes |
| `H/J/K/L` | Resize |
| `z` | Zoom/restore pane |
| `n/p/w` | Next/previous/window list |
| `r` | Reload configuration |
| `g` | Lazygit |
| `y` | Claude Code popup; requires the CLI to be installed |
| `o` | Open directory in the file manager |
| `e` | Close the other panes |
| `[` | Browse history with the keyboard; `q` exits |

Mouse enabled: the wheel scrolls shell history. In applications such as
Neovim, scrolling is handled by the application. `q` exits copy mode.

The fixed Solarized theme and layout are based on
[craftzdog/dotfiles](https://github.com/craftzdog/dotfiles).
`platform/` adapts directory opening to `open` or `xdg-open`.
TPM plugins live in `~/.config/tmux/plugins/`, outside Git; `Ctrl+T I`
installs them and `Ctrl+T U` updates them.
