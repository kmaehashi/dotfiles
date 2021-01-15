#!/bin/sh -uxe

HOMEBREW_ROOT="/usr/local/homebrew"

sudo mkdir -p "${HOMEBREW_ROOT}"
sudo chown "${USER}:" "${HOMEBREW_ROOT}"
git clone https://github.com/Homebrew/brew.git "${HOMEBREW_ROOT}"
