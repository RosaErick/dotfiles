# Installation

## Dependencies

Use Git, GNU Stow, and Python 3.11 or later. Clone the repo into `~/.dotfiles`;
the desktop scripts use this path.

On Arch, choose the CLI or full desktop dependencies:

```sh
./bootstrap/arch/install.sh cli
# or:
./bootstrap/arch/install.sh desktop
```

On macOS, install Homebrew and run:

```sh
./bootstrap/macos/install.sh
```

On other Linux distributions, install the equivalents with the distribution's
package manager. The lists in `bootstrap/arch/` serve as a reference; names may
vary. The bootstrap scripts install dependencies without changing the login shell.

## Configuration

```sh
./install.sh --profile arch-hyprland --dry-run
./install.sh --profile arch-hyprland
```

Profiles: `cli`, `macos`, `linux-desktop`, `arch-hyprland`.
`@include` reuses another profile; each remaining line identifies a package
relative to `packages/`. The Hyprland desktop can also be used on another
distribution by creating a profile with the same packages.

The installer checks for conflicts with Stow before creating links. Existing
files owned elsewhere cause an error: back them up and resolve the conflict.
It does not use `--adopt` or automatically replace personal files.
Profiles are additive: applying another does not remove installed packages.

`--target /path` lets you test links in an existing directory.
`--theme name` selects the palette; the first installation uses Carbonfox.
Installation state is stored in `~/.local/state/dotfiles/install.json`.

## Plugins

After creating the links, explicitly run the plugin download step:

```sh
./scripts/install-plugins.sh
```

It installs Oh My Zsh, Powerlevel10k, Zsh plugins, TPM, and tmux-pain-control
when missing, and runs `fisher update` for Fish. Existing Zsh/tmux checkouts
are not updated. LazyVim installs plugins when you open `nvim`.
Font instructions are in [Terminals](terminal.md).

## Desktop

Inside the Hyprland session, after installing dependencies and configurations:

```sh
~/.scripts/desktop-services
```

This step enables user services. Log out and back in to apply `environment.d`.
Choose a wallpaper with `wallpaper`; use `nwg-displays` to configure monitors.
The SDDM theme is optional: `sddm-install`.

## Maintenance and migration

Each package mirrors paths in the home directory and owns its files.
Do not create two packages that write to the same destination. Small system
differences stay alongside the application, such as `tmux/platform/`.

The migration on this machine updated the old links to `packages/` and
preserved the active palette. On another installation with the previous
structure, remove only the links pointing to the old paths before applying
the new profile; the installer reports these conflicts and does not perform
the migration automatically. Caches, downloaded plugins, monitor settings,
history, and local settings are not part of the versioned packages.

Verification without changing the real home directory:

```sh
python3 -m unittest discover -s tests -v
```
