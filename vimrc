call plug#begin('~/.vim/plugged')

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-endwise'
Plug 'kchmck/vim-coffee-script'
Plug 'tpope/vim-fugitive'
Plug 'nanotech/jellybeans.vim'
Plug 'ntpeters/vim-better-whitespace'
Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-commentary'
Plug 'janko-m/vim-test'
Plug 'rust-lang/rust.vim'
Plug 'andymass/vim-tradewinds'
Plug 'sodapopcan/vim-twiggy'
Plug 'nelstrom/vim-visual-star-search'
Plug 'mbbill/undotree'
Plug 'terryma/vim-expand-region'
Plug 'sheerun/vim-polyglot'

" Initialize plugin system
call plug#end()

"Font
set guifont=Source\ code\ pro:h14

" Leader
let mapleader=','
let maplocalleader=','

" General options
set number
set relativenumber
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

nnoremap <silent> <leader><leader> :Files <C-R>=getcwd()<CR><cr>
nnoremap <silent> <leader>f :Rg<cr>
nnoremap <silent> <leader>F :Rg<cr>
nnoremap <leader>b :Buffers<cr>

" Relative number toggle
function! ToggleNumberRel()
  setlocal relativenumber!
endfunction

" Quickly toggle between relativenumber and number
noremap <leader>rr :call ToggleNumberRel()<CR>

" Undotree
noremap <leader>u :UndotreeToggle<cr>
noremap <leader>uf :UndotreeFocus<cr>

" remove whitespace
let g:better_whitespace_enabled=1
let g:strip_whitespace_on_save=1
let g:strip_whitespace_confirm=0


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

nnoremap <silent><leader>t :call CustomNERDTreeToggle()<CR>
nnoremap <silent><leader>tf :NERDTreeFind<CR>

"vim-test setup
nnoremap <silent> <Leader>s :TestNearest<CR>
nnoremap <silent> <Leader>sf :TestFile<CR>
let test#strategy = "vimterminal"

"easier tab switching
noremap <C-j> gt
noremap <C-k> gT
inoremap <C-j> <esc>gt
inoremap <C-k> <esc>gT

"window management
noremap <silent><left>  :3wincmd <<cr>
noremap <silent><right> :3wincmd ><cr>
noremap <silent><up>    :3wincmd +<cr>
noremap <silent><down>  :3wincmd -<cr>

"Ale
let g:ale_lint_on_text_changed = 'never'
let g:ale_linters = {
\   'coffee': ['coffeelint'],
\}

set visualbell t_vb=

"macvim stuff
set guioptions=

