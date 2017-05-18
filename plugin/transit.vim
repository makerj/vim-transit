if exists( "g:loaded_vim_transit" )
  finish
endif
let g:loaded_vim_transit = 1

if !has( 'python' ) && !has( 'python3' )
  echohl WarningMsg |
    \ echomsg "Vim should be compiled with python support to use vim-transit" |
    \ echohl None
  finish
endif

let g:transit_src = get(g:, 'transit_src', 'en')
let g:transit_dst = get(g:, 'transit_dst', 'kr')

function! s:translate(...)
  let s:query = join(a:000, "")
  if empty(s:query)
    echo "vim-transit: empty query were given. ignore..."
  else
    echo "transit_src:".g:transit_src
    echo "Given text is [".s:query."]"
python << EOF
import vim
print "Vim argument is: [%s]" % vim.eval("s:query")
print "python: return string 'pypypy' to vim as variable"
s = 'pypypy'
vim.command("let pyreturn = '%s'" % s)
EOF
  echo pyreturn

  endif
endfunction

command! -nargs=* TransIt call <SID>translate('<args>')
