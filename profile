# homebrew on Mac
if [ -e "/Users" ]; then
	export PATH=/usr/local/bin:/usr/local/sbin:$PATH
	export MANPATH=/usr/local/share/man:$MANPATH
	export INFOPATH=/usr/local/share/info:$INFOPATH
fi

export LC_ALL=fr_FR.UTF-8
export LANG=fr_FR.UTF-8

# CVS over SSH
export CVS_RSH=ssh
