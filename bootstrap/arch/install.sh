#!/bin/sh
set -eu
DIR=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
case "${1:-cli}" in
    cli) files="$DIR/packages-cli.txt" ;;
    desktop) files="$DIR/packages-cli.txt $DIR/packages-desktop.txt" ;;
    *) echo 'Usage: bootstrap/arch/install.sh [cli|desktop]' >&2; exit 1 ;;
esac
. /etc/os-release
[ "$ID" = arch ] || { echo 'This bootstrap targets Arch Linux.' >&2; exit 1; }
# Lists contain one package name per line, with no shell expressions.
set --
for file in $files; do
    while IFS= read -r package; do
        [ -z "$package" ] || set -- "$@" "$package"
    done < "$file"
done
sudo pacman -S --needed "$@"
