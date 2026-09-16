# Shells

- **Fish + Tide:** `packages/common/fish/`. Prompt em uma linha, com diretório
  e Git à esquerda; status, ferramentas e relógio à direita.
- **Zsh + Powerlevel10k:** `packages/common/zsh/`. Autosuggestions, syntax
  highlighting, fzf, zoxide e aliases para eza.

O instalador não muda seu shell de login. Execute `fish` para entrar no Fish.
O manifesto `fish_plugins` preserva a seleção de plugins; `fish_variables`
e arquivos baixados pelo Fisher ficam fora do Git.

Para aplicar alterações no prompt em um Fish aberto:

```fish
source ~/.config/fish/conf.d/tide.fish
tide reload
```

Os plugins Zsh podem vir da instalação compartilhada em
`~/.local/share/zsh/plugins/` ou dos caminhos da distribuição/Homebrew.
`zsh-syntax-highlighting` é carregado por último.

Ajustes desta máquina podem ficar em `~/.config/fish/local.fish` e
`~/.config/zsh/local.zsh`, fora do Git. Crie os diretórios se necessário.

As cores do Tide usam como referência
[craftzdog/dotfiles](https://github.com/craftzdog/dotfiles), com o layout
adaptado localmente. Edite `conf.d/tide.fish` para manter o prompt reproduzível.
