set nocompatible

if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall | source ~/.vimrc
endif

call plug#begin('~/.vim/plug')

" Automatically install missing plugins on startup
if !empty(filter(copy(g:plugs), '!isdirectory(v:val.dir)'))
    autocmd VimEnter * PlugInstall | q
endif

" Plugins
Plug 'crusoexia/vim-monokai'
Plug 'itchyny/lightline.vim'
Plug 'scrooloose/syntastic'

call plug#end()

" Editor View Settings
syntax enable
silent! colorscheme monokai
set number
set term=screen-256color
filetype plugin indent off
filetype indent off
set noshowmode
set laststatus=2

" Indentation Remappings
noremap > >>
noremap < <<
vnoremap > >gv
vnoremap < <gv
inoremap <S-Tab> <C-d>
vmap <Tab> >gv
vmap <S-Tab> <gv

" Remap key bindings to take into account continuation
noremap <expr> j v:count ? 'j' : 'gj'
noremap <expr> k v:count ? 'k' : 'gk'

" Tab Spacing
:set autoindent
:set tabstop=4 softtabstop=4 shiftwidth=4 expandtab

" Mouse scrolling
:set mouse=a

" Syntastic Settings
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_python_checkers = ['flake8']
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0
let g:syntastic_auto_loc_list = 0
let g:syntastic_loc_list_height = 5
