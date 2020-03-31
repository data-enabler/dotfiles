autocmd bufwritepost .vimrc source $MYVIMRC

set tabstop=4
set shiftwidth=4
set number
set hlsearch
set splitbelow
set splitright

set visualbell
set background=dark
colorscheme industry

call plug#begin('~/.vim/plugged')
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-sleuth'
Plug 'jremmen/vim-ripgrep'
Plug '/usr/local/opt/fzf'
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

highlight DiffAdd    cterm=bold ctermfg=10 ctermbg=17 gui=none guifg=bg guibg=Red
highlight DiffDelete cterm=bold ctermfg=10 ctermbg=17 gui=none guifg=bg guibg=Red
highlight DiffChange cterm=bold ctermfg=10 ctermbg=17 gui=none guifg=bg guibg=Red
highlight DiffText   cterm=bold ctermfg=10 ctermbg=88 gui=none guifg=bg guibg=Red

