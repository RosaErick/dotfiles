# Instalação

## Dependências

Use Git, GNU Stow e Python 3.11 ou superior. Clone a repo em `~/.dotfiles`;
os scripts do desktop usam esse caminho.

No Arch, escolha as dependências de CLI ou do desktop completo:

```sh
./bootstrap/arch/install.sh cli
# ou:
./bootstrap/arch/install.sh desktop
```

No macOS, instale Homebrew e execute:

```sh
./bootstrap/macos/install.sh
```

Em outros Linux, instale os equivalentes com o gerenciador da distribuição.
As listas em `bootstrap/arch/` servem como referência; nomes podem variar.
Os bootstraps instalam dependências, sem trocar o shell de login.

## Configurações

```sh
./install.sh --profile arch-hyprland --dry-run
./install.sh --profile arch-hyprland
```

Perfis: `cli`, `macos`, `linux-desktop`, `arch-hyprland`.
`@include` reutiliza outro perfil; cada linha restante identifica um pacote
relativo a `packages/`. O desktop Hyprland também pode ser usado em outra
distribuição criando um perfil com esses mesmos pacotes.

O instalador verifica conflitos com Stow antes de criar os links. Arquivos
preexistentes de outro dono causam erro: faça backup e resolva o conflito.
Ele não usa `--adopt` nem substitui arquivos pessoais automaticamente.
Perfis são aditivos: aplicar outro não remove pacotes já instalados.

`--target /caminho` permite testar os links em um diretório existente.
`--theme nome` escolhe a paleta; a primeira instalação usa Carbonfox.
O estado da instalação fica em `~/.local/state/dotfiles/install.json`.

## Plugins

Depois dos links, execute explicitamente a etapa que baixa plugins:

```sh
./scripts/install-plugins.sh
```

Ela instala Oh My Zsh, Powerlevel10k, plugins do Zsh, TPM e tmux-pain-control
quando ausentes, e executa `fisher update` para o Fish. Os checkouts existentes
de Zsh/tmux não são atualizados. O LazyVim instala os plugins ao abrir `nvim`.
Fontes têm instruções em [Terminais](terminal.md).

## Desktop

Dentro da sessão Hyprland, após instalar as dependências e configurações:

```sh
~/.scripts/desktop-services
```

Essa etapa ativa os serviços do usuário. Saia e entre novamente para aplicar
`environment.d`. Escolha o wallpaper com `wallpaper`; use `nwg-displays`
para configurar os monitores. O tema do SDDM é opcional: `sddm-install`.

## Manutenção e migração

Cada pacote espelha os caminhos no home e possui seus próprios arquivos.
Não crie dois pacotes que escrevam no mesmo destino. Diferenças pequenas de
sistema ficam junto do aplicativo, como `tmux/platform/`.

A migração desta máquina atualizou os links antigos para `packages/` e
preservou a paleta ativa. Em outra instalação com a estrutura anterior,
remova apenas os links que apontam para os caminhos antigos antes de aplicar
o novo perfil; o instalador acusa esses conflitos e não faz a migração sozinho.
Caches, plugins baixados, monitores, históricos e configurações locais não
fazem parte dos pacotes versionados.

Verificação sem alterar o home real:

```sh
python3 -m unittest discover -s tests -v
```
