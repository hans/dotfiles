export ZSH=$HOME/.zsh

. ~/.profile
. $ZSH/aliases

autoload -U $ZSH/functions/*(:t)

autoload promptinit                                               # Walters zsh prompt
promptinit                                                        # user@host> ... /some/pwd
prompt walters

export PROMPT=" ⚛   "						                                  # atom-symbol prompt to mix with Walters' PWD display on the right

autoload -Uz compinit                                             # tab completion
compinit

setopt CORRECT                                                    # correct command spellings
setopt NO_LIST_BEEP                                               # don't beep when listing directories on autocomplete

bindkey '^[[3~' delete-char                                       # Mac Terminal.app delete key.. make it work

zstyle ':completion:*' use-cache on                               # cache autocompletion
zstyle ':completion:*' cache-path ~/.zsh/cache

zstyle ':completion:*' completer _complete _match _approximate    # fuzzy match autocompletion
zstyle ':completion:*match:*' original only
zstyle ':completion:*:approximate:*' max-errors 1 numeric

zstyle ':completion:*:cd:*' ignore-parents parent pwd             # don't insert the parent directory when completing ../<TAB>
