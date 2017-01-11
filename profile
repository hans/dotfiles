# homebrew on Mac
if [ -e "/Users" ]; then
	export PATH=/usr/local/bin:/usr/local/sbin:$PATH
	export MANPATH=/usr/local/share/man:$MANPATH
	export INFOPATH=/usr/local/share/info:$INFOPATH
	export NODE_PATH=/usr/local/lib/node_modules:$NODE_PATH
fi

# Anaconda Python and local binaries
export PATH=$HOME/anaconda/bin:$HOME/.bin:$PATH

# RVM
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"  # This loads RVM into a shell session.

export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/lib

export LANGUAGE=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

# CVS over SSH
export CVS_RSH=ssh

export EDITOR=vim

umask 002
