# .zshrc
# @author Kenichi Maehashi

# local
[ -f ~/.zshrc.local ] && . ~/.zshrc.local
[ -f ~/.zshrc_local ] && . ~/.zshrc_local

# PATH
export PATH="${HOME}/bin:${HOME}/local/bin:/sbin:/usr/sbin:${PATH}"

# LANG
if [ -z "${LANG}" ]; then
  export LANG=en_US.UTF-8
fi

# Completion
fpath=(~/.zsh_functions $fpath)

# History
HISTFILE=~/.zsh_history
HISTSIZE=10000000
HISTFILESIZE=10000000
SAVEHIST=10000000

# Prompt - see zshmisc(1) for syntax
setopt prompt_subst
PROMPT_HOOKS='_hook_prompt_default'
_prompt() {
  for H in $(echo ${PROMPT_HOOKS}); do
    "${H}"
  done
}
_hook_prompt_default() {
  [ ${COLUMNS} -gt 100 ] && echo -n "%U%n@${HOSTNICKNAME:-%M}%u %U%F{yellow}%~%f%u %# " || echo -n "%U%n@${HOSTNICKNAME:-%m}%u %# "
}
PROMPT='$(_prompt)'
PROMPT2='%_ > '

# Command hooks
PRECMD_HOOKS=''
PREEXEC_HOOKS=''
EXIT_HOOKS=''
precmd() {
  for H in $(echo ${PRECMD_HOOKS}); do
    "${H}" "${@}"
  done
}
preexec() {
  for H in $(echo ${PREEXEC_HOOKS}); do
    "${H}" "${@}"
  done
}
_at_exit() {
  for H in $(echo ${EXIT_HOOKS}); do
    "${H}" "${@}"
  done
}
trap '_at_exit' EXIT

# Word Splitting
WORDCHARS='*?-[]~=&;!#$%^(){}<>'

# Disable STOP character
stty stop undef

# Pager
export PAGER='less'

# Editor
if which vim; then
  export EDITOR="vim"
  alias vi='vim'
  alias view='vim -R'
elif which vi; then
  export EDITOR=vi
fi > /dev/null 2>&1

# Key Bindings
bindkey -e
bindkey "^[[3~" delete-char  # delete key
bindkey "^[[1~" beginning-of-line
bindkey "^[[4~" end-of-line
bindkey "^[[5~" history-beginning-search-backward
bindkey "^[[6~" history-beginning-search-forward
bindkey ";5A" none
bindkey ";5B" expand-word
bindkey "^l" forward-word
bindkey "^h" backward-word

# Key Bindings for menuselect
zmodload zsh/complist
bindkey -M menuselect '^l' forward-char
bindkey -M menuselect '^h' backward-char
bindkey -M menuselect '^k' up-line-or-history
bindkey -M menuselect '^j' down-line-or-history

# Auto-complete
autoload -U compinit
compinit -u

# Option: share history between shells
setopt share_history

# Option: automatically push directory
setopt auto_pushd

# Option: Change directory without 'cd'
setopt auto_cd

# Option: no beep for auto-completion
setopt nolistbeep

# Option: print 8-bit characters (for Japanese)
setopt print_eight_bit

# Option: Packed list view
setopt list_packed

# Option: No duplicate histories
setopt hist_ignore_all_dups
setopt hist_save_nodups

# Option: Ignore-space History
setopt hist_ignore_space

# Option: Reduce Blanks
setopt hist_reduce_blanks

# Option: Substitution after `=` (e.g., ./configure --prefix=/[tab])
setopt magic_equal_subst

# Option: extended glob (e.g., *~local (everything excluding "local")
setopt extended_glob

# Option: treat # in command line as comment
setopt interactive_comments

# completion using menu
zstyle ':completion:*:default' menu select interactive

# include other config
for RC_FILE in $(find ~/.zshrc.d/ -type f -or -type l | sort); do
    . "${RC_FILE}"
done
