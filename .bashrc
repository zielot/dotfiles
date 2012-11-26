# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# When bash is invoked as an interactive login shell, or as a
# non-inter‐active shell with the --login option, it first reads and
# executes commands from the file /etc/profile, if that file
# exists. After reading that file, it looks for ~/.bash_profile,
# ~/.bash_login, and ~/.profile, in that order, and reads and executes
# commands from the first one that exists and is readable.  The
# --noprofile option may be used when the shell is started to inhibit
# this behavior.


# When a login shell exits, bash reads and  executes  commands  from  the
# file ~/.bash_logout, if it exists. 

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# set PATH so it includes user's private bin if it exists
if [ -d ~/bin ] ; then
    PATH=~/bin:"${PATH}"
    export PATH
fi

if [ -d ~/lib ] ; then
    PATH=~/lib:"${PATH}"
    export PATH
fi

# do the same with MANPATH
if [ -d ~/man ]; then
    MANPATH=~/man:"${MANPATH}"
    export MANPATH
fi

#-----------------------------------
# Source global definitions (if any)
#-----------------------------------

if [ -f /etc/bashrc ]; then
    . /etc/bashrc   # --> Read /etc/bashrc, if present.
fi

# now override with customizations

ulimit -S -c 0		# Don't want any coredumps
set -o notify
set -o noclobber
#set -o ignoreeof

# if no unset variables are allowed then you must replace all
# occurences of any variable that might be unset with ${variable-}:
# set -o nounset

# useful for debugging:
# set -o xtrace          

# Enable options:
shopt -s cdspell
shopt -s cdable_vars

# If set, bash checks that a command found in the hash ta‐ ble exists
# before trying to execute it.  If a hashed command no longer exists,
# a normal path search is performed.
shopt -s checkhash
shopt -s mailwarn
shopt -s sourcepath
shopt -s no_empty_cmd_completion  # bash>=2.04 only
shopt -s cmdhist

# Disable options:
shopt -u mailwarn
unset MAILCHECK		# I don't want my shell to warn me of incoming mail

# don't put duplicate lines in the history. See bash(1) for more options
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoredups:ignorespace
HISTIGNORE="&:bg:fg:ll:ls:cd:fx:h"

# histappend: append to the history file, don't overwrite it

# histreedit: If readline is being used, and the histreedit shell option is
# enabled, a failed history substitution will be reloaded into the
# readline editing buffer for correction.

# histverify: If the histverify shell option is enabled (see the
# description of the shopt builtin below), and readline is being used,
# history substitutions are not immediately passed to the shell
# parser. Instead, the expanded line is reloaded into the readline
# editing buffer for further modification.
shopt -s histappend histreedit histverify

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=2000
HISTFILESIZE=8000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

#---------------
# Shell Prompt
#---------------
# Define some colors first:
red='\e[0;31m'
RED='\e[1;31m'
blue='\e[0;34m'
BLUE='\e[1;34m'
cyan='\e[0;36m'
CYAN='\e[1;36m'
NC='\e[0m'              # No Color
# --> Nice. Has the same effect as using "ansi.sys" in DOS.

# original prompt
PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME}: ${PWD}\007"'

#  --> Replace instances of \W with \w in prompt functions below
#+ --> to get display of full path name.

function fastprompt()
{
    unset PROMPT_COMMAND
    case $TERM in
        *term | *rxvt | mlterm )
            PS1="${cyan}[\h]$NC \W > \[\033]0;\${TERM} [\u@\h] \w\007\]" ;;
	linux )
	    PS1="${cyan}[\h]$NC \W > " ;;
        *)
            PS1="[\h] \W > " ;;
    esac
}

function powerprompt()
{
    _powerprompt()
    {
        LOAD=$(uptime|sed -e "s/.*: \([^,]*\).*/\1/" -e "s/ //g")
    }

    PROMPT_COMMAND=_powerprompt
    case $TERM in
        *term | *rxvt )
            PS1="${cyan}[\A \$LOAD]$NC\n[\h \#] \W > \[\033]0;\${TERM} [\u@\h] \w\007\]" ;;
        linux )
            PS1="${cyan}[\A - \$LOAD]$NC\n[\h \#] \w > " ;;
        * )
            PS1="[\A - \$LOAD]\n[\h \#] \w > " ;;
    esac
}


# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls="ls --color=auto -F"
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi


unset color_prompt force_color_prompt

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

# So let's do something
echo -e "${CYAN}This is BASH ${RED}${BASH_VERSION%.*}${NC}\n"

if [ -x /usr/games/fortune ]; then
    /usr/games/fortune -s     # makes our day a bit more fun.... :-)
fi

# this is the default prompt - might be slow. If too slow, use
# fastprompt instead....
powerprompt     


# NVM - Node Version Manager
. /opt/nvm/nvm.sh
. /opt/nvm/bash_completion

