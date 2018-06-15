call plug#begin('~/.vim/plugged')

Plug 'https://github.com/junegunn/vim-github-dashboard.git'
Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-surround'
Plug 'w0rp/ale'
Plug 'tpope/vim-endwise'
Plug 'vim-airline/vim-airline'
Plug 'kchmck/vim-coffee-script'
Plug 'joukevandermaas/vim-ember-hbs'
Plug 'tpope/vim-fugitive'
Plug 'nanotech/jellybeans.vim'
Plug 'ntpeters/vim-better-whitespace'
Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-commentary'
Plug 'janko-m/vim-test'
Plug 'rust-lang/rust.vim'
Plug 'kassio/neoterm'

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
set cursorline

" Undo
set undofile
set undoreload=10000
set undodir=~/.vim/tmp/undo/

" Color scheme
set background=dark
let g:jellybeans_overrides = {
\    'MatchParen': { 'guifg': 'ffffff', 'guibg': '556779' },
\}
colorscheme jellybeans

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

nnoremap <leader><leader> :call GitFilesInDir()<cr>
nnoremap <leader>b :Buffers<cr>

" Relative number toggle
function! ToggleNumberRel()
  setlocal relativenumber!
endfunction

function! GitFilesInDir()
  let localDir=getcwd()
  call fzf#vim#gitfiles(localDir)
endfunction

" Quickly toggle between relativenumber and number
noremap <leader>rr :call ToggleNumberRel()<CR>

" remove whitespace
let g:better_whitespace_enabled=1
let g:strip_whitespace_on_save=1

" ripgrep searching
let g:rg_command = '
  \ rg --column --line-number --no-heading --fixed-strings --ignore-case --hidden --follow --color "always" '

command! -bang -nargs=* F call fzf#vim#grep(g:rg_command .shellescape(<q-args>), 1, <bang>0)

" this makes vim so much faster
set lazyredraw
set ttyfast
set noshowcmd
set regexpengine=1

" Check if NERDTree is open or active
function! IsNERDTreeOpen()
  return exists("t:NERDTreeBufName") && (bufwinnr(t:NERDTreeBufName) != -1)
endfunction

function! CustomNERDTreeToggle()
  if IsNERDTreeOpen()
    NERDTreeClose
  else
    if bufname('%') == ''
      NERDTree
    else
      NERDTreeFind
    endif
  endif
endfunction

nnoremap <leader>t :call CustomNERDTreeToggle()<CR>
"neoterm
let g:neoterm_default_mod = "botright"

"vim-test setup
nnoremap <silent> <Leader>s :TestNearest<CR>
nnoremap <silent> <Leader>sf :TestFile<CR>
let test#strategy = "neoterm"

" always use system clipboard
set clipboard=unnamedplus
" rust stuff
let g:rustfmt_autosave = 1

"use 2.5.0
let g:ruby_host_prog = '~/.rbenv/versions/2.5.0/bin/neovim-ruby-host'

"easier tab switching
noremap <S-D-}> gt
noremap <S-D-{> gT

