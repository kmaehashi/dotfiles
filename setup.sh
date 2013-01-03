#!/bin/bash -e

DOTFILES="$(cd $(dirname ${0}) && echo ${PWD})"

_d()      { mkdir -p "${HOME}/${1}"; }
_c()      { _C "${1#.}" "${1}"; }
_l()      { _L "${1#.}" "${1}"; }
_C()      { [ -e "${HOME}/${2}" ] || cp -a "${DOTFILES}/${1}" "${HOME}/${2}" || echo "Failed: ${1}"; }
_L()      { [ -e "${HOME}/${2}" ] || ln -s "${DOTFILES}/${1}" "${HOME}/${2}" || echo "Failed: ${1}"; }
_ask()    { echo -n "${1} [y/N]? "; read A; [ "${A}" = "Y" -o "${A}" = "y" ]; }
_is_mac() { [ "$(uname -s)" = "Darwin" ]; }
_is_win() { [ "${OS}" = "Windows_NT" ]; }

# local
_d local
_d local/bin
_d local/tmp

# zsh
_l .zshrc
_d .zshrc.d
_l .zshrc.d/utilities
if _ask "Proxy Environment"; then
  _c .zshrc.d/proxy
fi

# screen
_l .screenrc
if _ask "Start Screen on Startup"; then
  _l .zshrc.d/_screen
fi

# vim
_l .vimrc

# ssh
_c .ssh
if _ask "Start SSH Agent on Startup"; then
  _l .zshrc.d/ssh-agent
  _d .ssh/ssh-agent-keys
fi

# maven
if _ask "Setup Maven"; then
  _c .m2
fi

# git
if _ask "Setup Git"; then
  _l .gitconfig
  _l .gitignore
  _l .zshrc.d/git-prompt
  _l .zshrc.d/git-pager
  _l local/bin/ifne
fi

# for Mac
if _is_mac; then
  if _ask "Setup Terminal"; then
    open ${DOTFILES}/osx/Kenichi.terminal
  fi
  if _ask "Setup Homebrew"; then
    ${DOTFILES}/osx/homebrew_setup.sh
  fi
fi

# for Windows
if _is_win; then
  _l .zshrc.d/utilities_cygwin
  _l .minttyrc
  _l .startxwinrc
  _L cygwin/elevate.vbs local/bin/elevate.vbs
  if _ask "Setup apt-cyg"; then
    ${DOTFILES}/cygwin/setup_apt-cyg.sh
  fi
fi
