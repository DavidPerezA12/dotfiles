# macOS setup

What I do on a new Mac, in order, and what the installer doesn't cover.

## Before the installer

```bash
softwareupdate -ia
xcode-select --install
```

Then clone the repo and run `./install.sh` as described in the
[README](../README.md).

## After the installer

- `gh auth login`, so Git can push to GitHub.
- Add my email and signing key to `~/.gitconfig.local`:

  ```ini
  [user]
    email = you@example.com
  ```

- In iTerm2, `iTerm2 > Install Shell Integration`. The `zshrc` loads it if it's
  there, and it's what makes new tabs and splits open in the same directory.
- Install the apps from the README by hand.

## macOS defaults

The system settings I change. They aren't in the installer because I'd rather
apply them myself.

Finder:

```bash
defaults write com.apple.finder AppleShowAllFiles -bool true
defaults write NSGlobalDomain AppleShowAllExtensions -bool true
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false
defaults write com.apple.finder ShowPathbar -bool true
defaults write com.apple.finder ShowStatusBar -bool true
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
killall Finder
```

Dock:

```bash
defaults write com.apple.dock autohide -bool true
defaults write com.apple.dock autohide-delay -float 0
defaults write com.apple.dock autohide-time-modifier -float 0.5
defaults write com.apple.dock tilesize -int 48
killall Dock
```

Screenshots in their own folder, without the shadow:

```bash
mkdir -p ~/Screenshots
defaults write com.apple.screencapture location ~/Screenshots
defaults write com.apple.screencapture disable-shadow -bool true
killall SystemUIServer
```

Faster key repeat (needs a logout to take effect):

```bash
defaults write NSGlobalDomain KeyRepeat -int 2
defaults write NSGlobalDomain InitialKeyRepeat -int 15
```
