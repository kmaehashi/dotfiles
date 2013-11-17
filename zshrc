# .zshrc
# @author Kenichi Maehashi

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
_prompt() {
  [ ${COLUMNS} -gt 100 ] && echo "%U%n@%M%u %U%F{yellow}%~%f%u %# " || echo "%U%n@%m%u %# "
}
PROMPT='$(_prompt)'
PROMPT2='%_ > '

# Pre-command hooks
PRECMD_HOOKS=''
precmd() {
  eval "${PRECMD_HOOKS}"
}

# Word Splitting
WORDCHARS='*?_-.[]~=&;!#$%^(){}<>'

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
bindkey "^[[3~" delete-char
bindkey "^[[1~" beginning-of-line
bindkey "^[[4~" end-of-line
bindkey "^[[5~" history-beginning-search-backward
bindkey "^[[6~" history-beginning-search-forward
bindkey ";5A" none
bindkey ";5B" expand-word
bindkey "^K" forward-word
bindkey "^J" backward-word

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
zstyle ':completion:*:default' menu select=1

for RC_FILE in $(find ~/.zshrc.d/ -type f -or -type l | sort); do
    . "${RC_FILE}"
done
