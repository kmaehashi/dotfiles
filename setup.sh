#!/bin/bash -e

DOTFILES="$(cd $(dirname ${0}) && echo ${PWD})"

_default() {
  _d()      { mkdir -p "${HOME}/${1}"; }
  _c()      { _C "${1#.}" "${1}"; }
  _l()      { _L "${1#.}" "${1}"; }
  _C()      { [ -e "${HOME}/${2}" ] || cp -p "${DOTFILES}/${1}" "${HOME}/${2}" || echo "Failed: ${1}"; }
  _L()      { [ -e "${HOME}/${2}" ] || ln -s "${DOTFILES}/${1}" "${HOME}/${2}" || echo "Failed: ${1}"; }
  _ask()    { echo -n "${1} [y/N]? "; read A; [ "${A}" = "Y" -o "${A}" = "y" ]; }
  _is_mac() { [ "$(uname -s)" = "Darwin" ]; }
  _is_win() { [ "${OS}" = "Windows_NT" ]; }
}

_dry_run() {
  TARGET_DIR=()
  TARGET_COPY=()
  TARGET_LINK=()
  _d()   { TARGET_DIR=("${TARGET_DIR[@]}" "${HOME}/${1}"); }
  _C()   { TARGET_COPY=("${TARGET_COPY[@]}" "${HOME}/${2}"); }
  _L()   { TARGET_LINK=("${TARGET_LINK[@]}" "${HOME}/${2}"); }
  _ask() { return 0; }
}

_do_list() {
  echo "Directories:"
  for TARGET in "${TARGET_DIR[@]}"; do
    echo "  ${TARGET}"
  done

  echo "Copied:"
  for TARGET in "${TARGET_COPY[@]}"; do
    echo "  ${TARGET}"
  done

  echo "Links:"
  for TARGET in "${TARGET_LINK[@]}"; do
    echo "  ${TARGET}"
  done
}

_do_remove() {
  _do_list
}

case "${1}" in
  --list )
    _default
    _dry_run
    trap _do_list 0
    ;;
  --remove )
    _default
    _dry_run
    trap _do_remove 0
    ;;
  * )
    _default
    ;;
esac

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
  _c .proxy.pac
fi

# screen
_l .screenrc
if _ask "Start Screen on Startup"; then
  _l .zshrc.d/_screen
fi

# vim
_l .vimrc

# ssh
_d .ssh
_c .ssh/config
if _ask "Start SSH Agent on Startup"; then
  _l .zshrc.d/ssh-agent
  _d .ssh/ssh-agent-keys
fi

# maven
if _ask "Use Maven"; then
  _d .m2
  _c .m2/settings.xml
fi

# Python
if _ask "Use Python (virtualenv)"; then
  _l .zshrc.d/python
fi

# git
if _ask "Use Git"; then
  _l .gitconfig
  _l .gitignore
  _l .zshrc.d/git-prompt
  _l .zshrc.d/git-pager
  _l local/bin/ifne
fi

# for Mac
if _is_mac; then
  _l .zshrc.d/utilities_osx
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
