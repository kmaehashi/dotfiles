#!/bin/sh -uxe

HOMEBREW_ROOT="/opt/homebrew"

sudo mkdir -p "${HOMEBREW_ROOT}"
sudo chown "${USER}:" "${HOMEBREW_ROOT}"
git clone https://github.com/mxcl/homebrew.git "${HOMEBREW_ROOT}"
