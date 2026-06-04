# 🍎 macOS Setup Guide

Complete macOS operating-system setup for development.

## 📑 Table of Contents

- [Initial Setup](#initial-setup)
- [Homebrew Setup](#homebrew-setup)
- [macOS Defaults](#macos-defaults)
- [Essential Apps](#essential-apps)
- [Development Tools](#development-tools)
- [Troubleshooting](#troubleshooting)

---

## 🚀 Initial Setup

### 1. Update macOS

```bash
softwareupdate -l                # List updates
softwareupdate -ia               # Install all updates
```

### 2. Install Xcode Command Line Tools

```bash
xcode-select --install
```

### 3. Configure Git

```bash
git config --global user.name "Your Name"
git config --global user.email "you@example.com"
git config --global init.defaultBranch main
```

This repo already links a base Git configuration. If you install the dotfiles,
you can keep your private email in `~/.gitconfig.local`:

```ini
[user]
  email = you@example.com
```

---

## 🍺 Homebrew Setup

### Installation

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Add to PATH (Apple Silicon). In this repo it lives in
# ~/Developer/dotfiles/zprofile and is linked to ~/.zprofile by ./install.sh.
echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/Developer/dotfiles/zprofile
eval "$(/opt/homebrew/bin/brew shellenv)"
```

### Useful Commands

```bash
brew update                      # Update Homebrew
brew upgrade                     # Upgrade packages
brew outdated                    # Show outdated packages
brew cleanup                     # Clean old versions
brew doctor                      # Diagnose issues
brew list                        # List installed packages
brew search <name>               # Search for a package
brew info <name>                 # Package information
```

---

## ⚙️ macOS Defaults

### System

```bash
# Show hidden files in Finder
defaults write com.apple.finder AppleShowAllFiles -bool true

# Show file extensions
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

# Avoid creating .DS_Store files on network volumes
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true

# Disable the warning when changing file extensions
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

# Show path bar in Finder
defaults write com.apple.finder ShowPathbar -bool true

# Show status bar in Finder
defaults write com.apple.finder ShowStatusBar -bool true
```

### Dock

```bash
# Auto-hide Dock
defaults write com.apple.dock autohide -bool true

# Dock animation time
defaults write com.apple.dock autohide-time-modifier -float 0.5

# Remove auto-hide delay
defaults write com.apple.dock autohide-delay -float 0

# Dock size
defaults write com.apple.dock tilesize -int 48

# Restart Dock
killall Dock
```

### Screenshots

```bash
# Change screenshot location
mkdir -p ~/Screenshots
defaults write com.apple.screencapture location ~/Screenshots

# Screenshot format (png, jpg, pdf)
defaults write com.apple.screencapture type -string "png"

# Disable screenshot shadow
defaults write com.apple.screencapture disable-shadow -bool true

# Restart service
killall SystemUIServer
```

### Keyboard

```bash
# Fast key repeat
defaults write NSGlobalDomain KeyRepeat -int 2

# Short delay before repeat
defaults write NSGlobalDomain InitialKeyRepeat -int 15
```

### Apply Changes

```bash
# Restart Finder
killall Finder

# Restart Dock
killall Dock

# Restart SystemUIServer
killall SystemUIServer
```

---

## 📱 Essential Apps

See [README.md - Applications](../README.md#applications).

---

## 🛠️ Development Tools

### Languages and Runtimes

```bash
# Node.js (nvm recommended)
# nvm is installed by ./install.sh and loaded from ~/Developer/dotfiles/zshrc

nvm install --lts
nvm use --lts

# Python
brew install python@3.11

# Ruby (already included with macOS, but install this for a newer version)
brew install ruby

# Go
brew install go

# Rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

# Java (OpenJDK)
brew install openjdk@17

# Bun (fast JavaScript runtime)
curl -fsSL https://bun.sh/install | bash
```

### Databases

```bash
# PostgreSQL
brew install postgresql@15
brew services start postgresql@15

# MySQL
brew install mysql
brew services start mysql

# MongoDB
brew tap mongodb/brew
brew install mongodb-community
brew services start mongodb-community

# Redis
brew install redis
brew services start redis

# SQLite (already included with macOS)
brew install sqlite
```

### Containers

```bash
# Docker Desktop
brew install --cask docker

# OrbStack (lightweight Docker Desktop alternative)
brew install --cask orbstack
```

---

## 🐛 Troubleshooting

### Homebrew Issues

```bash
# Permissions
sudo chown -R $(whoami) /opt/homebrew

# Reinstall Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/uninstall.sh)"
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

### PATH Issues

```bash
# Show current PATH
echo $PATH

# Add to PATH temporarily
export PATH="/new/path:$PATH"

# Add permanently in the dotfiles repo
echo 'path=("/new/path" $path)' >> ~/Developer/dotfiles/zshrc
source ~/.zshrc
```

### Clear Caches

```bash
# Homebrew cache
brew cleanup -s

# npm cache
npm cache clean --force

# pip cache
pip cache purge

# System cache
sudo rm -rf ~/Library/Caches/*
```

---

## 🔗 References

- [Homebrew](https://brew.sh/)
- [macOS Defaults](https://macos-defaults.com/)
- [Awesome macOS](https://github.com/iCHAIT/awesome-macOS)

---

⬅️ [Back to README](../README.md)
