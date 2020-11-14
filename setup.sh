#!/usr/bin/env bash

# Xcode Command Line Tools
touch /tmp/.com.apple.dt.CommandLineTools.installondemand.in-progress
softwareupdate --install "$(softwareupdate --list | sed -n -e 's/^.*\(Command Line Tools\)/\1/p' | head -1)"
