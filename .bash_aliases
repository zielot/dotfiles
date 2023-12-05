#!/bin/bash

#. ~/.ssh_aliases


_bash_history_sync() {
    builtin history -a         #1
    HISTFILESIZE=$HISTSIZE     #2
    builtin history -c         #3
    builtin history -r         #4
}

history() {                  #5
    _bash_history_sync
    builtin history "$@"
}

PROMPT_COMMAND=_bash_history_sync

# for WSL 2
# export DISPLAY=$(cat /etc/resolv.conf | grep nameserver | awk '{print $2; exit;}'):0.0
# for WSL 1
# export DISPLAY=127.0.0.1:0.0

# wsl particulars
# test if wsl?
# alias vpnon='
# wsl.exe -d wsl-vpnkit --cd /app service wsl-vpnkit status >/dev/null || \
# wsl.exe -d wsl-vpnkit --cd /app service wsl-vpnkit start
# '
# alias vpnoff='
# wsl.exe -d wsl-vpnkit --cd /app service wsl-vpnkit stop
# '
# alias netstatus='
# wsl.exe -d wsl-vpnkit --cd /app service wsl-vpnkit status
# '

# for Visual Studio Code
alias code="${USERPROFILE}/AppData/Local/Programs/Microsoft\ VS\ Code/bin/code"

alias vi=vim

# for emacs
export ALTERNATE_EDITOR=""

alias emt='
/usr/bin/emacsclient -n -nw -c $1 
'

alias em='
export LIBGL_ALWAYS_INDIRECT=1
/usr/bin/emacsclient -n -c \"$1\" -a \"\"
'

# emacs 
# alias killemacs="emacsclient -e '(shutdown-emacs-server)'"
# Nihongo MicroGnuEmacs
# alias e="ng"
# alias e="openwithemacs"

# alias kems="emacsclient -e '(kill-emacs)'"
# alias sems="/usr/bin/emacs --no-desktop --daemon"
# alias killemacs="emacsclient -e '(shutdown-emacs-server)'"

#Nihongo MicroGnuEmacs
#alias e="ng"
#alias e="openwithemacs"


# Some useful aliases.
alias texclean='rm -f *.toc *.aux *.log *.cp *.fn *.tp *.vr *.pg *.ky'
alias clean='echo -n "Really clean this directory? ";
	read yorn;
	if test "$yorn" = "y"; then
	   rm -f \#* *~ .*~ *.bak .*.bak  *.tmp .*.tmp core a.out;
	   echo "Cleaned.";
	else
	   echo "Not cleaned.";
	fi'

alias c='clear'
alias du='du -kh'
alias df='df -kTh'
alias path='echo -e ${PATH//:/\\n}'
alias pu="pushd"
alias po="popd"

h()
{
   cat ~/.bash_history | grep "$1" 
}

# alias h='history'

# job control
# process control
alias j="jobs -l"

# ls aliases.
alias ll='ls -l'
alias la='ls -A'
alias l='ls -ltrA'
alias dot='ls .[a-zA-Z0-9_]*'

## get rid of command not found ##
#alias cd..='cd ..'
 
## a quick way to get out of current directory ##
# alias .='cd ..'
# alias ..='cd ../../'
# alias ...='cd ../../../'
# alias ....='cd ../../../../'
# alias .....='cd ../../../../..'
# alias .4='cd ../../../../'
# alias .5='cd ../../../../..'

alias ts='date +"%Y%m%d%H%M%S"'
alias ds='date +"%Y%m%d"'

alias m='mount |column -t'
# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Csh compatability:
alias unsetenv=unset

# functions
alias fx='declare -F'


function randprint() 
{
    cat /dev/urandom | LC_ALL=C tr -dc '[:print:]'| fold -w ${1} | head -n1
}

# use Bash RegEx parameter replacement to decode
function urldecode() { local i="${*//+/ }"; echo -e "${i//%/\\x}"; }

# from https://gist.github.com/cdown/1163649?permalink_comment_id=3625308#gistcomment-3625308
function urlencode() { [[ "${1}" ]] || return 1; local LANG=C i x; for (( i = 0; i < ${#1}; i++ )); do x="${1:i:1}"; [[ "${x}" == [a-zA-Z0-9.~_-] ]] && echo -n "${x}" || printf '%%%02X' "'${x}"; done; echo; }

# check password
function chgpass()
{
    echo "Type in your password to check"
    pwscore
    read -n1 -r -p "Press any key to continue..." key
    clear
}

# dictionary
function dl()
{
    dict "$1" | less
}

function yelpman()
{
    setsid yelp "man:$1"
}


### Functions
function gman() 
{
    # this doesn't work: 
    # developer@kubuntuBox:~$ gman file
    # *ERROR*: WoMan can only format man pages written with the usual `-man' macros
    # Done displaying WoMan file.

    # if /usr/bin/emacsclient -e "(woman \"$1\")"; then 
    #     echo "Now displaying WoMan $1.";

    if [[ -n "$(command -v yelp)" ]];then
        yelpman $1
        echo "Displaying yelp \"man:$1.\""; 
    else
        man "$1";
    fi 
}

function kman()
{
  echo "khelpcenter man:/$1"
  khelpcenter man:/$1 
}

function kinfo()
{
  echo "khelpcenter info:/$1"
  khelpcenter info:/$1
}

function setenv()
{
    if [ $# -ne 2 ] ; then
	echo "setenv: Too few arguments"
    else
	export $1="$2"
    fi
}

term()
{
    TERM=$1
    export TERM
    tset
}

xtitle () 
{ 
    echo -n -e "\033]0;$*\007"
}

if [ -f /unix ] ; then
    clear()
    {
	tput clear
    }
fi


# Function which adds an alias to the current shell and to
# the ~/.bash_aliases file.
add-alias ()
{
    local name=$1 value="$2"
    echo alias $name=\'$value\' >>~/.bash_aliases
    eval alias $name=\'$value\'
    alias $name
}

# process control
pg()
{
    pgrep -l $1 
}

# This is a little like `zap' from Kernighan and Pike
pk()
{
    local pid
	    #original has confused syntax; ax is BSD-style which does
	    #not require dashes; i.e. ps ax and NOT ps -ax
    pid=$(ps -C $1 --no-heading | awk '{ print $1 }')
    echo -n "killing $1 (process $pid)..."
    kill -9 $pid
    echo "slaughtered."
}

# file-name parts
fext()
{
    echo -e "${1: -3}"
}

fbase()
{
    echo -e "${1##*/}"
}

froot()
{
    echo -e "${1%%.*}"
}

fdir()
{
    echo -e "${1%/*}"
}

# do math using the bc calculator
function dm()
{
	echo $@ | bc -l
}

# apt aliases.
alias listdeb="dpkg -L"

finddeb()
{
    aptitude search "$1" | sort -u | less 
}

showdeb()
{
    dpkg -s "$1" || apt-cache show "$1"
}

# "repeat" command.  Like:
#
#	repeat 10 echo foo
repeat ()
{ 
    local count="$1" i;
    shift;
    for i in $(_seq 1 "$count");
    do
        eval "$@";
    done
}

# Subfunction needed by `repeat'.
_seq ()
{ 
    local lower upper output;
    lower=$1 upper=$2;

    if [ $lower -ge $upper ]; then return; fi
    while [ $lower -lt $upper ];
    do
	echo -n "$lower "
        lower=$(($lower + 1))
    done
    echo "$lower"
}

watch()
{
    if [ $# -ne 1 ] ; then
	    tail -f nohup.out
    else
	    tail -f $1
    fi
}

# original from
# @(#) lowercase.ksh 1.0 92/10/08
# 92/10/08 john h. dubois iii (john@armory.com)
# conversion to bash v2 syntax done by Chet Ramey
lowercase()
{
    for file; do
	[ -f "$file" ] || continue
	filename=${file##*/}
	case "$file" in
	    */*)    dirname=${file%/*} ;;
	    *) dirname=.;;
	esac
	nf=$(echo $filename | tr A-Z a-z)
	newname="${dirname}/${nf}"
	if [ "$nf" != "$filename" ]; then
	    mv "$file" "$newname"
	    echo "lowercase: $file -> $newname"
	else
	    echo "lowercase: $file not changed."
	fi
    done
}


bold()
{
    tput smso
}

unbold()
{
    tput rmso
}


join-lines()
{
    sed -e '
:1
/\\$/{N
  s/\n//              
  t1
}
/\\/!d 
s/\\[[:blank:]]*//g
' $1
}


# for use with the (mini)conda package manager 
# from anaconda
# alias cel='conda env list'
# alias cea='conda activate '
# alias ced='conda deactivate '
alias web='google-chrome &'
alias files='exec nohup nautilus 2>&1 &'
