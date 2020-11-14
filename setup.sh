#!/usr/bin/env bash

# Cache user credentials
sudo -v

# Keep-alive: update existing `sudo` time stamp until `setup.sh` has finished
while true; do sleep 60; sudo -n true; kill -0 "$!" || exit; done 2>/dev/null &


# Xcode Command Line Tools
if test ! $(xcode-select --print-path); then
    touch /tmp/.com.apple.dt.CommandLineTools.installondemand.in-progress
    softwareupdate --install "$(softwareupdate --list | sed -n -e 's/^.*\(Command Line Tools\)/\1/p' | head -1)"
    rm /tmp/.com.apple.dt.CommandLineTools.installondemand.in-progress
fi


# Homebrew
if ! hash brew 2>/dev/null; then
    echo | /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)" > /dev/null
fi

# Update Homebrew recipes
brew update
