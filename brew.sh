#!/usr/bin/env bash
# 
# chmod 755 brew.sh
# bash brew.sh
#

echo "START"

# Check for Homebrew, install if we don't have it
if test ! $(which brew); then
    echo "Installing homebrew..."
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# Update homebrew recipes
brew update

# Install GNU core utilities
brew tap homebrew/dupes
brew install coreutils
brew install gnu-sed --with-default-names
brew install gnu-tar --with-default-names
brew install gnu-indent --with-default-names
brew install gnu-which --with-default-names
brew install gnu-grep --with-default-names

# Install GNU `find`, `locate`, `updatedb`, and `xargs`, g-prefixed
brew install findutils

# Install Bash 4
brew install bash

PACKAGES=(
    ack
    autoconf
    automake
    balena-cli
    boot2docker
    ffmpeg
    gettext
    gifsicle
    git
    graphviz
    hub
    jq
    markdown
    memcached
    npm
    pkg-config
    postgresql
    python
    python3
    pypy
    rename
    tmux
    tree
    vim
    wget
)

echo "Installing packages..."
brew install ${PACKAGES[@]}

echo "Cleaning up..."
brew cleanup

echo "Installing cask..."
brew install caskroom/cask/brew-cask

CASKS=(
    1password
    balenaetcher
    docker
    firefox
    github
    google-chrome
    gpgtools
    iterm2
    little-snitch
    macvim
    microsoft-word
    microsoft-excel
    parallels
    pycharm-ce-with-anaconda-plugin
    setapp
    teamviewer
    visual-studio-code
    vlc
)

echo "Installing cask apps..."
brew install --cask ${CASKS[@]}

echo "Installing fonts..."
brew tap caskroom/fonts
FONTS=(
    font-inconsolidata
    font-roboto
    font-clear-sans
)
brew cask install ${FONTS[@]}

echo "Installing Python packages..."
PYTHON_PACKAGES=(
    ipython
    virtualenv
    virtualenvwrapper
)
sudo pip install ${PYTHON_PACKAGES[@]}

echo "Installing Ruby gems"
RUBY_GEMS=(
    bundler
    filewatcher
    cocoapods
)
sudo gem install ${RUBY_GEMS[@]}

echo "Installing global npm packages..."
npm install marked -g

echo "Configuring OSX..."

# Set fast key repeat rate
defaults write NSGlobalDomain KeyRepeat -int 0

# Require password as soon as screensaver or sleep mode starts
defaults write com.apple.screensaver askForPassword -int 1
defaults write com.apple.screensaver askForPasswordDelay -int 0

# Show filename extensions by default
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

# Disable "natural" scroll
defaults write NSGlobalDomain com.apple.swipescrolldirection -bool false

echo "Showing icons for hard drives, servers, and removable media on the desktop"
defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool true

echo "Showing all filename extensions in Finder by default"
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

echo "Showing status bar in Finder by default"
defaults write com.apple.finder ShowStatusBar -bool true

echo "Allowing text selection in Quick Look/Preview in Finder by default"
defaults write com.apple.finder QLEnableTextSelection -bool true

echo "Displaying full POSIX path as Finder window title"
defaults write com.apple.finder _FXShowPosixPathInTitle -bool true

echo "Disabling the warning when changing a file extension"
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

echo "Use column view in all Finder windows by default"
defaults write com.apple.finder FXPreferredViewStyle Clmv

echo "Avoiding the creation of .DS_Store files on network volumes"
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true

echo "FINISH"

