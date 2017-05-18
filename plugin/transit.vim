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
import requests
print "Vim argument is: [%s]" % vim.eval("s:query")
print "python: return web page contents to vim as a variable"
content = requests.get('http://api.ipify.org?format=json').content.replace("'", "''") # escape single quote
vim.command("let web_content = '%s'" % content)
EOF
  echo web_content

  endif
endfunction

command! -nargs=* TransIt call <SID>translate('<args>')
