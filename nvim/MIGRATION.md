# Neovim Configuration Migration Guide

## What's Changed

Your Neovim configuration has been completely modernized and upgraded! Here are the major improvements:

### 📦 Package Manager Migration
- **Migrated from Packer to lazy.nvim** for better performance and lazy loading
- Much faster startup times
- Better plugin management with automatic updates

### 🚀 New Modern Plugins Added

#### Development Experience
- **which-key.nvim** - Shows available keybindings in a popup
- **trouble.nvim** - Pretty list for diagnostics, references, quickfix, etc.
- **harpoon** - Fast file navigation for frequently used files
- **indent-blankline.nvim** - Adds indentation guides
- **nvim-dap** - Debugging capabilities with virtual text
- **noice.nvim** - Better UI for messages, cmdline and the popupmenu

#### UI/UX Improvements
- **alpha-nvim** - Beautiful startup screen
- **bufferline.nvim** - Better buffer/tab line
- **nvim-notify** - Beautiful notifications
- **dressing.nvim** - Better default vim.ui interfaces

#### Productivity
- **toggleterm.nvim** - Terminal integration with floating windows
- **persistence.nvim** - Session management
- **copilot.lua** - AI pair programming (improved version)

### 🎨 Enhanced Features

#### LSP Improvements
- Better error handling and diagnostics
- More language servers (Python, Go, Rust, etc.)
- Enhanced formatting with multiple formatters
- Better keybindings with descriptions

#### Git Integration
- Enhanced gitsigns with better keybindings
- Fugitive integration for advanced git operations
- Better telescope git integration

#### Enhanced Autocompletion
- Super Tab functionality
- Better snippet integration
- Improved UI with borders

## 🎯 Key Keybindings

### New Essential Keybindings

| Key | Action | Description |
|-----|--------|-------------|
| `<leader>ff` | Find Files | Telescope file finder |
| `<leader>fs` | Live Grep | Search text in project |
| `<leader>fb` | Buffers | List open buffers |
| `<leader>xx` | Diagnostics | Show diagnostics (Trouble) |
| `<leader>ha` | Harpoon Add | Add file to harpoon |
| `<leader>hh` | Harpoon Menu | Show harpoon menu |
| `<C-\>` | Terminal | Toggle floating terminal |
| `<leader>gg` | Lazygit | Open lazygit |
| `gd` | Go to Definition | LSP go to definition |
| `gr` | References | Show references |
| `K` | Hover | Show documentation |

### Buffer Navigation
| Key | Action |
|-----|--------|
| `<S-h>` | Previous buffer |
| `<S-l>` | Next buffer |
| `<leader>bb` | Switch to other buffer |

### Window Navigation
| Key | Action |
|-----|--------|
| `<C-h/j/k/l>` | Navigate windows |
| `<leader>sv` | Split vertically |
| `<leader>sh` | Split horizontally |
| `<leader>sm` | Maximize/minimize split |

### Git Operations
| Key | Action |
|-----|--------|
| `<leader>hs` | Stage hunk |
| `<leader>hr` | Reset hunk |
| `<leader>hp` | Preview hunk |
| `]c` / `[c` | Next/Previous hunk |

### Debugging (F-keys)
| Key | Action |
|-----|--------|
| `<F5>` | Start/Continue debugging |
| `<F1>` | Step into |
| `<F2>` | Step over |
| `<F3>` | Step out |
| `<leader>db` | Toggle breakpoint |

## 🔧 Installation

### First Time Setup

1. **Backup your old configuration** (already done, but good practice):
   ```bash
   cp -r ~/.config/nvim ~/.config/nvim.backup
   ```

2. **Remove old plugin directory**:
   ```bash
   rm -rf ~/.local/share/nvim/site/pack/packer
   ```

3. **Start Neovim** and lazy.nvim will automatically install all plugins:
   ```bash
   nvim
   ```

4. **Wait for all plugins to install** - this may take a few minutes on first run

### Post-Installation

1. **Run health checks**:
   ```vim
   :checkhealth
   ```

2. **Install language servers** (they should auto-install via Mason):
   ```vim
   :Mason
   ```

3. **Update plugins** (lazy.nvim will notify you):
   ```vim
   :Lazy update
   ```

## 🎨 Customization

### Changing Colorschemes

You now have multiple colorschemes available:
- **nightfly** (default)
- **catppuccin**
- **tokyonight**

To change, edit `lua/David/plugins/colorscheme.lua` and modify the priority settings.

### Adding New Plugins

Create a new file in `lua/David/plugins/` following the lazy.nvim spec:

```lua
return {
  {
    "author/plugin-name",
    config = function()
      -- Plugin configuration
    end,
  },
}
```

### Modifying Keybindings

Edit `lua/David/core/keymaps.lua` to add or modify keybindings.

## 🐛 Troubleshooting

### Common Issues

1. **Plugins not loading**: Run `:Lazy sync` to reinstall
2. **LSP not working**: Run `:Mason` and ensure language servers are installed
3. **Slow startup**: Run `:Lazy profile` to identify slow plugins
4. **Colorscheme issues**: Ensure terminal supports true colors

### Performance

Your configuration should now start much faster due to:
- Lazy loading of plugins
- Optimized plugin configurations
- Disabled unnecessary vim plugins

## 📚 Learning Resources

- **Which-key**: Press `<leader>` and wait to see available commands
- **Telescope**: `:help telescope` for advanced usage
- **LSP**: `:help lsp` for language server features
- **DAP**: `:help dap` for debugging capabilities

## 🚀 What's Next

Your configuration now includes:
- ✅ Modern package management
- ✅ Enhanced LSP with multiple languages
- ✅ Debugging capabilities
- ✅ Better git integration
- ✅ Improved UI/UX
- ✅ AI pair programming
- ✅ Session management
- ✅ Advanced file navigation

You're now set up with a modern, performant Neovim configuration that rivals any IDE!
