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
    echo "Hello World!"
    echo "transit_src:".g:transit_src
    echo "Given text is [".s:query."]"
  endif
endfunction

command! -nargs=* TransIt call <SID>translate('<args>')
