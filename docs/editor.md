# Editor

Neovim with LazyVim: `packages/common/nvim/.config/nvim/`.

- `lua/config/`: options, keybindings, and initialization.
- `lua/plugins/`: plugins and customizations.
- `lazy-lock.json`: plugin versions, tracked in Git.

Autocompletion uses Blink: `Tab`/`Shift+Tab` cycle through suggestions; `Enter`
confirms after selecting one. `Ctrl+Space` opens suggestions.

## Diffview

| Shortcut | Action |
|---|---|
| `Space g v` | Local changes |
| `Space g V` | Repository history |
| `Space g H` | File history |
| `Space g q` | Close Diffview |

Use `:Lazy` to manage plugins and `:LazyExtras` for language integrations.
The configuration is shared; dependencies for each language must be available
on the machine.
