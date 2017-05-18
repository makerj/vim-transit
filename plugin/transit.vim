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

function! s:translate()
  echo "Hello World!"
endfunction

command! TransIt call <SID>translate()
