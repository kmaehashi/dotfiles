#!/bin/sh -uxe

HOMEBREW_ROOT="/opt/homebrew"

sudo mkdir -p "${HOMEBREW_ROOT}"
sudo git clone https://github.com/mxcl/homebrew.git "${HOMEBREW_ROOT}"
