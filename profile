# homebrew on Mac
if [ -e "/Users" ]; then
	export PATH=$HOME/.bin:/usr/local/bin:/usr/local/sbin:$PATH
	export MANPATH=/usr/local/share/man:$MANPATH
	export INFOPATH=/usr/local/share/info:$INFOPATH
fi

# RVM
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"  # This loads RVM into a shell session.

export LANGUAGE=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

# CVS over SSH
export CVS_RSH=ssh

export EDITOR=emacsclient
