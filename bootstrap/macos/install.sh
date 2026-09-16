#!/bin/sh
set -eu
[ "$(uname -s)" = Darwin ] || { echo 'This bootstrap targets macOS.' >&2; exit 1; }
command -v brew >/dev/null || { echo 'Install Homebrew first: https://brew.sh' >&2; exit 1; }
DIR=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
brew bundle --file="$DIR/Brewfile"
