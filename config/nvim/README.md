# Neovim

My Neovim setup for code projects: fuzzy finding, LSP, diagnostics, Git,
integrated terminals, and the shortcuts I use every day.

The configuration lives inside this repo at:

```text
config/nvim
```

The active installation should point to that folder inside the path where you
cloned the repository. For example, if you use `~/Developer/dotfiles`:

```text
~/.config/nvim -> ~/Developer/dotfiles/config/nvim
```

## Installation

From the repository root:

```bash
./install.sh
```

The script creates the symlink and makes Neovim use this configuration. When
you open `nvim` for the first time, `lazy.nvim` downloads the plugins.

Useful requirements:

- Neovim 0.9 or newer
- Git
- ripgrep, for Telescope searches
- Node.js, Python, Go, or Rust only if you plan to use their language servers
- lazygit, if you want to open it from Neovim

To confirm that the link points to the right place:

```bash
readlink ~/.config/nvim
```

## Structure

```text
config/nvim/
├── init.lua
├── lazy-lock.json
└── lua/David/
    ├── core/
    │   ├── options.lua
    │   └── keymaps.lua
    ├── lazy-setup.lua
    └── plugins/
        ├── lsp/
        └── *.lua
```

- `init.lua` loads options, keymaps, and plugins.
- `core/options.lua` contains the editor's base behavior.
- `core/keymaps.lua` keeps the general shortcuts.
- `plugins/` keeps each plugin in its own file.
- `plugins/lsp/` groups Mason, LSP, formatters, and related tools.

## Included Configuration

- `lazy.nvim` for plugin management.
- `nightfly` as the main theme.
- `telescope.nvim` for finding files, text, buffers, and help.
- `nvim-tree.lua` as the file explorer.
- `nvim-lspconfig`, `mason.nvim`, and `nvim-cmp` for LSP and completion.
- `treesitter` for better highlighting and parsing.
- `gitsigns.nvim`, Telescope Git, and `lazygit` for Git workflows.
- `toggleterm.nvim` for terminals inside Neovim.
- `harpoon` for quickly jumping between frequent files.
- `trouble.nvim` for diagnostics, quickfix, and symbols.
- `nvim-dap` for debugging.
- `copilot.lua` for Copilot suggestions.

## Most-Used Shortcuts

The leader key is `Space`.

### Search

| Shortcut | Action |
| --- | --- |
| `<leader>ff` | Find files |
| `<leader>fr` | Recent files |
| `<leader>fs` | Search text in the project |
| `<leader>fc` | Search word under cursor |
| `<leader>fb` | Open buffers |
| `<leader>fh` | Neovim help |

### Files and Buffers

| Shortcut | Action |
| --- | --- |
| `<leader>ee` | Toggle nvim-tree |
| `<leader>ef` | Open nvim-tree at current file |
| `<S-h>` / `<S-l>` | Previous / next buffer |
| `[b` / `]b` | Previous / next buffer |
| `<leader>bb` | Return to last buffer |

### Windows and Tabs

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

### Editing and Quick Actions

| Shortcut | Action |
| --- | --- |
| `jk` | Leave insert mode |
| `<leader>/` | Comment line or selection |
| `<leader>nh` | Clear search highlight |
| `<leader>+` / `<leader>-` | Increment / decrement number |
| `<leader>ww` | Save |
| `<leader>qq` | Quit |
| `<leader>un` | Dismiss notifications |

## Useful Commands

```vim
:Lazy
:Lazy sync
:Mason
:checkhealth
```

If an LSP feature does not appear, opening `:Mason` and installing the missing
server is usually enough. Mason binaries are added to the `PATH` from
`core/options.lua`.

## Copilot

The main shortcuts are:

| Shortcut | Action |
| --- | --- |
| `<M-l>` | Accept suggestion |
| `<M-]>` | Next suggestion |
| `<M-[>` | Previous suggestion |
| `<C-]>` | Dismiss suggestion |
| `<M-CR>` | Open panel |

## Maintenance

Update plugins:

```vim
:Lazy sync
```

Check general issues:

```vim
:checkhealth
```

Clear cache if Neovim gets into a weird state:

```bash
rm -rf ~/.cache/nvim
rm -rf ~/.local/share/nvim
rm -rf ~/.local/state/nvim
```

Only do this knowing it removes downloaded plugins, local state, and temporary
data. When you open Neovim again, `lazy.nvim` will reinstall anything missing.
