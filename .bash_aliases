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
alias ll="ls -l"
alias dot='ls .[a-zA-Z0-9_]*'

## get rid of command not found ##
alias cd..='cd ..'
 
## a quick way to get out of current directory ##
alias .='cd ..'
alias ..='cd ../../'
alias ...='cd ../../../'
alias ....='cd ../../../../'
alias .....='cd ../../../../..'
alias .4='cd ../../../../'
alias .5='cd ../../../../..'

alias ts='date +"%Y%m%d%H%M%S"'
alias ds='date +"%Y%m%d"'

alias m='mount |column -t'
# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Csh compatability:
alias unsetenv=unset

# emacs 
# alias killemacs="emacsclient -e '(shutdown-emacs-server)'"
# Nihongo MicroGnuEmacs
# alias e="ng"
# alias e="openwithemacs"

# These don't work, yet
alias htmlencode="perl -MHTML::Entities -pe 'encode_entities($1)'"
alias htmldecode="perl -MHTML::Entities -pe 'decode_entities($1)'"

# alias kems="emacsclient -e '(kill-emacs)'"
# alias sems="/usr/bin/emacs --no-desktop --daemon"
# alias killemacs="emacsclient -e '(shutdown-emacs-server)'"

#Nihongo MicroGnuEmacs
#alias e="ng"
#alias e="openwithemacs"

# functions
alias fx='declare -F'

### Functions
function gman() 
{
    # this doesn't work: 
    # developer@kubuntuBox:~$ gman file
    # *ERROR*: WoMan can only format man pages written with the usual `-man' macros
    # Done displaying WoMan file.

    if /usr/bin/emacsclient -e "(woman \"$1\")"; then 
        echo "Now displaying WoMan $1.";
    # elif yelp 'man:$1'; then 
    #     echo "Done displaying yelp \"man:$1.\""; 
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
alias dl="dpkg -L"
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


