# Vim Cheat Sheet

Vim is a modal text editor that improves efficiency through keyboard commands. Here are the essentials for getting started.

## Modes
1. **Normal Mode** (`Esc`): Navigate and manipulate text.
2. **Insert Mode** (`i`, `a`, `o`): Type text.
3. **Visual Mode** (`v`): Select text.
4. **Visual Block Mode** (`Ctrl + v`): Select columns of text.
5. **Command-Line Mode** (`:`): Run commands (:w, :q, :wq!). (`!` means force)

## Key Commands

### Switch to Insert Mode
- `i`: Insert before cursor.
- `a`: Insert after cursor.
- `o`: Open a new line below.

### Switch to Normal Mode
- `Esc`: Return to Normal mode.


### Basic Commands
- `:w`: Save file.
- `:q`: Quit Vim.
- `:wq`: Save and quit.

## Movements
- `h`: Move left.
- `j`: Move down.
- `k`: Move up.
- `l`: Move right.
- `w`: Move forward to the beginning of the next word.
- `b`: Move backward to the beginning of the current/previous word.
- `e`: Move to the end of the current/next word.
- `0`: Move to the beginning of the line.
- `$`: Move to the end of the line.
- `gg`: Go to the beginning of the file.
- `G`: Go to the end of the file.
- `Ctrl + f`: Move forward one page.
- `Ctrl + b`: Move backward one page.
- `{`: Move to the beginning of the previous paragraph.
- `}`: Move to the beginning of the next paragraph.
- `(`: Move to the beginning of the current/previous sentence.
- `)`: Move to the beginning of the next sentence.
- `f<char>`: Move to the next occurrence of `<char>` in the current line.
- `F<char>`: Move to the previous occurrence of `<char>` in the current line.
- `t<char>`: Move up to (before) the next occurrence of `<char>` in the current line.
- `T<char>`: Move up to (before) the previous occurrence of `<char>` in the current line.
- `;`: Repeat the last `f`, `F`, `t`, or `T` command.
- `,`: Repeat the last `f`, `F`, `t`, or `T` command in the opposite direction.

## Operators (Combine with movements)
- `d`: Delete (`dw` deletes a word, `d$` deletes to end of line).
- `y`: Yank (copy).
- `c`: Change (replace).
- `gU`: Convert text to uppercase (`gUw` makes word uppercase).
- `gu`: Convert text to lowercase (`guw` makes word lowercase).
- `~`: Toggle case of character(s) (`g~w` toggles case for word).
- `>`: Indent (`>}` indents until the next paragraph).
- `<`: Unindent (`<}` unindents until the next paragraph).

## Visual Mode Commands
- `v`: Enter Visual mode.
- `y`: Copy selected.
- `d`: Delete selected.
- `>`, `<`: Indent, unindent.

## Visual Block Mode Commands
- `Ctrl + v`: Enter Visual Block mode.
- `I` or `A`: Insert or append text on multiple lines.

## Tips
- **Vimtutor**: Run `vimtutor` in terminal for a quick Vim tutorial.

## Other Cheat Sheets
- [https://vim.rtorr.com](https://vim.rtorr.com)
  
---

This cheat sheet covers the essentials to get started in Vim and boost your efficiency!
