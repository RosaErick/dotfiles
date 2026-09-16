# Dotfiles

[English](../README.md) · **Português (Brasil)**

Meu ambiente de desenvolvimento: Fish/Zsh, Neovim com LazyVim, tmux e
terminais compartilhados entre Linux e macOS. Desktop Hyprland separado.

## Conteúdo

### Shells e ferramentas CLI

- [Fish](https://fishshell.com/) + [Tide](https://github.com/IlanCosman/tide) — Prompt em uma linha, cores e Neovim como editor padrão
- [Zsh](https://www.zsh.org/) + [Powerlevel10k](https://github.com/romkatv/powerlevel10k) — Prompt personalizado com suporte a instant prompt
- [Fisher](https://github.com/jorgebucaran/fisher) — Gerenciador de plugins do Fish; Fisher, Tide e fzf.fish estão no [manifesto versionado](../packages/common/fish/.config/fish/fish_plugins)
- [Oh My Zsh](https://github.com/ohmyzsh/ohmyzsh) — Framework do Zsh com o plugin Git habilitado
- [fzf](https://github.com/junegunn/fzf) / [fzf.fish](https://github.com/PatrickF1/fzf.fish) — Busca interativa no histórico e em arquivos; no Zsh, inclui prévias de arquivos com bat e de diretórios com eza
- [zoxide](https://github.com/ajeetdsouza/zoxide) (`z` / `zi`) — Navegação por diretórios nos dois shells, com seleção interativa pelo `zi`
- [eza](https://github.com/eza-community/eza) — Aliases `ls`, `ll`, `la` e `lt` com ícones, status Git e visualização em árvore; o Fish também adiciona `tree`
- [bat](https://github.com/sharkdp/bat) — Substitui `cat` no Fish e mostra prévias de arquivos na integração fzf do Zsh
- [fd](https://github.com/sharkdp/fd) — Busca de arquivos usada pelo fzf, incluindo ocultos e excluindo `.git`
- [ghq](https://github.com/x-motemen/ghq) + [fzf](https://github.com/junegunn/fzf) — Comando `r` no Fish para selecionar e entrar em um repositório Git local
- [zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions) — Sugestões do histórico e das completions; `Ctrl+Espaço` aceita uma sugestão
- [zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting) — Destaque dos comandos durante a digitação
- [Histórico do Zsh](https://zsh.sourceforge.io/Doc/Release/Options.html#History) — Até 100 mil entradas, remoção de duplicatas e gravação incremental
- [mise](https://mise.jdx.dev/) — Ativação opcional no Zsh quando instalado; a instalação e as versões dos runtimes não são gerenciadas aqui
- **Ambiente dos shells** — Caminhos para scripts e binários locais; o Fish também adiciona `~/go/bin`
- [btop](https://github.com/aristocratos/btop) — Monitor de recursos e tema integrado à paleta
- [Yazi](https://github.com/sxyazi/yazi) — Tema do gerenciador de arquivos no terminal

As integrações ficam em [config.fish](../packages/common/fish/.config/fish/config.fish)
e [.zshrc](../packages/common/zsh/.zshrc). A instalação dos plugins está em
[install-plugins.sh](../scripts/install-plugins.sh); o código baixado dos plugins fica fora do Git.

### Editor

- [Neovim + LazyVim](../packages/common/nvim/) — Opções, atalhos, autocmds e versões dos plugins
- [Blink](../packages/common/nvim/.config/nvim/lua/plugins/completion.lua) — Autocomplete do editor, navegação com Tab e documentação das sugestões
- [Diffview](../packages/common/nvim/.config/nvim/lua/plugins/diffview.lua) — Comparação de alterações Git e histórico de arquivos no editor

### Terminais e sessões

- [Ghostty](../packages/common/ghostty/) — Fontes e fallbacks, cores, transparência, atalhos e sessão tmux independente
- [Kitty](../packages/common/kitty/) — Fonte, cores, transparência, abas e conexão à sessão tmux `main`
- [tmux](../packages/common/tmux/) — Painéis, atalhos, mouse, barra Solarized, popups e adaptações Linux/macOS

### Fontes e aparência

- [Fontconfig](../packages/linux/fontconfig/) — Preferência de fontes: PlemolJP Console NF, BlexMono e JetBrainsMono Nerd Font no Linux
- [GTK 3/4](../packages/linux/gtk/) — Aparência dos aplicativos GTK e CSS gerado pela paleta
- [Temas compartilhados](../themes/) — Comando `theme`, renderizador e paletas Carbonfox, Solarized Osaka e Solarized Dark Patched

### Desktop Hyprland

- [Hyprland](../packages/desktops/hyprland/compositor/.config/hypr/hyprland.lua) — Janelas, atalhos, regras, ambiente e carregamento das configurações de monitores
- [Waybar](../themes/templates/hyprland/) — Módulos e estilo da barra, com ocultação em fullscreen
- [Rofi](../packages/desktops/hyprland/rofi/) — Launcher em lista, grade de aplicativos e tema
- [Mako](../themes/templates/hyprland/mako-config.tmpl) — Aparência e opções das notificações
- [nwg-dock](../packages/desktops/hyprland/scripts/.scripts/dock) — Inicialização, estilo, ícone do launcher e serviço do dock

### Sessão e automação

- [Hypridle](../packages/desktops/hyprland/compositor/.config/hypr/hypridle.conf) — Ações de inatividade da sessão
- [Hyprlock](../packages/desktops/hyprland/compositor/.config/hypr/hyprlock.conf) — Aparência e comportamento da tela de bloqueio
- [Hyprpaper / wallpaper](../packages/desktops/hyprland/scripts/.scripts/wallpaper) — Seletor de imagem, monitor e ajuste; gera a configuração local do wallpaper
- [SDDM](../themes/sddm/) — Tema da tela de login e script de instalação no sistema
- [Serviços e ambiente](../packages/desktops/hyprland/services/) — Unidades systemd do dock e fullscreen, além do PATH para scripts
- [Scripts do desktop](../packages/desktops/hyprland/scripts/) — Áudio, screenshots, menu da sessão, consulta de atalhos, arquivos e gerenciador de tarefas

As configurações geradas são mantidas pelos templates; os links acima apontam
para a fonte que deve ser editada. Monitores, wallpaper selecionado, caches e
plugins baixados ficam fora do Git. As fontes são instaladas separadamente.

## Perfis

- `cli` — Shells, editor, tmux, btop e Yazi
- `macos` — CLI + Ghostty e Kitty
- `linux-desktop` — CLI + terminais, Fontconfig e GTK
- `arch-hyprland` — Linux desktop + Hyprland, barra, dock e scripts

Validado neste Arch. macOS e outros Linux ainda precisam de teste real.

## Instalação

Com Git, GNU Stow e Python 3.11+ instalados, clone em `~/.dotfiles`:

```sh
cd ~/.dotfiles
./install.sh --profile cli --dry-run
./install.sh --profile cli
```

Escolha um dos perfis acima. O instalador cria links e gera os temas;
dependências, plugins e serviços têm etapas próprias em [Instalação](../docs/installation.md).

## Organização

- `packages/common/`: configurações compartilhadas, por aplicativo.
- `packages/linux/`: integrações Linux.
- `packages/desktops/hyprland/`: desktop e seus serviços.
- `profiles/`: seleção de pacotes por ambiente.
- `bootstrap/`: dependências do Arch e macOS.
- `themes/`: paletas, templates e renderizador.
- `docs/`: uso e manutenção.

[Shells](../docs/shell.md) · [Editor](../docs/editor.md) ·
[Terminais e tmux](../docs/terminal.md) · [Desktop](../docs/desktop.md) ·
[Temas](../docs/theming.md)
