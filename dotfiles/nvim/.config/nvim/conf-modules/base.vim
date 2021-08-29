" Enables FileType identification
filetype plugin on
syntax on

" Appearance
hi CursorLine term=bold cterm=bold

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')
autocmd VimEnter * call OnVimEnter()
autocmd FileType markdown nnoremap <buffer> <C-C> !pandoc % --pdf-engine=xelatex -o %:r.pdf 
autocmd BufRead,BufNewFile,BufCreate *.py,*.hs setlocal foldmethod=indent
autocmd FileType python setlocal formatprg=autopep8\ -
autocmd FileType tex let g:syntastic_quiet_messages = {"!level" : "warnings"}
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() |
    \ quit | endif
autocmd VimEnter * NERDTree | wincmd p
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists('s:std_in') |
    \ execute 'NERDTree' argv()[0] | wincmd p | enew | execute 'cd '.argv()[0] | endif

"
" Coc Custom Formatters
augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

