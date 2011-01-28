# homebrew on Mac
if [ -e "/Users" ]; then
	export PATH=/usr/local/bin:/usr/local/sbin:$PATH
	export MANPATH=/usr/local/share/man:$MANPATH
	export INFOPATH=/usr/local/share/info:$INFOPATH

	# RVM
	[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"  # This loads RVM into a shell session.
fi

export LC_ALL=fr_FR.UTF-8
export LANG=fr_FR.UTF-8

# CVS over SSH
export CVS_RSH=ssh
