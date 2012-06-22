#!/bin/sh

BASEDIR=~/dotfiles

# .zshrc
ln -s ${BASEDIR}/zshrc ~/.zshrc
ln -s ${BASEDIR}/zshrc_screen ~/.zshrc_screen
ln -s ${BASEDIR}/zshrc_ssh_agent ~/.zshrc_ssh_agent

# .screenrc
ln -s ${BASEDIR}/screenrc ~/.screenrc

# .vimrc
ln -s ${BASEDIR}/vimrc ~/.vimrc

# .ssh
if [ ! -d ~/.ssh ]; then
    cp -rp ${BASEDIR}/ssh ~/.ssh
fi

######################################################
# for Cygwin only:
ln -s ${BASEDIR}/cygwin/minttyrc ~/.minttyrc

