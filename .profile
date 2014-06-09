# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

export CLICCOLOR=true

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
    fi
fi

if [ -d /usr/local/bin ]; then
    PATH=/usr/local/bin:/usr/local/sbin:"${PATH}";
fi

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

# Determine which OS we are running
OS=`uname`
KERNEL=`uname -r`
MACH=`uname -m`

if [ "${OS}" == "Darwin" ]; then
    # OS X
    export EDITOR="/usr/local/bin/emacs"
    export PATH="/usr/local/share/python:$PATH"
    export GROOVY_HOME="/usr/local/opt/groovy/libexec"
    export PATH=$PATH:/Applications/B1FreeArchiver.app/Contents/MacOS
fi


