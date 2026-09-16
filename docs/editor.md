# Editor

Neovim com LazyVim: `packages/common/nvim/.config/nvim/`.

- `lua/config/`: opções, atalhos e inicialização.
- `lua/plugins/`: plugins e personalizações.
- `lazy-lock.json`: versões dos plugins, mantidas no Git.

O autocomplete usa Blink: `Tab`/`Shift+Tab` percorrem sugestões; `Enter`
confirma após selecionar uma. `Ctrl+Espaço` abre as sugestões.

## Diffview

| Atalho | Ação |
|---|---|
| `Espaço g v` | Alterações locais |
| `Espaço g V` | Histórico do repositório |
| `Espaço g H` | Histórico do arquivo |
| `Espaço g q` | Fechar Diffview |

Use `:Lazy` para gerenciar plugins e `:LazyExtras` para integrações de
linguagens. A configuração é compartilhada; dependências de cada linguagem
precisam estar disponíveis na máquina.
