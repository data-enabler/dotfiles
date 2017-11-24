set visualbell
set tabstop=4
set shiftwidth=4
set number
set hlsearch
set background=dark
autocmd bufwritepost .vimrc source $MYVIMRC

call plug#begin('~/.vim/plugged')
Plug 'tpope/vim-sensible'
Plug 'itchyny/lightline.vim'
Plug 'edkolev/tmuxline.vim'
Plug 'tpope/vim-vividchalk'
"Plug 'altercation/vim-colors-solarized'
call plug#end()

" lightline
set noshowmode
let g:lightline = {'colorscheme': 'OldHope'}

" tmuxline
let g:tmuxline_powerline_separators = 0

" vividchalk
colorscheme vividchalk

" solarized
"colorscheme solarized
"let g:solarized_termcolors=256

