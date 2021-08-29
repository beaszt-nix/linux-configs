" Common Editing Variables
set nocompatible
set bg=light
set go=a
set mouse=a
set nohlsearch
set clipboard+=unnamedplus
set tabstop=4 softtabstop=0 expandtab shiftwidth=4 smarttab

set encoding=utf-8
set number relativenumber

set expandtab
set tabstop=2
set shiftwidth=2
set nu rnu
set path+=**
set wildmenu
set splitbelow
set splitright

" CoC 
" TextEdit might fail if hidden is not set.
set hidden

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif
