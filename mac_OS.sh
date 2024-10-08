#!/usr/bin/env bash
# 
#
#

echo "START"

#Закрыть все системные настройки, дабы избежать ошибок!
osascript -e 'tell application "System Preferences" to quit'

#Ввод пароля
sudo -v

# Запомнить судо на 2 часа
while true; do sudo -n true; sleep 120; kill -0 "$$" || exit; done 2>/dev/null &

#xcode install
xcode-select --install

# Проверка установлен ли Homebrew
if test ! $(which brew); then
    echo "Устанавливаю brew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
fi

# Update homebrew
brew update

# M1 config for brew
grep -q -F 'export PATH="/opt/homebrew/bin:$PATH"' .zshrc
if [ $? -ne 0 ]; then
  echo 'export PATH="/opt/homebrew/bin:$PATH"' >> .zshrc
fi

source ~/.zshrc

# appdir 
export HOMEBREW_CASK_OPTS="--appdir=/Applications"

PACKAGES=(
asciinema
balena-cli
bash-completion
bat
cask
cmake
dive
docker-completion
docui
gh
thefuck
git
lazydocker
lazygit
npm
openssh
python
python3
romkatv/powerlevel10k/powerlevel10k
tailscale
tldr
tree
vim
wget
zsh
)

# zsh theme powerlevel10k
echo "source $(brew --prefix)/opt/powerlevel10k/powerlevel10k.zsh-theme" >>~/.zshrc

echo "Installing packages..."
brew install ${PACKAGES[@]}

eval $(thefuck --alias)
eval $(thefuck --alias FUCK)

echo "Cleaning up..."
brew cleanup

###############################################################################

CASKS=(
1password
alfred
arq
appcleaner
balenaetcher
docker
github
google-chrome
icloud-control
ilya-birman-typography-layout
iterm2
itsycal
karabiner-elements
little-snitch
microsoft-word
microsoft-excel
ngrok # тунель к локальному порту из вне! АГОНЬ)
parallels
pycharm-ce-with-anaconda-plugin
raycast
#setapp ставь руками)
sublime-text
suspicious-package
teamviewer
termius
transmission
tunnelblick
visual-studio-code
vlc
)

echo "Installing cask apps..."
brew install --cask ${CASKS[@]}

# git config
git config --global user.name "Evgenij Eliseew"
git config --global user.email evgenij_eliseew@live.de


echo "Installing Python packages..."
sudo pip install ipython
sudo pip install virtualenv
sudo pip install virtualenvwrapper

echo "Installing Ruby gems"
sudo gem install bundler
sudo gem install filewatcher
sudo gem install cocoapods

echo "Installing global packages..."
npm install marked -g

echo "Configuring MacOS..."

# gitignore add
curl https://raw.githubusercontent.com/github/gitignore/master/Global/macOS.gitignore -o ~/.gitignore_global

echo "Showing icons for hard drives, servers, and removable media on the desktop"
defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool true

echo "Displaying full POSIX path as Finder window title"
defaults write com.apple.finder _FXShowPosixPathInTitle -bool true

echo "Disabling the warning when changing a file extension"
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

echo "Use column view in all Finder windows by default"
defaults write com.apple.finder FXPreferredViewStyle Clmv

# Always show scrollbars
defaults write NSGlobalDomain AppleShowScrollBars -string "Always"

# Disable the “Are you sure you want to open this application?” dialog
defaults write com.apple.LaunchServices LSQuarantine -bool false

# Disable auto-correct
defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false

# Disable machine sleep while charging
sudo pmset -c sleep 0

# Set standby delay to 24 hours (default is 1 hour)
sudo pmset -a standbydelay 86400

# Finder: allow quitting via ⌘ + Q; doing so will also hide desktop icons
defaults write com.apple.finder QuitMenuItem -bool true

# Finder: show hidden files by default
defaults write com.apple.finder AppleShowAllFiles -bool true

# Finder: show status bar
defaults write com.apple.finder ShowStatusBar -bool true

# Finder: show path bar
defaults write com.apple.finder ShowPathbar -bool true

# When performing a search, search the current folder by default
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"

# Avoid creating .DS_Store files on network or USB volumes
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true

# Disable disk image verification
defaults write com.apple.frameworks.diskimages skip-verify -bool true
defaults write com.apple.frameworks.diskimages skip-verify-locked -bool true
defaults write com.apple.frameworks.diskimages skip-verify-remote -bool true

# Disable the warning before emptying the Trash
defaults write com.apple.finder WarnOnEmptyTrash -bool false

# Use AirDrop over every interface.
defaults write com.apple.NetworkBrowser BrowseAllInterfaces 1

###############################################################################
# Dock,                                                                       #
###############################################################################

# Set the icon size of Dock items to 36 pixels
defaults write com.apple.dock tilesize -int 36

###############################################################################
# Safari & WebKit                                                             #
###############################################################################

# Set Safari’s home page to `about:blank` for faster loading
defaults write com.apple.Safari HomePage -string "about:blank"

# Privacy: don’t send search queries to Apple
defaults write com.apple.Safari UniversalSearchEnabled -bool false
defaults write com.apple.Safari SuppressSearchSuggestions -bool true

###############################################################################
# Mail                                                                        #
###############################################################################

# Copy email addresses as `foo@example.com` instead of `Foo Bar <foo@example.com>` in Mail.app
defaults write com.apple.mail AddressesIncludeNameOnPasteboard -bool false

###############################################################################
# Mac App Store                                                               #
###############################################################################

# Enable the automatic update check
defaults write com.apple.SoftwareUpdate AutomaticCheckEnabled -bool true

# Check for software updates daily, not just once per week
defaults write com.apple.SoftwareUpdate ScheduleFrequency -int 1

# Download newly available updates in background
defaults write com.apple.SoftwareUpdate AutomaticDownload -int 1

# Install System data files & security updates
defaults write com.apple.SoftwareUpdate CriticalUpdateInstall -int 1

# Turn on app auto-update
defaults write com.apple.commerce AutoUpdate -bool true

###############################################################################

for app in "Activity Monitor" \
	"Address Book" \
	"Calendar" \
	"Contacts" \
	"Dock" \
	"Finder" \
	"Google Chrome" \
	"Mail" \
	"Messages" \
	"Photos" \
	"Safari" \
	"SystemUIServer" \
	"Transmission" \
	"Terminal"; do
	killall "${app}" &> /dev/null
done
echo "FINISH_ ребутнись, для полного счастья!"
