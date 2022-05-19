" Fundamentals "{{{
" ---------------------------------------------------------------------
" init autocmd
autocmd!
" set script encoding
scriptencoding utf-8
" stop loading config if it's on tiny or small
if !1 | finish | endif

" copy to clipboard
set clipboard+=unnamedplus
set signcolumn=yes
set nocompatible
set number
set hidden
set mouse=a
set relativenumber
set noerrorbells
syntax enable
set fileencodings=utf-8,sjis,euc-jp,latin
set encoding=utf-8
set title
set autoindent
set smartindent
set background=dark
set nobackup
set nohlsearch
set showcmd
set cmdheight=1
set laststatus=2
set scrolloff=2
set expandtab
"let loaded_matchparen = 1
set backupskip=/tmp/*,/private/tmp/*
" incremental substitution (neovim)
if has('nvim')
  set inccommand=split
endif

" Suppress appending <PasteStart> and <PasteEnd> when pasting
set t_BE=

set nosc noru nosm
"set showmatch
" How many tenths of a second to blink when matching brackets
"set mat=2
" Ignore case when searching
set ignorecase
" Be smart when using tabs ;)
set smarttab
" indents
filetype plugin indent on
set shiftwidth=4
set tabstop=4
" set scl=yes
set ai "Auto indent
set si "Smart indent
set nowrap "No Wrap lines
set incsearch
set backspace=start,eol,indent
" Finding files - Search down into subfolders
set path+=**
set wildignore+=*/node_modules/*

" Turn off paste mode when leaving insert
autocmd InsertLeave * set nopaste

" Add asterisks in block comments
set formatoptions+=r

set completeopt=menu,menuone,noselect

"}}}

" Highlights "{{{
" ---------------------------------------------------------------------
set cursorline
"set cursorcolumn

" Set cursor line color on visual mode
highlight Visual cterm=NONE ctermbg=236 ctermfg=NONE guibg=Grey40

highlight LineNr cterm=none ctermfg=240 guifg=#2b506e guibg=#000000

"}}}

" File types "{{{
" ---------------------------------------------------------------------
" JavaScript
au BufNewFile,BufRead *.es6 setf javascript
" TypeScript
au BufNewFile,BufRead *.tsx setf typescriptreact
" Markdown
au BufNewFile,BufRead *.md set filetype=markdown
" Blade
" au BufNewFile,BufRead *.blade.php set filetype=blade
" vue
" au BufNewFile,BufRead *.vue set filetype=html

set suffixesadd=.js,.es,.jsx,.json,.css,.less,.sass,.styl,.php,.py,.md

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
  " let g:neosolarized_termtrans=1
  " runtime ./colors/NeoSolarized.vim
  " colorscheme NeoSolarized
  " colorscheme nord
  " colorscheme PaperColor
  colorscheme tokyonight
  " highlight Normal guibg=none
endif

"}}}

" Extras "{{{
" ---------------------------------------------------------------------
set exrc
" let test#php#phpunit#executable = 'docker-compose run --rm phpunit'
 let test#php#phpunit#executable = './vendor/bin/phpunit'
" let test#php#phpunit#executable = './vendor/bin/pest'
let g:test#preserve_screen = 0
if has('nvim')
  tmap <C-o> <C-\><C-n>
endif
nmap <silent> t<C-n> :TestNearest<CR>
nmap <silent> t<C-f> :TestFile<CR>
nmap <silent> t<C-l> :TestLast<CR>
nmap <silent> t<C-g> :TestVisit<CR>

"}}}
" vim: set foldmethod=marker foldlevel=0:i
"
let g:dashboard_custom_section = {}
let g:dashboard_custom_footer = {}
let g:dashboard_custom_header = [
   \'        ▄▄▄▄▄███████████████████▄▄▄▄▄     ',
   \'      ▄██████████▀▀▀▀▀▀▀▀▀▀██████▀████▄   ',
   \'     █▀████████▄             ▀▀████ ▀██▄  ',
   \'    █▄▄██████████████████▄▄▄         ▄██▀ ',
   \'     ▀█████████████████████████▄    ▄██▀  ',
   \'       ▀████▀▀▀▀▀▀▀▀▀▀▀▀█████████▄▄██▀    ',
   \'         ▀███▄              ▀██████▀      ',
   \'           ▀██████▄        ▄████▀         ',
   \'              ▀█████▄▄▄▄▄▄▄███▀           ',
   \'                ▀████▀▀▀████▀             ',
   \'                  ▀███▄███▀                ',
   \'                     ▀█▀                   ',
   \ ]
