call plug#begin('~/.vim/plugged')

Plug 'https://github.com/junegunn/vim-github-dashboard.git'
Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'
Plug 'altercation/vim-colors-solarized'
Plug 'tpope/vim-surround'
Plug 'bling/vim-airline'
Plug 'w0rp/ale'
Plug 'kchmck/vim-coffee-script'
Plug 'joukevandermaas/vim-ember-hbs'
Plug 'tpope/vim-fugitive'

" Initialize plugin system
call plug#end()

" Leader
let mapleader=','
let maplocalleader=','

" General options
set number
set ruler
set autoindent
set smartindent
set encoding=utf-8
set backspace=indent,eol,start
set modelines=0
set laststatus=2
set showcmd
set splitright
set splitbelow
set autoread " auto reload file on change
set scrolloff=8

" Undo 
set undofile
set undoreload=10000
set undodir=~/.vim/tmp/undo/

" Color scheme
let g:solarized_termcolors=256
let g:solarized_contrast="normal"
let g:solarized_underline=0
let g:solarized_termtrans=0
set background=dark
colorscheme solarized

" Wrapping stuff
set nowrap
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
set list
set listchars=tab:\ \ ,trail:·

" redefining defaults
nnoremap / /\v
vnoremap / /\v
noremap H ^
noremap L g_
nnoremap K <nop>

" Searching
set hlsearch
set incsearch
set ignorecase
set smartcase
set showmatch

" key bindings
nnoremap <silent> <C-l> :noh<CR><C-L>
" edit and source vimrc easily
nnoremap <leader>ev :vsplit $MYVIMRC<CR>
nnoremap <leader>sv :source $MYVIMRC<cr>

" spare my fingers in the long run
inoremap jj <esc>
inoremap jk <esc>
inoremap jK jk

nnoremap <leader>f :GFiles<cr>

" Relative number toggle
function! ToggleNumberRel()
  if &relativenumber
    setlocal number
  else
    setlocal relativenumber
  endif
endfunction

" Quickly toggle between relativenumber and number
noremap <leader>rr :call ToggleNumberRel()<CR>

" ripgrep searching
let g:rg_command = '
  \ rg --column --line-number --no-heading --fixed-strings --ignore-case --no-ignore --hidden --follow --color "always"
  \ -g "*.{js,json,php,md,styl,jade,html,config,py,cpp,c,go,hs,rb,conf,coffee,hbs}"
  \ -g "!{.git,node_modules,vendor}/*" '

command! -bang -nargs=* F call fzf#vim#grep(g:rg_command .shellescape(<q-args>), 1, <bang>0)
