#!/bin/bash -e

DOTFILES="$(cd $(dirname ${0}) && echo ${PWD})"

_action_default() {
  _d()      { mkdir -p "${HOME}/${1}"; }
  _c()      { _C "${1#.}" "${1}"; }
  _l()      { _L "${1#.}" "${1}"; }
  _C()      { [ -e "${HOME}/${2}" ] || cp -p "${DOTFILES}/${1}" "${HOME}/${2}" || echo "Failed: ${1}"; }
  _L()      { [ -e "${HOME}/${2}" ] || ln -s "${DOTFILES}/${1}" "${HOME}/${2}" || echo "Failed: ${1}"; }
  _ask()    { echo -n "${1} [y/N]? "; read A; [ "${A}" = "Y" -o "${A}" = "y" ]; }
  _setup()  { _ask "${@}"; }
  _is_mac() { [ "$(uname -s)" = "Darwin" ]; }
  _is_win() { [ "${OS}" = "Windows_NT" ]; }
}

_action_dry_run() {
  TARGET_DIR=()
  TARGET_COPY=()
  TARGET_LINK=()
  _d()     { TARGET_DIR=("${TARGET_DIR[@]}" "${HOME}/${1}"); }
  _C()     { TARGET_COPY=("${TARGET_COPY[@]}" "${HOME}/${2}"); }
  _L()     { TARGET_LINK=("${TARGET_LINK[@]}" "${HOME}/${2}"); }
  _ask()   { return 0; }
  _setup() { return 1; }
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
  for TARGET in "${TARGET_LINK[@]}"; do
    if [ -e "${TARGET}" ]; then
      if [ -L "${TARGET}" ]; then
        echo "Removing Symlink: ${TARGET}"
        rm "${TARGET}"
      else
        echo "Not Removing: Symlink Expected: ${TARGET}"
      fi
    fi
  done

  for TARGET in "${TARGET_COPY[@]}"; do
    if [ -e "${TARGET}" ]; then
      echo "Not Removing: Copied File: ${TARGET}"
    fi
  done

  # TODO need to sort directories
  for TARGET in "${TARGET_DIR[@]}"; do
    if [ -d "${TARGET}" ]; then
      echo "Removing Directory: ${TARGET}"
      rmdir "${TARGET}"
    fi
  done
}

_main() {
  _action_default

  case "${1}" in
    --list )
      _action_dry_run
      _process
      _do_list
      ;;
    --remove )
      _action_dry_run
      _process
      _do_remove
      ;;
    * )
      _process
      ;;
  esac
}

_process() {
  # local
  _d local
  _d local/bin
  _d local/tmp

  # zsh
  _l .zsh_functions
  _l .zshrc
  _d .zshrc.d
  _l .zshrc.d/utilities
  _c .zshrc_local

  # Proxy
  if _ask "Proxy Environment"; then
    _l local/bin/proxy
    _l .zshrc.d/proxy
    _c .proxy.pac
    _c .ssh/config
  fi

  # screen
  _l .screenrc
  _l .zshrc.d/screen-env
  if _ask "Start Screen on Startup"; then
    _l .zshrc.d/_screen
  fi

  # vim
  _l .vimrc

  # ssh
  _d .ssh
  _l .zshrc.d/ssh-agent
  if _ask "Start SSH Agent on Startup"; then
    _d .ssh/agent-keys.d
  fi

  # maven
  if _ask "Use Maven"; then
    _d .m2
    _c .m2/settings.xml
  fi

  # Python
  if _ask "Use Python"; then
    _l .zshrc.d/python
    _l .pythonrc.py
  fi

  # git
  if _ask "Use Git"; then
    _l .gitconfig
    _l .gitignore
    if ! _is_win; then
      _l .zshrc.d/git-prompt
    fi
    _l .zshrc.d/git-env
    _l local/bin/ifne
  fi

  # extended_su
  if _ask "Use Extended su Mode"; then
    _l .zshrc.d/extended_su
  fi

  # net-tools-disabler
  if _ask "Use net-tools disabler"; then
    _l .zshrc.d/net-tools-disabler
  fi

  # for Mac
  if _is_mac; then
    _l .zshrc.d/_homebrew
    _l .zshrc.d/utilities_osx
    if _setup "Setup Terminal"; then
      open ${DOTFILES}/osx/Kenichi.terminal
      osascript -e '
          tell application "Terminal"
            set the default settings to current settings of the selected tab of the window 0
            close the window 0
          end tell
      '
    fi
    if _setup "Setup Homebrew"; then
      ${DOTFILES}/osx/homebrew_setup.sh
    fi
  fi

  # for Windows
  if _is_win; then
    _l .zshrc.d/utilities_cygwin
    _l .minttyrc
    _l .startxwinrc
    _L cygwin/elevate.vbs local/bin/elevate.vbs
    if _ask "Use golang"; then
      _l .zshrc.d/golang_cygwin
    fi
  fi
}

if [ ${#BASH_SOURCE[@]} = 1 ]; then
  _main "${@}"
fi
