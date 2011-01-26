. ~/.aliases
. ~/.profile

autoload promptinit	    # Walters zsh prompt
promptinit		    # user@host> ... /some/pwd
prompt walters

autoload -Uz compinit	    # tab completion
compinit

setopt CORRECT		    # correct command spellings
setopt NO_LIST_BEEP	    # don't beep when listing directories on autocomplete

bindkey '^[[3~' delete-char # Mac Terminal.app delete key.. make it work
