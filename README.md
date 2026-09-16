# Dotfiles

Meu ambiente de desenvolvimento: Fish/Zsh, Neovim com LazyVim, tmux e
terminais compartilhados entre Linux e macOS. Desktop Hyprland separado.

## Configurações incluídas

### Shells e ferramentas CLI

| Configuração | O que inclui |
|---|---|
| [Fish + Tide](packages/common/fish/) | Prompt em uma linha, cores, aliases, fzf, zoxide e manifesto de plugins Fisher |
| [Zsh + Powerlevel10k](packages/common/zsh/) | Prompt, histórico, aliases, fzf, zoxide, autosuggestions e syntax highlighting |
| [btop](packages/common/btop/) | Monitor de recursos e tema integrado à paleta |
| [Yazi](themes/templates/common/yazi-theme.toml.tmpl) | Tema do gerenciador de arquivos no terminal |

### Editor

| Configuração | O que inclui |
|---|---|
| [Neovim + LazyVim](packages/common/nvim/) | Opções, atalhos, autocmds e versões dos plugins |
| [Blink](packages/common/nvim/.config/nvim/lua/plugins/completion.lua) | Autocomplete do editor, navegação com Tab e documentação das sugestões |
| [Diffview](packages/common/nvim/.config/nvim/lua/plugins/diffview.lua) | Comparação de alterações Git e histórico de arquivos no editor |

### Terminais e sessões

| Configuração | O que inclui |
|---|---|
| [Ghostty](packages/common/ghostty/) | Fontes e fallbacks, cores, transparência, atalhos e sessão tmux independente |
| [Kitty](packages/common/kitty/) | Fonte, cores, transparência, abas e conexão à sessão tmux `main` |
| [tmux](packages/common/tmux/) | Painéis, atalhos, mouse, barra Solarized, popups e adaptações Linux/macOS |

### Fontes e aparência

| Configuração | O que inclui |
|---|---|
| [Fontconfig](packages/linux/fontconfig/) | Preferência de fontes: PlemolJP Console NF, BlexMono e JetBrainsMono Nerd Font no Linux |
| [GTK 3/4](packages/linux/gtk/) | Aparência dos aplicativos GTK e CSS gerado pela paleta |
| [Temas compartilhados](themes/) | Comando `theme`, renderizador e paletas Carbonfox, Solarized Osaka e Solarized Dark Patched |

### Desktop Hyprland

| Configuração | O que inclui |
|---|---|
| [Hyprland](packages/desktops/hyprland/compositor/.config/hypr/hyprland.lua) | Janelas, atalhos, regras, ambiente e carregamento das configurações de monitores |
| [Waybar](themes/templates/hyprland/) | Módulos e estilo da barra, com ocultação em fullscreen |
| [Rofi](packages/desktops/hyprland/rofi/) | Launcher em lista, grade de aplicativos e tema |
| [Mako](themes/templates/hyprland/mako-config.tmpl) | Aparência e opções das notificações |
| [nwg-dock](packages/desktops/hyprland/scripts/.scripts/dock) | Inicialização, estilo, ícone do launcher e serviço do dock |

### Sessão e automação

| Configuração | O que inclui |
|---|---|
| [Hypridle](packages/desktops/hyprland/compositor/.config/hypr/hypridle.conf) | Ações de inatividade da sessão |
| [Hyprlock](packages/desktops/hyprland/compositor/.config/hypr/hyprlock.conf) | Aparência e comportamento da tela de bloqueio |
| [Hyprpaper / wallpaper](packages/desktops/hyprland/scripts/.scripts/wallpaper) | Seletor de imagem, monitor e ajuste; gera a configuração local do wallpaper |
| [SDDM](themes/sddm/) | Tema da tela de login e script de instalação no sistema |
| [Serviços e ambiente](packages/desktops/hyprland/services/) | Unidades systemd do dock e fullscreen, além do PATH para scripts |
| [Scripts do desktop](packages/desktops/hyprland/scripts/) | Áudio, screenshots, menu da sessão, consulta de atalhos, arquivos e gerenciador de tarefas |

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
