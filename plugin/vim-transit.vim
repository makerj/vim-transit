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
let g:transit_dst = get(g:, 'transit_dst', 'ko')

function! s:translate(...)
  let s:query = join(a:000, "")
  if empty(s:query)
    echo "vim-transit: empty query were given. ignore..."
  else
    "echo "transit_src:".g:transit_src
    "echo "Given text is [".s:query."]"
python << EOF
import vim
import requests
import json
import os

api_key = os.environ.get('GOOGLE_CLOUD_API_KEY', None)
if api_key:
  vim.command("let web_content = ''")
  api_url = 'https://translation.googleapis.com/language/translate/v2?key=%s' % api_key
  api_data = {
    'q': vim.eval("s:query"),
    'source': vim.eval('g:transit_src'),
    'target': vim.eval('g:transit_dst'),
    'format': 'text',
  }
  content = requests.post(api_url, data=api_data).content.replace("'", "''") # escape single quote
  translated = json.loads(content)['data']['translations'][0]['translatedText']
  vim.command("let web_content = '%s'" % translated)
else:
  vim.command("let web_content = 'vim-transit: (ERROR) Environment variable GOOGLE_CLOUD_API_KEY is not set'")
EOF
  echo web_content

  endif
endfunction

command! -nargs=* TransIt call <SID>translate('<args>')
