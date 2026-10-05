# David Perez's Dotfiles

The config I use on my Macs: Zsh, Git, iTerm2, Neovim and Homebrew. When I set
up a new machine or reinstall macOS, I clone this, run the installer and I'm
back to where I was.

## Install

```bash
git clone https://github.com/DavidPerezA12/dotfiles.git ~/Developer/dotfiles
cd ~/Developer/dotfiles
./install.sh
source ~/.zshrc
```

I keep it in `~/Developer/dotfiles`, but it works from any path.

The script installs Homebrew if it's missing, the packages in the `Brewfile`,
Oh My Zsh with Powerlevel10k, NVM and the Neovim plugins. Then it symlinks the
config files into `HOME` and loads my iTerm2 preferences.

Options:

```bash
./install.sh --no-brew --no-nvim-sync   # quick, skips Homebrew and plugin sync
./install.sh --no-iterm2                # leaves iTerm2 alone
./install.sh --verify                   # only checks, changes nothing
```

`make install`, `make quick` and `make verify` do the same thing.

## How it works

The files in `HOME` are symlinks to this repo:

```text
~/.zshrc            -> dotfiles/zshrc
~/.zprofile         -> dotfiles/zprofile
~/.p10k.zsh         -> dotfiles/p10k.zsh
~/.gitconfig        -> dotfiles/.gitconfig
~/.gitignore_global -> dotfiles/.gitignore_global
~/.config/nvim      -> dotfiles/config/nvim
```

So I edit everything here, not in `HOME`.

My email and signing keys don't live in the repo. They go in
`~/.gitconfig.local`, which `.gitconfig` loads if it exists. If there was
already a `~/.gitconfig`, the installer copies the name, email and signing key
there before replacing it.

## What's inside

- **Zsh**: Oh My Zsh, Powerlevel10k, autosuggestions and syntax highlighting.
  [Aliases and commands](docs/COMMANDS.md).
- **Neovim**: lazy.nvim, LSP with Mason, Telescope, Treesitter and Copilot.
  [Keymaps](config/nvim/README.md).
- **iTerm2**: my preferences and Nerd Fonts for icons. The prompt has a few
  quirks, written down in [TERMINAL_PROMPT.md](docs/TERMINAL_PROMPT.md).
- **CLI**: `git`, `gh`, `ripgrep`, `fd`, `fzf`, `lazygit`, `tmux`,
  `shellcheck` and a few more. The full list is in the `Brewfile`.

The rest of the macOS setup that isn't automated is in
[MACOS_SETUP.md](docs/MACOS_SETUP.md).

## Other apps

I install these by hand, depending on the machine:

- [Raycast](https://www.raycast.com/) instead of Spotlight
- [VS Code](https://code.visualstudio.com/) and
  [Xcode](https://developer.apple.com/xcode/)
- [Magnet](https://apps.apple.com/es/app/magnet/id441258766?mt=12) for windows
- [AlDente](https://apphousekitchen.com/) to limit battery charge
- [Macs Fan Control](https://crystalidea.com/macs-fan-control)
- [Amphetamine](https://apps.apple.com/es/app/amphetamine/id937984704?mt=12) to
  keep the Mac awake
- [Cloudflare WARP](https://one.one.one.one/) and
  [CyberGhost](https://www.cyberghostvpn.com/)
- [Parallels](https://www.parallels.com/) and
  [CrossOver](https://www.codeweavers.com/crossover/) for Windows stuff
- [CleanMyMac](https://macpaw.com/cleanmymac)
- [LM Studio](https://lmstudio.ai/) for local models
- [Warp](https://www.warp.dev/), when I'm not using iTerm2

## Keeping it up to date

```bash
brew update && brew upgrade
make nvim-sync
make verify
```

## License

MIT. Take whatever's useful.
