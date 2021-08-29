
" Tags
command! MakeTags !ctags -R .

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')


command! -nargs=0 CapToCamel :%s/\(\u\)\(\u\u*\)/\1\L\2/g 
command! -nargs=0 CamelToSnake :%s/\(\u\)\(\l\l*\)/\L\1\2_/g
command! -nargs=0 AppendNum :%s/\(\h*\)_/\=printf("%s = %d;", submatch(1), line(".") - line("'<") + 1)
command! -nargs=0 ProtoMarkReq :%s/\(.*\)Y$/required \1/g
command! -nargs=0 ProtoMarkOpt :v/^required/norm Ioptional<SPACE>
command! -nargs=0 ProtoStripTail :%s/\(.*;\).*/\1/g

function MkProto()
  let cur_win=  winnr()
  vnew scratch
  normal! "+p
  execute "CapToCamel"
  execute "CamelToSnake"
  execute "AppendNum"
  execute "ProtoMarkReq"
  execute "ProtoMarkOpt"
  substitute/__/_/g
  substitute/\(.*\);\s*//g
endfunction
