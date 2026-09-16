# Shells

- **Fish + Tide:** `packages/common/fish/`. Single-line prompt with the directory
  and Git on the left; status, tools, and clock on the right.
- **Zsh + Powerlevel10k:** `packages/common/zsh/`. Autosuggestions, syntax
  highlighting, fzf, zoxide, and eza aliases.

The installer does not change your login shell. Run `fish` to enter Fish.
The `fish_plugins` manifest preserves the plugin selection; `fish_variables`
and files downloaded by Fisher stay outside Git.

To apply prompt changes in an open Fish shell:

```fish
source ~/.config/fish/conf.d/tide.fish
tide reload
```

Zsh plugins can come from the shared installation at
`~/.local/share/zsh/plugins/` or the distribution/Homebrew paths.
`zsh-syntax-highlighting` is loaded last.

Machine-specific settings can go in `~/.config/fish/local.fish` and
`~/.config/zsh/local.zsh`, outside Git. Create the directories if needed.

Tide colors use [craftzdog/dotfiles](https://github.com/craftzdog/dotfiles)
as a reference, with the layout adapted locally. Edit `conf.d/tide.fish`
to keep the prompt reproducible.
