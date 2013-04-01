# homebrew on Mac
if [ -e "/Users" ]; then
	export PATH=$HOME/.bin:/usr/local/bin:/usr/local/sbin:$PATH
	export MANPATH=/usr/local/share/man:$MANPATH
	export INFOPATH=/usr/local/share/info:$INFOPATH
	export NODE_PATH=/usr/local/lib/node_modules:$NODE_PATH
fi

# RVM
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"  # This loads RVM into a shell session.

# CUDA, Cabal, Python binaries
export PATH=/usr/local/share/python:$PATH:~/.cabal/bin:/usr/local/cuda/bin

export LD_LIBRARY_PATH=$PATH:/usr/local/lib

export LANGUAGE=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

# CVS over SSH
export CVS_RSH=ssh

export EDITOR=emacsclient
