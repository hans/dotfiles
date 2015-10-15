syntax on
colorscheme desert

set cindent
set smartindent
set smarttab
set autoindent
set softtabstop=4
set shiftwidth=4
set expandtab

" Octave syntax 
augroup filetypedetect 
au! BufRead,BufNewFile *.m,*.oct set filetype=octave 
augroup END
