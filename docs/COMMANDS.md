# 📟 Commands and Aliases Guide

Full documentation for the commands, aliases, and functions available in this
setup.

## 📑 Table of Contents

- [General Aliases](#general-aliases)
- [Git Aliases](#git-aliases)
- [Essential CLI Tools](#essential-cli-tools)
- [Navigation and Search](#navigation-and-search)
- [Tips and Tricks](#tips-and-tricks)

---

## 🔧 General Aliases

### macOS App Aliases

```bash
xcode       # Opens Xcode
```

### Improved Navigation

```bash
ls          # Standard ls command
cat         # Standard cat command
```

---

## 🐙 Git Aliases

Provided by the Oh My Zsh `git` plugin:

```bash
# Status and basics
g           # git
gst         # git status
gss         # git status -s

# Add and commit
ga          # git add
gaa         # git add --all
gc          # git commit -v
gc!         # git commit -v --amend
gca         # git commit -v -a
gcam        # git commit -a -m

# Branch
gb          # git branch
gba         # git branch -a
gbd         # git branch -d
gbD         # git branch -D

# Checkout
gco         # git checkout
gcb         # git checkout -b
gcm         # git checkout main/master

# Pull and push
gl          # git pull
gp          # git push
gpf         # git push --force-with-lease
gpu         # git push upstream

# Log
glog        # git log --oneline --decorate --graph
gloga       # git log --oneline --decorate --graph --all
glg         # git log --stat
glgg        # git log --graph

# Diff
gd          # git diff
gds         # git diff --staged
gdw         # git diff --word-diff

# Merge and rebase
gm          # git merge
gma         # git merge --abort
grb         # git rebase
grbi        # git rebase -i
grba        # git rebase --abort
grbc        # git rebase --continue

# Stash
gsta        # git stash
gstp        # git stash pop
gstl        # git stash list

# Remote
gr          # git remote
gra         # git remote add
grv         # git remote -v
```

---

## 🚀 Essential CLI Tools

These tools are installed from the `Brewfile` with `./install.sh` or with:

```bash
brew bundle install --file ~/Developer/dotfiles/Brewfile
```

### `git` - Version Control

```bash
git status                   # Show status
git add .                    # Add all changes
git commit -m "message"      # Create commit
git push                     # Push changes
```

### `neovim` - Modern Editor

```bash
nvim file.txt                # Open file
nvim .                       # Open current directory
:Lazy                        # Plugin manager
:Mason                       # LSP manager
```

### `nvm` - Node Version Manager

```bash
# Installation and management
nvm install node             # Install latest version
nvm install 20.10.0          # Install specific version
nvm install --lts            # Install LTS version
nvm use 20.10.0              # Use specific version
nvm use node                 # Use latest version
nvm use --lts                # Use LTS version

# Listing and search
nvm ls                       # List installed versions
nvm ls-remote                # List available versions
nvm ls-remote --lts          # List LTS versions
nvm current                  # Current version in use

# Utilities
nvm uninstall 20.10.0        # Uninstall version
nvm alias default 20.10.0    # Set default version
nvm which node               # Path to current node executable
```

### `curl` and `wget` - Data Transfer

```bash
curl https://example.com     # Download content
curl -O https://example.com/file.txt  # Download file
wget https://example.com/file.txt     # Download file
```

### `ripgrep`, `fd`, and `fzf` - Fast Search

```bash
rg "TODO"                    # Search text in the project
rg "TODO" -l                 # Show only files with matches
fd config                    # Search files/folders by name
fd lua config/nvim           # Search Lua files under config/nvim
fzf                          # Interactive fuzzy finder
nvim "$(fd . | fzf)"         # Pick a file and open it in Neovim
```

### `lazygit` - Git in the Terminal

```bash
lazygit                      # Open Git UI
```

In Neovim it is also available from `<leader>gg`.

### `tmux` - Terminal Sessions

```bash
tmux                         # New session
tmux new -s work             # New named session
tmux ls                      # List sessions
tmux attach -t work          # Attach to a session
```

### `shellcheck` - Validate Shell Scripts

```bash
shellcheck install.sh        # Check the installer
```

---

## 🧭 Navigation and Search

### Useful Combinations

```bash
# Search and edit with Neovim
nvim $(fzf)

# Search content and open file
rg "TODO" -l | fzf | xargs nvim

# View Git history for a file
glog -- file.txt
```

---

## 💡 Tips and Tricks

### Reload Configuration

```bash
source ~/.zshrc              # Reload zshrc
exec zsh                     # Restart shell
```

### Powerlevel10k

```bash
p10k configure               # Reconfigure theme
p10k segment list            # Show available segments
```

### Neovim

```bash
nvim                         # Open Neovim
:Lazy                        # Plugin manager
:Mason                       # LSP manager
:checkhealth                 # Check health
```

### History

```bash
history | grep command       # Search history
!!                           # Repeat last command
!$                           # Last argument of previous command
!*                           # All arguments of previous command
```

### Homebrew

```bash
brew update                  # Update Homebrew
brew upgrade                 # Upgrade packages
brew outdated                # Show outdated packages
brew cleanup                 # Clean old versions
brew list                    # List installed packages
brew info <package>          # Package information
```

### Dotfiles

```bash
cd ~/Developer/dotfiles
make verify                 # Run local checks
make quick                  # Fast relink without brew/lazy sync
make nvim-sync              # Sync Neovim plugins
./install.sh --verify        # Verify symlinks and syntax without installing
./install.sh --no-brew --no-nvim-sync    # Fast relink without brew/lazy sync
./install.sh --no-iterm2     # Install without touching iTerm2 configuration
HOMEBREW_NO_ENV_HINTS=1 HOMEBREW_NO_REQUIRE_TAP_TRUST=1 brew bundle check --file Brewfile
```

### Private Local Git

The global Git configuration lives in `~/.gitconfig`, linked from this repo.
Private or machine-specific data belongs in `~/.gitconfig.local`:

```ini
[user]
  email = you@example.com
```

---

## 🔗 References

- [Oh My Zsh Cheatsheet](https://github.com/ohmyzsh/ohmyzsh/wiki/Cheatsheet)
- [ripgrep Guide](https://github.com/BurntSushi/ripgrep/blob/master/GUIDE.md)
- [fd GitHub](https://github.com/sharkdp/fd)
- [fzf Wiki](https://github.com/junegunn/fzf/wiki)
- [Neovim Keymaps](../config/nvim/README.md)

---

⬅️ [Back to README](../README.md)
