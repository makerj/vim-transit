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
let s:translated = ''

function! s:translate(query)
  if empty(a:query)
    echo "vim-transit: empty query were given. ignore..."

  else
    "echo "transit_src:".g:transit_src
    "echo "Given text is [".a:query."]"
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
    'q': vim.eval("a:query"),
    'source': vim.eval('g:transit_src'),
    'target': vim.eval('g:transit_dst'),
    'format': 'text',
  }
  content = requests.post(api_url, data=api_data).content.replace("'", "''") # escape single quote
  translated = json.loads(content)['data']['translations'][0]['translatedText']
  vim.command("let s:translated = '%s'" % translated)
else:
  vim.command("let s:translated = 'vim-transit: (ERROR) Environment variable GOOGLE_CLOUD_API_KEY is not set'")
EOF
  endif
endfunction

function! s:TransIt(...)
  call s:translate(join(a:000, ""))
  echo s:translated
endfunction

function! s:TransItPut(...)
  call s:translate(join(a:000, ""))
  :put =s:translated
endfunction

function! s:TransItBlock() abort
  let start_v = col("'<") - 1
  let end_v = col("'>")
  let lines = getline("'<","'>")

  if len(lines) > 1
    let lines[0] = strpart(lines[0],start_v)
    let lines[-1] = strpart(lines[-1],0,end_v)
    let str = join(lines)
  else
    let str = strpart(lines[0],start_v,end_v-start_v)
  endif

  call s:translate(str)
  echo s:translated
endfunction

function! s:TransItBlockPut() abort
  let start_v = col("'<") - 1
  let end_v = col("'>")
  let lines = getline("'<","'>")

  if len(lines) > 1
      let lines[0] = strpart(lines[0],start_v)
    let lines[-1] = strpart(lines[-1],0,end_v)
    let str = join(lines)
  else
    let str = strpart(lines[0],start_v,end_v-start_v)
  endif

  call s:translate(str)
  :put =s:translated
endfunction

function! s:TransItSwapLang()
  let tmp = g:transit_src
  let g:transit_src = g:transit_dst
  let g:transit_dst = tmp
  echo 'transit: current langpair >>'
        \.' src['.g:transit_src.']'
        \.' dst['.g:transit_dst.']'
endfunction

command! TransItSwapLang call <SID>TransItSwapLang()
command! -nargs=* TransIt call <SID>TransIt('<args>')
command! -nargs=* TransItPut call <SID>TransItPut('<args>')
command! -range TransItBlock call <SID>TransItBlock()
command! -range TransItBlockPut call <SID>TransItBlockPut()

