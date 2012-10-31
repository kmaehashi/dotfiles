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
alias grepc='grep --color=force'
alias ls='ls --color=tty'
alias ll='ls -l --color=tty'
alias lla='ls -al --color=tty'
alias less='less --tabs=4 --LONG-PROMPT --RAW-CONTROL-CHARS --ignore-case'

# Parent directories
DOTS=".."
DOTS_DIR=".."
for (( DEPTH=0; DEPTH < 10; DEPTH++ )); do
  DOTS="${DOTS}."
  DOTS_DIR="${DOTS_DIR}/.."
  alias ${DOTS}="${DOTS_DIR}"
done

# Environment-specific configuration
if [ "${OS}" = "Windows_NT" ]; then
    ${SYSTEMROOT}/System32/chcp.com 65001
    export CYGWIN=nodosfilewarning
    export DISPLAY=:0.0
    alias open='cygstart'
    alias ifconfig='ipconfig | iconv -f cp932 -t utf-8'
    alias sudo='cscript //Nologo $(cygpath --windows ~/bin/elevate.vbs)'
    alias cyg-upgrade='sudo $(cygpath --windows /setup.exe) --download --local-install --site ftp://ftp.jaist.ac.jp/pub/cygwin/ --only-site --root "C:\cygwin" --quiet-mode --no-desktop'
    alias cyg-upgrade-exe='wget -O /setup.exe http://cygwin.com/setup.exe; chmod +x /setup.exe'
    alias cyg-upgrade-all='cyg-upgrade-exe; cyg-upgrade'
elif [ "$(uname -s)" = "Darwin" ]; then
    alias ls='ls -wG'
    alias ll='ls -lwG'
    alias lla='ls -alwG'
    alias dmesg='sudo dmesg'
fi > /dev/null 2>&1

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
