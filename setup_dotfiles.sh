#!/bin/sh

BASEDIR=~/dotfiles

# bin
if [ ! -d ~/bin ]; then
    mkdir ~/bin
    ln -s ${BASEDIR}/bin/ifne ~/bin/ifne
fi

# .zshrc
ln -s ${BASEDIR}/zshrc ~/.zshrc
if [ ! -d ~/.zshrc.d ]; then
    mkdir ~/.zshrc.d
    ln -s ${BASEDIR}/zshrc.d/utilities ~/.zshrc.d/utilities
fi

# .screenrc
ln -s ${BASEDIR}/screenrc ~/.screenrc

# .vimrc
ln -s ${BASEDIR}/vimrc ~/.vimrc

# .ssh
if [ ! -d ~/.ssh ]; then
    cp -rp ${BASEDIR}/ssh ~/.ssh
fi

# .gitconfig & .gitignore
echo "If you need git configuration, manually run the command below:"
echo "ln -s "${BASEDIR}/gitconfig" ~/.gitconfig"
echo "ln -s "${BASEDIR}/gitignore" ~/.gitignore"
echo "ln -s ${BASEDIR}/zshrc.d/git-pager ~/.zshrc.d/git-pager"

######################################################
# for Cygwin only:
if [ "${OS}" = "Windows_NT" ]; then
    ln -s ${BASEDIR}/cygwin/minttyrc ~/.minttyrc
    ln -s ${BASEDIR}/cygwin/startxwinrc ~/.startxwinrc
fi

