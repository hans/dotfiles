. ~/.aliases

# for the mac
if [ -e "/Users" ]; then
	export PATH=$PATH:/opt/local/bin:/Users/hans/.bin
	export MANPATH=$MANPATH:/opt/local/share/man
	export INFOPATH=$INFOPATH:/opt/local/share/info
fi

autoload promptinit
promptinit
prompt walters

autoload -Uz compinit
compinit