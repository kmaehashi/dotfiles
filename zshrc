# .zshrc
# @author Kenichi Maehashi

# PATH
PATH=$PATH:/sbin:/usr/sbin:$HOME/bin:$HOME/local/bin

# History
HISTFILE=~/.zsh_history
HISTSIZE=10000000
HISTFILESIZE=10000000
SAVEHIST=10000000

# Prompt - see zshmisc(1) for syntax
PROMPT="%n@%M:%~ %# "
PROMPT2="%_ > "

# Word Splitting
WORDCHARS='*?_-.[]~=&;!#$%^(){}<>'

# Aliases
alias grep='grep --color=auto'
alias ls='ls --color=tty'
alias ll='ls -l --color=tty'

# Environment-specific configuration
if [ "${OS}" = "Windows_NT" ]; then
    ${SYSTEMROOT}/System32/chcp.com 65001
    export CYGWIN=nodosfilewarning
    export DISPLAY=:0.0
    alias open='cygstart'
    alias killall='taskkill /f /im'
    alias ifconfig='ipconfig | iconv -f cp932 -t utf-8'
elif [ "$(uname -s)" = "Darwin" ]; then
    alias ls='ls -wG'
    alias ll='ls -lwG'
fi > /dev/null 2>&1

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
bindkey "^?"    backward-delete-char
bindkey "^H"    backward-delete-char
bindkey "^[[3~" delete-char
bindkey "^[[1~" beginning-of-line
bindkey "^[[4~" end-of-line
bindkey "^[[5~" history-beginning-search-backward
bindkey "^[[6~" history-beginning-search-forward

# Auto-complete
autoload -U compinit
compinit -u

# Option: share history between shells
setopt share_history

# Option: automatically push directory
setopt auto_pushd

# Option: Change directory without 'cd'
setopt auto_cd

# Option: Spell collection
setopt correct

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

# ------------------------ Utility Functions ------------------------
# "realpath"
function realpath() {
    if [ ! -e "${1}" ]; then
        echo "${0}: ${1}: No such file"
    else
        echo "$(cd $(dirname ${1}) && echo ${PWD})/$(basename ${1})"
    fi
}

# "runonce"
function runonce() {
    while [ 1 ]; do "$@" && return; done
}

# "localtime"
function localtime() {
    perl -e '$t = localtime($ARGV[0]); print "$t\n"' ${1}
}
# -------------------------------------------------------------------

for RC_FILE in $(find -H ~/.zshrc.d/ -xtype f); do
    . "${RC_FILE}"
done
