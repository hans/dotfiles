export ZSH=$HOME/.zsh

. ~/.profile
. $ZSH/aliases

fpath=($ZSH/functions $fpath)
autoload -U $ZSH/functions/*(:t)

autoload promptinit                                               # Walters zsh prompt
promptinit                                                        # user@host> ... /some/pwd
prompt walters

export PROMPT=" ⚛   "                                             # atom-symbol prompt to mix with Walters' PWD display on the right

autoload -Uz compinit                                             # tab completion
compinit

setopt BRACE_CCL                                                  # http://stackoverflow.com/questions/2394728
setopt CORRECT                                                    # correct command spellings
setopt NO_LIST_BEEP                                               # don't beep when listing directories on autocomplete

bindkey '^[[3~' delete-char                                       # Mac Terminal.app delete key.. make it work

zstyle ':completion:*' use-cache on                               # cache autocompletion
zstyle ':completion:*' cache-path ~/.zsh/cache

zstyle ':completion:*' completer _complete _match _approximate    # fuzzy match autocompletion
zstyle ':completion:*:match:*' original only
zstyle ':completion:*:approximate:*' max-errors 1 numeric
zstyle ':completion:*:descriptions' format '%B%d%b'               # describe the available completions
zstyle ':completion:*:cd:*' ignore-parents parent pwd             # don't insert the parent directory when completing ../<TAB>

source $ZSH/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh   # syntax highlighting!
