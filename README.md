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

## Trocar de tema

    theme --list
    theme carbonfox

Renderiza todos os templates e recarrega waybar, mako, hyprland e o dock.
Ghostty e rofi releem sozinhos na proxima janela.

## Criar um tema novo

Copie `theme/palettes/carbonfox.toml`, mude os hexes, rode `theme <nome>`.
Nao edite os arquivos gerados (eles tem um cabecalho avisando) — edite o
template correspondente em `theme/templates/`.

## O que NAO esta versionado

`monitors.lua` e `workspaces.lua` sao gerados pelo nwg-displays e sao
especificos desta maquina (nomes de saida, posicao das telas).
