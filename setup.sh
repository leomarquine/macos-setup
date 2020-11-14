#!/usr/bin/env bash

# Xcode Command Line Tools
if test ! $(xcode-select --print-path); then
    touch /tmp/.com.apple.dt.CommandLineTools.installondemand.in-progress
    softwareupdate --install "$(softwareupdate --list | sed -n -e 's/^.*\(Command Line Tools\)/\1/p' | head -1)"
    rm /tmp/.com.apple.dt.CommandLineTools.installondemand.in-progress
fi


# Homebrew
if ! hash brew 2>/dev/null; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
fi

# Update Homebrew recipes
brew update
