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

function! s:translate(text)
  echo "Hello World!"
  echo "transit_src:".g:transit_src
  echo "Given text is [".a:text."]"
endfunction

command! TransIt call <SID>translate('constant')
