#!/bin/sh
# Symlinks this repo into place and brings the session up. Idempotent.
set -eu
cd "$(dirname "$0")"
REPO="$(pwd)"
STAMP=$(date +%Y%m%d-%H%M%S)

mkdir -p ~/.config ~/.scripts

# stow leaves foreign files in a folder alone (e.g. gtk-3.0/bookmarks)
stow -d "$REPO" -t ~/.config  --restow .config
stow -d "$REPO" -t ~/.scripts --restow .scripts

# These two live in $HOME. stow does not guard them, so back up anything
# that is a real file before replacing it — losing someone's .zshrc silently
# is not an acceptable failure mode.
for f in .zshrc .p10k.zsh; do
    if [ -e "$HOME/$f" ] && [ ! -L "$HOME/$f" ]; then
        mv "$HOME/$f" "$HOME/$f.bak-$STAMP"
        echo "backed up ~/$f -> ~/$f.bak-$STAMP"
    fi
    ln -sfn "$REPO/$f" "$HOME/$f"
done

# Config files are generated from the palette, so a fresh clone has none.
"$REPO/.scripts/theme" "${1:-carbonfox}"

# Wallpaper folder and a default symlink, so hyprpaper and hyprlock have a
# target on first boot instead of falling back to a flat colour.
PICS=$(xdg-user-dir PICTURES 2>/dev/null || echo "$HOME/Pictures")
mkdir -p "$PICS/wallpapers"
if [ ! -e "$HOME/.config/hypr/wallpaper" ]; then
    FIRST=$(find "$PICS/wallpapers" -maxdepth 1 -type f \
            \( -iname '*.jpg' -o -iname '*.png' -o -iname '*.webp' \) | head -1)
    [ -n "$FIRST" ] && ln -sfn "$FIRST" "$HOME/.config/hypr/wallpaper"
fi

systemctl --user daemon-reload
systemctl --user enable --now \
    waybar hyprpaper mako hypridle nwg-dock hyprpolkitagent

echo "done. log out and back in so environment.d applies."
