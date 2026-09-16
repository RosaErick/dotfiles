# Desktop Hyprland

`packages/desktops/hyprland/` agrupa compositor, Waybar, Rofi, Mako, dock,
scripts e serviços. É uma configuração de desktop Linux; os pacotes de
instalação do Arch ficam separados em `bootstrap/arch/`.

| Atalho | Ação |
|---|---|
| `Super + /` | Busca de atalhos, lidos do `hyprland.lua` |
| `Super + Q` | Terminal |
| `Super + R` | Launcher |
| `Super + E` | Yazi |
| `Super + Shift + E` | Nautilus |
| `Ctrl + Alt + Delete` | Menu da sessão |

## Scripts

Instalados em `~/.scripts/`, acessível pelos shells, Hyprland e serviços:

- `wallpaper`: escolher imagem, monitor e ajuste.
- `cheatsheet`: consultar atalhos.
- `audio-device`: escolher entrada/saída de áudio.
- `powermenu`, `screenshot`: sessão e captura de tela.
- `files`, `taskmanager`, `dock`: iniciar aplicativos do desktop.
- `waybar-fullscreen`: ocultar a barra em fullscreen.
- `desktop-services`: ativar explicitamente os serviços do usuário.
- `sddm-install`: copiar o tema de login para o sistema; usa sudo.

Monitores e workspaces gerados pelo nwg-displays, wallpaper selecionado e
estado por monitor ficam locais. Use `nwg-displays` e `wallpaper` na primeira
configuração de uma máquina.
