" Disable Vi compatibility mode for enhanced Vim features
set nocompatible

" Auto-install vim-plug plugin manager if not present
if empty(glob('~/.vim/autoload/plug.vim'))
    " Download vim-plug from GitHub
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    " Install plugins and reload config after Vim starts
    autocmd VimEnter * PlugInstall | source ~/.vimrc
endif

" Initialize vim-plug plugin manager
call plug#begin('~/.vim/plug')

" Automatically install missing plugins on startup
if !empty(filter(copy(g:plugs), '!isdirectory(v:val.dir)'))
    " Install missing plugins and close installation window
    autocmd VimEnter * PlugInstall | q
endif

" Plugins
Plug 'crusoexia/vim-monokai'    " Monokai color scheme
Plug 'itchyny/lightline.vim'     " Lightweight status line
Plug 'scrooloose/syntastic'     " Syntax checking plugin

" End plugin declarations
call plug#end()

" Editor View Settings
syntax enable                    " Enable syntax highlighting
silent! colorscheme monokai      " Set color scheme (silent! ignores errors if not found)
set number                       " Show line numbers
set term=screen-256color         " Set terminal type for 256 colors
filetype indent off              " Disable automatic indentation based on file type
set noshowmode                   " Don't show mode in command line (lightline handles this)
set laststatus=2                 " Always show status line

" Indentation Remappings
noremap > >>                     " Make > indent current line in normal mode
noremap < <<                     " Make < unindent current line in normal mode
vnoremap > >gv                   " Indent selection and keep it selected
vnoremap < <gv                   " Unindent selection and keep it selected
inoremap <S-Tab> <C-d>           " Shift+Tab unindents in insert mode
vmap <Tab> >gv                   " Tab indents selection and keeps it selected
vmap <S-Tab> <gv                 " Shift+Tab unindents selection and keeps it selected

" Remap key bindings to take into account continuation
noremap <expr> j v:count ? 'j' : 'gj'  " j moves down display lines when no count given
noremap <expr> k v:count ? 'k' : 'gk'  " k moves up display lines when no count given

" Tab Spacing
:set autoindent                  " Copy indent from current line when starting new line
:set tabstop=4 softtabstop=4 shiftwidth=4 expandtab  " 4-space indentation, convert tabs to spaces

" Mouse scrolling
:set mouse=a                     " Enable mouse support in all modes

" System clipboard for MacOS
set clipboard=unnamed            " Use system clipboard for yank/paste operations

" Syntastic Settings
set statusline+=%{exists('g:loaded_syntastic_plugin')?SyntasticStatuslineFlag():''}  " Add syntastic status to statusline
set statusline+=%#warningmsg#    " Set warning message highlighting
set statusline+=%*               " Reset highlighting to normal
let g:syntastic_python_checkers = ['flake8']           " Use flake8 for Python syntax checking
let g:syntastic_always_populate_loc_list = 1           " Always populate location list with errors
let g:syntastic_check_on_open = 0                      " Don't check syntax when opening files
let g:syntastic_check_on_wq = 0                        " Don't check syntax when saving and quitting
let g:syntastic_auto_loc_list = 0                      " Don't automatically open/close location list
let g:syntastic_loc_list_height = 5                    " Set location list window height to 5 lines
let g:syntastic_quiet_messages = { 'regex': 'F841' }   " Suppress F841 warnings (unused variable)
let g:syntastic_python_flake8_args='--ignore=E501'     " Ignore E501 (line too long) warnings

augroup vimrc_todo
    au!
    au Syntax * syn match MyTodo /\v<(FIXME|NOTE|TODO|OPTIMIZE|XXX):/
          \ containedin=.*Comment,vimCommentTitle
augroup END

set autoread                     " Automatically read file when changed outside Vim
set ttyfast                      " Indicate fast terminal connection for smoother redrawing
set wildmenu                     " Enhanced command-line completion with menu
" set relativenumber             " Show relative line numbers
set undofile                     " Persist undo history between sessions
