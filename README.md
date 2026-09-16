# Dotfiles

Meu ambiente de desenvolvimento: Fish/Zsh, Neovim com LazyVim, tmux e
terminais compartilhados entre Linux e macOS. Desktop Hyprland separado.

## Configurações incluídas

| Configuração | O que inclui | Local na repo |
|---|---|---|
| **Fish + Tide** | Prompt em uma linha, cores, aliases, fzf, zoxide e manifesto de plugins Fisher | [common/fish](packages/common/fish/) |
| **Zsh + Powerlevel10k** | Prompt, histórico, aliases, fzf, zoxide, autosuggestions e syntax highlighting | [common/zsh](packages/common/zsh/) |
| **Neovim + LazyVim** | Opções, atalhos, autocmds e versões dos plugins | [common/nvim](packages/common/nvim/) |
| **Blink** | Autocomplete do editor, navegação com Tab e documentação das sugestões | [completion.lua](packages/common/nvim/.config/nvim/lua/plugins/completion.lua) |
| **Diffview** | Comparação de alterações Git e histórico de arquivos no editor | [diffview.lua](packages/common/nvim/.config/nvim/lua/plugins/diffview.lua) |
| **tmux** | Painéis, atalhos, mouse, barra Solarized, popups e adaptações Linux/macOS | [common/tmux](packages/common/tmux/) |
| **Ghostty** | Fontes e fallbacks, cores, transparência, atalhos e sessão tmux independente | [common/ghostty](packages/common/ghostty/) |
| **Kitty** | Fonte, cores, transparência, abas e conexão à sessão tmux `main` | [common/kitty](packages/common/kitty/) |
| **btop** | Monitor de recursos e tema integrado à paleta | [common/btop](packages/common/btop/) |
| **Yazi** | Tema do gerenciador de arquivos no terminal | [Template Yazi](themes/templates/common/yazi-theme.toml.tmpl) |
| **Fontconfig** | Preferência de fontes: PlemolJP Console NF, BlexMono e JetBrainsMono Nerd Font no Linux | [linux/fontconfig](packages/linux/fontconfig/) |
| **GTK 3/4** | Aparência dos aplicativos GTK e CSS gerado pela paleta | [linux/gtk](packages/linux/gtk/) |
| **Hyprland** | Janelas, atalhos, regras, ambiente e carregamento das configurações de monitores | [hyprland.lua](packages/desktops/hyprland/compositor/.config/hypr/hyprland.lua) |
| **Hypridle** | Ações de inatividade da sessão | [hypridle.conf](packages/desktops/hyprland/compositor/.config/hypr/hypridle.conf) |
| **Hyprlock** | Aparência e comportamento da tela de bloqueio | [hyprlock.conf](packages/desktops/hyprland/compositor/.config/hypr/hyprlock.conf) |
| **Hyprpaper / wallpaper** | Seletor de imagem, monitor e ajuste; gera a configuração local do wallpaper | [wallpaper](packages/desktops/hyprland/scripts/.scripts/wallpaper) |
| **Waybar** | Módulos e estilo da barra, com ocultação em fullscreen | [Templates Hyprland](themes/templates/hyprland/) |
| **Rofi** | Launcher em lista, grade de aplicativos e tema | [hyprland/rofi](packages/desktops/hyprland/rofi/) |
| **Mako** | Aparência e opções das notificações | [Template Mako](themes/templates/hyprland/mako-config.tmpl) |
| **nwg-dock** | Inicialização, estilo, ícone do launcher e serviço do dock | [dock](packages/desktops/hyprland/scripts/.scripts/dock) · [Template CSS](themes/templates/hyprland/dock-style.css.tmpl) |
| **SDDM** | Tema da tela de login e script de instalação no sistema | [themes/sddm](themes/sddm/) · [Template QML](themes/templates/hyprland/sddm-main.qml.tmpl) |
| **Serviços e ambiente** | Unidades systemd do dock e fullscreen, além do PATH para scripts | [hyprland/services](packages/desktops/hyprland/services/) |
| **Scripts do desktop** | Áudio, screenshots, menu da sessão, consulta de atalhos, arquivos e gerenciador de tarefas | [hyprland/scripts](packages/desktops/hyprland/scripts/) |
| **Temas compartilhados** | Comando `theme`, renderizador e paletas Carbonfox, Solarized Osaka e Solarized Dark Patched | [themes](themes/) · [common/theme](packages/common/theme/) |

As configurações geradas são mantidas pelos templates; os links acima apontam
para a fonte que deve ser editada. Monitores, wallpaper selecionado, caches e
plugins baixados ficam fora do Git. As fontes são instaladas separadamente.

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
