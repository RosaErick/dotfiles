#!/bin/sh
# Explicit network step. Existing checkouts are never updated or overwritten.
set -eu
clone_missing() {
    if [ ! -e "$2" ]; then
        mkdir -p "$(dirname "$2")"
        git clone --depth 1 "$1" "$2"
    fi
}
clone_missing https://github.com/ohmyzsh/ohmyzsh.git "$HOME/.oh-my-zsh"
clone_missing https://github.com/romkatv/powerlevel10k.git "$HOME/.oh-my-zsh/custom/themes/powerlevel10k"
for plugin in zsh-autosuggestions zsh-syntax-highlighting; do
    clone_missing "https://github.com/zsh-users/$plugin.git" "${XDG_DATA_HOME:-$HOME/.local/share}/zsh/plugins/$plugin"
done
for plugin in tpm tmux-pain-control; do
    clone_missing "https://github.com/tmux-plugins/$plugin.git" "$HOME/.config/tmux/plugins/$plugin"
done
if command -v fish >/dev/null; then
    if fish -c 'functions -q fisher'; then
        fish -c 'fisher update'
    else
        fisher_source=$(mktemp)
        trap 'rm -f "$fisher_source"' EXIT HUP INT TERM
        curl -fsSL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish > "$fisher_source"
        fish -c 'source $argv[1]; fisher update' "$fisher_source"
    fi
fi
