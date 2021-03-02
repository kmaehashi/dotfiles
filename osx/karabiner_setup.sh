#!/bin/bash -ue

CONFIG_DIR=~/.config/karabiner

if [ -d ${CONFIG_DIR} ]; then
  echo "${CONFIG_DIR} already exists"
  exit 1
fi

ln -snf "$(cd $(dirname ${0}); pwd)/karabiner" ~/.config/karabiner

echo "${CONFIG_DIR} installed"
echo "Download: https://karabiner-elements.pqrs.org/"
