# ~/.config/fish/config.fish

if status is-interactive
    # ── PATH ──────────────────────────────────────────────────────────
    fish_add_path -g ~/.local/bin
    fish_add_path -g ~/go/bin

    # ── eza no lugar do ls ────────────────────────────────────────────
    # Substitui o "Terminal-Icons" do PowerShell: os icones vem do eza.
    if type -q eza
        alias ls  'eza --icons=always --group-directories-first'
        alias ll  'eza --icons=always --group-directories-first -l --git'
        alias la  'eza --icons=always --group-directories-first -la --git'
        alias lt  'eza --icons=always --tree --level=2'
        alias tree 'eza --icons=always --tree'
    end

    type -q bat; and alias cat bat

    # ── zoxide: o "z" ─────────────────────────────────────────────────
    # Sucessor do plugin z/jethrokuan: aprende os diretorios que voce usa.
    #   z parcial-do-nome   pula pro mais provavel
    #   zi                  escolhe num fzf
    type -q zoxide; and zoxide init fish | source

    # ── ghq + fzf: pular pra qualquer repositorio ─────────────────────
    if type -q ghq; and type -q fzf
        function r --description 'pula pra um repositorio clonado com ghq'
            set -l dir (ghq list --full-path | fzf --prompt='repo> ' --height=40% --reverse)
            and cd $dir
        end
    end

    # fzf.fish (plugin) ja liga:
    #   Ctrl+Alt+F  arquivos      Ctrl+R  historico
    #   Ctrl+Alt+L  git log       Ctrl+Alt+S  git status
    #   Ctrl+Alt+P  processos     Ctrl+V  variaveis
    set -gx FZF_DEFAULT_OPTS '--height=45% --layout=reverse --border=rounded'
    type -q fd; and set -gx FZF_DEFAULT_COMMAND 'fd --type f --hidden --exclude .git'

    set -gx EDITOR nvim
    set -gx VISUAL nvim
end
