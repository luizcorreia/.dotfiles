" Fundamentals "{{{
" ---------------------------------------------------------------------

" init autocmd
autocmd!
" set script encoding
scriptencoding utf-8
" stop loading config if it's on tiny or small
if !1 | finish | endif

set nocompatible
set relativenumber
syntax enable
set fileencodings=utf-8,sjis,euc-jp,latin
set encoding=utf-8
set title
set autoindent
set background=dark
set nobackup
set nohlsearch
set incsearch
set showcmd
set cmdheight=1
set laststatus=2
set scrolloff=10
set expandtab
"let loaded_matchparen = 1
set shell=zsh
set backupskip=/tmp/*,/private/tmp/*

" Having longer updatetime leads to noticeable
" delays and poor user experience
set updatetime=50

" Don't pass messages to lins-completion-menul.
"set shortmess+=c

set colorcolumn=80

" incremental substitution (neovim)
if has('nvim')
  set inccommand=split
endif

" Suppress appending <PasteStart> and <PasteEnd> when pasting
set t_BE=

set nosc noru nosm
" Don't redraw while executing macros (good performance config)
set lazyredraw
"set showmatch
" How many tenths of a second to blink when matching brackets
"set mat=2
" Ignore case when searching
set ignorecase
" Be smart when using tabs ;)
set smarttab
" indents
filetype plugin indent on
set shiftwidth=2
set tabstop=2 softtabstop=2
set ai "Auto indent
set si "Smart indent
set nowrap "No Wrap lines
set backspace=start,eol,indent

set noswapfile
set nobackup
set undodir=~/.vim/undodir
set undofile
set signcolumn=yes
set isfname+=@-@

" Give more space for displaying messages.
set cmdheight=1
" Finding files - Search down into subfolders
set path+=**
set wildignore+=**/node_modules/*
set wildignore+=*/_build/*
set wildignore+=**/coverage/*
set wildignore+=**/android/*
set wildignore+=**/.git/*

" Turn off paste mode when leaving insert
autocmd InsertLeave * set nopaste

" Add asterisks in block comments
set formatoptions+=r
let mapleader = "<Space>" 
"}}}

" Highlights "{{{fish
" ---------------------------------------------------------------------
set cursorline
set guicursor=
"set cursorcolumn

" Set cursor line color on visual mode
highlight Visual cterm=NONE ctermbg=236 ctermfg=NONE guibg=Grey40

highlight LineNr cterm=none ctermfg=240 guifg=#2b506e guibg=#000000

augroup BgHighlight
  autocmd!
  autocmd WinEnter * set cul
  autocmd WinLeave * set nocul
augroup END

if &term =~ "screen"
  autocmd BufEnter * if bufname("") !~ "^?[A-Za-z0-9?]*://" | silent! exe '!echo -n "\ek[`hostname`:`basename $PWD`/`basename %`]\e\\"' | endif
  autocmd VimLeave * silent!  exe '!echo -n "\ek[`hostname`:`basename $PWD`]\e\\"'
endif

"}}}

" File types "{{{
" ---------------------------------------------------------------------
" JavaScript
au BufNewFile,BufRead *.es6 setf javascript

" TypeScript
au BufNewFile,BufRead *.tsx setf typescriptreact

" Markdown
au BufNewFile,BufRead *.md set filetype=markdown
" Highlight the line the cursor is on
autocmd FileType markdown set cursorline
" Set spell check to British English
autocmd FileType markdown setlocal spell spelllang=pt_br

" Flow
au BufNewFile,BufRead *.flow set filetype=javascript

" Haskell
au BufNewFile,BufRead *.hs setf haskell

set suffixesadd=.js,.es,.jsx,.json,.css,.less,.sass,.styl,.php,.py,.md

autocmd FileType coffee setlocal shiftwidth=2 tabstop=2
autocmd FileType ruby setlocal shiftwidth=2 tabstop=2
autocmd FileType yaml setlocal shiftwidth=2 tabstop=2

"}}}

" Imports "{{{
" ---------------------------------------------------------------------
runtime ./plug.vim
if has("unix")
  let s:uname = system("uname -s")
  " Do Mac stuff
  if s:uname == "Darwin\n"
    runtime ./macos.vim
  endif
endif

runtime ./maps.vim
"}}}

" Syntax theme "{{{
" ---------------------------------------------------------------------

" true color
if exists("&termguicolors") && exists("&winblend")
  syntax enable
  set termguicolors
  set winblend=0
  set wildoptions=pum
  set pumblend=5
  set background=dark
  " Use NeoSolarized
  "let g:neosolarized_termtrans=1
  "runtime ./colors/NeoSolarized.vim
  colorscheme gruvbox
endif

"}}}

" Extras "{{{
" ---------------------------------------------------------------------

set exrc

" markdown-preview do not close the preview tab when switching to other buffers
let g:mkdp_auto_close = 0
augroup pandoc_syntax
    au! BufNewFile,BufFilePre,BufRead *.md set filetype=markdown.pandoc
augroup END

augroup highlight_yank
    autocmd!
    autocmd TextYankPost * silent! lua require'vim.highlight'.on_yank({timeout = 40})
augroup END
"}}}

" vim: set foldmethod=marker foldlevel=0:
