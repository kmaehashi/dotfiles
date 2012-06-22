#!/bin/sh

BASEDIR=~/dotfiles

# .zshrc
ln -s ${BASEDIR}/zshrc ~/.zshrc
if [ ! -d ~/.zshrc.d ]; then
    mkdir ~/.zshrc.d
    ln -s ${BASEDIR}/zshrc.d/screen ~/.zshrc.d/screen
    ln -s ${BASEDIR}/zshrc.d/ssh-agent ~/.zshrc.d/ssh-agent
    cp -rp ${BASEDIR}/zshrc.d/proxy ~/.zshrc.d/proxy
fi

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
if [ "${OS}" = "Windows_NT" ]; then
    ln -s ${BASEDIR}/cygwin/minttyrc ~/.minttyrc
fi

