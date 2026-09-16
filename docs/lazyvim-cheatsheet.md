# LazyVim Cheat Sheet

`Space` = leader. Keys are sequential unless joined by `+`. Normal mode unless noted.

## Everyday

| Keys | Action |
|---|---|
| `Space Space` | Find project files |
| `Space /` | Search text across the project |
| `Space e` | File explorer |
| `Space ,` | Switch open buffers |
| `Ctrl+s` | Save file |
| `i` / `a` | Insert before / after cursor |
| `Esc` | Normal mode; clear search highlighting |
| `u` / `Ctrl+r` | Undo / redo |
| `Shift+h` / `Shift+l` | Previous / next buffer |
| `Space b d` | Close buffer |
| `Space b b` | Switch to previous buffer |
| `Space` then wait | Show available shortcuts |

## Editing and movement

| Keys | Action |
|---|---|
| `h j k l` | Left, down, up, right |
| `w` / `b` / `e` | Next word / previous word / word end |
| `0` / `^` / `$` | Line start / first nonblank / line end |
| `gg` / `G` | File start / end |
| `Ctrl+d` / `Ctrl+u` | Half-page down / up |
| `v` / `V` / `Ctrl+v` | Select characters / lines / block |
| `yy` / `dd` / `p` | Copy line / cut line / paste after |
| `ciw` / `diw` | Change / delete word |
| `o` / `O` | Insert line below / above |
| `.` | Repeat last change |
| `gcc` | Toggle line comment |
| `gc` (selection) | Toggle selection comments |
| `>` / `<` (selection) | Indent / unindent |
| `Alt+j` / `Alt+k` | Move line or selection down / up |

## Search and navigation

| Keys | Action |
|---|---|
| `/text` then `Enter` | Search current file |
| `n` / `N` | Next / previous match |
| `Space s w` | Search cursor word or selection in project |
| `Space f r` | Recent files |
| `Space s b` | Search buffer lines |
| `Space s r` | Search and replace across files |
| `Ctrl+o` / `Ctrl+i` | Jump back / forward |

## Code and completion

LSP actions require a language server with support for the action.

| Keys | Action |
|---|---|
| `gd` / `gr` | Definition / references |
| `K` | Hover documentation |
| `Space c a` | Code actions |
| `Space c r` | Rename symbol |
| `Space c f` | Format file or selection |
| `]d` / `[d` | Next / previous diagnostic |
| `Space c d` | Line diagnostics |
| `Space x x` | Project diagnostics |
| `Space s s` | File symbols |
| `gI` / `gy` | Implementation / type definition |
| `gK` | Signature help |
| `Ctrl+Space` (insert) | Show completion / documentation |
| `Tab` / `Shift+Tab` (completion menu) | Next / previous suggestion |
| `Enter` (completion menu) | Accept selected suggestion |
| `Ctrl+e` (insert) | Cancel completion |

## Windows and terminal

| Keys | Action |
|---|---|
| `Ctrl+h/j/k/l` | Focus left / lower / upper / right window |
| `Space \|` / `Space -` | Split right / below |
| `Space w d` | Close window |
| `Space w m` | Toggle window zoom |
| `Ctrl+Arrow` | Resize window |
| `Ctrl+/` | Focus/toggle project terminal |
| `Space f t` | Open project terminal |
| `Ctrl+\` then `Ctrl+n` (terminal) | Terminal normal mode |

## Git and Diffview

| Keys | Action |
|---|---|
| `Space g g` | Open Lazygit at repository root |
| `Space g v` | Open Diffview changes |
| `Space g q` | Close Diffview |
| `Space g H` | Diffview: current file history |
| `Space g V` | Diffview: repository history |
| `]h` / `[h` | Next / previous changed hunk |
| `Space g h p` | Preview hunk |
| `Space g h s` | Stage/unstage hunk |
| `Space g h r` | Discard hunk changes |
| `Space g h b` | Blame current line |

## Less frequent

| Keys | Action |
|---|---|
| `Space f n` | New buffer |
| `Space b o` | Close other buffers |
| `Space u f` | Toggle autoformat globally |
| `Space u w` | Toggle line wrapping |
| `Space u d` | Toggle diagnostics |
| `Space s k` | Search keybindings |
| `Space s h` | Search help |
| `Space l` | Plugin manager |
| `Space q q` | Quit all windows |
