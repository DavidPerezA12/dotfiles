#!/usr/bin/env bash

# The macOS settings I use. Not run by install.sh; apply with `make macos`.
# Some need a logout to take effect.

set -euo pipefail

if [[ "$OSTYPE" != "darwin"* ]]; then
    echo "This script only works on macOS" >&2
    exit 1
fi

# Appearance
defaults write NSGlobalDomain AppleInterfaceStyle -string "Dark"

# Trackpad: tap to click
defaults write com.apple.AppleMultitouchTrackpad Clicking -bool true
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1

# Finder: extensions, path and status bars, list view, search the current
# folder, new windows in ~/Developer
defaults write NSGlobalDomain AppleShowAllExtensions -bool true
defaults write com.apple.finder ShowPathbar -bool true
defaults write com.apple.finder ShowStatusBar -bool true
defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"
defaults write com.apple.finder NewWindowTarget -string "PfLo"
defaults write com.apple.finder NewWindowTargetPath -string "file://$HOME/Developer/"

# Dock: hidden, no recent apps, Spaces keep their order
defaults write com.apple.dock autohide -bool true
defaults write com.apple.dock tilesize -int 67
defaults write com.apple.dock show-recents -bool false
defaults write com.apple.dock mru-spaces -bool false

# Desktop: clicking the wallpaper doesn't hide windows, no gaps when tiling
defaults write com.apple.WindowManager EnableStandardClickToShowDesktop -bool false
defaults write com.apple.WindowManager EnableTiledWindowMargins -bool false

# Screenshots in their own folder
mkdir -p "$HOME/Documents/CapturasPantalla"
defaults write com.apple.screencapture location -string "$HOME/Documents/CapturasPantalla"

killall Finder Dock SystemUIServer 2>/dev/null || true
echo "macOS defaults applied. Log out for the trackpad and appearance changes."
