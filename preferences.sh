#!/usr/bin/env bash

# Close any open System Preferences panes, to prevent them from overriding
# settings we’re about to change
osascript -e 'tell application "System Preferences" to quit'


###############################################################################
# Updates                                                                     #
###############################################################################

# search for system updates and install them
sudo softwareupdate —i -a


###############################################################################
# General                                                                     #
###############################################################################

echo "Configuring general preferences"

# Disable wallpaper tinting in windows
defaults write NSGlobalDomain AppleReduceDesktopTinting -bool true

# Show scrollbars only when scrolling. Possible values: `WhenScrolling`, `Automatic` and `Always`
defaults write NSGlobalDomain AppleShowScrollBars -string "WhenScrolling"


###############################################################################
# Desktop & Screen Saver                                                      #
###############################################################################

echo "Configuring desktop and screen saver preferences"

# Change screensaver to Drift
defaults -currentHost write com.apple.screensaver moduleDict -dict moduleName Drift path "/System/Library/Screen Savers/Drift.saver" type 8

# Start screensaver after 10 minutes
defaults -currentHost write com.apple.screensaver idleTime 600


###############################################################################
# Dock & Menu Bar                                                             #
###############################################################################

echo "Configuring dock preferences"

# Set the icon size of Dock items to 64 pixels
defaults write com.apple.dock tilesize -int 64

# Change minimize/maximize window effect
defaults write com.apple.dock mineffect -string "suck"

# Don’t animate opening applications from the Dock
defaults write com.apple.dock launchanim -bool false

# Make Dock icons of hidden applications translucent
defaults write com.apple.dock showhidden -bool true

# Turn off magnification
defaults write com.apple.dock magnification -boolean false

# Automatically hide and show the Dock
defaults write com.apple.dock autohide -bool true

# Remove the auto-hiding Dock delay
defaults write com.apple.dock autohide-delay -float 0

# Change the animation speed when hiding/showing the Dock
defaults write com.apple.dock autohide-time-modifier -float 0.5

# Don’t show recent applications in Dock
defaults write com.apple.dock show-recents -bool false

# Rearrange dock icons
dockutil --remove "Launchpad" &> /dev/null
dockutil --remove "Safari" &> /dev/null
dockutil --remove "Messages" &> /dev/null
dockutil --remove "Mail" &> /dev/null
dockutil --remove "Maps" &> /dev/null
dockutil --remove "Photos" &> /dev/null
dockutil --remove "FaceTime" &> /dev/null
dockutil --remove "Calendar" &> /dev/null
dockutil --remove "Contacts" &> /dev/null
dockutil --remove "Reminders" &> /dev/null
dockutil --remove "Notes" &> /dev/null
dockutil --remove "TV" &> /dev/null
dockutil --remove "Podcasts" &> /dev/null
dockutil --remove "App Store" &> /dev/null
dockutil --remove "Numbers" &> /dev/null
dockutil --remove "Keynote" &> /dev/null
dockutil --remove "Pages" &> /dev/null
dockutil --add "/Applications/Google Chrome.app" --after "Finder"
dockutil --add "/Applications/Visual Studio Code.app" --before "System Preferences"
dockutil --add "/Applications/Tableplus.app" --before "System Preferences"
dockutil --add "/System/Applications/Utilities/Terminal.app" --before "System Preferences"


###############################################################################
# Mission Control                                                             #
###############################################################################

echo "Configuring mission control preferences"

# Don’t automatically rearrange Spaces based on most recent use
defaults write com.apple.dock mru-spaces -bool false

# Don’t group windows by application
defaults write com.apple.dock expose-group-by-app -bool false

# Hot Corner: top left screen corner → Start screen saver
defaults write com.apple.dock wvous-tl-corner -int 5
defaults write com.apple.dock wvous-tl-modifier -int 0

# Hot Corner: top right screen corner → Desktop
defaults write com.apple.dock wvous-tr-corner -int 4
defaults write com.apple.dock wvous-tr-modifier -int 0

# Hot Corner: bottom left screen corner → Launchpad
defaults write com.apple.dock wvous-bl-corner -int 11
defaults write com.apple.dock wvous-bl-modifier -int 0

# Hot Corner: bottom right screen corner → Mission Control
defaults write com.apple.dock wvous-br-corner -int 2
defaults write com.apple.dock wvous-br-modifier -int 0


###############################################################################
# Security & Privacy                                                          #
###############################################################################

echo "Configuring security and privacy preferences"

# Turn on firewall
sudo defaults write /Library/Preferences/com.apple.alf globalstate -int 1


###############################################################################
# Date & Time                                                                 #
###############################################################################

# Set the timezone; see `sudo systemsetup -listtimezones` for other values
sudo systemsetup -settimezone "America/Sao_Paulo" > /dev/null


###############################################################################
# General UI/UX                                                               #
###############################################################################

# Set computer name (as done via System Preferences → Sharing)
sudo scutil --set ComputerName "Leonardo Marquine - MacBook"
sudo scutil --set HostName "Leonardo Marquine - MacBook"
sudo scutil --set LocalHostName "LeonardoMarquine-MacBook"
sudo defaults write /Library/Preferences/SystemConfiguration/com.apple.smb.server NetBIOSName -string "Leonardo Marquine - MacBook"

# Expand save panel by default
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode2 -bool true

# Expand print panel by default
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint -bool true
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint2 -bool true

# Automatically quit printer app once the print jobs complete
defaults write com.apple.print.PrintingPrefs "Quit When Finished" -bool true

# Enable full keyboard access for all controls
# (e.g. enable Tab in modal dialogs)
defaults write NSGlobalDomain AppleKeyboardUIMode -int 3


###############################################################################
# Finder                                                                      #
###############################################################################

# Set the Home directory as the default location for new Finder windows
defaults write com.apple.finder NewWindowTarget -string "PfLo"
defaults write com.apple.finder NewWindowTargetPath -string "file://${HOME}/"

# Hide icons for hard drives, servers, and removable media on the desktop
defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool false
defaults write com.apple.finder ShowHardDrivesOnDesktop -bool false
defaults write com.apple.finder ShowMountedServersOnDesktop -bool false
defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool false

# Keep folders on top when sorting by name
defaults write com.apple.finder _FXSortFoldersFirst -bool true
defaults write com.apple.finder _FXSortFoldersFirstOnDesktop -bool true

# When performing a search, search the current folder by default
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"

# Disable the warning when changing a file extension
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

# Avoid creating .DS_Store files on network or USB volumes
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true

# Use list view in all Finder windows by default. Codes for the other view modes: `icnv`, `clmv`, `glyv`
defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"


###############################################################################
# Magnet
###############################################################################

# Do not show dynamo add
defaults write com.crowdcafe.windowmagnet.plist alreadyClickedDynamoItem -bool true
defaults write com.crowdcafe.windowmagnet.plist didntWantToSeeDynamo -bool true


###############################################################################
# Kill affected applications                                                  #
###############################################################################

for app in "Dock" "Finder" "SystemUIServer" "Magnet"; do
    killall "${app}" &> /dev/null
done

echo "Done. Note that some of these changes require a logout/restart to take effect."
