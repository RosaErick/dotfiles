# dotfiles

Arch Linux + Hyprland.

## Estrutura

    theme/palettes/*.toml    paletas (uma por tema)
    theme/templates/*.tmpl   templates, usam {{chave}} da paleta
    theme/render.py          motor: paleta + templates -> configs
    <pacote>/.config/...     pacotes stow, viram symlink em ~

## Instalar numa maquina nova

    git clone <repo> ~/.dotfiles
    cd ~/.dotfiles
    stow -t ~ waybar rofi mako ghostty hypr nwg-dock gtk bin
    theme carbonfox

Pacotes que o yazi usa para preview (nenhum e obrigatorio):

    ffmpeg       video
    poppler      PDF          (+ poppler-data para encodings especiais)
    resvg        SVG          <- NAO e o imagemagick
    imagemagick  HEIC, PSD
    fd fzf zoxide 7zip jq     busca, arquivos compactados, JSON

## Trocar de tema

    theme --list
    theme carbonfox

Pacotes que o yazi usa para preview (nenhum e obrigatorio):

    ffmpeg       video
    poppler      PDF          (+ poppler-data para encodings especiais)
    resvg        SVG          <- NAO e o imagemagick
    imagemagick  HEIC, PSD
    fd fzf zoxide 7zip jq     busca, arquivos compactados, JSON

Renderiza todos os templates e recarrega waybar, mako, hyprland e o dock.
Ghostty e rofi releem sozinhos na proxima janela.

## Criar um tema novo

Copie `theme/palettes/carbonfox.toml`, mude os hexes, rode `theme <nome>`.
Nao edite os arquivos gerados (eles tem um cabecalho avisando) — edite o
template correspondente em `theme/templates/`.

## O que NAO esta versionado

`monitors.lua` e `workspaces.lua` sao gerados pelo nwg-displays e sao
especificos desta maquina (nomes de saida, posicao das telas).

## sudo sem terminal

`SUDO_ASKPASS` aponta pra `bin/.local/bin/rofi-askpass`, entao:

    sudo -A pacman -S <pacote>

abre um prompt de senha em rofi em vez de exigir tty. Util quando o comando
parte de um lancador, script ou agente sem terminal interativo.

## Tela de atalhos

`SUPER + /` abre uma lista pesquisavel de todos os keybinds.

Ela e gerada lendo `hypr/.config/hypr/hyprland.lua` na hora, entao nunca
desatualiza. A descricao de cada atalho vem do comentario no fim da linha:

    hl.bind(mainMod .. " + Q", hl.dsp.exec_cmd(terminal))  -- abrir terminal

Adicionou um bind? Comente ele e a tela ja mostra.
Conferir sem abrir janela: `cheatsheet --print`.

## Waybar

Desenho proprio, misturando duas referencias:

  space_dots (vdawg-git)           barra transparente flutuante; areas em
                                   numerais CJK; CPU como grafico de blocos
  summer-day-and-night (MathisP75) efeito 3D de tecla: borda inferior numa
                                   versao escura da cor do modulo; a area
                                   ativa AFUNDA (perde a borda e desce)

As sombras nao sao escritas a mao: o render.py deriva `_dark` (50%) e `_dim`
(75%) de cada cor da paleta. Paleta nova ganha sombras corretas de graca.

## fish

Instalado ao lado do zsh — o shell de login continua sendo o zsh.
Para experimentar: rode `fish` num terminal. Para adotar de vez:

    chsh -s /usr/bin/fish

Plugins ficam em `fish/.config/fish/fish_plugins` (versionado). Numa maquina
nova: `fisher update` reinstala todos.

    tide          prompt (equivale ao powerlevel10k do zsh)
    fzf.fish      Ctrl+R historico, Ctrl+Alt+F arquivos, Ctrl+Alt+L git log
    zoxide        o "z": aprende os diretorios que voce usa; `zi` escolhe no fzf
    eza           ls com icones — substitui o Terminal-Icons do PowerShell
    r             funcao propria: pula pra qualquer repo do ghq via fzf

Nota: `--icons` sozinho no eza cai em "auto"; use `--icons=always`.
