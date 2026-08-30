#!/bin/sh
# Symlinks this repo into place. Idempotent — safe to re-run.
set -e
cd "$(dirname "$0")"
REPO="$(pwd)"

mkdir -p ~/.config ~/.scripts

# stow keeps existing foreign files intact (e.g. gtk-3.0/bookmarks)
stow -d "$REPO" -t ~/.config  --restow .config
stow -d "$REPO" -t ~/.scripts --restow .scripts

# these two live in $HOME, not $HOME/.config
ln -sfn "$REPO/.zshrc"    ~/.zshrc
ln -sfn "$REPO/.p10k.zsh" ~/.p10k.zsh

echo "linked. now run:  theme carbonfox"
