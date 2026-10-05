# Neovim

My Neovim config. `./install.sh` links it to `~/.config/nvim`, and the first
time you open `nvim`, lazy.nvim downloads the plugins.

You need Neovim 0.9 or newer, Git and ripgrep (Telescope uses it). Node, Python,
Go or Rust only matter if you want their language servers.

## Layout

- `init.lua` loads the options, keymaps and plugins.
- `lua/David/core/` has the base options and general keymaps.
- `lua/David/plugins/` has one file per plugin; LSP and formatters are in
  `plugins/lsp/`.

## Plugins

Telescope for searching, nvim-tree as the file explorer, LSP with Mason and
nvim-cmp, Treesitter, gitsigns and lazygit for Git, toggleterm, harpoon,
trouble for diagnostics, nvim-dap for debugging and Copilot. The theme is
nightfly.

## Keymaps

The leader is `Space`.

### Search

| Shortcut | Action |
| --- | --- |
| `<leader>ff` | Find files |
| `<leader>fr` | Recent files |
| `<leader>fs` | Search text in the project |
| `<leader>fc` | Search word under cursor |
| `<leader>fb` | Open buffers |
| `<leader>fh` | Neovim help |

### Files and buffers

| Shortcut | Action |
| --- | --- |
| `<leader>ee` | Toggle nvim-tree |
| `<leader>ef` | Open nvim-tree at current file |
| `<S-h>` / `<S-l>` | Previous / next buffer |
| `[b` / `]b` | Previous / next buffer |
| `<leader>bb` | Return to last buffer |

### Windows and tabs

| Shortcut | Action |
| --- | --- |
| `<leader>sv` | Vertical split |
| `<leader>sh` | Horizontal split |
| `<leader>se` | Equalize split sizes |
| `<leader>sx` | Close split |
| `<leader>sm` | Maximize/restore split |
| `<C-h/j/k/l>` | Move between windows |
| `<leader><tab>o` | New tab |
| `<leader><tab>x` | Close tab |

### LSP

| Shortcut | Action |
| --- | --- |
| `gd` | Go to definition |
| `gD` | Go to declaration |
| `gR` | Show references |
| `gi` | Go to implementation |
| `gt` | Show type definition |
| `K` | Hover documentation |
| `<leader>ca` | Code actions |
| `<leader>rn` | Rename symbol |
| `<leader>d` | Line diagnostics |
| `<leader>D` | Buffer diagnostics |
| `[d` / `]d` | Previous / next diagnostic |
| `<leader>rs` | Restart LSP |

### Git

| Shortcut | Action |
| --- | --- |
| `<leader>gs` | Git status with Telescope |
| `<leader>gc` | Commits |
| `<leader>gfc` | Current file commits |
| `<leader>gb` | Branches |
| `<leader>gg` | Open lazygit |
| `]c` / `[c` | Next / previous change |
| `<leader>ghs` | Stage hunk |
| `<leader>ghr` | Reset hunk |
| `<leader>ghp` | Preview hunk |
| `<leader>ghb` | Line blame |
| `<leader>gtb` | Toggle line blame |
| `<leader>gtd` | Toggle deleted lines |

### Harpoon

| Shortcut | Action |
| --- | --- |
| `<leader>ha` | Add file |
| `<leader>hh` | Quick menu |
| `<leader>h1` ... `<leader>h4` | Jump to marked file |
| `<leader>hp` / `<leader>hn` | Previous / next marked file |

### Terminal

| Shortcut | Action |
| --- | --- |
| `<C-\>` | Toggle terminal |
| `<leader>tt` | Floating terminal |
| `<leader>tH` | Horizontal terminal |
| `<leader>tV` | Vertical terminal |
| `<leader>tj` | Node REPL |
| `<leader>tp` | Python REPL |
| `<leader>tu` | htop |

### Editing

| Shortcut | Action |
| --- | --- |
| `jk` | Leave insert mode |
| `<leader>/` | Comment line or selection |
| `<leader>nh` | Clear search highlight |
| `<leader>+` / `<leader>-` | Increment / decrement number |
| `<leader>ww` | Save |
| `<leader>qq` | Quit |
| `<leader>un` | Dismiss notifications |

### Copilot

| Shortcut | Action |
| --- | --- |
| `<M-l>` | Accept suggestion |
| `<M-]>` | Next suggestion |
| `<M-[>` | Previous suggestion |
| `<C-]>` | Dismiss suggestion |
| `<M-CR>` | Open panel |

## When something's off

If an LSP feature is missing, it's usually because the server isn't
installed: open `:Mason` and install it. `:checkhealth` covers most other
problems.

If Neovim ends up in a weird state, you can clear its local data. It wipes the
downloaded plugins, but lazy.nvim reinstalls them on the next launch:

```bash
rm -rf ~/.cache/nvim ~/.local/share/nvim ~/.local/state/nvim
```
