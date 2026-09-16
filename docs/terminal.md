# Terminais e tmux

Configurações em `packages/common/{ghostty,kitty,tmux}/`.
Ghostty abre uma sessão tmux independente por janela/aba. Kitty conecta à
sessão compartilhada `main`. Ambos usam Zsh se o tmux não estiver instalado.

## Fontes

Preferência: **PlemolJP Console NF → BlexMono Nerd Font → JetBrainsMono Nerd Font**.
Ghostty declara essa ordem diretamente. Kitty usa PlemolJP como principal;
no Linux, `packages/linux/fontconfig/` configura os fallbacks.
O fallback equivalente do Kitty no macOS ainda precisa de validação.

Instale [PlemolJP NF v3.1.0](https://github.com/yuru7/PlemolJP/releases/tag/v3.1.0).
Extraia os TTFs de `PlemolJPConsole_NF` do arquivo `PlemolJP_NF_v3.1.0.zip`:

- Linux: `~/.local/share/fonts/PlemolJPConsoleNF/`, depois `fc-cache -f`.
- macOS: instale pelo Catálogo de Fontes ou em `~/Library/Fonts/`.

SHA-256 do arquivo: `015142b7ce4fb497ea6eb14567c435b69450eb5028fb7d29c032d1ffb3854abb`.
Instale também as duas fontes de fallback; o bootstrap Arch já as inclui.
Os binários das fontes não entram no Git.

## tmux

Prefixo: **Ctrl+T**, solte e pressione a próxima tecla.

| Tecla após o prefixo | Ação |
|---|---|
| `c` | Nova janela |
| `\|` / `-` | Dividir à direita / abaixo |
| `h/j/k/l` | Mudar de painel |
| `H/J/K/L` | Redimensionar |
| `z` | Ampliar/restaurar painel |
| `n/p/w` | Próxima/anterior/lista de janelas |
| `r` | Recarregar configuração |
| `g` | Lazygit |
| `y` | Claude Code em popup; requer o CLI instalado |
| `o` | Abrir diretório no gerenciador de arquivos |
| `e` | Fechar os outros painéis |
| `[` | Histórico pelo teclado; `q` sai |

Mouse habilitado: a roda rola o histórico no shell. Em aplicativos como
Neovim, a rolagem é tratada pelo aplicativo. `q` sai do modo de cópia.

O tema fixo Solarized e o layout são baseados em
[craftzdog/dotfiles](https://github.com/craftzdog/dotfiles).
`platform/` adapta a abertura de diretórios para `open` ou `xdg-open`.
Plugins TPM ficam em `~/.config/tmux/plugins/`, fora do Git; `Ctrl+T I`
instala e `Ctrl+T U` atualiza.
