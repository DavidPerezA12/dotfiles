# David Perez's Dotfiles

Personal macOS development setup. It includes Zsh, Git, iTerm2, Neovim,
Homebrew, and a few scripts to bring new or freshly reinstalled machines back to
the same baseline.

## Installation

Clone the repository wherever you prefer. On my machines I use
`~/Developer/dotfiles`, so that path appears in a few examples.

```bash
mkdir -p ~/Developer
git clone https://github.com/DavidPerezA12/dotfiles.git ~/Developer/dotfiles
cd ~/Developer/dotfiles

chmod +x install.sh
./install.sh

source ~/.zshrc
```

The installer does the following:

- Installs Homebrew if it is not available.
- Installs the tools listed in `Brewfile`.
- Installs NVM to manage Node.js versions.
- Configures Zsh, Git, Oh My Zsh, and Powerlevel10k.
- Configures Neovim and syncs plugins.
- Installs Nerd Fonts for iTerm2.
- Creates symlinks from `HOME` to this repository.
- Applies the iTerm2 configuration when `config/iterm2/` exists.

For a quick pass without touching Homebrew or resyncing Neovim plugins:

```bash
./install.sh --no-brew --no-nvim-sync
```

To install without touching the iTerm2 configuration:

```bash
./install.sh --no-iterm2
```

To verify that everything is still connected without installing or changing
anything:

```bash
./install.sh --verify
```

Private Git data, such as email addresses or signing keys, belongs in
`~/.gitconfig.local`. That file is loaded from `.gitconfig` when it exists, but
it is not part of the repository. If you already have a `~/.gitconfig` with an
identity configured, the installer tries to preserve those values in
`~/.gitconfig.local` before creating the symlink.

There are also `make` shortcuts:

```bash
make install
make quick
make verify
```

## Source of Truth

Configuration is edited in this repository, no matter where it is cloned. The
installer resolves the real checkout path and creates links from `HOME` back to
that folder.

If the repository is cloned to `~/Developer/dotfiles`, the links look like this:

```text
~/.config/nvim -> ~/Developer/dotfiles/config/nvim
~/.zshrc       -> ~/Developer/dotfiles/zshrc
~/.zprofile    -> ~/Developer/dotfiles/zprofile
~/.p10k.zsh    -> ~/Developer/dotfiles/p10k.zsh
~/.gitconfig   -> ~/Developer/dotfiles/.gitconfig
~/.gitignore_global -> ~/Developer/dotfiles/.gitignore_global
```

Do not edit `~/.config/nvim`, `~/.zshrc`, `~/.zprofile`, or `~/.p10k.zsh`
directly, because they are links. Edit the matching files inside the cloned
repository instead. For private Git data, use `~/.gitconfig.local`.

## Applications

The installer sets up the tools managed by this repository. The rest are apps I
use depending on the machine or the moment, and they may be installed from the
App Store, direct downloads, or another manual path.

### Productivity

| App | Use | Installation |
| --- | --- | --- |
| [Raycast](https://www.raycast.com/) | Launcher and productivity | Manually installed app |

### Development

| App | Use | Installation |
| --- | --- | --- |
| [iTerm2](https://iterm2.com/) | Main terminal | Installed by the script |
| [Neovim](https://neovim.io/) | Code editor | Installed by the script |
| [VS Code](https://code.visualstudio.com/) | Secondary IDE | Manually installed app |
| [Xcode](https://developer.apple.com/xcode/) | IDE for iOS/macOS | App Store |

### Other Utilities

| App | Use | Link |
| --- | --- | --- |
| [Macs Fan Control](https://crystalidea.com/macs-fan-control) | Fan control | [crystalidea.com](https://crystalidea.com/macs-fan-control) |
| [Amphetamine](https://apps.apple.com/es/app/amphetamine/id937984704?mt=12) | Keep the Mac awake | App Store |
| [AlDente](https://apphousekitchen.com/) | Battery charge limit | [apphousekitchen.com](https://apphousekitchen.com/) |
| [Cloudflare WARP](https://one.one.one.one/) | VPN | [one.one.one.one](https://one.one.one.one/) |
| [Magnet](https://apps.apple.com/es/app/magnet/id441258766?mt=12) | Window management | App Store |
| [CrossOver](https://www.codeweavers.com/crossover/) | Windows apps and games | [codeweavers.com](https://www.codeweavers.com/crossover/) |
| [Parallels Desktop](https://www.parallels.com/) | Virtualization | [parallels.com](https://www.parallels.com/) |
| [CyberGhost VPN](https://www.cyberghostvpn.com/) | VPN | [cyberghostvpn.com](https://www.cyberghostvpn.com/) |
| [CleanMyMac X](https://macpaw.com/cleanmymac) | macOS cleanup | [macpaw.com](https://macpaw.com/cleanmymac) |
| [LM Studio](https://lmstudio.ai/) | Local models | [lmstudio.ai](https://lmstudio.ai/) |
| [Warp](https://www.warp.dev/) | Alternative terminal | [warp.dev](https://www.warp.dev/) |

## CLI Tools

These tools are installed with `./install.sh`:

```bash
brew bundle install --file ./Brewfile
```

| Tool | Description | Usage |
| --- | --- | --- |
| `git` | Version control | `git`, `gst`, `gco` |
| `gh` | GitHub CLI and Git credential helper | `gh auth login`, `gh pr view` |
| `neovim` | Code editor | `nvim` |
| `curl` | Data transfer | `curl` |
| `wget` | File downloads | `wget` |
| `ripgrep` | Fast text search | `rg "text"` |
| `fd` | Fast file search | `fd name` |
| `fzf` | Interactive fuzzy finder | `fzf` |
| `lazygit` | Terminal UI for Git | `lazygit` |
| `tmux` | Terminal multiplexer | `tmux` |
| `shellcheck` | Shell script linter | `shellcheck install.sh` |
| `nvm` | Node.js version manager | `nvm install node` |

[See all commands and aliases](docs/COMMANDS.md).

## What Gets Configured

### Terminal

- iTerm2 with custom preferences.
- Powerlevel10k for the prompt. The prompt stability rules live in
  [docs/TERMINAL_PROMPT.md](docs/TERMINAL_PROMPT.md).
- Nerd Fonts for icons.

### Zsh

- Oh My Zsh.
- `git`.
- `zsh-autosuggestions`.
- `zsh-syntax-highlighting`.

### Neovim

- `lazy.nvim` for plugins.
- LSP configured with Mason.
- Telescope for searches.
- GitHub Copilot.
- Treesitter.
- Plugins for Git, terminal, debugging, and navigation.

[See Neovim keymaps](config/nvim/README.md).

## Structure

```text
dotfiles/
├── README.md              # This file
├── install.sh             # Installation script
├── Brewfile               # Homebrew packages
├── LICENSE                # MIT license
├── .gitignore             # Ignored files
├── .gitconfig             # Global Git configuration
├── .gitignore_global      # Global Git ignores
│
├── zshrc                  # Zsh configuration
├── zprofile               # Login-shell PATH for macOS/Homebrew
├── p10k.zsh               # Powerlevel10k configuration
│
├── config/
│   ├── nvim/              # Neovim configuration
│   │   ├── init.lua
│   │   └── lua/David/
│   └── iterm2/            # iTerm2 configuration
│       └── com.googlecode.iterm2.plist
│
└── docs/                  # Documentation
    ├── COMMANDS.md        # Commands and aliases
    ├── MACOS_SETUP.md     # macOS setup
    └── TERMINAL_PROMPT.md # Terminal prompt invariants
```

## Documentation

- [Commands and aliases](docs/COMMANDS.md)
- [Neovim guide](config/nvim/README.md)
- [macOS setup](docs/MACOS_SETUP.md)
- [Terminal prompt stability](docs/TERMINAL_PROMPT.md)

## Maintenance

### Verify Configuration

```bash
make verify
./install.sh --verify
HOMEBREW_NO_ENV_HINTS=1 HOMEBREW_NO_REQUIRE_TAP_TRUST=1 brew bundle check --file ./Brewfile
shellcheck install.sh
nvim --headless "+checkhealth" +qa
```

### Update Tools

```bash
brew update
brew upgrade
brew bundle install --file ./Brewfile
```

### Sync Neovim

```bash
nvim --headless "+Lazy! sync" +qa
```

### Check Links

```bash
readlink ~/.config/nvim
readlink ~/.zshrc
readlink ~/.zprofile
readlink ~/.p10k.zsh
readlink ~/.gitconfig
```

## License

MIT. Use it as a reference and adapt whatever you need.
