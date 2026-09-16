# Dotfiles

Meu ambiente de desenvolvimento: Fish/Zsh, Neovim com LazyVim, tmux e
terminais compartilhados entre Linux e macOS. Desktop Hyprland separado.

## Perfis

| Perfil | Inclui |
|---|---|
| `cli` | Shells, editor, tmux, btop e Yazi |
| `macos` | CLI + Ghostty e Kitty |
| `linux-desktop` | CLI + terminais, Fontconfig e GTK |
| `arch-hyprland` | Linux desktop + Hyprland, barra, dock e scripts |

Validado neste Arch. macOS e outros Linux ainda precisam de teste real.

## Instalação

Com Git, GNU Stow e Python 3.11+ instalados, clone em `~/.dotfiles`:

```sh
cd ~/.dotfiles
./install.sh --profile cli --dry-run
./install.sh --profile cli
```

Escolha o perfil da tabela. O instalador cria links e gera os temas;
dependências, plugins e serviços têm etapas próprias em [Instalação](docs/installation.md).

## Organização

- `packages/common/`: configurações compartilhadas, por aplicativo.
- `packages/linux/`: integrações Linux.
- `packages/desktops/hyprland/`: desktop e seus serviços.
- `profiles/`: seleção de pacotes por ambiente.
- `bootstrap/`: dependências do Arch e macOS.
- `themes/`: paletas, templates e renderizador.
- `docs/`: uso e manutenção.

[Shells](docs/shell.md) · [Editor](docs/editor.md) ·
[Terminais e tmux](docs/terminal.md) · [Desktop](docs/desktop.md) ·
[Temas](docs/theming.md)
